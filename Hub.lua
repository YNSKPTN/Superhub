local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 320, 0, 600)
main.Position = UDim2.new(0, 10, 0, 10)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)

Instance.new("UICorner", main)

-- BUTTON MAKER
local function createButton(text, posY, callback)
    local btn = Instance.new("TextButton", main)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0,10,0,posY)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.TextColor3 = Color3.new(1,1,1)

    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

-- ✈️ FLY
local flying = false
local flyBV

createButton("Fly", 10, function()
    flying = not flying
    if flying then
        flyBV = Instance.new("BodyVelocity")
        flyBV.MaxForce = Vector3.new(999999,999999,999999)
        flyBV.Parent = hrp

        RunService.RenderStepped:Connect(function()
            if flying and flyBV then
                flyBV.Velocity = camera.CFrame.LookVector * 60
            end
        end)
    else
        if flyBV then flyBV:Destroy() end
    end
end)

-- 👻 NOCLIP
local noclip = false
createButton("Noclip", 60, function()
    noclip = not noclip
end)

RunService.Stepped:Connect(function()
    if noclip then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 🫥 INVISIBLE
local invisible = false
createButton("Invisible", 110, function()
    invisible = not invisible
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = invisible and 1 or 0
        end
    end
end)

-- 💀 GOD MODE
local godmode = false
createButton("God Mode", 160, function()
    godmode = not godmode

    if godmode then
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)

        humanoid.HealthChanged:Connect(function()
            if godmode and humanoid.Health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)

        task.spawn(function()
            while godmode do
                task.wait(0.1)
                if humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end)
    end
end)

-- ⚡ SPEED
local speedOn = false
local normalSpeed = 16
local boostedSpeed = 50

createButton("Speed", 210, function()
    speedOn = not speedOn
    humanoid.WalkSpeed = speedOn and boostedSpeed or normalSpeed
end)

-- 🦘 JUMP
local jumpOn = false
local normalJump = 50
local boostedJump = 120

createButton("Jump", 260, function()
    jumpOn = not jumpOn
    humanoid.JumpPower = jumpOn and boostedJump or normalJump
end)

-- PLAYER LIST
local listFrame = Instance.new("Frame", main)
listFrame.Size = UDim2.new(1, -20, 0, 280)
listFrame.Position = UDim2.new(0,10,0,310)
listFrame.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", listFrame)
layout.Padding = UDim.new(0,5)

local function goTo(target)
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        hrp.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(2,0,0)
    end
end

local function pull(target)
    if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        target.Character.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(3,0,0)
    end
end

local function spectate(target)
    if target.Character then
        camera.CameraSubject = target.Character:FindFirstChild("Humanoid")
    end
end

local function refresh()
    listFrame:ClearAllChildren()
    layout.Parent = listFrame

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            local item = Instance.new("Frame", listFrame)
            item.Size = UDim2.new(1, 0, 0, 40)
            item.BackgroundColor3 = Color3.fromRGB(40,40,40)

            Instance.new("UICorner", item)

            local name = Instance.new("TextLabel", item)
            name.Size = UDim2.new(0.4, 0, 1, 0)
            name.Text = plr.Name
            name.TextColor3 = Color3.new(1,1,1)
            name.BackgroundTransparency = 1

            local function makeBtn(txt, pos, func)
                local b = Instance.new("TextButton", item)
                b.Size = UDim2.new(0.2, 0, 1, 0)
                b.Position = pos
                b.Text = txt
                b.BackgroundColor3 = Color3.fromRGB(70,70,70)
                b.TextColor3 = Color3.new(1,1,1)

                Instance.new("UICorner", b)
                b.MouseButton1Click:Connect(func)
            end

            makeBtn("Git", UDim2.new(0.4,0,0,0), function()
                goTo(plr)
            end)

            makeBtn("Çek", UDim2.new(0.6,0,0,0), function()
                pull(plr)
            end)

            makeBtn("İzle", UDim2.new(0.8,0,0,0), function()
                spectate(plr)
            end)
        end
    end
end

Players.PlayerAdded:Connect(refresh)
Players.PlayerRemoving:Connect(refresh)

refresh()
