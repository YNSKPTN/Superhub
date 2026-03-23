-- [[ YNS V90 - ELMAS DONDURMA VE HARCAMA ENGELLEYİCİ ]]
print("--- ELMASLAR BUZ DOLABINA KONULDU: DONDURULUYOR ---")

local player = game.Players.LocalPlayer
local gemValue = nil

-- 1. ADIM: Mevcut Elmas Miktarını Tespit Et ve Sabitle
for _, v in pairs(player:GetDescendants()) do
    if v:IsA("IntValue") or v:IsA("NumberValue") then
        if v.Name:lower():find("gem") or v.Name:lower():find("diamond") then
            gemValue = v
            local initialAmount = v.Value
            print("DONDURULAN ELMAS MİKTARI: " .. initialAmount)
            
            -- Değer her değiştiğinde eski haline getir
            v.Changed:Connect(function(newVal)
                if newVal < initialAmount then
                    v.Value = initialAmount
                    print("ELMAS AZALMASI ENGELLENDİ! 😎")
                end
            end)
        end
    end
end

-- 2. ADIM: Harcama Sinyallerini (RemoteEvents) Blokla
local mt = getrawmetatable(game)
setreadonly(mt, false)
local old = mt.__namecall

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    -- Eğer sunucuya 'Satın Al' veya 'Harcama' mesajı gidiyorsa engelle
    if method == "FireServer" then
        local name = self.Name:lower()
        if name:find("buy") or name:find("purchase") or name:find("spend") or name:find("usegem") then
            warn("HARCAMA SİNYALİ YAKALANDI VE İPTAL EDİLDİ: " .. self.Name)
            return nil -- Mesajın gitmesini engelle
        end
    end
    
    return old(self, unpack(args))
end)

print("--- ELMASLARIN ŞU AN DONMUŞ OLMALI. BİR ŞEY ALMAYI DENE! ---")
