-- [[ YNS V36 - ŞİFRE TAHMİN EDİCİ SALDIRI ]]
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RewardedAdEvent")

print("--- ÖZEL ŞİFRE TAHMİNLERİ DENENİYOR ---")

-- Denenecek şifre listesi (Yaygın kullanılanlar)
local passwords = {
    "Gem", "Gems", "Diamond", "Diamonds", "Reward", "Claim", 
    "GiveReward", "Finished", "AdFinished", "100", "50", 
    true, 1, 100, "Success", "Complete"
}

task.spawn(function()
    while task.wait(0.2) do
        for _, pass in pairs(passwords) do
            pcall(function()
                -- Hem tekli hem çiftli argüman deniyoruz
                remote:FireServer(pass)
                remote:FireServer("Gems", pass)
            end)
        end
    end
end)

print("--- SALDIRI TAM GAZ DEVAM EDİYOR! ---")
