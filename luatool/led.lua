lighton=0
pin=1
gpio.mode(pin,gpio.OUTPUT)


tmr.alarm(1,2000,1,function()
    if lighton==0 then
        print("HIGH")
        lighton=1
        gpio.write(pin,gpio.HIGH)
    else
        lighton=0
        print("Low")
        gpio.write(pin,gpio.LOW)
    end
end)
