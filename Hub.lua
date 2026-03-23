-- [[ YNS V41 - YENİ HEDEF & ANTİ-KİCK TARAYICI ]]
print("--- YENİ HEDEF TARANIYOR... ---")

-- Atılma engelleyici: Sunucu seni atmaya çalışırsa engellemeye çalışır
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then 
        warn("SUNUCU SENİ ATMAYA ÇALIŞTI AMA ENGELLEDİM! 😎")
        return nil 
    end
    return old(self, ...)
end)

-- Sistem Açığı Tarama Fonksiyonu
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent") then
        local n = v.Name:lower()
        -- Para, elmas ve ödül anahtar kelimeleri
        if n:find("money") or n:find("cash") or n:find("gem") or n:find("diamond") or n:find("reward") or n:find("coin") then
            print("ZAYIF NOKTA YAKALANDI: " .. v:GetFullName())
            
            -- Saldırı başlat (Hızı güvenli seviyede: 0.5 saniye)
            task.spawn(function()
                while task.wait(0.5) do
                    pcall(function()
                        v:FireServer(999)
                        v:FireServer(true)
                        v:FireServer("Claim")
                    end)
                end
            end)
        end
    end
end
print("--- TARAMA BİTTİ. ŞİMDİ PARANI KONTROL ET! ---")
