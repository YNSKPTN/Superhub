-- Basit Uzak Etkinlik İzleyici
print("--- Remote Logger Baslatildi ---")

local function hookRemotes()
    local oldHook
    oldHook = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        local args = {...}

        -- Eğer bir sinyal (FireServer) gönderiliyorsa bunu yakala
        if method == "FireServer" or method == "InvokeServer" then
            print("------------------------------------------")
            print("Tetiklenen Remote: " .. self:GetFullName())
            print("Gonderilen Veriler (Args): ", table.concat(args, ", "))
            print("------------------------------------------")
        end

        return oldHook(self, ...)
    end)
end

-- Scripti calistir
pcall(hookRemotes)
