-- [[ YNS V42 - ADMIN PARA BASICI ]]
local adminRemote = game:GetService("ReplicatedStorage"):WaitForChild("AdminRemotes"):WaitForChild("SetMoney")

print("--- ADMIN YETKİSİYLE PARA BASILIYOR ---")

task.spawn(function()
    while task.wait(0.1) do -- Saniyede 10 kez gönder
        pcall(function()
            -- Bu kapı muhtemelen iki değer bekliyor: (Oyuncu, Miktar)
            -- Veya sadece (Miktar) bekliyor. Biz ikisini de deniyoruz.
            adminRemote:FireServer(999999) 
            adminRemote:FireServer(game.Players.LocalPlayer, 999999)
        end)
    end
end)

print("--- İŞLEM TAMAM! PARANI VE KONSOLU KONTROL ET ---")
