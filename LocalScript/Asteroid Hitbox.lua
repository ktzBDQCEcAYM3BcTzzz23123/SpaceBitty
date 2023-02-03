local TweenService = game:GetService("TweenService")
local Meteor = script.Parent

while true do wait()
	if script.Parent.Parent:FindFirstChild(Meteor.Name) then
		for _,Touched in pairs(script.Parent.Parent:GetChildren()) do
			delay(0, function()
				if Touched.Name == "PlayerFrame" then
					delay(0, function()
						if Meteor.Visible == true then
							Meteor.Rotation = Meteor.Rotation +5

							if script.Parent.Parent:findFirstChild("PlayerFrame").ImageTransparency == 0 then
								local PlayerFramePositionX = script.Parent.Parent.PlayerFrame.Position.X.Scale+0.05
								local CheckpointPositionX = Meteor.Position.X.Scale
								local CheckpointPositionX2 = Meteor.Position.X.Scale+0.05

								local PlayerFramePositionY = script.Parent.Parent.PlayerFrame.Position.Y.Scale+0.05
								local CheckpointPositionYUpper = Meteor.Position.Y.Scale+0.1
								local CheckpointPositionYLower = Meteor.Position.Y.Scale-0


								if PlayerFramePositionX >= CheckpointPositionX then
									if CheckpointPositionYLower <= PlayerFramePositionY then
										if CheckpointPositionYUpper >= PlayerFramePositionY then
											if CheckpointPositionX2 > PlayerFramePositionX then
												if script.Parent.Parent.MainFrame.Bar.Value.Value <= 0 then
													--Pass
												else
													script.Parent.Parent.MainFrame.Bar.Value.Value = script.Parent.Parent.MainFrame.Bar.Value.Value -10
													local totalResult = script.Parent.Parent.MainFrame.Bar.Value.Value
													print(totalResult)

													TweenService:Create(script.Parent.Parent.MainFrame.Bar.Bar,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.In,0,false,0),{Size=UDim2.new(tonumber("0." .. totalResult),0,1,0)}):Play()
													Meteor.Visible = false; Meteor:Destroy()
												end
											end
										end
									end
								end
							end
						end
					end)
				elseif Touched:IsA("ObjectValue") then
					delay(0, function()
						if script.Parent.Parent:findFirstChild("PlayerFrame").ImageTransparency == 0 then
							if Meteor.Visible == true then
								local PlayerFramePositionX = Touched.Value.Position.X.Scale+0.05
								local CheckpointPositionX = Meteor.Position.X.Scale
								local CheckpointPositionX2 = Meteor.Position.X.Scale+0.05

								local PlayerFramePositionY = Touched.Value.Position.Y.Scale+0.05
								local CheckpointPositionYUpper = Meteor.Position.Y.Scale+0.1
								local CheckpointPositionYLower = Meteor.Position.Y.Scale-0


								if PlayerFramePositionX >= CheckpointPositionX then
									if CheckpointPositionYLower <= PlayerFramePositionY then
										if CheckpointPositionYUpper >= PlayerFramePositionY then
											if CheckpointPositionX2 > PlayerFramePositionX then
												Touched.Value:Destroy(); Touched:Destroy();

												script.Parent.Parent.Parent.Parent.PointValue.Value = script.Parent.Parent.Parent.Parent.PointValue.Value +math.random(1,10)
												Meteor.Visible = false; Meteor:Destroy()
											end
										end
									end
								end
							end
						end
					end)
				end
			end)
		end
	else
		break
	end
end