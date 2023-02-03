local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local isGameLoaded = game:IsLoaded()
local Valuez = false

if isGameLoaded == isGameLoaded then
	delay(0, function()
		for _,button in pairs(script.Parent.Frame.WelcomeFrame:GetChildren()) do
			delay(0, function()
				if button:IsA("TextButton") then
					button.MouseEnter:Connect(function()
						TweenService:Create(button,TweenInfo.new(0.3,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Size=UDim2.new(0.653, 0,0.192, 0)}):Play()
					end)

					button.MouseLeave:Connect(function()
						TweenService:Create(button,TweenInfo.new(0.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out,0,false,0),{Size=UDim2.new(0.701, 0,0.236, 0)}):Play()
					end)
				end
			end)
		end
	end)
	
	game.ReplicatedStorage.RemoteEvent:FireServer("GetLB")

	game.ReplicatedStorage.RemoteEvent.OnClientEvent:Connect(function(Responsed)
		delay(0, function()
			local LBTable = {}
			local LBValues = 0

			for _,TableValue in pairs(Responsed) do
				delay(0, function()
					print(TableValue[1],TableValue[2])
					LBValues = LBValues +1
					LBTable[TableValue] = {TableValue[1],TableValue[2]}

					local LBPlayer = script.Parent.Frame.LeaderboardFrame.Frame.LbText:Clone()
					LBPlayer.Parent = script.Parent.Frame.LeaderboardFrame.Frame

					LBPlayer.LayoutOrder = LBValues
					LBPlayer.Name = TableValue[1]; LBPlayer.Text = TableValue[1] .. ", " .. TableValue[2] .. " Points"
					LBPlayer.Visible = true
				end)
			end
		end)
	end)

	script.Parent.Frame.WelcomeFrame.TextButton.MouseButton1Down:Connect(function()
		script.Parent.Frame.MainFrame.Visible = true; script.Parent.Frame.WelcomeFrame.Visible = false
		script.Parent.Frame.PlayerFrame.Visible = true
	end)
	
	script.Parent.Frame.WelcomeFrame.Leaderboard.MouseButton1Down:Connect(function()
		script.Parent.Frame.WelcomeFrame.Visible = false
		script.Parent.Frame.LeaderboardFrame.Visible = true
	end)
	
	script.Parent.Frame.LeaderboardFrame.TextButton.MouseButton1Down:Connect(function()
		script.Parent.Frame.LeaderboardFrame.Visible = false
		script.Parent.Frame.WelcomeFrame.Visible = true
	end)

	delay(0, function()
		for _,Buttons in pairs(script.Parent:GetDescendants()) do
			if Buttons:IsA("TextButton") then
				delay(0, function()
					Buttons.MouseEnter:Connect(function()
						script.Parent.Leave:Play()
					end)

					Buttons.MouseButton1Down:Connect(function()
						script.Parent.Clicked:Play()
					end)
				end)
			end
		end
	end)

	script.Parent.Frame.MainFrame.Changed:Connect(function()
		if script.Parent.Frame.MainFrame.Visible == true then
			if Valuez == false then
				Valuez = true
				
				game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

				delay(0, function()
					while true do wait(15)
						if script.Parent.Parent.MultipleValue.Value >= 1 then
							--Pass
						else
							script.Parent.Parent.MultipleValue.Value = script.Parent.Parent.MultipleValue.Value +1
						end
					end
				end)

				local Smokes = false
				local Done = false

				script.Parent.Frame.MainFrame.Bar.Value.Changed:Connect(function()
					script.Parent.Frame.MainFrame.Bar.TextLabel.Text = script.Parent.Frame.MainFrame.Bar.Value.Value .. " HP"

					if script.Parent.Frame.MainFrame.Bar.Value.Value <= 50 then
						script.Parent.Warning.Playing = true

						if script.Parent.Frame.MainFrame.Bar.Value.Value <= 1 then
							if Done == false then
								Done = true;

								delay(0, function()
									game.ReplicatedStorage.RemoteEvent:FireServer({"Save",script.Parent.Parent.PointValue.Value})
								end)

								script.Parent.Warning:Stop()
								script.Parent.Frame.MainFrame.Visible = false; script.Parent.Destroyed:Play()
								local Explode = script.Parent.Frame.PlayerFrame.Explode:Clone()
								Explode.Size = UDim2.new(0,0,0,0); Explode.Parent = script.Parent.Frame.PlayerFrame
								Explode.Name = "Death"; Explode.Visible = true; script.Parent.Frame.PlayerFrame.ImageTransparency = 1

								TweenService:Create(Explode,TweenInfo.new(2,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out,0,false,0),{Size=UDim2.new(2.997,0,1.508,0)}):Play()

								delay(2, function()
									TweenService:Create(Explode,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{ImageTransparency=1}):Play()

									wait(2)

									TweenService:Create(script.Parent.Frame.Dead,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{TextTransparency=0}):Play()
									TweenService:Create(script.Parent.Frame.Dead.UIStroke,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Transparency=0}):Play()

									wait(2)
									script.Parent.Frame.Dead.Frame.TextButton.Size = UDim2.new(0,0,0,0); script.Parent.Frame.Dead.Frame.TextButton.Visible = true; script.Parent.Welcomed:Play()
									TweenService:Create(script.Parent.Frame.Dead.Frame.TextButton,TweenInfo.new(1,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out,0,false,0),{Size=UDim2.new(0.524, 0,0.94, 0)}):Play()
									script.Parent.Frame.Dead.Frame.TextButton.MouseButton1Down:Connect(function()
										script.Parent.Parent.PointValue.Value = 0; script.Parent.Parent.FireRateValue.Value = 0; script.Parent.Parent.MultipleValue.Value = 0
										Player.Character.Humanoid.Health = Player.Character.Humanoid.Health -Player.Character.Humanoid.MaxHealth; task.wait()

										delay(0, function()
											for _,Fls in pairs(script.Parent:GetDescendants()) do
												delay(0, function()
													if Fls:IsA("LocalScript") then
														Fls:Destroy()
													end
												end)
											end
										end)
									end)
								end)
							end
						else
							Smokes = true
						end
					else
						Smokes = false
					end
				end)

				delay(0, function()
					while true do wait(0.1)
						if Smokes == true then
							if script.Parent.Frame:findFirstChild("PlayerFrame").ImageTransparency == 0 then
								delay(0, function()
									local Smokes = script.Parent.Frame.Smokes:Clone()
									Smokes.Parent = script.Parent.Frame; Smokes.Position = script.Parent.Frame.PlayerFrame.Position
									Smokes.Visible = true

									local SmokesX = Smokes.Position.X.Scale-Random.new():NextNumber(-0.5,0.5)
									local SmokesY = Smokes.Position.Y.Scale-Random.new():NextNumber(-0.5,0.5)

									TweenService:Create(Smokes,TweenInfo.new(5,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Position=UDim2.new(SmokesX,0,SmokesY,0)}):Play()
									TweenService:Create(Smokes,TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Size=UDim2.new(0,0,0,0)}):Play()

									delay(0, function()
										while true do wait(0.05)
											Smokes.Rotation = Smokes.Rotation +1
										end
									end)

									delay(5, function()
										Smokes:Destroy()
									end)
								end)
							end
						end
					end
				end)

				script.Parent.Parent.PointValue.Changed:Connect(function()
					script.Parent.Frame.MainFrame.TextLabel.Text = "POINTS: " .. script.Parent.Parent.PointValue.Value
				end)
			end
		end
	end)
end