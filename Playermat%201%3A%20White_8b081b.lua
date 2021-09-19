-- set true to enable debug logging
DEBUG = false
-- we use this to turn off collision handling (for clue spawning)
-- until after load is complete (probably a better way to do this)
COLLISION_ENABLED = false
-- position offsets, adjust these to reposition things relative to mat [x,y,z]
DRAWN_ENCOUNTER_CARD_OFFSET = {0.98, 0.5, -0.635}
DRAWN_CHAOS_TOKEN_OFFSET = {-1.2, 0.5, -0.45}
DISCARD_BUTTON_OFFSETS = {
  {-0.98, 0.2, -0.945},
  {-0.525, 0.2, -0.945},
  {-0.07, 0.2, -0.945},
  {0.39, 0.2, -0.945},
  {0.84, 0.2, -0.945},
}
-- draw deck and discard zone
DECK_POSITION = { x=-1.4, y=0, z=0.3 }
DECK_ZONE_SCALE = { x=3, y=5, z=8 }
DRAW_DECK_POSITION = { x=-55, y=2.5, z=4.5 }

-- play zone
PLAYER_COLOR = "White"
PLAY_ZONE_POSITION = { x=-54.42, y=4.10, z=20.96}
PLAY_ZONE_ROTATION = { x=0, y=270, z=0 }
PLAY_ZONE_SCALE = { x=36.63, y=5.10, z=14.59}

RESOURCE_COUNTER_GUID = "4406f0"

-- the position of the global discard pile
-- TODO: delegate to global for any auto discard actions
DISCARD_POSITION = {-3.85, 3, 10.38}

function log(message)
  if DEBUG then
    print(message)
  end
end

-- builds a function that discards things in searchPostion to discardPostition
function makeDiscardHandlerFor(searchPosition, discardPosition)
  return function (_)
    local discardItemList = findObjectsAtPosition(searchPosition)
    for _, obj in ipairs(discardItemList) do
      obj.setPositionSmooth(discardPosition, false, true)
      obj.setRotation({0, -90, 0})
    end
  end
end

-- build a discard button at position to discard from searchPosition to discardPosition
-- number must be unique
function makeDiscardButton(position, searchPosition, discardPosition, number)
  local handler = makeDiscardHandlerFor(searchPosition, discardPosition)
  local handlerName = 'handler' .. number
  self.setVar(handlerName, handler)
  self.createButton({
    label = "Discard",
    click_function= handlerName,
    function_owner= self,
    position = position,
    scale = {0.12, 0.12, 0.12},
    width = 800,
    height = 280,
    font_size = 180,
  })
end

function onload(save_state)
  self.interactable = DEBUG
  DATA_HELPER = getObjectFromGUID('708279')
  PLAYER_CARDS = DATA_HELPER.getTable('PLAYER_CARD_DATA')
  PLAYER_CARD_TOKEN_OFFSETS = DATA_HELPER.getTable('PLAYER_CARD_TOKEN_OFFSETS')

  -- positions of encounter card slots
  local encounterSlots = {
    {1, 0, -0.7},
    {0.55, 0, -0.7},
    {0.1, 0, -0.7},
    {-0.35, 0, -0.7},
    {-0.8, 0, -0.7}
  }

  local i = 1
  while i <= 5 do
    makeDiscardButton(DISCARD_BUTTON_OFFSETS[i], encounterSlots[i], DISCARD_POSITION, i)
    i = i + 1
  end

  self.createButton({
    label = " ",
    click_function = "drawEncountercard",
    function_owner = self,
    position = {-1.45,0,-0.7},
    rotation = {0,-15,0},
    width = 170,
    height = 255,
    font_size = 50
  })

  self.createButton({
    label=" ",
    click_function = "drawChaostokenButton",
    function_owner = self,
    position = {1.48,0.0,-0.74},
    rotation = {0,-45,0},
    width = 125,
    height = 125,
    font_size = 50
  })

  self.createButton({
    label="Upkeep",
    click_function = "doUpkeep",
    function_owner = self,
    position = {1.48,0.1,-0.44},
    scale = {0.12, 0.12, 0.12},
    width = 800,
    height = 280,
    font_size = 180
  })

  self.createButton({
    label="Draw 1",
    click_function = "doDrawOne",
    function_owner = self,
    position = {1.48,0.1,-0.36},
    scale = {0.12, 0.12, 0.12},
    width = 800,
    height = 280,
    font_size = 180
  })

  local state = JSON.decode(save_state)
  if state ~= nil then
    if state.playerColor ~= nil then
        PLAYER_COLOR = state.playerColor
    end
    if state.zoneID ~= nil then
        zoneID = state.zoneID
        Wait.time(checkDeckZoneExists, 30)
    else
        spawnDeckZone()
    end
  else
    spawnDeckZone()
  end

  COLLISION_ENABLED = true
end

function onSave()
    return JSON.encode({ zoneID=zoneID, playerColor=PLAYER_COLOR })
end

function setMessageColor(color)
    -- send messages to player who clicked button if no seated player found
    messageColor = Player[PLAYER_COLOR].seated and PLAYER_COLOR or color
end

function getDrawDiscardDecks(zone)
    -- get the draw deck and discard pile objects
    drawDeck = nil
    discardPile = nil
    for i,object in ipairs(zone.getObjects()) do
        if object.tag == "Deck" or object.tag == "Card" then
            if object.is_face_down then
                drawDeck = object
            else
                discardPile = object
            end
        end
    end
end

function checkDeckThenDrawOne()
    -- draw 1 card, shuffling the discard pile if necessary
    if drawDeck == nil then
        if discardPile ~= nil then
            shuffleDiscardIntoDeck()
            Wait.time(|| drawCards(1), 1)
        end
        printToColor("Take 1 horror (drawing card from empty deck)", messageColor)
    else
        drawCards(1)
    end
end

function doUpkeep(obj, color, alt_click)
    -- right-click binds to new player color
    if alt_click then
        PLAYER_COLOR = color
        printToColor("Upkeep button bound to " .. color, color)
        return
    end

    setMessageColor(color)

    -- unexhaust cards in play zone
    local objs = Physics.cast({
        origin = PLAY_ZONE_POSITION,
        direction = { x=0, y=1, z=0 },
        type = 3,
        size = PLAY_ZONE_SCALE,
        orientation = PLAY_ZONE_ROTATION
    })

    local y = PLAY_ZONE_ROTATION.y

    local investigator = nil
    for i,v in ipairs(objs) do
        local obj = v.hit_object
        local props = obj.getCustomObject()
        if obj.tag == "Card" and not obj.is_face_down and not doNotReady(obj) then
            if props ~= nil and props.unique_back then
                local name = obj.getName()
                if string.match(name, "Jenny Barnes") ~= nil then
                    investigator = "Jenny Barnes"
                elseif name == "Patrice Hathaway" then
                    investigator = name
                end
            else
                local r = obj.getRotation()
                if (r.y - y > 10) or (y - r.y > 10) then
                    obj.setRotation(PLAY_ZONE_ROTATION)
                end
            end
        elseif obj.tag == "Board" and obj.getDescription() == "Action token" then
            if obj.is_face_down then obj.flip() end
        end
    end

    -- gain resource
    getObjectFromGUID(RESOURCE_COUNTER_GUID).call("add_subtract")
    if investigator == "Jenny Barnes" then
        getObjectFromGUID(RESOURCE_COUNTER_GUID).call("add_subtract")
        printToColor("Taking 2 resources (Jenny)", messageColor)
    end

    -- get the draw deck and discard pile objects
    local zone = getObjectFromGUID(zoneID)
    if zone == nil then return end

    getDrawDiscardDecks(zone)

    -- special draw for Patrice Hathaway (shuffle discards if necessary)
    if investigator == "Patrice Hathaway" then
        patriceDraw()
        return
    end

    -- draw 1 card (shuffle discards if necessary)
    checkDeckThenDrawOne()
end

function doDrawOne(obj, color, alt_click)
    -- right-click binds to new player color
    if alt_click then
        PLAYER_COLOR = color
        printToColor("Draw 1 button bound to " .. color, color)
        return
    end

    setMessageColor(color)

    -- get the draw deck and discard pile objects
    local zone = getObjectFromGUID(zoneID)
    if zone == nil then return end

    getDrawDiscardDecks(zone)

    -- draw 1 card (shuffle discards if necessary)
    checkDeckThenDrawOne()
end

function doNotReady(card)
    if card.getVar("do_not_ready") == true then
        return true
    else
        return false
    end
end

function drawCards(numCards)
    if drawDeck == nil then return end
    drawDeck.deal(numCards, PLAYER_COLOR)
end

function shuffleDiscardIntoDeck()
    discardPile.flip()
    discardPile.shuffle()
    discardPile.setPositionSmooth(DRAW_DECK_POSITION, false, false)
    drawDeck = discardPile
    discardPile = nil
end

function patriceDraw()
    local handSize = #Player[PLAYER_COLOR].getHandObjects()
    if handSize >= 5 then return end
    local cardsToDraw = 5 - handSize
    local deckSize
    printToColor("Drawing " .. cardsToDraw .. " cards (Patrice)", messageColor)
    if drawDeck == nil then
        deckSize = 0
    elseif drawDeck.tag == "Deck" then
        deckSize = #drawDeck.getObjects()
    else
        deckSize = 1
    end

    if deckSize >= cardsToDraw then
        drawCards(cardsToDraw)
        return
    end

    drawCards(deckSize)
    if discardPile ~= nil then
        shuffleDiscardIntoDeck()
        Wait.time(|| drawCards(cardsToDraw - deckSize), 1)
    end
    printToColor("Take 1 horror (drawing card from empty deck)", messageColor)
end

function checkDeckZoneExists()
    if getObjectFromGUID(zoneID) ~= nil then return end
    spawnDeckZone()
end

function spawnDeckZone()
    local pos = self.positionToWorld(DECK_POSITION)
    local zoneProps = {
      position = pos,
      scale = DECK_ZONE_SCALE,
      type = 'ScriptingTrigger',
      callback = 'zoneCallback',
      callback_owner = self,
      rotation = self.getRotation()
    }
    spawnObject(zoneProps)
end

function zoneCallback(zone)
    zoneID = zone.getGUID()
end

function findObjectsAtPosition(localPos)
    local globalPos = self.positionToWorld(localPos)
    local objList = Physics.cast({
        origin=globalPos, --Where the cast takes place
        direction={0,1,0}, --Which direction it moves (up is shown)
        type=2, --Type. 2 is "sphere"
        size={2,2,2}, --How large that sphere is
        max_distance=1, --How far it moves. Just a little bit
        debug=false --If it displays the sphere when casting.
    })
    local decksAndCards = {}
        for _, obj in ipairs(objList) do
        if obj.hit_object.tag == "Deck" or obj.hit_object.tag == "Card" then
            table.insert(decksAndCards, obj.hit_object)
        end
    end
    return decksAndCards
end

function spawnTokenOn(object, offsets, tokenType)
  local tokenPosition = object.positionToWorld(offsets)
  spawnToken(tokenPosition, tokenType)
end

-- spawn a group of tokens of the given type on the object
function spawnTokenGroup(object, tokenType, tokenCount)
  local offsets = PLAYER_CARD_TOKEN_OFFSETS[tokenCount]
  if offsets == nil then
    error("couldn't find offsets for " .. tokenCount .. ' tokens')
  end
  local i = 0
  while i < tokenCount do
    local offset = offsets[i + 1]
    spawnTokenOn(object, offset, tokenType)
    i = i + 1
  end
end

function buildPlayerCardKey(object)
  return object.getName() .. ':' .. object.getDescription()
end

function getPlayerCardData(object)
  return PLAYER_CARDS[buildPlayerCardKey(object)] or PLAYER_CARDS[object.getName()]
end

function shouldSpawnTokens(object)
  -- we assume we shouldn't spawn tokens if in doubt, this should
  -- only ever happen on load and in that case prevents respawns
  local spawned = DATA_HELPER.call('getSpawnedPlayerCardGuid', {object.getGUID()})
  local canSpawn = getPlayerCardData(object)
  return not spawned and canSpawn
end

function markSpawned(object)
  local saved = DATA_HELPER.call('setSpawnedPlayerCardGuid', {object.getGUID(), true})
  if not saved then
    error('attempt to mark player card spawned before data loaded')
  end
end

function spawnTokensFor(object)
  local data = getPlayerCardData(object)
  if data == nil then
    error('attempt to spawn tokens for ' .. object.getName() .. ': no token data')
  end
  log(object.getName() .. '[' .. object.getDescription() .. ']' .. ' : ' .. data['tokenType'] .. ' : ' .. data['tokenCount'])
  spawnTokenGroup(object, data['tokenType'], data['tokenCount'])
  markSpawned(object)
end

function resetSpawnState()
    local zone = getObjectFromGUID(zoneID)
    if zone == nil then return end

    for i,object in ipairs(zone.getObjects()) do
        if object.tag == "Card" then
            local guid = object.getGUID()
            if guid ~= nil then unmarkSpawned(guid, true) end
        elseif object.tag == "Deck" then
            local cards = object.getObjects()
            if (cards ~= nil) then
                for i,v in ipairs(cards) do
                    if v.guid ~= nil then unmarkSpawned(v.guid) end
                end
            end
        end
    end
end

function unmarkSpawned(guid, force)
  if not force and getObjectFromGUID(guid) ~= nil then return end
  DATA_HELPER.call('setSpawnedPlayerCardGuid', {guid, false})
end

function onCollisionEnter(collision_info)
  if not COLLISION_ENABLED then
    return
  end

  local object = collision_info.collision_object
  Wait.time(resetSpawnState, 1)
  -- anything to the left of this is legal to spawn
  local discardSpawnBoundary = self.positionToWorld({-1.2, 0, 0})
  local boundaryLocalToCard = object.positionToLocal(discardSpawnBoundary)
  if boundaryLocalToCard.x > 0 then
    log('not checking for token spawn, boundary relative is ' .. boundaryLocalToCard.x)
    return
  end
  if not object.is_face_down and shouldSpawnTokens(object) then
    spawnTokensFor(object)
  end
end

-- functions delegated to Global
function drawChaostokenButton(object, player, isRightClick)
  -- local toPosition = self.positionToWorld(DRAWN_CHAOS_TOKEN_OFFSET)
  Global.call("drawChaostoken", {self, DRAWN_CHAOS_TOKEN_OFFSET, isRightClick})
end

function drawEncountercard(object, player, isRightClick)
local toPosition = self.positionToWorld(DRAWN_ENCOUNTER_CARD_OFFSET)
Global.call("drawEncountercard", {toPosition, self.getRotation(), isRightClick})
end

function spawnToken(position, tokenType)
  Global.call('spawnToken', {position, tokenType})
end

function updatePlayerCards(args)
    local custom_data_helper = getObjectFromGUID(args[1])
    data_player_cards = custom_data_helper.getTable("PLAYER_CARD_DATA")
    for k, v in pairs(data_player_cards) do
        PLAYER_CARDS[k] = v
    end
end