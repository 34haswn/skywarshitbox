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

        -- Hitboxları ve görünürlüğü düzenle
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player then
                local char = p.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        if hitboxEnabled then
                            root.Size = Vector3.new(5, 4, 4)
                            root.CanCollide = false
                            root.Transparency = 0.8 -- Kendi orijinal görüntüsünü bozmasın diye

                            -- Adamın üzerinde net görünmesi için Highlight (Parlama) efekti ekle
                            local highlight = char:FindFirstChild("HCK_Highlight")
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.Name = "HCK_Highlight"
                                highlight.Adornee = char
                                highlight.FillColor = Color3.fromRGB(255, 0, 0) -- İç renk (Kırmızı)
                                highlight.FillTransparency = 0.5
                                highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Çerçeve rengi (Beyaz)
                                highlight.OutlineTransparency = 0
                                highlight.Parent = char
                            end
                        else
                            root.Size = Vector3.new(2, 2, 1)
                            root.CanCollide = true
                            root.Transparency = 1

                            -- Hitbox kapandığında parlamayı sil
                            local highlight = char:FindFirstChild("HCK_Highlight")
                            if highlight then
                                highlight:Destroy()
                            end
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
