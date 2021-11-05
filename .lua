local Library = require(game:GetService("ReplicatedStorage").Framework.Library)
local IDToName = {}
local NameToID = {}
for i,v in pairs(Library.Directory.Pets ) do
    IDToName[i] = v.name
    NameToID[v.name] = i
end

function GetPets()
    local MyPets = {}
    for i,v in pairs(Library.Save.Get().Pets) do
        if not table.find(_G.Exclusions, IDToName[v.id]) then
            local ThingyThingyTempTypeThing = (v.g and 'Gold') or (v.r and 'Rainbow') or (v.dm and 'Dark Matter') or 'Normal'
            local TempString = ThingyThingyTempTypeThing .. IDToName[v.id]
            if MyPets[TempString] then
                table.insert(MyPets[TempString], v.uid)
            else
                MyPets[TempString] = {}
                table.insert(MyPets[TempString], v.uid)
            end
        end
    end
    return MyPets
end

while wait() and _G.AutoCombine do
    for i, v in pairs(GetPets()) do
        if #v >= _G.CombineNumber and _G.AutoCombine then
            if string.find(i, "Normal") and _G.AutoCombine and _G.Gold then
                local Args = {}
                for eeeee = 1, _G.CombineNumber do
                    Args[#Args+1] = v[#Args+1]
                end
                Library.Network.Invoke("use golden machine", Args)

            elseif string.find(i, "Gold") and _G.AutoCombine and _G.Rainbow then
                local Args = {}
                for eeeee = 1, _G.CombineNumber do
                    Args[#Args+1] = v[#Args+1]
                end
                Library.Network.Invoke("use rainbow machine", Args)
            end
        end
    end
end
