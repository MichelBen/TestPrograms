local function onConnectCb(str)
 print("---onConnectCb")
 print(string.format("status %s",wifi.sta.status()))
 print(string.format("IP %s",wifi.sta.getip()))

 print("-start Connect TCP")
 netSocket=net.createConnection(net.TCP, 0)

 --netSocket:on("connection", function(conn,payload)
 --    print("------ connection : sending...")
 --    conn:send("HEAD / HTTP/1.0\r\n") 
 --    conn:send("Accept: */*\r\n")
 --    conn:send("User-Agent: Mozilla/4.0 (compatible; ESP8266;)\r\n")
 --    conn:send("\r\n")
 --end)
 
 netSocket:on("receive", function(conn, payload)
    print("--------- received")
    print(payload)
    end)
 netSocket:on("disconnection", function(conn,payload)
     print("-------- disconnect")
     --conn:close()
 end)

 netSocket:connect(80,'google.com')
 netSocket:send("GET HTTP/1.1\r\nHost:google.com\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
 --conn:dns('google.com',function(conn,ip) ipaddr=ip;
 --    print("-dns")
 --    conn:connect(80,ipaddr)
 --    end)

 -- print("-disconnection wifi")     
 -- wifi.sta.disconnect()
 
end    

    
    
    wifi.setmode(wifi.STATION)
    wifi.sta.config("mbfree","martineestlaplusbelle")
    wifi.sta.connect()
    -- tmr.delay(10000000)   -- wait 1,000,000 us = 1 second
    i=0
    tmr.alarm(1, 1000, 1, function()
      if wifi.sta.getip()== nil then
         print(string.format("wait ... %s", i))
      else
         tmr.stop(1)
         print("-ESP8266 mode is: " .. wifi.getmode())
         print("-The module MAC address is: " .. wifi.ap.getmac())
         print("-Config done, IP is "..wifi.sta.getip())
         onConnectCb("1")
      end
    end)



