local cart = {
	["Apple"] = 3,
	["Banana"] = 2
}

local proxyCart = proxie.createProxy(
	cart,
	function(key, newValue, oldValue)
		print(`Cart Updated - Item: {key}, Old Quantity: {oldValue}, New Quantity: {newValue}`)
	end
)

-- Adding new items and updating quantities
proxyCart["Apple"] = 5 -- Logs: Cart Updated - Item: Apple, Old Quantity: 3, New Quantity: 5
proxyCart["Orange"] = 4 -- Logs: Cart Updated - Item: Orange, Old Quantity: nil, New Quantity: 4
