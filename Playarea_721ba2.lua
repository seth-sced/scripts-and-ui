-- set true to enable debug logging
DEBUG = false

-- we use this to turn off collision handling (for clue spawning)
-- until after load is complete (probably a better way to do this)
COLLISION_ENABLED = false

-- TODO get the log function from global instead
-- log = Global.call('getLogFunction', this)
function getLogFunction(object)
  return function (message)
    if DEBUG then
      print(message)
    end
  end
end

log = getLogFunction(self)

function onload(save_state)
  self.interactable = DEBUG
  local dataHelper = getObjectFromGUID('708279')
  LOCATIONS = dataHelper.getTable('LOCATIONS_DATA')

  TOKEN_PLAYER_ONE = Global.getTable('tokenplayerone')
  COUNTER = getObjectFromGUID('f182ee')
  log('attempting to load state: ' .. save_state)
  if save_state ~= '' then
    SPAWNED_LOCATION_GUIDS = JSON.decode(save_state)
  end

  COLLISION_ENABLED = true
end

function onSave()
  local spawned_locations = JSON.encode(SPAWNED_LOCATION_GUIDS)
  self.script_state = spawned_locations
end

--[[
records locations we have spawned clues for, we write this to the save
file onsave() so we don't spawn clues again after a load
]]
SPAWNED_LOCATION_GUIDS = {}

function isAlreadySpawned(object)
  return SPAWNED_LOCATION_GUIDS[object.getGUID()] ~= nil
end

function markSpawned(object)
  SPAWNED_LOCATION_GUIDS[object.getGUID()] = 1
end

function buildKey(object)
  return object.getName() .. '_' .. object.getGUID()
end

-- try the compound key then the name alone as default
function getLocation(object)
  return LOCATIONS[buildKey(object)] or LOCATIONS[object.getName()]
end

function isLocationWithClues(object)
  return getLocation(object) ~= nil
end

--[[
Return the number of clues to spawn on this location
]]
function getClueCount(object, isFaceDown, playerCount)
  if not isLocationWithClues(object) then
    error('attempted to get clue for unexpected object: ' .. object.getName())
  end
  local details = getLocation(object)
  log(object.getName() .. ' : ' .. details['type'] .. ' : ' .. details['value'] .. ' : ' .. details['clueSide'])
  if ((isFaceDown and details['clueSide'] == 'back')
      or (not isFaceDown and details['clueSide'] == 'front')) then
    if details['type'] == 'fixed' then
      return details['value']
    elseif details['type'] == 'perPlayer' then
      return details['value'] * playerCount
    end
    error('unexpected location type: ' .. details['type'])
  end
  return 0
end

function spawnToken(position, number)
  local obj_parameters = {
    position = position,
    rotation = {3.87674022, -90, 0.239081308}
  }
  local custom = {
    thickness = 0.1,
    stackable = true
  }

  if number == '1' or number == '2' then
    obj_parameters.type = 'Custom_Token'
    custom.merge_distance = 5.0
    local token = spawnObject(obj_parameters)
      if number == '1' then
        custom.image = TOKEN_PLAYER_ONE.damageone
        token.setCustomObject(custom)
        token.scale {0.17, 1, 0.17}
        return token
      end

      if number == '2' then
        custom.image = TOKEN_PLAYER_ONE.damagethree
        token.setCustomObject(custom)
        token.scale {0.18, 1, 0.18}
        return token
      end
  end

  if number == '3' or number == '4' then
    obj_parameters.type = 'Custom_Tile'
    custom.type = 2
    local token = spawnObject(obj_parameters)
    if number == '3' then
      custom.image = TOKEN_PLAYER_ONE.clue
      custom.image_bottom = TOKEN_PLAYER_ONE.doom
      token.setCustomObject(custom)
      token.scale {0.25, 1, 0.25}
      token.use_snap_points=false
      return token
    end

    if number == '4' then
      custom.image = TOKEN_PLAYER_ONE.doom
      custom.image_bottom = TOKEN_PLAYER_ONE.clue
      token.setCustomObject(custom)
      token.scale {0.25, 1, 0.25}
      token.use_snap_points=false
      return token
    end
  end

end


function spawnCluesAtLocation(clueCount, collision_info)
  local object = collision_info.collision_object
  if isAlreadySpawned(object) then
    error('tried to spawn clue for already spawned location:' .. object.getName())
  end

  local obj_parameters = {}
  obj_parameters.type = 'Custom_Token'
  obj_parameters.position = {
    object.getPosition()[1],
    object.getPosition()[2] + 1,
    object.getPosition()[3]
  }

  log('spawning clues for ' .. object.getName() .. '_' .. object.getGUID())
  local playerCount = COUNTER.getVar('val')
  log('player count is ' .. playerCount .. ', clue count is ' .. clueCount)
  -- mark this location as spawned, can't happen again
  markSpawned(object)
  i = 0
  while i < clueCount do
    if i < 4 then
      obj_parameters.position = {
        collision_info.collision_object.getPosition()[1] + 0.3,
        collision_info.collision_object.getPosition()[2] + 0.2,
        collision_info.collision_object.getPosition()[3] - 0.8 + (0.55 * i)
      }
    elseif i < 8 then
      obj_parameters.position = {
        collision_info.collision_object.getPosition()[1] + 0.85,
        collision_info.collision_object.getPosition()[2] + 0.2,
        collision_info.collision_object.getPosition()[3] - 3 + (0.55 * i)
      }
    else
      obj_parameters.position = {
        collision_info.collision_object.getPosition()[1] + 0.575,
        collision_info.collision_object.getPosition()[2] + 0.4,
        collision_info.collision_object.getPosition()[3] - 5.2 + (0.55 * i)}
    end
    spawnToken(obj_parameters.position, '3')
    i = i + 1
  end
end


function updateLocations(args)
    local custom_data_helper = getObjectFromGUID(args[1])
    data_locations = custom_data_helper.getTable("LOCATIONS_DATA")
    for k, v in pairs(data_locations) do
        LOCATIONS[k] = v
    end
end

function onCollisionEnter(collision_info)
  -- short circuit all collision stuff until we've loaded state
  if not COLLISION_ENABLED then
    return
  end

  -- check if we should spawn clues here
  local object = collision_info.collision_object
  if isLocationWithClues(object) and not isAlreadySpawned(object) then
    -- this isn't an either/or as down/up here means at a relatively low angle
  --   local isFaceUp = not object.is_face_down
  --  local isFaceDown = (object.getRotation()[3] > 160 and object.getRotation()[3] < 200)
    local playerCount = COUNTER.getVar('val')
    local clueCount = getClueCount(object, object.is_face_down, playerCount)
    if clueCount > 0 then
      spawnCluesAtLocation(clueCount, collision_info)
    end
  end
end