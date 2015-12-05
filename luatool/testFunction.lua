function bar()
  print(x) --> nil
  local x = 6
  print(x) --> 6
end

function foo()
  local x = 5
  print(x) --> 5
  bar()
  print(x) --> 5
end
local x = 1
print(x)
foo()
print(x)