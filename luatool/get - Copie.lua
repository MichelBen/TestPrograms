

majorVer, minorVer, devVer, chipid, flashid, flashsize, flashmode, flashspeed = node.info();
print("majorVer   :" .. majorVer)
print("minorVer   :" ..  minorVer)
print("devVer     :" ..  devVer)
print("chipid     :" ..  chipid)
print("flashid    :" ..  flashid)
print("flashsize  :" ..  flashsize)
print("flashmode  :" ..  flashmode)
print("flashspeed :" ..  flashspeed)

PIN = 4 --  data pin, GPIO2

dht22 = require("dht22")
dht22.read(PIN)
t = dht22.getTemperature()
h = dht22.getHumidity()

if h == nil then
  print("Error reading from DHT22")
else
  -- temperature in degrees Celsius  and Farenheit
  -- floating point and integer version:
  print("Temperature C : "..((t-(t % 10)) / 10) .. "." .. (t % 10).." deg C")
  -- only integer version:
 -- print("Temperature F : "..(9 * t / 50 + 32)   .. "." .. (9 * t / 5 % 10).." deg F")
  -- only float point version:
  --print("Temperature F : "..(9 * t / 50 + 32)    .. " deg F")

  -- humidity
  -- floating point and integer version
  print("Humidity      : "..((h - (h % 10)) / 10) .. "." .. (h % 10) .. "%")
end

print("Connect to wifi")
wifi.setmode(wifi.STATION)
wifi.sta.config("mbfree","martineestlaplusbelle")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
  if wifi.sta.getip()== nil then
     print("IP unavaiable, Waiting...")
  else
     tmr.stop(1)
     print("ESP8266 mode is: " .. wifi.getmode())
     print("The module MAC address is: " .. wifi.ap.getmac())
     print("Config done, IP is "..wifi.sta.getip())
  end
end)

ip = wifi.sta.getip()
print("ip : " .. ip)
print("status : :" .. wifi.sta.status())

print("start Connect TCP")
conn=net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, payload)
    print("received")
	print(payload)
    end)
conn:on("disconnection", function(conn,payload)
     print("disconnect")
     conn:close()
end)

conn:on("connection", function(conn,payload)
     print("connection : sending...")
     conn:send("HEAD / HTTP/1.0\r\n") 
     conn:send("Accept: */*\r\n")
     conn:send("User-Agent: Mozilla/4.0 (compatible; ESP8266;)\r\n")
     conn:send("\r\n")

end)

conn:dns('google.com',function(conn,ip) ipaddr=ip;
     --print(ipaddr)
     conn:connect(80,ipaddr)
     end)

print("disconnect wifi")	 
wifi.sta.disconnect()
-- release module
dht22 = nil
package.loaded["dht22"]=nil
