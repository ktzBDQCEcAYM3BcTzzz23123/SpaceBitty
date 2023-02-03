local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local MeteorTable = {}
local MeteorValue = 0
local isGameLoaded = game:IsLoaded()
local Gui = script.Parent.Parent.Playable
local Valuez = false

if isGameLoaded == isGameLoaded then
	print("TRUE")
	
	Gui.Frame.MainFrame.Changed:Connect(function()
		if Gui.Frame.MainFrame.Visible == true then
			if Valuez == false then
				Valuez = true
				
				for _,Meteors in pairs(Gui.Frame:GetChildren()) do
					if string.find(Meteors.Name,"Checkpoint") then
						MeteorValue = MeteorValue +1
						MeteorTable[MeteorValue] = Meteors
					end
				end

				delay(0, function()
					while true do wait(1)
						delay(0, function()
							if Gui.Frame:findFirstChild("PlayerFrame").ImageTransparency == 0 then
								for shoot = 0,script.Parent.Parent.FireRateValue.Value do wait(0.1)
									delay(0, function()
										local Ammo = Gui.Frame.Ammo:Clone()
										local Laser = Gui.Laser:Clone()
										Laser.Parent = Ammo; Laser:Play()
										local ObjectValue = Instance.new("ObjectValue")
										ObjectValue.Name = "AmmoValue"; ObjectValue.Value = Ammo
										Ammo.Name = "Ammo_" .. math.random(1,9999); Ammo.Visible = true; Ammo.Position = UDim2.new(Gui.Frame.PlayerFrame.Position.X.Scale,Gui.Frame.PlayerFrame.Position.X.Offset,Gui.Frame.PlayerFrame.Position.Y.Scale+0.052,Gui.Frame.PlayerFrame.Position.Y.Offset)
										Ammo.Parent = Gui.Frame; ObjectValue.Parent = Gui.Frame; TweenService:Create(Ammo,TweenInfo.new(8,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(Ammo.Position.X.Scale+5,Ammo.Position.X.Offset,Ammo.Position.Y.Scale,Ammo.Position.Y.Offset)}):Play(); wait(2); Ammo:Destroy()
										ObjectValue:Destroy()
									end)
								end
							end
						end)

						delay(0, function()
							if Gui.Frame.PlayerFrame.Position.X.Scale <= -0.1 then
								Gui.Frame.MainFrame.Bar.Value.Value = Gui.Frame.MainFrame.Bar.Value.Value -10
								TweenService:Create(Gui.Frame.MainFrame.Bar.Bar,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Size=UDim2.new(tonumber(Gui.Frame.MainFrame.Bar.Value.Value/100),0,1,0)}):Play()
							elseif Gui.Frame.PlayerFrame.Position.Y.Scale >= 1 then
								Gui.Frame.MainFrame.Bar.Value.Value = Gui.Frame.MainFrame.Bar.Value.Value -10
								TweenService:Create(Gui.Frame.MainFrame.Bar.Bar,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Size=UDim2.new(tonumber(Gui.Frame.MainFrame.Bar.Value.Value/100),0,1,0)}):Play()
							elseif Gui.Frame.PlayerFrame.Position.Y.Scale <= -0.1 then
								Gui.Frame.MainFrame.Bar.Value.Value = Gui.Frame.MainFrame.Bar.Value.Value -10
								TweenService:Create(Gui.Frame.MainFrame.Bar.Bar,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Size=UDim2.new(tonumber(Gui.Frame.MainFrame.Bar.Value.Value/100),0,1,0)}):Play()
							elseif Gui.Frame.PlayerFrame.Position.X.Scale >= 1 then
								Gui.Frame.MainFrame.Bar.Value.Value = Gui.Frame.MainFrame.Bar.Value.Value -10
								TweenService:Create(Gui.Frame.MainFrame.Bar.Bar,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Size=UDim2.new(tonumber(Gui.Frame.MainFrame.Bar.Value.Value/100),0,1,0)}):Play()
							end
						end)

						delay(0, function()
							for Spawns = 0,script.Parent.Parent.MultipleValue.Value do
								delay(0, function()
									local Meteor = MeteorTable[math.random(1,MeteorValue)]:Clone()
									print(Meteor.Name)
									Meteor.Position = UDim2.new(1,0,Random.new():NextNumber(0,0.95),0)
									Meteor.Parent = Gui.Frame; Meteor.Name = "Meteor_" .. math.random(1,999999)
									local Times = math.random(1,10)
									Meteor.Visible = true; Meteor.LocalScript.Enabled = true ;TweenService:Create(Meteor,TweenInfo.new(Times,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(-1,0,Meteor.Position.Y.Scale,0)}):Play()

									delay(Times, function()
										Meteor:Destroy()
									end)
								end)
							end
						end)
					end
				end)

				Gui.Frame.MainFrame.TextButton.MouseButton1Down:Connect(function()
					if script.Parent.Parent.FireRateValue.Value >= 3 then
						Gui.Frame.MainFrame.TextButton.Text = "MAX UPGRADE"
					else
						if script.Parent.Parent.PointValue.Value >= 50 then
							script.Parent.Parent.PointValue.Value = script.Parent.Parent.PointValue.Value -50
							script.Parent.Parent.FireRateValue.Value = script.Parent.Parent.FireRateValue.Value +1
							Gui.Frame.MainFrame.TextButton.TextLabel.Text = "FIRERATE:" .. script.Parent.Parent.FireRateValue.Value
						else
							delay(0, function()
								Gui.Frame.MainFrame.TextButton.Text = "NOT ENOUGH POINT" wait(1)
								Gui.Frame.MainFrame.TextButton.Text = "FIRE RATE 1+ / 50 POINTS"
							end)
						end
					end
				end)
			end
		end
	end)
end