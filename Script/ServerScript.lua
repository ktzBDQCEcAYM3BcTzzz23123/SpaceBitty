local Datastore = game:GetService("DataStoreService")

game.Players.PlayerAdded:Connect(function(player)
	local RateLimit = Instance.new("BoolValue")
	RateLimit.Name = "RateLimit"; RateLimit.Parent = player
	
	delay(0, function()
		player.CharacterAdded:Connect(function()
			if player.Character:WaitForChild("Humanoid") then
				if workspace:WaitForChild(player.Name):WaitForChild("Humanoid") then
					player.Character.Humanoid.WalkSpeed = 0
				end
			end
		end)
	end)
end)

game.ReplicatedStorage.RemoteEvent.OnServerEvent:Connect(function(Player, Responsed)
	if Responsed[1] == "Save" then
		delay(0, function()
			if Player:FindFirstChild("RateLimit").Value == false then
				Player.RateLimit.Value = true
				local LeaderboardDatabase = Datastore:GetDataStore("Leaderboard"):GetAsync("Datastore")
				local LeaderboardTable = {}; local LeaderboardValue = 0

				if LeaderboardDatabase == nil then
					LeaderboardValue = LeaderboardValue +1
					LeaderboardTable[LeaderboardValue] = {Player.Name,tonumber(Responsed[2])}

					local DataSave = Datastore:GetDataStore("Leaderboard"):SetAsync("Datastore", LeaderboardTable)

					if DataSave == DataSave then
						print(DataSave)
					end
				else
					LeaderboardValue = LeaderboardValue +1
					LeaderboardTable[LeaderboardValue] = {Player.Name,tonumber(Responsed[2])}

					for _,DataTable in pairs(LeaderboardDatabase) do
						if DataTable[1] == Player.Name then
							--Pass
						else
							LeaderboardValue = LeaderboardValue +1
							LeaderboardTable[LeaderboardValue] = {DataTable[1],DataTable[2]}
						end
					end

					table.sort(LeaderboardTable, function(a,b)
						return a[2]>b[2]
					end)
					
					local CheckedValue = 0
					
					for z,Checks in pairs(LeaderboardTable) do
						CheckedValue = CheckedValue +1
					end
										
					if CheckedValue == 6 then
						print(LeaderboardTable[6][1])
						if LeaderboardTable[6][1] == Player.Name then
							--Pass
						else
							local DataSave = Datastore:GetDataStore("Leaderboard"):SetAsync("Datastore", LeaderboardTable)

							if DataSave == DataSave then
								print(DataSave)
							end
						end
					else
						local DataSave = Datastore:GetDataStore("Leaderboard"):SetAsync("Datastore", LeaderboardTable)

						if DataSave == DataSave then
							print(DataSave)
						end
					end
				end
			end
		end)
	elseif Responsed == "GetLB" then
		delay(0, function()
			local DBS = Datastore:GetDataStore("Leaderboard"):GetAsync("Datastore")
			
			if DBS == nil then
				--Pass
			else
				game.ReplicatedStorage.RemoteEvent:FireClient(Player,DBS)
			end
		end)
	end
end)

delay(0, function()
	while true do wait(10)
		for _,Players in pairs(game.Players:GetChildren()) do
			delay(0, function()
				if Players:FindFirstChild("RateLimit") then
					if Players.RateLimit.Value == true then
						Players.RateLimit.Value = false
					end
				end
			end)
		end
	end
end)