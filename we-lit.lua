local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local originalCall
originalCall = hookmetamethod(game, "__namecall", newcclosure(function(target, ...)
    local callMethod = getnamecallmethod()
    local callArgs = {...}
    local targetName = tostring(target)
    if callMethod == "FireServer" then
        if targetName == "HitResult" then
            callArgs[4] = "Dodge"
            return originalCall(target, unpack(callArgs))
        end
        if targetName == "PartyMembers" then
            if callArgs[2] == "ParryTry" then
                callArgs[3] = true
                return originalCall(target, unpack(callArgs))
            end
        end
        if targetName == "TargetSelection" then
            callArgs[1] = "Critical"
            return originalCall(target, unpack(callArgs))
        end
        if targetName:lower():find("qte") or targetName:lower():find("timing") then
            for i,v in ipairs(callArgs) do
                if v=="Good" or v=="Great" or v=="Miss" or v=="Normal" then callArgs[i]="Perfect" end
                if type(v)=="number" and v<95 then callArgs[i]=100 end
            end
            return originalCall(target, unpack(callArgs))
        end
    end
    return originalCall(target, ...)
end))
print("we lit")
