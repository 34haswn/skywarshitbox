local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

-- Bildirim fonksiyonu
local function showNotification(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = text;
            Duration = duration or 2;
        })
    end)
end

-- Inject edildiği an bildirim ver ve hitboxları büyüt
showNotification("HCK Hitbox", "Script Çalıştı!", 2)

-- Oyundaki mevcut oyuncuların hitboxlarını hemen büyüt
for _, p in pairs(Players:GetPlayers()) do
    if p ~= player then
        local char = p.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Size = Vector3.new(5, 5, 5)
                root.CanCollide = false
                root.Transparency = 1
            end
        end
    end
end

-- Sonradan oyuna girenler için de otomatik aktif kalması (isteğe bağlı döngü)
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        local root = char:WaitForChild("HumanoidRootPart", 5)
        if root then
            root.Size = Vector3.new(5, 5, 5)
            root.CanCollide = false
            root.Transparency = 1
        end
    end)
end)
