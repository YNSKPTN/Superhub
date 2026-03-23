-- [[ YNS V35 - DERİN KAPILI SALDIRI ]]
local targetName = "RewardedAdEvent"
local foundRemote = nil

print("--- KAPILI SALDIRI: " .. targetName .. " ARANIYOR ---")

-- Tüm oyunu tara ve kapıyı bul
for _, v in pairs(game:GetDescendants()) do
    if v.Name == targetName and (v:IsA("RemoteEvent") or v:IsA("UnreliableRemoteEvent")) then
        foundRemote = v
        print("BULDUM! Kapı şurada saklanmış: " .. v:GetFullName())
        break
    end
end

if foundRemote then
    task.spawn(function()
        while task.wait(0.3) do
            pcall(function()
                -- Sunucuyu kandırmak için farklı kombinasyonlar
                foundRemote:FireServer("Reward")
                foundRemote:FireServer(true)
                foundRemote:FireServer(100)
                foundRemote:FireServer("Claim")
                foundRemote:FireServer()
            end)
        end
    end)
    print("--- SALDIRI BAŞLATILDI! ---")
else
    print("HATA: Kapı bu isimle bulunamadı. İsmi değişmiş olabilir.")
end
