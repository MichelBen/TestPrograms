print("dht22test.lua module  v4")
-- local moduleName = ...
-- local M = {}
-- _G[moduleName] = M

-- function M.read(pin)
  local pin = 4
  local cMax = 1000
  local bitlengthMax = 100
  if debug then print("M.read begin") end

  local debug = true
  
  -- Use Markus Gritsch trick to speed up read/write on GPIO
  local gpio_read  = gpio.read
  local gpio_write = gpio.write
  local bitStreamSts = {}
  local bitStreamLen = {}
  local bitStreamTmr = {}
  for i=1,40,1 do
     bitStreamLen[i] = tmr.now()
  end
  
  print("=============== test duree boucle")
  for i=2,40,1 do
     print(i, bitStreamLen[i],bitStreamLen[i] - bitStreamLen[i-1] )
  end
  
  print("=============== test delay 3")
  local t1
  local t1t
  local t2
  local t2t
  t1 = tmr.now()
  t1t= tmr.time()
  print("  wait debut" ,t1t)
  tmr.delay(10000000)
  print("  wait fin", t1t)
  t2t= tmr.time()
  t2 = tmr.now()
  print(tmr.time(), t1t, t2t, t1, t2, t2-t1)
  
  print("---")
  local t1
  local t2
  t1 = tmr.now()
  t2 = tmr.now()
  print(t1,t2,t2-t1)
  
  print(tmr.now())
  tmr.delay(1000)
  print(tmr.now())
  print("---")
  
  for j = 1, 85, 1 do
    bitStreamSts[j] = 0
	bitStreamLen[j] = 0
	bitStreamTmr[j] = 0
  end
  
  local bitlength = 0

  -- Step 1:  send out start signal to DHT22
  --   micro-s   min    typ    max 
  -- by cpu
  -- low         800   1000  20000
  -- hight        20     30    200
  -- by DTH
  --  response signal
  -- low          75     80     85
  -- hight        75     80     85  
  --   data
  if debug then print("Step 1:  send out start signal to DHT22") end
  gpio.mode(pin, gpio.OUTPUT)
  gpio.write(pin, gpio.HIGH)
  tmr.delay(100) -- micro seconds
  
  gpio.write(pin, gpio.LOW)
  tmr.delay(1000)

  gpio.mode(pin, gpio.INPUT)
  
  local v
  local streamMax = 20
  for i = 1, streamMax , 1 do
    v = gpio_read(pin)
	bitStreamSts[i]  = v
	bitStreamTmr[i] = tmr.now()
    while (gpio_read(pin) == v) do end
	-- bitStreamLen[i]  = c
	
  end

  for i = 2, streamMax , 1 do
    print(i, bitStreamSts[i], bitStreamTmr[i], bitStreamTmr[i] - bitStreamTmr[i-1])
  end  
 -- end


-- return M