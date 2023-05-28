local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")
local lplr = game:GetService("Players").LocalPlayer

_G.aim = false
_G.autoclickwhileaim = true
_G.KeyBind = Enum.KeyCode.F
local yay,sus = pcall(function()
	function getclosest()
	print("in getclo function")
	    local clodis = math.huge
	    local cloplr
	    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	    print("out if")
	        if v ~= game:GetService("Players").LocalPlayer and v.TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health ~= 0 then
	        print("in if")
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
	            if _G.autoclickwhileaim == true and getclosest().ClassName == "Player" and getclosest().Character:FindFirstChild("Head") and getclosest().TeamColor ~= game:GetService("Players").LocalPlayer.TeamColor then
	                ts:Create(camera,TweenInfo.new(0.25), {CFrame = CFrame.new(camera.CFrame.Position, getclosest().Character.Head.Position)}):Play()
	                if lplr:GetMouse().Target and getclosest().Character.Parent:FindFirstChild(lplr:GetMouse().Target.Parent.Name) then 
	                	local person = getclosest().Character.Parent:FindFirstChild(lplr:GetMouse().Target.Parent.Name)
	                	if type(mouse1down) ~= 'function' then
		                	mouse1press() 
		                	elseif type(mouse1press) ~= 'function' then 
		                	mouse1down() 
		                	else 
		                	print("missing mouse1down or mouse1press") 
	                	end
	                	game:GetService("RunService").RenderStepped:Wait()
	                	if type(mouse1up) ~= 'function' then 
		                	mouse1release() 
		                	elseif type(mouse1release) ~= 'function' then
		                	mouse1up()
		                	else
		                	print("missing mouse1up or mouse1release")
	                	end
	                end
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
if sus then warn(sus) error(sus) end
