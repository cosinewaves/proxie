--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local proxie = require(ReplicatedStorage.proxie)

-- Since the car type references this table twice, it's easier to store it as a single type.
type CarProperties = {
	Fuel: number,
	DistanceTravelled: number,
	MilesPerGallon: number,
	isUnlocked: boolean
}

type Car = {
	Owner: string,
	Properties: CarProperties,
	_proxyTable: proxie.Proxy<CarProperties>, -- Ensure to pass CarProperties as a generic type to receive intellisense support
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
		_proxyTable = {} :: proxie.Proxy<CarProperties> -- Typecasting the type stops the type solver having a tantrum in strict mode
	}
	
	-- NOTE: In strict mode, the type-solver will error this code. I am yet to make a fix so please create a PR if you know how to.
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
