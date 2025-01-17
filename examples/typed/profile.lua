type UserProfile = {
	Username: string,
	Level: number
}

local userProfile: UserProfile = {
	Username = "Player1",
	Level = 10
}

local proxyUserProfile: proxie.Proxy<UserProfile, string, any> = proxie.createProxy(
	userProfile,
	function(key: string, newValue: any, oldValue: any)
		print(`Key: {key}, Old Value: {oldValue}, New Value: {newValue}`)
	end
)

-- Updating values
proxyUserProfile.Level = 15 -- Logs: Key: Level, Old Value: 10, New Value: 15
proxyUserProfile.Username = "PlayerX" -- Logs: Key: Username, Old Value: Player1, New Value: PlayerX
