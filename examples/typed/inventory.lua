type Inventory = {
	[ItemName: string]: number
}

local inventory: Inventory = {
	["Potion"] = 5,
	["Sword"] = 1
}

local proxyInventory: proxie.Proxy<Inventory, string, number> = proxie.createProxy(
	inventory,
	function(key: string, newValue: number, oldValue: number)
		print(`Item: {key}, Old Count: {oldValue}, New Count: {newValue}`)
	end
)

-- Updating inventory
proxyInventory["Potion"] = 10 -- Logs: Item: Potion, Old Count: 5, New Count: 10
proxyInventory["Shield"] = 1 -- Logs: Item: Shield, Old Count: nil, New Count: 1
