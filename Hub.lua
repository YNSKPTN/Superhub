-- [[ YNS V71 - CLASHERS ROYALE REKLAMSIZ ÖDÜL BASICI ]]
local remote = game:GetService("ReplicatedStorage"):WaitForChild("RewardedAdEvent")

print("--- REKLAM ÖDÜLÜ SÜREKLİ ALINIYOR ---")

task.spawn(function()
    while task.wait(0.5) do -- Sunucu fark etmesin diye yarım saniyede bir
        pcall(function()
            -- Sunucuya 'Reklam bitti' mesajı gönderiyoruz
            remote:FireServer()
            remote:FireServer(true)
            remote:FireServer("ClaimReward")
        end)
    end
end)

print("--- İŞLEM AKTİF! EĞER PARA GELMİYORSA BİR KERE REKLAM TUŞUNA BAS ---")
