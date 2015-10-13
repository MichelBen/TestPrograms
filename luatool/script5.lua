local function onConnectCb(str)
	print("---onConnectCb")
	print(string.format("status %s",wifi.sta.status()))
	print(string.format("IP %s",wifi.sta.getip()))
	print("--- DNS Start")
	sk=net.createConnection(net.TCP, 0)
	sk:dns("api.coindesk.com",function(sk,ip)
		ipaddr=ip
		print(ipaddr)
	 end)
	print("--- DNS End")
	print("- Start Connect TCP")
	conn=net.createConnection(net.TCP, 0)

	conn:on("receive", function(conn, payload)
		print("--- Receive Start")
		print(payload)
		print("--- Receive End")
	   end)
	  
	conn:connect(80,ipaddr)
	conn:send("GET /v1/bpi/currentprice.json HTTP/1.1\r\nHost: api.coindesk.com\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")

	print("- End Connect TCP")
 
end   --local function onConnectCb(str)
    
wifi.setmode(wifi.STATION)
wifi.sta.config("mbfree","martineestlaplusbelle")
wifi.sta.connect()
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



