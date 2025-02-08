# proxie - a modern, strictly typed proxy table solver written in luau
*proxie* is a easy to use and stricly typed roblox proxy table creator. it was derived from [this](https://devforum.roblox.com/t/metatable-and-proxy-table-help/3086359/2) post and turned into a module script for easier use and allowing you to use it across scripts.

## how to use (non-typed)
to use the module, require the `proxie` module from anywhere in your game.
```lua
local proxie = require(ReplicatedStorage.Packages.proxie)
```
you can then call the `createProxy` constructor function on the module to create a new proxy table. you must pass along a pre-existing table in the function alongside a callback function for which will be ran when a value in the table changes.
```lua
-- table can be empty 
local myTable = { 
  Name = "proxie fan #1",
  Age = 53,
  Married = true,
}

-- you can add keys later on
myTable.Address = "1 Roblox Lane"

local myCallbackFunction = function (key, newValue, oldValue)
  print(`key: {key} has changed from {oldValue} to {newValue}`)
end

local proxyTable = proxie.createProxy(myTable, myCallbackFunction)
```
you can then update values inside your passed table which will trigger the callback function.
```lua
local myTable = ...
local proxyTable = ...

myTable.Age =+ 1
myTable.Married = false

-- [OUTPUT]: key: Age has changed from 53 to 54
-- [OUTPUT]: key: Married has changed from true to false

```
## how to use (typed)
*proxie* has two types of which are:
```lua
export type Proxy<T> = {[any]: any}
export type ProxyCallback<I, V> = (key: I, newValue: V, oldValue: V) -> ()
```
the `Proxy<T>` type serves as the type for your created Proxy table which you create in the module. the `ProxyCallback<I, V>` type serves as the type for the callback function you pass to the constructor function. both types are generic types allowing you to have whatever types you'd like in your table, receiving full intellisense support. for mixed tables, i.e. the example above, you can use `any` to annotate your tables. you can also use type unions.

to create a typed proxy table, you must first add a type to your pre-existing table. following the example above, you can do something like this.
```lua
type myTableType = {
  Name: string,
  Age: number,
  Married: boolean
}

local myTable: myTableType = {
  Name = "proxie fan #1",
  Age = 53,
  Married = true
}
```
you must then type annotate the constructor function to correctly get intelisense support.
```lua
local proxie = require(...)
local myTable: myTableType = ...

local myProxieTable: proxie.Proxy<myTableType, string, any> = proxie.createProxy(
  myTable,
  function(key: string, newValue: any, oldValue: any)
    print(`Key: {key}, Old Value: {oldValue}, New Value: {newValue}`)
  end
)
```
you can also pass in a existing function for better readabilty.
```lua
local proxie = require(...)
local myTable: myTableType = ...

local callback = function(key: string, newValue: any, oldValue: any): ()
  print(`Key: {key}, Old Value: {oldValue}, New Value: {newValue}`)
end

local myProxieTable: proxie.Proxy<myTableType, string, any> = proxie.createProxy(
  myTable,
  callback
)
```
## how to use for oop
please see examples/oop/car
## footer
all credits of this module go to the author [OniiSamaUwU](https://www.roblox.com/users/profile?username=OniiSamaUwU)
any questions please contact me on discord, my id is 732286835492913174. 




