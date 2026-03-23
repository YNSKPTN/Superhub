-- [[ YNS V34 - REWARDED AD EXPLOIT ]]
local remote = game:GetService("ReplicatedStorage"):WaitForChild("RewardedAdEvent") -- Bulduğumuz kapı

print("--- REWARDED AD KAPISINA SALDIRI BAŞLADI ---")

task.spawn(function()
    while task.wait(0.3) do -- Sunucuyu şüphelendirmemek için 0.3 saniye
        pcall(function()
            -- Bu kapının bekleyebileceği farklı şifreleri tek tek deniyoruz:
            remote:FireServer("Reward")
            remote:FireServer("Gem")
            remote:FireServer("Diamond")
            remote:FireServer(true)
            remote:FireServer(100)
            remote:FireServer("Give")
        end)
    end
end)

print("--- SALDIRI SÜRÜYOR... ELMASLARINI KONTROL ET! ---")
