print("-disconnection wifi debut")     
wifi.sta.disconnect()
print("-Connect to wifi")
wifi.setmode(wifi.STATION)
wifi.sta.config("mbfree","martineestlaplusbelle")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function()
  if wifi.sta.getip()== nil then
     print("-IP unavaiable, Waiting...")
  else
     tmr.stop(1)
     print("-ESP8266 mode is: " .. wifi.getmode())
     print("-The module MAC address is: " .. wifi.ap.getmac())
     print("-Config done, IP is "..wifi.sta.getip())
  end
end)

ip = wifi.sta.getip()
print("-ip : ")
print(ip)
print("-status : :" .. wifi.sta.status())

print("-start Connect TCP")
conn=net.createConnection(net.TCP, 0)
conn:on("receive", function(conn, payload)
    print("-received")
	print(payload)
    end)
conn:on("disconnection", function(conn,payload)
     print("-disconnect")
     conn:close()
end)

conn:on("connection", function(conn,payload)
     print("-connection : sending...")
     conn:send("HEAD / HTTP/1.0\r\n") 
     conn:send("Accept: */*\r\n")
     conn:send("User-Agent: Mozilla/4.0 (compatible; ESP8266;)\r\n")
     conn:send("\r\n")
end)

conn:dns('google.com',function(conn,ip) ipaddr=ip;
     print("-dns")
     conn:connect(80,ipaddr)
     end)

print("-disconnection wifi")	 
wifi.sta.disconnect()
-- release module
--dht22 = nil
--package.loaded["dht22"]=nil
