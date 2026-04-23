local USER_NAME = "cool_name9009"
local BIG_NUMBER = 999999999 -- İstediğin o devasa sayı

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		if player.Name == USER_NAME then
			local humanoid = character:WaitForChild("Humanoid")
			
			-- 1. Maksimum canı ve mevcut canı o devasa sayıya çekiyoruz
			humanoid.MaxHealth = BIG_NUMBER
			humanoid.Health = BIG_NUMBER
			
			-- 2. Canın azalmasını engellemek için döngü
			-- 0.000001 saniyede bir canı kontrol edip geri fulleyen çok hızlı bir döngü
			task.spawn(function()
				while character and character.Parent do
					if humanoid.Health < BIG_NUMBER then
						humanoid.Health = BIG_NUMBER
					end
					task.wait(0.000001) -- İstediğin o çok küçük bekleme süresi
				end
			end)
			
			-- 3. Ölüm animasyonunu kapatıyoruz (Kafa kopsa bile hayatta kal)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			
			print("cool_name9009 için Limitli-Sonsuz Can Aktif!")
		end
	end)
end)
