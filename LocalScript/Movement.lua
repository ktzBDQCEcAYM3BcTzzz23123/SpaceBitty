local UpValue = false
local DownValue = false
local RightValue = false
local LeftValue = false
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local isGameLoaded = game:IsLoaded()
local Valuez = false

if isGameLoaded == isGameLoaded then
	print("LOADED")
	
	script.Parent.Frame.MainFrame.Changed:Connect(function()
		if script.Parent.Frame.MainFrame.Visible == true then
			if Valuez == false then
				Valuez = true
				
				game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
				TweenService:Create(script.Parent.Frame.Background,TweenInfo.new(5000,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(-10,0,0,0)}):Play()

				UserInputService.InputBegan:Connect(function(hit)
					if hit.KeyCode == Enum.KeyCode.W then
						UpValue = true
					elseif hit.KeyCode == Enum.KeyCode.S then
						DownValue = true
					elseif hit.KeyCode == Enum.KeyCode.D then
						RightValue = true
					elseif hit.KeyCode == Enum.KeyCode.A then
						LeftValue = true
					end
				end)

				UserInputService.InputEnded:Connect(function(hit)
					if hit.KeyCode == Enum.KeyCode.W then
						UpValue = false
					elseif hit.KeyCode == Enum.KeyCode.S then
						DownValue = false
					elseif hit.KeyCode == Enum.KeyCode.D then
						RightValue = false
					elseif hit.KeyCode == Enum.KeyCode.A then
						LeftValue = false
					end
				end)


				RunService.Heartbeat:Connect(function()
					if script.Parent.Frame:findFirstChild("PlayerFrame").ImageTransparency == 0 then
						if UpValue == true then
							TweenService:Create(script.Parent.Frame.PlayerFrame,TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(script.Parent.Frame.PlayerFrame.Position.X.Scale,script.Parent.Frame.PlayerFrame.Position.X.Offset,script.Parent.Frame.PlayerFrame.Position.Y.Scale-0.05,script.Parent.Frame.PlayerFrame.Position.Y.Offset)}):Play()
						elseif DownValue == true then
							TweenService:Create(script.Parent.Frame.PlayerFrame,TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(script.Parent.Frame.PlayerFrame.Position.X.Scale,script.Parent.Frame.PlayerFrame.Position.X.Offset,script.Parent.Frame.PlayerFrame.Position.Y.Scale+0.05,script.Parent.Frame.PlayerFrame.Position.Y.Offset)}):Play()
						elseif RightValue == true then
							TweenService:Create(script.Parent.Frame.PlayerFrame,TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(script.Parent.Frame.PlayerFrame.Position.X.Scale+0.025,script.Parent.Frame.PlayerFrame.Position.X.Offset,script.Parent.Frame.PlayerFrame.Position.Y.Scale,script.Parent.Frame.PlayerFrame.Position.Y.Offset)}):Play()
						elseif LeftValue == true then
							TweenService:Create(script.Parent.Frame.PlayerFrame,TweenInfo.new(0.1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(script.Parent.Frame.PlayerFrame.Position.X.Scale-0.025,script.Parent.Frame.PlayerFrame.Position.X.Offset,script.Parent.Frame.PlayerFrame.Position.Y.Scale,script.Parent.Frame.PlayerFrame.Position.Y.Offset)}):Play()
						end
					end
				end)
			end
		end
	end)
end