getgenv().Players = game:GetService'Players'
getgenv().TeleportService = game:GetService'TeleportService'
getgenv().ReplicatedStorage = game:GetService'ReplicatedStorage' 
getgenv().StarterGui = game:GetService'StarterGui'
getgenv().TweenService = game:GetService'TweenService'
getgenv().UserInput = game:GetService'UserInputService'
getgenv().RunService = game:GetService'RunService'
getgenv().Lighting = game:GetService'Lighting'
getgenv().CoreGui = game:GetService'CoreGui'
getgenv().HttpService = game:GetService'HttpService'
getgenv().VirtualUser = game:GetService'VirtualUser'
getgenv().LP = Players.LocalPlayer or Players.PlayerAdded:Wait()
getgenv().Mouse = LP:GetMouse()
getgenv().GetChar = function() return LP.Character or LP.CharacterAdded:Wait() end
GetChar():WaitForChild'Humanoid'

local Raw = getrawmetatable(game)
setreadonly(Raw, false)

local newcclosure, getnamecallmethod, checkcaller, getcaller = newcclosure, getnamecallmethod, checkcaller, getcallingscript
local ACFlags, INFlags = {
	'WalkSpeed', 'JumpPower', 'HipHeight', 'Health'
}, {
	'bv', 'hb', 'ws'
}

local NewIndex, NameCall; do
	local IsA, IsDescendantOf = game.IsA, game.IsDescendantOf
	local tfind = table.find

	local unpack = unpack

	local StarterGui = game:GetService'StarterGui'
	local SetCore = StarterGui.SetCore

	local NewIndexFunc = function(self, Key, Value)
		if not checkcaller() then
			if IsA(self, 'Humanoid') then
				SetCore(StarterGui, 'ResetButtonCallback', true)

				if tfind(ACFlags, Key) then
					return
				end
			end
			if self == workspace and Key == 'Gravity' then
				return NormalGravity
			end
			if Key == 'CFrame' and IsDescendantOf(self, LP.Character) then
				return
			end
		end
		return NewIndex(self, Key, Value)
	end

	local NameCallFunc = function(self, ...)
		local Method = getnamecallmethod()
		local Args = {...}

		if checkcaller() then
			if Method == 'FindFirstChild' and Args[1] == 'RealHumanoidRootPart' then
				Args[1] = 'HumanoidRootPart'
			end
			return NameCall(self, unpack(Args))
		end

		if (Method == 'Destroy' or Method == 'Kick') and (self == LP or IsA(self, 'BodyMover')) then
			return wait(9e9)
		end
		if Method == 'BreakJoints' and self == LP.Character then
			return wait(9e9)
		end
		if (Method == 'WaitForChild' or Method == 'FindFirstChild') and getcaller() ~= script and TpBypass and Args[1] == 'HumanoidRootPart' then
			Args[1] = 'Torso'
			return NameCall(self, unpack(Args))
		end

		if Method == 'FireServer' then
			if tfind(ACFlags, Args[1]) then
				return wait(9e9)
			end

			local Name = self.Name

			if Name == 'Fire' and Aimlock and AimlockTarget then
				return NameCall(self, AimbotToCFrame())
			end
			if Name == 'Input' then
				if tfind(INFlags, Args[1]) then
					return wait(9e9)
				end

				if Aimlock and AimlockTarget then
					if Args[2] and Args[2].mousehit then
						Args[2].mousehit = AimbotToCFrame()
						return NameCall(self, unpack(Args))
					end
				end
			end

			if self.Parent == ReplicatedStorage or Args[1] == 'hey' and Name ~= 'SayMessageRequest' then
				return wait(9e9)
			end
			if Name == 'Touch1' and AlwaysGh then
				Args[3] = true
				return NameCall(self, unpack(Args))
			end
			if Args[1] == 'play' then
				PlayOnDeath = Args[2]
			elseif Args[1] == 'stop' then
				PlayOnDeath = nil
			end
		end

		return NameCall(self, unpack(Args))
	end

	if syn then
		NewIndex = hookmetamethod(game, '__newindex', newcclosure(NewIndexFunc))
		NameCall = hookmetamethod(game, '__namecall', newcclosure(NameCallFunc))
	else
		NewIndex = hookfunction(Raw.__newindex, newcclosure(NewIndexFunc))
		NameCall = hookfunction(Raw.__namecall, newcclosure(NameCallFunc))
	end
end
