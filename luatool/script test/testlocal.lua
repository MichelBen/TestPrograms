local function d(t)
    dt="--" .. t .. "--"
    print(string.format("d(t)=%s",dt))
    return dt
end
a="!a!"
local b="!loc b!"
d(a)
d(b)