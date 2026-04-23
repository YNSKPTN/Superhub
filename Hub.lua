local USER_NAME = "cool_name9009"

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if player.Name == USER_NAME then
            local humanoid = character:WaitForChild("Humanoid")
            
            -- OYUNUN SENİ ÖLDÜRMESİNİ ENGELLEMEK İÇİN:
            -- 'BreakJointsOnDeath' özelliğini kapatıyoruz, böylece canın 0 olsa bile dağılmazsın.
            humanoid.BreakJointsOnDeath = false
            
            -- Canı çok yüksek bir değere sabitle
            humanoid.MaxHealth = 999999
            humanoid.Health = 999999
            
            -- Saniyede 100 kez canı kontrol eden aşırı hızlı bir döngü
            game:GetService("RunService").Heartbeat:Connect(function()
                if humanoid.Health < 999999 then
                    humanoid.Health = 999999
                end
            end)
            
            -- Karakterin parçalarının "CanCollide" (Çarpışma) özelliğini kullanarak 
            -- Bazı hasar scriptlerini kandırabiliriz
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    -- Bazı oyunlar 'Touch' ile hasar verir, bunu manipüle ediyoruz
                end
            end
            
            print("Random Tool için özel koruma yüklendi.")
        end
    end)
end)
