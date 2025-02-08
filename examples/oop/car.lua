--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local proxie = require(ReplicatedStorage.proxie)

type CarProperties = {
	Fuel: number,
	DistanceTravelled: number,
	MilesPerGallon: number,
	isUnlocked: boolean
}

type Car = {
	Owner: string,
	Properties: CarProperties,
	_proxyTable: proxie.Proxy<CarProperties>,
}

local function CarConstructorFunction(Owner: string): Car
	
	local properties: CarProperties = {
		Fuel = math.random(10, 100),
		DistanceTravelled = 0,
		MilesPerGallon = math.random(35, 65),
		isUnlocked = false
	}

	local self: Car = {
		Owner = Owner,
		Properties = properties,
		_proxyTable = {} :: proxie.Proxy<CarProperties>
	}
	
	-- In strict mode, the type-solver will error this code. I am yet to make a fix so please create a PR if you know how to.
	self._proxyTable = proxie.createProxy(self.Properties, function(key: string, newValue: number | boolean, oldValue: number | boolean)
		print(
			"[" .. self.Owner .. "'s Car]: " .. key .. " has changed from " .. tostring(oldValue) .. " to " .. tostring(newValue) .. "."
		)
	end)

	-- Redirect Properties to _proxyTable so changes fire the callback
	self.Properties = self._proxyTable

	return self
end


local MyCar = CarConstructorFunction("Shedletsky")
MyCar.Properties.Fuel = 20
print(MyCar.Properties.Fuel) 

--[[

	[OUTPUT]:
	-> [Shedletsky's Car]: Fuel has changed from 51 to 20.
 	-> 20

]]
