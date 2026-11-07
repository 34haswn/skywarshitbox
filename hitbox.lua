local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local hitboxEnabled = false

local function showNotification(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = text;
            Duration = duration or 2;
        })
    end)
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F1 then
        hitboxEnabled = not hitboxEnabled

        -- Hitbox boyutlarını ve durumunu güncelle
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player then
                local char = p.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        if hitboxEnabled then
                            root.Size = Vector3.new(5, 4, 4)
                            root.CanCollide = false
                            root.Transparency = 1
                        else
                            root.Size = Vector3.new(2, 2, 1)
                            root.CanCollide = true
                            root.Transparency = 1
                        end
                    end
                end
            end
        end

        -- Sağ altta çıkacak bildirimler
        if hitboxEnabled then
            showNotification("HCK Hitbox", "Hitbox Açıldı!", 2)
        else
            showNotification("HCK Hitbox", "Hitbox Kapandı!", 2)
        end
    end
end)
