local USER_NAME = "cool_name9009"

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		if player.Name == USER_NAME then
			local humanoid = character:WaitForChild("Humanoid")
			
			-- 1. Görünmez Koruma Kalkanı Oluşturur
			local ff = Instance.new("ForceField")
			ff.Visible = false -- Kimse koruma kalkanın olduğunu görmez
			ff.Parent = character
			
			-- 2. Canı ve Max Canı sonsuza çek
			humanoid.MaxHealth = math.huge
			humanoid.Health = math.huge
			
			-- 3. Ölüm durumunu kökten kapat
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			
			-- 4. Eğer kalkan bir şekilde silinirse geri ekle
			character.ChildRemoved:Connect(function(child)
				if child:IsA("ForceField") then
					local newFF = Instance.new("ForceField")
					newFF.Visible = false
					newFF.Parent = character
				end
			end)
			
			print("cool_name9009 için SÜPER ÖLÜMSÜZLÜK aktif!")
		end
	end)
end)
