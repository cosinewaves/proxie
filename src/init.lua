--!strict
export type Proxy<T> = {
	[any]: any
}

export type ProxyCallback<I, V> = (key: I, newValue: V, oldValue: V) -> ()

export type ProxyModule = {
	createProxy: <T, I, V>(t: T, callbackFunction: ProxyCallback<I, V>) -> T
}

local ProxyModule: ProxyModule = {}

function ProxyModule.createProxy<T, I, V>(t: T, callbackFunction: ProxyCallback<I, V>): T
	assert(typeof(t) == "table", "Expected a table as the first argument")

	local proxy: any = newproxy(true)
	local proxyMetatable: {[any]: any} = getmetatable(proxy)

	-- Direct indexing back to the original table
	proxyMetatable.__index = function(_: any, index: I): V
		return t[index] :: V
	end

	-- Listen for new index on proxy and apply it to the original table
	proxyMetatable.__newindex = function(_: any, index: I, newValue: V): ()
		local oldValue: V = t[index] :: V
		t[index] = newValue
		callbackFunction(index, newValue, oldValue)
	end

	-- Direct iteration to the original table
	proxyMetatable.__iter = function(_: any): (typeof(next), T)
		return next, t
	end

	return proxy
end

return table.freeze(ProxyModule)
