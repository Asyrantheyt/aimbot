local uis = game:GetService("UserInputService")

_G.aim = false
_G.KeyBind = Enum.KeyCode.F

function getclosest()
    local clodis = math.huge
    local cloplr
    for i,v in pairs(game:GetService("Players"):GetChildren()) do
        if v ~= game:GetService("Players").LocalPlayer and v.TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor and v.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if distance < clodis then
                clodis = distance
                cloplr = v
            end
        end
    end
    return cloplr
end


uis.InputBegan:Connect(function(input)
    if input.KeyCode == _G.KeyBind then
        _G.aim = true
        while _G.aim == true then
            local camera = game:GetService("Workspace").CurrentCamera
            if getclosest().ClassName == "Player" and getclosest().Character:FindFirstChild("Head") and getclosest().TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor then
                camera.CFrame = CFrame.new(camera.CFrame.Position, getclosest().Character.Head.Position)
                uis.InputEnded:Connect(function(input)
                    if input.KeyCode == _G.KeyBind then
                        _G.aim = false
                    end
                end)
                if _G.aim == false then break end
                game:GetService("RunService").RenderStepped:Wait()
            end
        end
    end
end)

uis.InputEnded:Connect(function(input)
    if input.KeyCode == _G.KeyBind then
        _G.aim = false
    end
end)
