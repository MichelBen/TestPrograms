gpio.mode(0, gpio.INPUT)
keysts=gpio.read(0)
gpio.mode(0, gpio.OUTPUT)
print("key :" .. keysts)
