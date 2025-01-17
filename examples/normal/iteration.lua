local scores = {
	Alice = 95,
	Bob = 88,
	Charlie = 76
}

local proxyScores = proxie.createProxy(
	scores,
	function(key, newValue, oldValue)
		print(`Score Update - Player: {key}, Old Score: {oldValue}, New Score: {newValue}`)
	end
)

-- Iterating through the table
for key, value in proxyScores do
	print(`Player: {key}, Score: {value}`)
end

-- Modifying scores
proxyScores.Alice = 100 -- Logs: Score Update - Player: Alice, Old Score: 95, New Score: 100
proxyScores.Bob = 90 -- Logs: Score Update - Player: Bob, Old Score: 88, New Score: 90
