-- initboot call by init.lua

print("initboot.lua Start")

beep(2,1)


local keySts=keyin(KEYpin)
print("key :" .. keySts)
if keySts == 1 then
    print("run allinone")
    dofile("allinone.lua")
end

print("initboot.lua End")
