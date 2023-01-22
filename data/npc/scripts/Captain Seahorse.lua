local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Travel
local function addTravelKeyword(keyword, cost, destination, action)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a seek a passage to ' .. keyword:titleCase() .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination}, nil, action)
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

local function Cptl(f, r)
     return f:upper()..r:lower()
end

function creatureSayCallback(cid, type, msg)       
     local player, cmsg = Player(cid), msg:gsub("(%a)([%w_']*)", Cptl)
     if not npcHandler:isFocused(cid) then
         if msg == "bring me to carlin" then                            -- here use your own formula
             npcHandler:addFocus(cid)
            local carlin =  {x=32387, y=31820, z=6}                            -- set proper location coords and name
            local playerpos = player:getPosition()
                if (doPlayerRemoveMoney(cid, 150) == TRUE) then            -- set instant travel cost
                    doTeleportThing(cid,carlin)                            -- change 'jngl' name if needed
                    doSendMagicEffect(playerpos,3)
                    doSendMagicEffect(carlin,11)                            -- change 'jngl' name if needed
                else
                    selfSay('Not enough gold.')
                    npcHandler:releaseFocus(cid)
				end
	elseif msg == "bring me to thais" then
             npcHandler:addFocus(cid)
            local thais =  {x=32310, y=32210, z=6}
            local playerpos = player:getPosition()
                if (doPlayerRemoveMoney(cid, 250) == TRUE) then
                    doTeleportThing(cid,thais)
                    doSendMagicEffect(playerpos,3)
                    doSendMagicEffect(thais,11)
                else
                    selfSay('Not enough gold.')
                    npcHandler:releaseFocus(cid)
                end
			end
	elseif msg == "bring me to yalahar" then
             npcHandler:addFocus(cid)
            local yalahar =  {x=32816, y=31272, z=6}
            local playerpos = player:getPosition()
                if (doPlayerRemoveMoney(cid, 240) == TRUE) then
                    doTeleportThing(cid,yalahar)
                    doSendMagicEffect(playerpos,3)
                    doSendMagicEffect(yalahar,11)
                else
                    selfSay('Not enough gold.')
                    npcHandler:releaseFocus(cid)
                end
	elseif msg == "bring me to svargrond" then
             npcHandler:addFocus(cid)
            local svargrond =  {x=32341, y=31108, z=6}
            local playerpos = player:getPosition()
                if (doPlayerRemoveMoney(cid, 220) == TRUE) then
                    doTeleportThing(cid,svargrond)
                    doSendMagicEffect(playerpos,3)
                    doSendMagicEffect(svargrond,11)
                else
                    selfSay('Not enough gold.')
                    npcHandler:releaseFocus(cid)
                end
	elseif msg == "bring me to venore" then
             npcHandler:addFocus(cid)
            local venore =  {x=32954, y=32022, z=6}
            local playerpos = player:getPosition()
                if (doPlayerRemoveMoney(cid, 210) == TRUE) then
                    doTeleportThing(cid,venore)
                    doSendMagicEffect(playerpos,3)
                    doSendMagicEffect(venore,11)
                else
                    selfSay('Not enough gold.')
                    npcHandler:releaseFocus(cid)
                end
	elseif msg == "bring me to ankrahmun" then
             npcHandler:addFocus(cid)
            local ankrahmun =  {x=33092, y=32883, z=6}
            local playerpos = player:getPosition()
                if (doPlayerRemoveMoney(cid, 200) == TRUE) then
                    doTeleportThing(cid,ankrahmun)
                    doSendMagicEffect(playerpos,3)
                    doSendMagicEffect(ankrahmun,11)
                else
                    selfSay('Not enough gold.')
                    npcHandler:releaseFocus(cid)
                end
	elseif msg == "bring me to cormaya" then
             npcHandler:addFocus(cid)
            local cormaya =  {x=33288, y=31956, z=6}
            local playerpos = player:getPosition()
                if (doPlayerRemoveMoney(cid, 200) == TRUE) then
                    doTeleportThing(cid,cormaya)
                    doSendMagicEffect(playerpos,3)
                    doSendMagicEffect(cormaya,11)
                else
                    selfSay('Not enough gold.')
                    npcHandler:releaseFocus(cid)
                end
		end
		return true
	end

addTravelKeyword('venore', 40, Position(32954, 32022, 6), function(player) if player:getStorageValue(Storage.postman.Mission01) == 3 then player:setStorageValue(Storage.postman.Mission01, 4) end end)
addTravelKeyword('thais', 160, Position(32310, 32210, 6))
addTravelKeyword('carlin', 110, Position(32387, 31820, 6))
addTravelKeyword('ab\'dendriel', 70, Position(32734, 31668, 6))
addTravelKeyword('port hope', 150, Position(32527, 32784, 6))
addTravelKeyword('liberty bay', 170, Position(32285, 32892, 6))
addTravelKeyword('ankrahmun', 160, Position(33092, 32883, 6))
addTravelKeyword('cormaya', 20, Position(33288, 31956, 6))



-- Kick
--keywordHandler:addKeyword({'kick'}, StdModule.kick, {npcHandler = npcHandler, destination = {Position(33174, 31773, 6), Position(33175, 31771, 6), Position(33177, 31772, 6)}})

-- Basic
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Thais}, {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Ankrahmun}, {Liberty Bay} or the isle {Cormaya}?'})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Thais}, {Carlin}, {Ab\'Dendriel}, {Venore}, {Port Hope}, {Ankrahmun}, {Liberty Bay} or the isle {Cormaya}?'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'My name is Captain Seahorse from the Royal Tibia Line.'})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Edron. Where do you want to go?'})
keywordHandler:addKeyword({'yalahar'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry, but we don\'t serve this route. However, I heard that Wyrdin here in Edron is looking for adventurers to go on a trip to Yalahar for him.'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome on board, |PLAYERNAME|. Where may I {sail} you today?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. Recommend us if you were satisfied with our service.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')

npcHandler:addModule(FocusModule:new())
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)