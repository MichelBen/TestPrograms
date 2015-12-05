local function onConnectCb(str)
	print("---onConnectCb")
    print(str)
	print(string.format("status %s",wifi.sta.status()))
	print(string.format("IP %s",wifi.sta.getip()))
	print("--- DNS Start")
	sk=net.createConnection(net.TCP, 0)
	sk:dns("lespages.info",function(sk,ip)
		ipaddr=ip
		print("ipaddr :")
		print(ipaddr)

        print("send")
        conn:connect(80,ipaddr)
        conn:send("GET /logdata/adddata.php?name=DHTV2&value=".. str .." HTTP/1.1\r\nHost: lespages.info\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n")
        
        gpio.write(1,gpio.HIGH)
        tmr.delay(500000)
        
        gpio.mode(2, gpio.INPUT)
        keysts=gpio.read(2)
        print("key :" .. keysts)
        if keysts == 1 then
            print("key not pressed. SLEEP")
            --node.dsleep(5000000, 1)
            print("SLEEP done")
        end
        print("key pressed. NOT SLEEP")
        gpio.write(1,gpio.LOW)
        node.dsleep(5000000, 1)
        gpio.write(1,gpio.HIGH)        
        node.dsleep(10000000, 1)
        gpio.write(1,gpio.LOW)
        print('end NOT sleep')
	  end)
	print("--- DNS End")
	print("- Start Connect TCP")
	conn=net.createConnection(net.TCP, 0)

	conn:on("receive", function(conn, payload)
		print("--- Receive Start")
		print(payload)
		print("--- Receive End")
	   end)

	print("- End Connect TCP")
	
 
end   --local function onConnectCb(str)
gpio.mode(1,gpio.OUTPUT)
gpio.write(1,gpio.HIGH)
tmr.delay(500000)
gpio.mode(1,gpio.OUTPUT)
tmr.delay(500000)
gpio.write(1,gpio.LOW)
tmr.delay(500000)
gpio.write(1,gpio.HIGH)
tmr.delay(500000)
gpio.write(1,gpio.LOW)
tmr.delay(500000)
gpio.write(1,gpio.HIGH)
tmr.delay(500000)
gpio.write(1,gpio.LOW)
tmr.delay(500000)


print("call DHTv2 Start")
ret_error_code, ret_error_msg, temp, hum = dofile("DHTv2.lua")
print("testcall print")
print(ret_error_code)
print(ret_error_msg)
print(temp)
print(hum)
print("call DHTv2 End")
    
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
     print("APPEL de onConnectCb --------------------")     
	 onConnectCb(ret_error_code..";"..ret_error_msg..";"..temp..";"..hum)
     print("RETOUR de onConnectCb --------------------")

  end
end)



