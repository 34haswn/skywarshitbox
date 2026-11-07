local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local hitboxEnabled = false

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        hitboxEnabled = not hitboxEnabled

        -- Hitboxları düzenle (hiçbir hata çıkmaz)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player then
                local char = p.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        if hitboxEnabled then
                            root.Size = Vector3.new(5, 5, 5)
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

        -- GUI hatasız şekilde güncellenir (hiçbir warn veya error olmaz)
        local playerGui = player:FindFirstChild("PlayerGui")
        if playerGui then
            local screen = playerGui:FindFirstChild("ScreenGui")
            if screen then
                local frame = screen:FindFirstChild("PromoFrame")
                if frame then
                    local promoLabel = frame:FindFirstChild("Advertising")
                    if promoLabel then
                        if hitboxEnabled then
                            promoLabel.Text = "Join the group in the desc for codes!"
                        else
                            promoLabel.Text = "Kodlar için iniş sırasında grupye katıl!"
                        end
                    end
                end
            end
        end
    end
end)
