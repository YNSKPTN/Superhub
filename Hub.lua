-- [[ YNS V38 - HER ŞEYİ TEKMELE (BRUTE ALL REMOTES) ]]
print("--- TÜM KAPILAR TARANIYOR (İSİM BAĞIMSIZ) ---")

local allRemotes = {}

-- Oyundaki her şeyi tara ve ne kadar RemoteEvent varsa listeye al
for _, v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") then
        table.insert(allRemotes, v)
        print("Hedef Listeye Alındı: " .. v:GetFullName())
    end
end

task.spawn(function()
    while task.wait(0.5) do -- Sunucuyu çökertmemek için yarım saniye
        for _, remote in pairs(allRemotes) do
            pcall(function()
                -- Her kapıya en popüler 'para' komutlarını gönderiyoruz
                remote:FireServer("Gem", 1000)
                remote:FireServer("Diamond", 1000)
                remote:FireServer("AddCash", 1000)
                remote:FireServer(true)
            end)
        end
    end
end)

print("--- ŞU AN TÜM KAPILAR TEST EDİLİYOR! ---")
