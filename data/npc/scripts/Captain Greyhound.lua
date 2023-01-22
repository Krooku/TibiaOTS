local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Travel
local function addTravelKeyword(keyword, cost, destination, condition)
	if condition then
		keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m sorry but I don\'t sail there.'}, condition)
	end

	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to ' .. keyword:titleCase() .. ' for |TRAVELCOST|?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination})
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
	elseif msg == "bring me to edron" then
             npcHandler:addFocus(cid)
            local edron =  {x=33175, y=31764, z=6}
            local playerpos = player:getPosition()
                if (doPlayerRemoveMoney(cid, 200) == TRUE) then
                    doTeleportThing(cid,edron)
                    doSendMagicEffect(playerpos,3)
                    doSendMagicEffect(edron,11)
                else
                    selfSay('Not enough gold.')
                    npcHandler:releaseFocus(cid)
                end		
			end
		return true
	end




addTravelKeyword('thais', 110, Position(32310, 32210, 6))
addTravelKeyword('ab\'dendriel', 80, Position(32734, 31668, 6))
addTravelKeyword('edron', 110, Position(33175, 31764, 6))
addTravelKeyword('venore', 130, Position(32954, 32022, 6))
addTravelKeyword('svargrond', 110, Position(32341, 31108, 6))
addTravelKeyword('yalahar', 185, Position(32816, 31272, 6), function(player) return player:getStorageValue(Storage.SearoutesAroundYalahar.Carlin) ~= 1 and player:getStorageValue(Storage.SearoutesAroundYalahar.TownsCounter) < 5 end)
addTravelKeyword('port hope', 160, Position(32527, 32784, 6))

-- Kick
--keywordHandler:addKeyword({'kick'}, StdModule.kick, {npcHandler = npcHandler, destination = {Position(32384, 31815, 6), Position(32387, 31815, 6), Position(32390, 31815, 6)}})

-- Basic
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "My name is Captain Greyhound from the Royal Tibia Line."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I am the captain of this sailing-ship."})
keywordHandler:addKeyword({'captain'}, StdModule.say, {npcHandler = npcHandler, text = "I am the captain of this sailing-ship."})
keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, text = "The Royal Tibia Line connects all seaside towns of Tibia."})
keywordHandler:addKeyword({'line'}, StdModule.say, {npcHandler = npcHandler, text = "The Royal Tibia Line connects all seaside towns of Tibia."})
keywordHandler:addKeyword({'company'}, StdModule.say, {npcHandler = npcHandler, text = "The Royal Tibia Line connects all seaside towns of Tibia."})
keywordHandler:addKeyword({'route'}, StdModule.say, {npcHandler = npcHandler, text = "The Royal Tibia Line connects all seaside towns of Tibia."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = "The Royal Tibia Line connects all seaside towns of Tibia."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, text = "We can transport everything you want."})
keywordHandler:addKeyword({'passenger'}, StdModule.say, {npcHandler = npcHandler, text = "We would like to welcome you on board."})
keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = "Where do you want to go? To {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} or {Edron?}"})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = "Where do you want to go? To {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} or {Edron?}"})
keywordHandler:addKeyword({'town'}, StdModule.say, {npcHandler = npcHandler, text = "Where do you want to go? To {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} or {Edron?}"})
keywordHandler:addKeyword({'destination'}, StdModule.say, {npcHandler = npcHandler, text = "Where do you want to go? To {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} or {Edron?}"})
keywordHandler:addKeyword({'sail'}, StdModule.say, {npcHandler = npcHandler, text = "Where do you want to go? To {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} or {Edron?}"})
keywordHandler:addKeyword({'go'}, StdModule.say, {npcHandler = npcHandler, text = "Where do you want to go? To {Thais}, {Ab\'Dendriel}, {Venore}, {Svargrond}, {Yalahar} or {Edron?}"})
keywordHandler:addKeyword({'ice'}, StdModule.say, {npcHandler = npcHandler, text = "I'm sorry, but we don't serve the routes to the Ice Islands."})
keywordHandler:addKeyword({'senja'}, StdModule.say, {npcHandler = npcHandler, text = "I'm sorry, but we don't serve the routes to the Ice Islands."})
keywordHandler:addKeyword({'folda'}, StdModule.say, {npcHandler = npcHandler, text = "I'm sorry, but we don't serve the routes to the Ice Islands."})
keywordHandler:addKeyword({'vega'}, StdModule.say, {npcHandler = npcHandler, text = "I'm sorry, but we don't serve the routes to the Ice Islands."})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, text = "I'm not sailing there. This route is afflicted by a ghost ship! However I've heard that Captain Fearless from Venore sails there."})
keywordHandler:addKeyword({'darama'}, StdModule.say, {npcHandler = npcHandler, text = "I'm not sailing there. This route is afflicted by a ghost ship! However I've heard that Captain Fearless from Venore sails there."})
keywordHandler:addKeyword({'ghost'}, StdModule.say, {npcHandler = npcHandler, text = "Many people who sailed to Darashia never returned because they were attacked by a ghostship! I'll never sail there!"})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = "This is Carlin. Where do you want to go?"})

npcHandler:setMessage(MESSAGE_GREET, "Welcome on board, |PLAYERNAME|. Where can I {sail} you today?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. Recommend us if you were satisfied with our service.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye then.")
npcHandler:addModule(FocusModule:new())
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
