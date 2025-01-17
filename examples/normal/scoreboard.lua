local dataTable = {
	PlayerName = "Guest",
	Score = 1000
}

local proxyDataTable = proxie.createProxy(
	dataTable,
	function(key, newValue, oldValue)
		print(`Key: {key}, Old Value: {oldValue}, New Value: {newValue}`)
	end
)

-- Adding and modifying fields
proxyDataTable.Health = 100 -- Logs: Key: Health, Old Value: nil, New Value: 100
proxyDataTable.Score = 2000 -- Logs: Key: Score, Old Value: 1000, New Value: 2000
