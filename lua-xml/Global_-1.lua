--[[ Lua code. See documentation: http://berserk-games.com/knowledgebase/scripting/ --]]
-- Card size used for autodealing --

-- global position constants
ENCOUNTER_DECK_POS = {-3.8, 1, 5.7}
ENCOUNTER_DECK_SPAWN_POS = {-3.8, 3, 5.7}
ENCOUNTER_DECK_DISCARD_POSITION = {-3.8, 0.5, 10.5}
g_cardWith=2.30;
g_cardHeigth=3.40;

containerId = 'fea079'
tokenDataId = '708279'


maxSquid = 0

CACHE = {
    object = {},
    data = {}
}

--[[ The OnLoad function. This is called after everything in the game save finishes loading.
Most of your script code goes here. --]]
function onload()
  --Player.White.changeColor('Yellow')
  tokenplayerone = {
    damageone = "http://cloud-3.steamusercontent.com/ugc/1758068501357115146/903D11AAE7BD5C254C8DC136E9202EE516289DEA/",
    damagethree = "http://cloud-3.steamusercontent.com/ugc/1758068501357113055/8A45F27B2838FED09DEFE492C9C40DD82781613A/",
    horrorone = "http://cloud-3.steamusercontent.com/ugc/1758068501357163535/6D9E0756503664D65BDB384656AC6D4BD713F5FC/",
    horrorthree = "http://cloud-3.steamusercontent.com/ugc/1758068501357162977/E5D453CC14394519E004B4F8703FC425A7AE3D6C/",
    resource = "http://cloud-3.steamusercontent.com/ugc/1758068501357192910/11DDDC7EF621320962FDCF3AE3211D5EDC3D1573/",
    resourcethree = "https://i.imgur.com/1GZsDTt.png",
    doom = "https://i.imgur.com/EoL7yaZ.png",
    clue = "http://cloud-3.steamusercontent.com/ugc/1758068501357164917/1D06F1DC4D6888B6F57124BD2AFE20D0B0DA15A8/"
  }

  TOKEN_DATA = {
    clue = {image = tokenplayerone.clue, scale = {0.15, 0.15, 0.15}},
    resource = {image = tokenplayerone.resource, scale = {0.17, 0.17, 0.17}},
    doom = {image = tokenplayerone.doom, scale = {0.17, 0.17, 0.17}}
  }

  getObjectFromGUID("6161b4").interactable=false
  getObjectFromGUID("721ba2").interactable=false
  getObjectFromGUID("9f334f").interactable=false
  getObjectFromGUID("23a43c").interactable=false
  getObjectFromGUID("5450cc").interactable=false
  getObjectFromGUID("463022").interactable=false
  getObjectFromGUID("9487a4").interactable=false
  getObjectFromGUID("91dd9b").interactable=false
  getObjectFromGUID("f182ee").interactable=false

end

function onObjectDrop(player, obj)
--  local mat = getObjectFromGUID("dsbd0ff4")
--  log(mat.positionToLocal(obj.getPosition()))
end

function take_callback(object_spawned, mat)
    customObject = object_spawned.getCustomObject()
    local player = mat.getGUID();

    local image = customObject.image

    -- Update global stats
    if PULLS[image] == nil then
      PULLS[image] = 0
    end
    PULLS[image] = PULLS[image] + 1
    -- Update player stats
    if PLAYER_PULLS[player][image] == nil then
      PLAYER_PULLS[player][image] = 0
    end
    PLAYER_PULLS[player][image] = PLAYER_PULLS[player][image] + 1

end
MAT_GUID_TO_COLOUR = {
  ["8b081b"] = "White",
  -- player 2 conrad
  ["bd0ff4"] = "Orange",
  -- player
  ["383d8b"] = "Green",
  -- playur 4 olivia
  ["0840d5"] = "Red"
}


PLAYER_PULLS = {
  -- player 1 max
  ["8b081b"] = {},
  -- player 2 conrad
  ["bd0ff4"] = {},
  -- player
  ["383d8b"] = {},
  -- playur 4 olivia
  ["0840d5"] = {}
}

PULLS = {
  -- cultist
  ["https://i.imgur.com/VzhJJaH.png"] = 0,
  -- skull
  ["https://i.imgur.com/stbBxtx.png"] = 0,
  -- tablet
  ["https://i.imgur.com/1plY463.png"] = 0,
  -- curse
  ["http://cloud-3.steamusercontent.com/ugc/1655601092778636039/2A25BD38E8C44701D80DD96BF0121DA21843672E/"] = 0,
  -- tentacle
  ["https://i.imgur.com/lns4fhz.png"] = 0,
  -- minus eight
  ["https://i.imgur.com/9t3rPTQ.png"] = 0,
  -- minus seven
  ["https://i.imgur.com/4WRD42n.png"] = 0,
  -- minus six
  ["https://i.imgur.com/c9qdSzS.png"] = 0,
  -- minus five
  ["https://i.imgur.com/3Ym1IeG.png"] = 0,
  -- minus four
  ["https://i.imgur.com/qrgGQRD.png"] = 0,
  -- minus three
  ["https://i.imgur.com/yfs8gHq.png"] = 0,
  -- minus two
  ["https://i.imgur.com/bfTg2hb.png"] = 0,
  -- minus one
  ["https://i.imgur.com/w3XbrCC.png"] = 0,
  -- zero
  ["https://i.imgur.com/btEtVfd.png"] = 0,
  -- plus one
  ["https://i.imgur.com/uIx8jbY.png"] = 0,
  -- elder thing
  ["https://i.imgur.com/ttnspKt.png"] = 0,
  -- bless
  ["http://cloud-3.steamusercontent.com/ugc/1655601092778627699/339FB716CB25CA6025C338F13AFDFD9AC6FA8356/"] = 0,
  -- elder sign
  ["https://i.imgur.com/nEmqjmj.png"] = 0,
}

IMAGE_TOKEN_MAP = {
    -- elder sign
    ["https://i.imgur.com/nEmqjmj.png"] = "Elder Sign",
    -- plus one
    ["https://i.imgur.com/uIx8jbY.png"] = "+1",
    -- zero
    ["https://i.imgur.com/btEtVfd.png"] = "0",
    -- minus one
    ["https://i.imgur.com/w3XbrCC.png"] = "-1",
    -- minus two
    ["https://i.imgur.com/bfTg2hb.png"] = "-2",
    -- minus three
    ["https://i.imgur.com/yfs8gHq.png"] = "-3",
    -- minus four
    ["https://i.imgur.com/qrgGQRD.png"] = "-4",
    -- minus five
    ["https://i.imgur.com/3Ym1IeG.png"] = "-5",
    -- minus six
    ["https://i.imgur.com/c9qdSzS.png"] = "-6",
    -- minus seven
    ["https://i.imgur.com/4WRD42n.png"] = "-7",
    -- minus eight
    ["https://i.imgur.com/9t3rPTQ.png"] = "-8",
    -- skull
    ["https://i.imgur.com/stbBxtx.png"] = "Skull",
    -- cultist
    ["https://i.imgur.com/VzhJJaH.png"] = "Cultist",
    -- tablet
    ["https://i.imgur.com/1plY463.png"] = "Tablet",
    -- elder thing
    ["https://i.imgur.com/ttnspKt.png"] = "Elder Thing",
    -- tentacle
    ["https://i.imgur.com/lns4fhz.png"] = "Auto-fail",
    -- bless
    ["http://cloud-3.steamusercontent.com/ugc/1655601092778627699/339FB716CB25CA6025C338F13AFDFD9AC6FA8356/"] = "Bless",
    -- curse
    ["http://cloud-3.steamusercontent.com/ugc/1655601092778636039/2A25BD38E8C44701D80DD96BF0121DA21843672E/"] = "Curse"
}

function resetStats()
    for key,value in pairs(PULLS) do
      PULLS[key] = 0
    end
    for playerKey, playerValue in pairs(PLAYER_PULLS) do
      for key,value in pairs(PULLS) do
        PLAYER_PULLS[playerKey][key] = value
      end
    end


end

function getPlayerName(playerMatGuid)
  local playerColour = MAT_GUID_TO_COLOUR[playerMatGuid]
  if Player[playerColour].seated then
    return Player[playerColour].steam_name
  else
    return playerColour
  end
end

function printStats()
  local squidKing = "Nobody"


  printToAll("\nOverall Game stats\n")
  printNonZeroTokenPairs(PULLS)
  printToAll("\nIndividual Stats\n")
  for playerMatGuid, countTable in pairs(PLAYER_PULLS) do
    local playerName = getPlayerName(playerMatGuid)
    printToAll(playerName ..  " Stats", {r=255,g=0,b=0})
    printNonZeroTokenPairs(PLAYER_PULLS[playerMatGuid])
    playerSquidCount = PLAYER_PULLS[playerMatGuid]["https://i.imgur.com/lns4fhz.png"]
    if playerSquidCount ~= nil and playerSquidCount > maxSquid then
      squidKing = playerName
	  maxSquid = playerSquidCount
    end
  end
  printToAll(squidKing .. " is an auto-fail magnet.", {r=255,g=0,b=0})
end

function printNonZeroTokenPairs(theTable)
    for key,value in pairs(theTable) do
      if value ~= 0 then
        printToAll(IMAGE_TOKEN_MAP[key] .. '=' .. tostring(value))
      end
    end
end

-- Remove comments to enable autorotate cards on hands.
-- function onObjectEnterScriptingZone(zone, object)
-- Autorotate cards with right side up when entering hand.
--      if zone.getGUID() == "c506bf" or   -- white
--         zone.getGUID() == "cbc751" then -- orange
--         object.setRotationSmooth({0,270,0})
-- elseif zone.getGUID() == "67ce9a" then -- green
--         object.setRotationSmooth({0,0,0})
--  elseif zone.getGUID() == "57c22c" then -- red
--        object.setRotationSmooth({0,180,0})
--end
--end

function findInRadiusBy(pos, radius, filter, debug)
  local radius = (radius or 1)
  local objList = Physics.cast({
    origin = pos,
    direction = {0,1,0},
    type = 2,
    size = {radius, radius, radius},
    max_distance = 0,
    debug = (debug or false)
  })

  local filteredList = {}
  for _, obj in ipairs(objList) do
    if filter == nil then
      table.insert(filteredList, obj.hit_object)
    elseif filter and filter(obj.hit_object) then
      table.insert(filteredList, obj.hit_object)
    end
  end
  return filteredList
end

function dealCardsInRows(paramlist)
  	local currPosition={};
    local numRow=1;
	local numCard=0;
	local invMultiplier=1;
	local allCardsDealed=0;
		if paramlist.inverse then
		invMultiplier=-1;
	end
		if paramlist.maxCardsDealed==nil then

		allCardsDealed=0;
		paramlist.maxCardsDealed=paramlist.cardDeck.getQuantity()

	elseif paramlist.maxCardsDealed>=paramlist.cardDeck.getQuantity() or paramlist.maxCardsDealed<=0 then

		allCardsDealed=0;
		paramlist.maxCardsDealed=paramlist.cardDeck.getQuantity()

	else

		allCardsDealed=1;

	end

	if paramlist.mode=="x" then
		currPosition={paramlist.iniPosition[1]+(2*g_cardWith*invMultiplier*allCardsDealed),paramlist.iniPosition[2],paramlist.iniPosition[3]};

	else
		currPosition={paramlist.iniPosition[1],paramlist.iniPosition[2],paramlist.iniPosition[3]+(2*g_cardWith*invMultiplier*allCardsDealed)};

	end

	for i = 1,paramlist.maxCardsDealed,1 do

    paramlist.cardDeck.takeObject
      ({
        position= currPosition,
        smooth= true
      });

		numCard=numCard+1;
		if numCard>=paramlist.maxCardRow then

			if paramlist.mode=="x" then
				currPosition={paramlist.iniPosition[1]+(2*g_cardWith*invMultiplier*allCardsDealed),paramlist.iniPosition[2],paramlist.iniPosition[3]};
				currPosition[3]=currPosition[3]-(numRow*g_cardHeigth*invMultiplier);
			else
				currPosition={paramlist.iniPosition[1],paramlist.iniPosition[2],paramlist.iniPosition[3]+(2*g_cardWith*invMultiplier*allCardsDealed)};
				currPosition[1]=currPosition[1]+(numRow*g_cardHeigth*invMultiplier);
			end
			numCard=0;
			numRow=numRow+1;

		else
			if paramlist.mode=="x" then
				currPosition[1]=currPosition[1]+(g_cardWith*invMultiplier);
			else
				currPosition[3]=currPosition[3]+(g_cardWith*invMultiplier);
			end
		end
  end
end

function isDeck(x)
  return x.tag == 'Deck'
end

function isCardOrDeck(x)
  return x.tag == 'Card' or isDeck(x)
end

function drawEncountercard(params) --[[ Parameter Table Position, Table Rotation]]
  local position = params[1]
  local rotation = params[2]
  local alwaysFaceUp = params[3]
  local faceUpRotation
  local card
  local items = findInRadiusBy(ENCOUNTER_DECK_POS, 4, isCardOrDeck)
  if #items > 0 then
    for i, v in ipairs(items) do
      if v.tag == 'Deck' then
        card = v.takeObject({index = 0})
        break
      end
    end
    -- we didn't find the deck so just pull the first thing we did find
    if card == nil then card = items[1] end
    actualEncounterCardDraw(card, params)
    return
  end
-- nothing here, time to reshuffle
  reshuffleEncounterDeck(params)
end

function actualEncounterCardDraw(card, params)
  local position = params[1]
  local rotation = params[2]
  local alwaysFaceUp = params[3]
  local faceUpRotation = 0
  if not alwaysFaceUp then
    if getObjectFromGUID(tokenDataId).call('checkHiddenCard', card.getName()) then
      faceUpRotation = 180
    end
  end
  card.setPositionSmooth(position, false, false)
  card.setRotationSmooth({0,rotation.y,faceUpRotation}, false, false)
end

IS_RESHUFFLING = false
function reshuffleEncounterDeck(params)
  -- finishes moving the deck back and draws a card
  local function move(deck)
    deck.setPositionSmooth(ENCOUNTER_DECK_SPAWN_POS, true, false)
    actualEncounterCardDraw(deck.takeObject({index=0}), params)
    Wait.time(function()
      IS_RESHUFFLING = false
    end, 1)
  end
  -- bail out if we're mid reshuffle
  if IS_RESHUFFLING then
    return
  end
  local discarded = findInRadiusBy(ENCOUNTER_DECK_DISCARD_POSITION, 4, isDeck)
  if #discarded > 0 then
    IS_RESHUFFLING = true
    local deck = discarded[1]
    if not deck.is_face_down then
      deck.flip()
    end
    deck.shuffle()
    Wait.time(|| move(deck), 0.3)
  else
    printToAll("couldn't find encounter discard pile to reshuffle", {1, 0, 0})
  end
end

CHAOS_TOKENS = {}
CHAOS_TOKENS_LAST_MAT = nil
function putBackChaosTokens()
  local chaosbagposition = chaosbag.getPosition()
  for k, token in pairs(CHAOS_TOKENS) do
    if token ~= nil then
      chaosbag.putObject(token)
      token.setPosition({chaosbagposition[1],chaosbagposition[2]+0.5,chaosbagposition[3]})
      end
    end
      CHAOS_TOKENS = {}
  end

function drawChaostoken(params)
  local mat = params[1]
  local tokenOffset = params[2]
  local isRightClick = params[3]
  local isSameMat = (CHAOS_TOKENS_LAST_MAT == nil or CHAOS_TOKENS_LAST_MAT == mat)
  if not isSameMat then
    putBackChaosTokens()
  end
  CHAOS_TOKENS_LAST_MAT = mat
  -- if we have left clicked and have no tokens OR if we have right clicked
  if isRightClick or #CHAOS_TOKENS == 0 then
    local items = getObjectFromGUID("83ef06").getObjects()
    for i,v in ipairs(items) do
      if items[i].getDescription() == "Chaos Bag" then
        chaosbag = getObjectFromGUID(items[i].getGUID())
        break
      end
    end
    -- bail out if we have no tokens
    if #chaosbag.getObjects() == 0 then
      return
    end
    chaosbag.shuffle()
    -- add the token to the list, compute new position based on list length
    tokenOffset[1] = tokenOffset[1] + (0.17 * #CHAOS_TOKENS)
    local toPosition = mat.positionToWorld(tokenOffset)
    local token = chaosbag.takeObject({
      index = 0,
      position = toPosition,
      rotation = mat.getRotation(),
	  callback_function = function(obj) take_callback(obj, mat) end
    })
    CHAOS_TOKENS[#CHAOS_TOKENS + 1] = token
    return
  else
    putBackChaosTokens()
  end
end

function spawnToken(params)
  -- Position to spawn,
  -- rotation vector to apply
  -- translation vector to apply
  -- token type
  local position = params[1]
  local tokenType = params[2]
  local tokenData = TOKEN_DATA[tokenType]
  if tokenData == nil then
    error("no token data found for '" .. tokenType .. "'")
  end

  local token = spawnObject({
    type = 'Custom_Token',
    position = position,
	rotation = {x=0, y=270, z=0}
  })
  token.setCustomObject({
    image = tokenData['image'],
    thickness = 0.3,
    merge_distance = 5.0,
    stackable = true,
  })
  token.use_snap_points=false
  token.scale(tokenData['scale'])
  return token
end

function round(params) -- Parameter (int number, int numberDecimalPlaces)
  return tonumber(string.format("%." .. (params[2] or 0) .. "f", params[1]))
end

function roundposition(params) -- Parameter (Table position)
  return {round({params[1], 2}),round({params[2], 2}),round({params[3], 2})}
end

function isEqual(params) --Parameter (Table table1, Table table2) returns true if the tables are equal
  if params[1][1] == params[2][1] and params[1][2] == params[2][2] and params[1][3] == params[2][3] then
    return true
  else
    return false
  end
end

function isFaceup(params) --Object object
  if params.getRotation()[3] > -5 and params.getRotation()[3] < 5 then
    return true
  else
    return false
  end
end

--Difficulty selector script

function createSetupButtons(args)
    local data = getDataValue('modeData', args.key)
    if data ~= nil then
        local z = -0.15
        if data.easy ~= nil then
            args.object.createButton({
                label = 'Easy',
                click_function = 'easyClick',
                function_owner = args.object,
                position = {0, 0.1, z},
                rotation = {0, 0, 0},
                scale = {0.47, 1, 0.47},
                height = 200,
                width = 1150,
                font_size = 100,
                color = {0.87, 0.8, 0.70},
                font_color = {0, 0, 0}
            })
            z = z + 0.20
        end
        if data.normal ~= nil then
            args.object.createButton({
                label = 'Standard',
                click_function = 'normalClick',
                function_owner = args.object,
                position = {0, 0.1, z},
                rotation = {0, 0, 0},
                scale = {0.47, 1, 0.47},
                height = 200,
                width = 1150,
                font_size = 100,
                color = {0.87, 0.8, 0.70},
                font_color = {0, 0, 0}
            })
            z = z + 0.20
        end
        if data.hard ~= nil then
            args.object.createButton({
                label = 'Hard',
                click_function = 'hardClick',
                function_owner = args.object,
                position = {0, 0.1, z},
                rotation = {0, 0, 0},
                scale = {0.47, 1, 0.47},
                height = 200,
                width = 1150,
                font_size = 100,
                color = {0.87, 0.8, 0.70},
                font_color = {0, 0, 0}
            })
            z = z + 0.20
        end
        if data.expert ~= nil then
            args.object.createButton({
                label = 'Expert',
                click_function = 'expertClick',
                function_owner = args.object,
                position = {0, 0.1, z},
                rotation = {0, 0, 0},
                scale = {0.47, 1, 0.47},
                height = 200,
                width = 1150,
                font_size = 100,
                color = {0.87, 0.8, 0.70},
                font_color = {0, 0, 0}
            })
            z = z + 0.20
        end
        z = z + 0.10
        if data.standalone ~= nil then
            args.object.createButton({
                label = 'Standalone',
                click_function = 'standaloneClick',
                function_owner = args.object,
                position = {0, 0.1, z},
                rotation = {0, 0, 0},
                scale = {0.47, 1, 0.47},
                height = 200,
                width = 1150,
                font_size = 100,
                color = {0.87, 0.8, 0.70},
                font_color = {0, 0, 0}
            })
        end
    end
end

function fillContainer(args)
    local container = getObjectCache(containerId)

    if container ~= nil then
        local data = getDataValue('modeData', args.key)
        if data == nil then return end

        local value = data[args.mode]
        if value == nil or value.token == nil then return end

        local pos = container.getPosition()
        if args.object ~= nil then
            pos = args.object.getPosition()
        end

        cleanContainer(container)

        for _, token in ipairs(value.token) do
            local obj = spawnToken_2(token, pos)
            if obj ~= nil then
                container.putObject(obj)
            end
        end

        if value.append ~= nil then
            for _, token in ipairs(value.append) do
                local obj = spawnToken_2(token, pos)
                if obj ~= nil then
                    container.putObject(obj)
                end
            end
        end

        if value.random then
            local n = #value.random
            if n > 0 then
                for _, token in ipairs(value.random[getRandomCount(n)]) do
                    local obj = spawnToken_2(token, pos)
                    if obj ~= nil then
                        container.putObject(obj)
                    end
                end
            end
        end

        if value.message then
            broadcastToAll(value.message)
        end
        if value.warning then
            broadcastToAll(value.warning, { 1, 0.5, 0.5 })
        end
    end
end

function spawnToken_2(id, pos)
    local url = getImageUrl(id)
    if url ~= '' then
        local obj = spawnObject({
            type = 'Custom_Tile',
            position = {pos.x, pos.y + 3, pos.z},
            rotation = {x = 0, y = 260, z = 0}
                    })
        obj.setCustomObject({
            type = 2,
            image = url,
            thickness = 0.10,
                    })
        obj.scale {0.81, 1, 0.81}
        obj.setName(getTokenName({ url=url }))
        return obj
    end
end

function getTokenName(params)
    local name = IMAGE_TOKEN_MAP[params.url]
    if name == nil then name = "" end
    return name
end

function getImageUrl(id)
    if id == 'p1' then return 'https://i.imgur.com/uIx8jbY.png' end
    if id == '0' then return 'https://i.imgur.com/btEtVfd.png' end
    if id == 'm1' then return 'https://i.imgur.com/w3XbrCC.png' end
    if id == 'm2' then return 'https://i.imgur.com/bfTg2hb.png' end
    if id == 'm3' then return 'https://i.imgur.com/yfs8gHq.png' end
    if id == 'm4' then return 'https://i.imgur.com/qrgGQRD.png' end
    if id == 'm5' then return 'https://i.imgur.com/3Ym1IeG.png' end
    if id == 'm6' then return 'https://i.imgur.com/c9qdSzS.png' end
    if id == 'm7' then return 'https://i.imgur.com/4WRD42n.png' end
    if id == 'm8' then return 'https://i.imgur.com/9t3rPTQ.png' end
    if id == 'skull' then return 'https://i.imgur.com/stbBxtx.png' end
    if id == 'cultist' then return 'https://i.imgur.com/VzhJJaH.png' end
    if id == 'tablet' then return 'https://i.imgur.com/1plY463.png' end
    if id == 'elder' then return 'https://i.imgur.com/ttnspKt.png' end
    if id == 'red' then return 'https://i.imgur.com/lns4fhz.png' end
    if id == 'blue' then return 'https://i.imgur.com/nEmqjmj.png' end
    return ''
end

function cleanContainer(container)
    for _, item in ipairs(container.getObjects()) do
        destroyObject(container.takeObject({}))
    end
end

function getObjectsInZone(zoneId)
    local zoneObject = getObjectCache(zoneId)

    if zoneObject == nil then
        return
    end

    local objectsInZone = zoneObject.getObjects()
    local objectsFound = {}

    for i = 1, #objectsInZone do
        local object = objectsInZone[i]
        if object.tag == 'Bag' then
            table.insert(objectsFound, object.guid)
        end
    end

    if #objectsFound > 0 then
        return objectsFound
    end
end

function getObjectCache(id)
    if CACHE.object[id] == nil then
        CACHE.object[id] = getObjectFromGUID(id)
    end
    return CACHE.object[id]
end

function getDataTable(storage)
    if CACHE.data[storage] == nil then
        local obj = getObjectCache(tokenDataId)
        if obj ~= nil then
            CACHE.data[storage] = obj.getTable(storage)
        end
    end
    return CACHE.data[storage]
end

function getDataValue(storage, key)
    local data = getDataTable(storage)
    if data ~= nil then
        local value = data[key]
        if value ~= nil then
            local res = {}
            for m, v in pairs(value) do
                res[m] = v
                if res[m].parent ~= nil then
                    local parentData = getDataValue(storage, res[m].parent)
                    if parentData ~= nil and parentData[m] ~= nil and parentData[m].token ~= nil then
                        res[m].token = parentData[m].token
                    end
                    res[m].parent = nil
                end
            end
            return res
        end
    end
end

function getRandomCount(to)
    updateRandomSeed()
    return math.random(1, to)
end

function updateRandomSeed()
    local chance = math.random(1,10)
    if chance == 1 then
        math.randomseed(os.time())
    end
end


-- Content Importing


--- Loadable Items test

local list_url = 'https://raw.githubusercontent.com/seth-sced/loadable-objects/main/library.json'
local library = nil

local request_obj

---

function onClick_toggleUi(player, window)
  toggle_ui(window)
end

function onClick_refreshList()
  local request = WebRequest.get(list_url, completed_list_update)
  request_obj = request
  startLuaCoroutine(Global, 'my_coroutine')
end

function onClick_select(player, params)
  params = JSON.decode(urldecode(params))
  local url = params.url
  local request = WebRequest.get(url, function (request) complete_obj_download(request, params) end )
  request_obj = request
  startLuaCoroutine(Global, 'my_coroutine')
end

function onClick_load()
  UI.show('progress_display')
  UI.hide('load_button')
end

function onClick_cancel()
end

---

function toggle_ui(title)
  UI.hide('load_ui')
  if UI.getValue('title') == title or title == 'Hidden' then
    UI.setValue('title', 'Hidden')
  else
    UI.setValue('title', title)
    update_window_content(title)
    UI.show('load_ui')
  end
end

function my_coroutine()
  while request_obj do
    UI.setAttribute('download_progress', 'percentage', request_obj.download_progress * 100)
    coroutine.yield(0)
  end
  return 1
end


function update_list(objects)
  local ui = UI.getXmlTable()
  local update_height = find_tag_with_id(ui, 'ui_update_height')
  local update_children = find_tag_with_id(update_height.children, 'ui_update_point')

  update_children.children = {}

  for i,v in ipairs(objects) do
    local s = JSON.encode(v);
    --print(s)
    table.insert(update_children.children,
      {
        tag = 'Text',
        value = v.name,
        attributes = { onClick = 'onClick_select('.. urlencode(JSON.encode(v)) ..')',
                       alignment = 'MiddleLeft' }
      }
    )
  end

  update_height.attributes.height = #(update_children.children) * 24
  UI.setXmlTable(ui)
end

function update_window_content(new_title)
  if not library then
    return
  end

  if new_title == 'Campaigns' then
    update_list(library.campaigns)
  elseif new_title == 'Standalone Scenarios' then
    update_list(library.scenarios)
  elseif new_title == 'Investigators' then
    update_list(library.investigators)
  elseif new_title == 'Community Content' then
    update_list(library.community)
  elseif new_title == 'Extras' then
    update_list(library.extras)
  else
    update_list({})
  end
end

function complete_obj_download(request, params)
  assert(request.is_done)
  if request.is_error or request.response_code ~= 200 then
    print('error: ' .. request.error)
  else
    if pcall(function ()
               local replaced_object
               pcall(function () if params.replace then replaced_object = getObjectFromGUID(params.replace) end end)
               if replaced_object then
                 local pos = replaced_object.getPosition()
                 local rot = replaced_object.getRotation()
                 local json = request.text
                 destroyObject(replaced_object)
                 Wait.frames(function () spawnObjectJSON({json = json, position = pos, rotation = rot}) end, 1)
               else
                 spawnObjectJSON({json = json})
               end
             end) then
      print('Object loaded.')
    else
      print('Error loading object.')
    end
  end

  request_obj = nil
  UI.setAttribute('download_progress', 'percentage', 100)

end

-- the download button on the placeholder objects calls this to directly initiate a download
function placeholder_download(params)
  -- params is a table with url and guid of replacement object, which happens to match what onClick_select wants
  onClick_select(nil, JSON.encode(params))
end

function completed_list_update(request)
  assert(request.is_done)
  if request.is_error or request.response_code ~= 200 then
    print('error: ' .. request.error)
  else
    local json_response = nil
    if pcall(function () json_response = JSON.decode(request.text) end) then
      library = json_response
      update_window_content(UI.getValue('title'))
    else
      print('error parsing downloaded library')
    end
  end

  request_obj = nil
  UI.setAttribute('download_progress', 'percentage', 100)
end

---

function find_tag_with_id(ui, id)
  for i,obj in ipairs(ui) do
    if obj.attributes and obj.attributes.id and obj.attributes.id == id then
      return obj
    end
    if obj.children then
      local result = find_tag_with_id(obj.children, id)
      if result then return result end
    end
  end
  return nil
end

function urlencode(str)
  str = string.gsub(str, "([^A-Za-z0-9-_.~])",
    function (c) return string.format("%%%02X", string.byte(c)) end)
  return str
end

function urldecode(str)
  str = string.gsub(str, "%%(%x%x)",
    function (h) return string.char(tonumber(h, 16)) end)
  return str
end