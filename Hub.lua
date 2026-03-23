-- [[ YNS V33 - SADECE SİSTEM AÇIĞI TARAYICI ]]
local p = game.Players.LocalPlayer

print("--- TARAMA BAŞLADI: AÇIKLAR ARANIYOR ---")

-- Oyunun içindeki tüm gizli kapıları (RemoteEvents) bulalım
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        local name = v.Name:lower()
        
        -- Para, Elmas veya Ödül ile ilgili anahtar kelimeler
        if name:find("diamond") or name:find("gem") or name:find("gold") or name:find("cash") or name:find("reward") or name:find("currency") or name:find("money") then
            
            print("Potansiyel Açık Bulundu: " .. v.Name)
            
            -- Bulduğumuz her açık için ayrı bir saldırı döngüsü başlatalım
            task.spawn(function()
                while task.wait(0.2) do -- Sunucuyu çok yormadan 0.2 saniyede bir dene
                    pcall(function()
                        -- En yaygın 3 farklı kandırma yöntemini aynı anda deniyoruz
                        v:FireServer(100)      -- Sayı gönder
                        v:FireServer(true)     -- Onay gönder
                        v:FireServer("Claim")  -- Komut gönder
                    end)
                end
            end)
        end
    end
end

print("--- TARAMA TAMAMLANDI. AÇIK BULUNDUYSA SALDIRI SÜRÜYOR ---")
