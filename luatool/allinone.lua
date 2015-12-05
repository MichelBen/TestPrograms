collectgarbage()
-- readDHT
local function readDHT(pin)
	if pin == nil then pin = DATApin end
	local ret_error_code=0
	local ret_error_msg=""
	local ret_temp=0
	local ret_hum=0
    local status=""
    local temp=0
    local humi=0
    local temp_decimial=0
    local humi_decimial=0

	status, temp, humi, temp_decimial, humi_decimial = dht.read(pin)
	if( status == dht.OK ) then
	  ret_temp = temp
	  ret_hum  = hum
	  ret_error_code=0
	elseif( status == dht.ERROR_CHECKSUM ) then
	  ret_error_msg="DHT Checksum error."
	  ret_error_code=1
	elseif( status == dht.ERROR_TIMEOUT ) then
	  ret_error_msg="DHT Time out."
	  ret_error_code=2
	end

	if ret_error_code ~= 0 then
	  print("error : [" .. ret_error_code .. "] " .. ret_error_msg)
	else
	  -- Integer firmware using this example
	  print(     
		string.format(
		  "DHT Temperature:%d.%03d;Humidity:%d.%03d\r\n",
		  math.floor(temp),
		  temp_decimial,
		  math.floor(humi),
		  humi_decimial
		)

	  )
	  -- Float firmware using this example
	  -- print("DHT Temperature:"..temp..";".."Humidity:"..humi)
	end
	return ret_error_code, ret_error_msg, temp, humi
end --readDHT

-- onConnectWifi WIFI =================================================
local function onConnectWifi(str)
	print(string.format("- onConnectWifi BEGIN ============ %s",str))
    print(string.format("status %s",wifi.sta.status()))
	print(string.format("IP %s",wifi.sta.getip()))
	
	print("-- Exec sk=net.createConnection")
	local sk=net.createConnection(net.TCP, 0)
	
	print("-- declare sk:dns")
	sk:dns("lespages.info",function(sk,ip)
		print("*--------------------")
		print("--- sk:dns")
		local ipaddr=ip
		print(string.format("--- ipaddr :%s",ipaddr))
	
		print("--- EXEC conn=net.createConnection")
		local conn=net.createConnection(net.TCP, 0)
		
		print("--- declare conn:on(connection")		
		conn:on("connection", function(sck,c)
				print("{--- conn:on(connection")
				local strToSend = "GET /logdata/adddata.php?name=DHTV2&value=".. str .." HTTP/1.1\r\nHost: lespages.info\r\nConnection: keep-alive\r\nAccept: */*\r\n\r\n"
				print("---- strToSend [" .. strToSend .. "] end strToSend")
                print("---- EXEC conn:sent")
				conn:send(strToSend)
				print("}--- conn:on(connection")
			end) -- conn:on connection

        print("--- declare conn:on(sent")            
        conn:on("sent",function(conn)
                print("{--- conn:on(sent")
                print("---- Closing SK connection")
                sk:close()
                sk=nill
                --conn:close()
                --conn=nill
                display(2)
                print("---- check if sleep")
                local keySts = keyin()

                print("key :" .. keySts)
                if keySts == 1 then
                    print("---- key not pressed. SLEEP")
                    display(3)
                    beep(5,0.1)
                    conn=nill
                    node.dsleep(5000000, 1)
                    display(4)
                    print("---- SLEEP done")
                    --for wi = 1 , 99999999 do
                    --    print("I'm waiting to sleep " .. wi)
                    --end
  
                end
                print("---- key pressed. NOT SLEEP")
                display(5)
                print('---- end NOT sleep')
            end)

        print("--- declare conn:on(receive")
        conn:on("receive", function(conn, payload)
                print("{--- conn:on(receive")
                print(string.format("---- payload :%s",payload))
                print("}--- conn:on(receive")
            end)

        print("--- declare conn:on(disconnection")
        conn:on("disconnection", function(conn)
                print("{--- conn:on(disconnection...")
                -- conn=nill
                print("}--- conn:on(disconnection...")
            end)
               
        print("--- EXEC conn:connect(80")
        conn:connect(80,ipaddr)
        
		print("--- sk:dns end")
	  end) -- sk:dns
	print("-- after sk:dns")

	print("- onConnectWifi END ============================")

end   --local function onConnectCb(str)

print("allinone Start")
display(7)

-- read DHT
print("read DHTv2 Start")
local ret_error_code
local ret_error_msg
local temp
local hum
ret_error_code, ret_error_msg, temp, hum = readDHT()
print("read DHTv2 End")

print("WIFI connect")
wifi.setmode(wifi.STATION)
wifi.sta.config("mbfree","martineestlaplusbelle")
wifi.sta.connect()
nbWifi=0
print("declare tmr.alarm")
tmr.alarm(1, 1000, 1, function()
  if wifi.sta.getip()== nil then
	 print(string.format("wait nbWifi : %s", nbWifi))
	 nbWifi = nbWifi + 1
  else
	 tmr.stop(1)
     print(string.format("find nbWifi : %s", nbWifi))
	 print("Config done, IP is "..wifi.sta.getip())
     print("APPEL de onConnectCb --------------------")     
	 onConnectWifi(ret_error_code..";"..ret_error_msg..";"..temp..";"..hum)
     print("RETOUR de onConnectCb --------------------")

  end
end)
print("allinone End")
