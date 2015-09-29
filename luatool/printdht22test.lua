PIN = 4 --  data pin, GPIO2

dht22 = require("dht22test.lua")
dht22.read(PIN)



-- release module
dht22 = nil
package.loaded["dht22test"]=nil