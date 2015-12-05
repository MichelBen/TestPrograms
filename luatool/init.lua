function beep(n,d,pin)
	if beepSts == 1 then
		if pin == nil then pin = BEEPpin end
		gpio.mode(pin,gpio.OUTPUT)
		local delay = d*100000
		if n<1 then n=1 end
		if d<1 then d=1 end
		for i = 1, n , 1 do
			gpio.write(pin,gpio.HIGH)
			tmr.delay(delay)
			gpio.write(pin,gpio.LOW)
			tmr.delay(delay)
		end
	end
end

function display(n)
    if n == 0 then switchLed(gpio.LOW, gpio.LOW ,gpio.LOW) end
    if n == 1 then switchLed(gpio.LOW, gpio.LOW ,gpio.HIGH) end
    if n == 2 then switchLed(gpio.LOW, gpio.HIGH ,gpio.LOW) end
    if n == 3 then switchLed(gpio.LOW, gpio.HIGH ,gpio.HIGH) end
    if n == 4 then switchLed(gpio.HIGH, gpio.LOW ,gpio.LOW) end
    if n == 5 then switchLed(gpio.HIGH, gpio.LOW ,gpio.HIGH) end
    if n == 6 then switchLed(gpio.HIGH, gpio.HIGH ,gpio.LOW) end
    if n == 7 then switchLed(gpio.HIGH, gpio.HIGH ,gpio.HIGH) end
end
    
function switchLed(l1,l2,l3)
    print("=================================Led :" .. l1 .. " " .. l2 .. " " .. l3)
    gpio.mode(LEDpin1,gpio.OUTPUT)
    gpio.mode(LEDpin2,gpio.OUTPUT)
    gpio.mode(LEDpin3,gpio.OUTPUT)
    gpio.write(LEDpin1,l1)
    gpio.write(LEDpin2,l2)
    gpio.write(LEDpin3,l3)
end

function keyin(pin)
    if pin == nil then pin=KEYpin end
    gpio.mode(pin, gpio.INPUT)
    return(gpio.read(pin))
end
-- ================================


-- ================================
DATApin = 1
KEYpin = 2
LEDpin1 = 3
LEDpin2 = 4
LEDpin3 = 5
BEEPpin = 6

beepSts = 1

print "init.lua Start"
print(string.format("Set D%s pin to low to abord boot sequence",KEYpin));

beep(1,1)

local keySts=keyin(KEYpin)
print("key :" .. keySts)
if keySts == 1 then
	beep(2,1)
    print("key not pressed. Normal boot")
    print("dofile('allinone.lc')")
    dofile('allinone.lc')
    --print("sleep before")
    --node.dsleep(3000000, 1)
    --print("sleep after")

end

print "init.lua End"

