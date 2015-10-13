print("-disconnection wifi DEBUT")     
wifi.sta.disconnect()
ip = wifi.sta.getip()
print("-ip : ")
print(ip)
print("-status : :" .. wifi.sta.status())

wifi.setmode(wifi.STATION)
wifi.startsmart(0, 
     function(ssid, password) 
         print(string.format("Success. SSID:%s ; PASSWORD:%s", ssid, password))
     end
)

    
-- above sdk v120, can get phone ip, must use esptouch v034.
ip = wifi.sta.getip()
print("-ip : ")
print(ip)
print("-status : :" .. wifi.sta.status())

print("-disconnection wifi FIN")     
wifi.sta.disconnect()
ip = wifi.sta.getip()
print("-ip : ")
print(ip)
print("-status : :" .. wifi.sta.status())
