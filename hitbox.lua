local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local hitboxEnabled = false

-- Inject edildiğinde çalışan başlangıç bildirimi
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "HCK Hitbox";
        Text = "Script Başarıyla Yüklendi! (F1)",
        Duration = 3;
    })
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        hitboxEnabled = not hitboxEnabled

        -- Hitboxları düzenle
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

        -- Açıldı / Kapandı bildirimi
        pcall(function()
            if hitboxEnabled then
                StarterGui:SetCore("SendNotification", {
                    Title = "HCK Hitbox";
                    Text = "Hitbox Açıldı!",
                    Duration = 2;
                })
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "HCK Hitbox";
                    Text = "Hitbox Kapandı!",
                    Duration = 2;
                })
            end
        end)
    end
end)
