-- [ YNS V32 - REMOTE LOGGING & SPY SYSTEM ]

local spyActive = false
local spyBtn = Instance.new("TextButton", main)
spyBtn.Size = UDim2.new(0.9, 0, 0, 45)
spyBtn.Position = UDim2.new(0.05, 0, 0.55, 0) -- Yeni pozisyon
spyBtn.Text = "SİNYAL İZLE: KAPALI"
spyBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 80)
spyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", spyBtn)

-- Yakalanan sinyalleri gösterecek küçük bir konsol (isteğe bağlı)
local logFrame = Instance.new("ScrollingFrame", sg)
logFrame.Size = UDim2.new(0, 250, 0, 150)
logFrame.Position = UDim2.new(0.5, 160, 0.1, 0)
logFrame.BackgroundColor3 = Color3.new(0,0,0)
logFrame.BackgroundTransparency = 0.5
logFrame.Visible = false

local logLayout = Instance.new("UIListLayout", logFrame)
logLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function addLog(txt)
    local l = Instance.new("TextLabel", logFrame)
    l.Size = UDim2.new(1, 0, 0, 20)
    l.Text = txt
    l.TextColor3 = Color3.new(0, 1, 0)
    l.TextScaled = true
    l.BackgroundTransparency = 1
end

-- --- [ ASIL CASUSLUK MEKANİZMASI ] ---
local function startSpying()
    local g = game
    local mt = getrawmetatable(g)
    setreadonly(mt, false)
    local old = mt.__namecall

    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}

        if spyActive and (method == "FireServer" or method == "InvokeServer") then
            -- Sinyali yakaladık!
            local remoteName = tostring(self.Name)
            local argStr = ""
            for i, v in pairs(args) do
                argStr = argStr .. tostring(v) .. ", "
            end
            
            warn("SİNYAL YAKALANDI: " .. remoteName .. " | ŞİFRE/ARG: " .. argStr)
            addLog(remoteName .. " -> " .. argStr)
        end
        return old(self, ...)
    end)
end

-- Casusluğu bir kere başlat (ama butona basınca aktif olsun)
pcall(startSpying)

spyBtn.MouseButton1Click:Connect(function()
    spyActive = not spyActive
    logFrame.Visible = spyActive
    spyBtn.Text = spyActive and "İZLEME AKTİF (KONSOLA BAK!)" or "SİNYAL İZLE: KAPALI"
    spyBtn.BackgroundColor3 = spyActive and Color3.fromRGB(120, 0, 180) or Color3.fromRGB(60, 0, 80)
end)
