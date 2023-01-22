function ExistItemByName(name)
    local items = io.open("data/items/items.xml", "r"):read("*all")
    local get = items:match('name="' .. name ..'"')
    if get == nil or get == "" then
        return false
    end
    return true
end

local function getPlayerList(cid)
    local tab = {}
    if getPlayerStorageValue(cid, 04420021) ~= -1 then
        table.insert(tab, getPlayerStorageValue(cid, 04420021))
    end
    if getPlayerStorageValue(cid, 04420031) ~= -1 then
        table.insert(tab, getPlayerStorageValue(cid, 04420031))
    end
    if getPlayerStorageValue(cid, 04420041) ~= -1 then
        table.insert(tab, getPlayerStorageValue(cid, 04420041))
    end
    if getPlayerStorageValue(cid, 04420051) ~= -1 then
        table.insert(tab, getPlayerStorageValue(cid, 04420051))
    end
    if #tab > 0 then
        return tab
    end
    return false
end

local function addToList(cid, name)
    local itemid = getItemIdByName(name)
    if getPlayerList(cid) and isInArray(getPlayerList(cid), itemid) then
        return false
    end
    if getPlayerStorageValue(cid, 04420021) == -1 then
        return doPlayerSetStorageValue(cid, 04420021, itemid)
    elseif getPlayerStorageValue(cid, 04420031) == -1 then
        return doPlayerSetStorageValue(cid, 04420031, itemid)
    elseif getPlayerStorageValue(cid, 04420041) == -1 then   
        return doPlayerSetStorageValue(cid, 04420041, itemid)
    elseif getPlayerStorageValue(cid, 04420051) == -1 then
        return doPlayerSetStorageValue(cid, 04420051, itemid)
    end
end

local function removeFromList(cid, name)
    local itemid = getItemIdByName(name)
    if getPlayerStorageValue(cid, 04420021) == itemid then
        return doPlayerSetStorageValue(cid, 04420021, -1)
    elseif getPlayerStorageValue(cid, 04420031) == itemid then
        return doPlayerSetStorageValue(cid, 04420031, -1)
    elseif getPlayerStorageValue(cid, 04420041) == itemid then
        return doPlayerSetStorageValue(cid, 04420041, -1)
    elseif getPlayerStorageValue(cid, 04420051) == itemid then
        return doPlayerSetStorageValue(cid, 04420051, -1)
    end
    return false
end

function onSay(cid, words, param)
    if(not checkExhausted(cid, 666, 6)) then
        return true
    end
    if param == "" then
        local fi = getPlayerStorageValue(cid, 04420021) ~= -1 and getItemNameById(getPlayerStorageValue(cid, 04420021)) or ""
        local se = getPlayerStorageValue(cid, 04420031) ~= -1 and getItemNameById(getPlayerStorageValue(cid, 04420031)) or ""
        local th = not vip.hasVip(cid) and "Not available for free account" or getPlayerStorageValue(cid, 04420041) ~= -1 and getItemNameById(getPlayerStorageValue(cid, 04420041)) or ""
        local fo = not vip.hasVip(cid) and "Not available for free account" or getPlayerStorageValue(cid, 04420051) ~= -1 and getItemNameById(getPlayerStorageValue(cid, 04420051)) or ""
        local stt = getPlayerStorageValue(cid, 04421011) == 1 and "yes" or "no"
        local str = getPlayerStorageValue(cid, 04421001) == 1 and "yes" or "no"
        doPlayerPopupFYI(cid, "{Auto-Loot} ---Player Auto Loot Menu\n{Auto-Loot} ----------------\n{Auto-Loot} ---Collect money: "..stt..". To turn on/off: !autoloot gold \n{Auto-Loot} ---Collect unique items: "..str..". To turn on/off: !autoloot power\n{Auto-Loot} --Configuration of slots:\n{Auto-Loot} ---Slot 1: "..fi.."\n{Auto-Loot} ---Slot 2: "..se.."\n{Auto-Loot} ---Slot 3: "..th.."\n{Auto-Loot} ---Slot 4: "..fo.."\n{Auto-Loot} ---To add a new item to the slots: !autoloot add, <item name>\n{Auto-Loot} ---To remove an item from the slots: !autoloot remove, <item name>\n{Auto-Loot} ---To clear all slots use: !autoloot clear\n{Auto-Loot} ---For information on how much you've done using the money collection, use: !autoloot goldinfo\n\nIf your autoloot bugar use ! autoloot debug\n\n{Auto-Loot} ----------------")
        return true
    end
    
    local t = string.explode(param, ",")
    
    if t[1] == "power" then
        local check = getPlayerStorageValue(cid, 04421001) == -1 and "turn on" or "turn off"
        doPlayerSetStorageValue(cid, 04421001, getPlayerStorageValue(cid, 04421001) == -1 and 1 or -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You "..check.." the auto loot.")
    elseif t[1] == "gold" then
        local check = getPlayerStorageValue(cid, 04421011) == -1 and "turn on" or "turn off"
        doPlayerSetStorageValue(cid, 04421011, getPlayerStorageValue(cid, 04421011) == -1 and 1 or -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "You "..check.." the collection of money.")
        doPlayerSetStorageValue(cid, 04421021, 0)
    elseif t[1] == "goldinfo" then
        local str = getPlayerStorageValue(cid, 04421011) == -1 and "The money collection system is turned off" or "The system has already collected "..getPlayerStorageZero(cid, 04421021).." gold coins"
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, str)
    elseif t[1] == "add" then
        if ExistItemByName(t[2]) then
            local item = getItemIdByName(t[2])
            if isInArray({2160, 2148, 2152}, item) then
                return doPlayerSendCancel(cid, "You cannot autoloot coins. To collect money use !autoloot gold")
            end
            if vip.hasVip(cid) then
                if getPlayerStorageValue(cid, 04420011) < 3 then
                    if addToList(cid, t[2]) then
                        doPlayerSetStorageValue(cid, 04420011, getPlayerStorageValue(cid, 04420011) + 1)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, t[2].." added to your auto loot list! To see your list say !autoloot list")
                    else
                        doPlayerSendCancel(cid, t[2].." is already on your list!")
                    end
                else
                    doPlayerSendCancel(cid, "Your list already has 4 items! You must remove one before adding another.")
                end
            else
                if getPlayerStorageValue(cid, 04420011) < 1 then
                    if addToList(cid, t[2]) then
                        doPlayerSetStorageValue(cid, 04420011, getPlayerStorageValue(cid, 04420011) + 1)
                        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, t[2].." added to your auto loot list! To see your list say !autoloot")
                    else
                        doPlayerSendCancel(cid, t[2].." is already on your list!")
                    end
                else
                    doPlayerSendCancel(cid, "You already have an item added to the auto loot! To add another one, you must remove the current item.")
                end
            end
        else
            doPlayerSendCancel(cid, "This item does not exist!")
        end
    elseif t[1] == "remove" then
        if ExistItemByName(t[2]) then
            if removeFromList(cid, t[2]) then
                doPlayerSetStorageValue(cid, 04420011, getPlayerStorageValue(cid, 04420011) - 1)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, t[2].." removed from your auto loot list!")
            else
                doPlayerSendCancel(cid, "This item is not on your list!")
            end
        else
            doPlayerSendCancel(cid, "This item does not exist!")
        end
    elseif t[1] == "clear" then
        if getPlayerStorageValue(cid, 04420011) > -1 then
            doPlayerSetStorageValue(cid, 04420011, -1)
            doPlayerSetStorageValue(cid, 04420021, -1)
            doPlayerSetStorageValue(cid, 04420031, -1)
            doPlayerSetStorageValue(cid, 04420041, -1)
            doPlayerSetStorageValue(cid, 04420051, -1)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "clean list!")
        else
            doPlayerSendCancel(cid, "Your list is now clean!")
        end
    elseif t[1] == "debug" or t[1] == "desbugar" then
        doPlayerSetStorageValue(cid, 04420011, -1)
        doPlayerSetStorageValue(cid, 04420021, -1)
        doPlayerSetStorageValue(cid, 04420031, -1)
        doPlayerSetStorageValue(cid, 04420041, -1)
        doPlayerSetStorageValue(cid, 04420051, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "buggy!")
    elseif t[1] == "list" then
        local fi = getPlayerStorageValue(cid, 04420021) ~= -1 and ""..getItemNameById(getPlayerStorageValue(cid, 04420021)).."\n" or ""
        local se = getPlayerStorageValue(cid, 04420031) ~= -1 and ""..getItemNameById(getPlayerStorageValue(cid, 04420031)).."\n" or ""
        local th = getPlayerStorageValue(cid, 04420041) ~= -1 and ""..getItemNameById(getPlayerStorageValue(cid, 04420041)).."\n" or ""
        local fo = getPlayerStorageValue(cid, 04420051) ~= -1 and ""..getItemNameById(getPlayerStorageValue(cid, 04420051)).."\n" or ""
        doPlayerPopupFYI(cid, "The auto loot system is collecting:\n "..fi..""..se..""..th..""..fo)
    end
    return true
end