local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")

_G.aim = false
_G.KeyBind = Enum.KeyCode.F
local yay,sus = pcall(function()
	function getclosest()
	    local clodis = math.huge
	    local cloplr
	    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	        if v ~= game:GetService("Players").LocalPlayer and v.TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health ~= 0 then
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
	        while _G.aim == true do
	            local camera = game:GetService("Workspace").CurrentCamera
	            if getclosest().ClassName == "Player" and getclosest().Character:FindFirstChild("Head") and getclosest().TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor then
	                ts:Create(camera,TweenInfo.new(0.25), {CFrame = CFrame.new(camera.CFrame.Position, getclosest().Character.Head.Position)}):Play()
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
end)
if sus then warn(sus) and error(sus) end
