DHTpin = 4
ret_error_code=0
ret_error_msg=""
ret_temp=0
ret_hum=0

status,temp,humi,temp_decimial,humi_decimial = dht.read(DHTpin)
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
   print("DHT Temperature:"..temp..";".."Humidity:"..humi)
end
return ret_error_code, ret_error_msg, temp, humi
