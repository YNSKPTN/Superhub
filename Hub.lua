local USER_NAME = "cool_name9009" -- Gerçek kullanıcı adın
local DISPLAY_NAME = "notcoolname" -- Görünen ismin

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		-- Hem kullanıcı adını hem de görünen ismi kontrol ediyoruz
		if player.Name == USER_NAME or player.DisplayName == DISPLAY_NAME then
			local humanoid = character:WaitForChild("Humanoid")
			
			-- Canı sonsuz yapıyoruz
			humanoid.MaxHealth = math.huge
			humanoid.Health = math.huge
			
			-- Herhangi bir hasar anında canı saniyesinde geri fulle
			humanoid.HealthChanged:Connect(function()
				if humanoid.Health < math.huge then
					humanoid.Health = math.huge
				end
			end)
			
			-- Ölüm durumunu tamamen devre dışı bırakır (reset çeksen bile ölmezsin)
			humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
			
			print(USER_NAME .. " için tanrı modu aktif!")
		end
	end)
end)
