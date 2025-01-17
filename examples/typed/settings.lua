type Settings = {
	MusicVolume: number,
	GraphicsQuality: string
}

local settings: Settings = {
	MusicVolume = 50,
	GraphicsQuality = "High"
}

local proxySettings: proxie.Proxy<Settings, string, any> = proxie.createProxy(
	settings,
	function(key: string, newValue: any, oldValue: any)
		print(`Setting Changed - Key: {key}, Old Value: {oldValue}, New Value: {newValue}`)
	end
)

-- Modifying settings
proxySettings.MusicVolume = 75 -- Logs: Setting Changed - Key: MusicVolume, Old Value: 50, New Value: 75
proxySettings.GraphicsQuality = "Ultra" -- Logs: Setting Changed - Key: GraphicsQuality, Old Value: High, New Value: Ultra
