local USER_NAME = "cool_name9009"

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		if player.Name == USER_NAME then
			-- 1. Karakterdeki her parçanın hasar alma özelliğini kapatmayı dener
			for _, part in pairs(character:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanTouch = true -- Dokunabilirsin ama...
				end
			end

			local humanoid = character:WaitForChild("Humanoid")
			
			-- 2. En kritik nokta: Hasar alma fonksiyonunu "boşaltıyoruz"
			-- Birisi sana hasar vermeye çalıştığında oyun hiçbir şey yapmayacak
			humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)

			-- 3. Ölümsüzlük Kalkanı (Görünmez)
			local forceField = Instance.new("ForceField")
			forceField.Visible = false
			forceField.Parent = character
			
			-- 4. Canı sabitleme
			humanoid.MaxHealth = 10^9
			humanoid.Health = 10^9
            
            print("Süper koruma denemesi aktif!")
		end
	end)
end)
