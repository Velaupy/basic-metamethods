require("C:\\Users\\Velmi_r\\Documents\\stuff\\languages\\Luau\\velmi_r")()

function clonetab(tab:{}):{}
        return {unpack(tab)}
end
metatable = {
        __newindex = function(self:{number},index:number,val)
                rawset(self,index,val)
                print(("newindex: new element has been added (%d: %s)"):format(index,tostring(val)))
        end;
        __call = function(self:{number},...)
                for _,v in pairs({...}) do
                        rawset(self,#self+1,v)
                end
        end;
        __add = function(self:{number},tab2:{number}):{number}
                local tab:{number} = clonetab(self)
                for i,v:number in pairs(tab2) do
                        tab[i] = (tab[i] or 0) + v
                end
                return tab
        end;
        __sub = function(self:{number},tab2:{number}):{number}
                local tab:{number} = clonetab(self)
                for i,v:number in pairs(tab2) do
                        tab[i] = (tab[i] or 0) - v
                end
                return tab
        end;
        __mul = function(self:{number},tab2:{number}):{number}
                local tab:{number} = clonetab(self)
                for i,v:number in pairs(tab2) do
                        tab[i] = (tab[i] or 0) * v
                end
                return tab
        end;
        __div = function(self:{number},tab2:{number}):{number}
                local tab:{number} = clonetab(self)
                for i,v:number in pairs(tab2) do
                        tab[i] = (tab[i] or 0) / v
                end
                return tab
        end;
        __eq = function(self:{number},compare:{number}):boolean
                for i,v in pairs(compare) do
                        if self[i] ~= v then
                                return false
                        end
                end
                return true
        end;
        __tostring = function(self:{number}):string
                local str:string = ""
                for i,v:number in pairs(self) do
                        str ..= ("%d: %s\n"):format(i,tostring(v))
                end
                return str
        end;
}
mt = setmetatable({1,2,3},metatable)
function header(str:string)
        print(("/|-|\\    %s    /|-|\\"):format(tostring(str)))
end

header("newindex function")
for i=4,5 do
        mt[i] = i
end

print()

header("call function")
mt(6,7,8,9,10)
for i,v in pairs(mt) do
        print(i,v)
end

print()

mt2 = setmetatable(clonetab(mt),metatable)
function randnums():{number}
        local randnums:{number} = {}
        for i=1,10 do
                math.randomseed(i * os.clock())
                table.insert(randnums,randnum(10))
        end
        return randnums
end

header("add function")
for _,v in pairs(mt + mt2) do
        print(v)
end
header("sub function")
for _,v in pairs(mt - randnums()) do
        print(v)
end
header("mul function")
for _,v in pairs(mt * mt2) do
        print(v)
end
header("div function")
for _,v in pairs(mt / randnums()) do
        print(v)
end

print()

header("eq function")
mt3 = setmetatable({1,2,4,5,10},metatable)
print(mt == mt2)
print(mt == mt3)

print()

header("tostring function")
print(tostring(mt))
print()
print(tostring(mt3))