-- Simple script to test if ESP is OK
-- on/off pin 4
-- and print
lighton=0
pin=4
gpio.mode(pin,gpio.OUTPUT)
tmr.alarm(1,1000,1,function()
    if lighton==0 then
        lighton=1
        gpio.write(pin,gpio.HIGH)
        print("on")

    else
        lighton=0
        gpio.write(pin,gpio.LOW)
        print("OFF") 
    end
end)
