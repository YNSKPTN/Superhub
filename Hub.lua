local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if method == "FireServer" then
        -- Yakalanan event ismini ve yazdığın kelimeyi sohbete yazar
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "YAKALANDI: " .. self.Name .. " | Kelime: " .. tostring(args[1]);
            Color = Color3.fromRGB(255, 85, 0); -- Turuncu renk
        })
    end
    return oldNamecall(self, ...)
end)
