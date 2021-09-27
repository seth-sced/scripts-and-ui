-- Bundled by luabundle {"version":"1.6.0"}
local __bundle_require, __bundle_loaded, __bundle_register, __bundle_modules = (function(superRequire)
	local loadingPlaceholder = {[{}] = true}

	local register
	local modules = {}

	local require
	local loaded = {}

	register = function(name, body)
		if not modules[name] then
			modules[name] = body
		end
	end

	require = function(name)
		local loadedModule = loaded[name]

		if loadedModule then
			if loadedModule == loadingPlaceholder then
				return nil
			end
		else
			if not modules[name] then
				if not superRequire then
					local identifier = type(name) == 'string' and '\"' .. name .. '\"' or tostring(name)
					error('Tried to require ' .. identifier .. ', but no such module has been registered')
				else
					return superRequire(name)
				end
			end

			loaded[name] = loadingPlaceholder
			loadedModule = modules[name](require, loaded, register, modules)
			loaded[name] = loadedModule
		end

		return loadedModule
	end

	return require, loaded, register, modules
end)(nil)
__bundle_register("__root", function(require, _LOADED, __bundle_register, __bundle_modules)
require("ClassCardContainer")

end)
__bundle_register("ClassCardContainer", function(require, _LOADED, __bundle_register, __bundle_modules)
-- Class card bag implementation.  Mimics the behavior of the previous SCED
-- card memory bags, but spawns cards from the All Cards Bag instead.
--
-- The All Cards Bag handles indexing of the player cards by class and level, as
-- well as sorting those lists.  See that object for more information.

local allCardsBagGuid = "15bb07"

local skillCount = 0
local eventCount = 0
local assetCount = 0

-- Coordinates to begin laying out cards to match the reserved areas of the
-- table.  Cards will lay out horizontally, then create additional rows
local startPositions = {
  upgrades = {
    skill = Vector(58.09966, 1.31, -47.42),
    event = Vector(52.94421, 1.31, -47.42),
    asset = Vector(40.29005, 1.31, -47.42),
  },
  level0 = {
    skill = Vector(58.38383, 1.31, 92.39036),
    event = Vector(53.22857, 1.31, 92.44123),
    asset = Vector(40.9602, 1.31, 92.44869),
  },
}

-- Amount to shift for the next card (zShift) or next row of cards (xShift)
-- Note that the table rotation is weird, and the X axis is vertical while the
-- Z axis is horizontal
local zShift = -2.29998
local xShift = -3.66572
local yRotation = 270
local cardsPerRow = 20

-- Tracks cards which are placed by this "bag" so they can be recalled
local placedCardGuids = { }

-- In order to mimic the behavior of the previous memory buttons we use a
-- a temporary bag when recalling objects.  This bag is tiny and transparent,
-- and will be placed at the same location as this object.  Once all placed
-- cards are recalled bag to this bag, it will be destroyed
local recallBag = {
  Name = "Bag",
  Transform = {
    scaleX = 0.01,
    scaleY = 0.01,
    scaleZ = 0.01,
  },
  ColorDiffuse = {
    r = 0,
    g = 0,
    b = 0,
    a = 0,
  },
  Locked = true,
  Grid = true,
  Snap = false,
  Tooltip = false,
}

function onLoad(savedData)
  createPlaceRecallButtons()
  placedCardGuids = { }
  if (savedData ~= nil) then
    local saveState = JSON.decode(savedData)
    if (saveState.placedCards ~= nil) then
      placedCardGuids = saveState.placedCards
    end
  end
end

function onSave()
  local saveState = {
    placedCards = placedCardGuids,
  }

  return JSON.encode(saveState)
end

--Creates recall and place buttons
function createPlaceRecallButtons()
    self.createButton({
        label="Place", click_function="buttonClick_place", function_owner=self,
        position={1,0.1,2.1}, rotation={0,0,0}, height=350, width=800,
        font_size=250, color={0,0,0}, font_color={1,1,1}
    })
    self.createButton({
        label="Recall", click_function="buttonClick_recall", function_owner=self,
        position={-1,0.1,2.1}, rotation={0,0,0}, height=350, width=800,
        font_size=250, color={0,0,0}, font_color={1,1,1}
    })
end

-- Spawns the set of cards identified by this objects Name (which should hold
-- the class) and description (whether to spawn basic cards or upgraded)
function buttonClick_place()
  -- Cards already on the table, don't spawn more
  if (#placedCardGuids > 0) then
    return
  end
  local cardClass = self.getName()
  local isUpgraded = false
  if (self.getDescription() == "Upgrades") then
    isUpgraded = true
  end
  skillCount = 0
  eventCount = 0
  assetCount = 0
  local allCardsBag = getObjectFromGUID(allCardsBagGuid)
  local cardList = allCardsBag.call("getCardsByClassAndLevel", {class = cardClass, upgraded = isUpgraded})
  placeCards(cardList)
end

-- Spawn all cards from the returned index
function placeCards(cardList)
  for _, card in ipairs(cardList) do
    placeCard(card.data, card.metadata)
  end
end

function placeCard(cardData, cardMetadata)
  local destinationPos
  if (cardMetadata.type == "Skill") then
    destinationPos = getSkillPosition(cardMetadata.level > 0)
  elseif (cardMetadata.type == "Event") then
    destinationPos = getEventPosition(cardMetadata.level > 0)
  elseif (cardMetadata.type == "Asset") then
    destinationPos = getAssetPosition(cardMetadata.level > 0)
  end
  local spawnedCard = spawnObjectData({
    data = cardData,
    position = destinationPos,
    rotation = {0, yRotation, 0},
    callback_function = recordPlacedCard})
end

-- Returns the table position where the next skill should be placed
-- Param isUpgraded: True if it's an upgraded card (right side of the table),
--     false for a Level 0 card (left side of table)
function getSkillPosition(isUpgraded)
  local skillPos
  if (isUpgraded) then
    skillPos = startPositions.upgrades.skill:copy()
  else
    skillPos = startPositions.level0.skill:copy()
  end
  local shift = Vector(div(skillCount, cardsPerRow) * xShift, 0, (skillCount % cardsPerRow) * zShift)
  skillPos:add(shift)
  skillCount = skillCount + 1

  return skillPos
end

-- Returns the table position where the next event should be placed
-- Param isUpgraded: True if it's an upgraded card (right side of the table),
--     false for a Level 0 card (left side of table)
function getEventPosition(isUpgraded)
  local eventPos
  if (isUpgraded) then
    eventPos = startPositions.upgrades.event:copy()
  else
    eventPos = startPositions.level0.event:copy()
  end
  local shift = Vector(div(eventCount, cardsPerRow) * xShift, 0, (eventCount % cardsPerRow) * zShift)
  eventPos:add(shift)
  eventCount = eventCount + 1

  return eventPos
end

-- Returns the table position where the next asset should be placed
-- Param isUpgraded: True if it's an upgraded card (right side of the table),
--     false for a Level 0 card (left side of table)
function getAssetPosition(isUpgraded)
  local assetPos
  if (isUpgraded) then
    assetPos = startPositions.upgrades.asset:copy()
  else
    assetPos = startPositions.level0.asset:copy()
  end
  local shift = Vector(div(assetCount, cardsPerRow) * xShift, 0, (assetCount % cardsPerRow) * zShift)
  assetPos:add(shift)
  assetCount = assetCount + 1

  return assetPos
end

-- Callback function which adds a spawned card to the tracking list
function recordPlacedCard(spawnedCard)
  table.insert(placedCardGuids, spawnedCard.getGUID())
end

-- Recalls all spawned cards to the bag, and clears the placedCardGuids list
function buttonClick_recall()
  local trash = spawnObjectData({data = recallBag, position = self.getPosition()})
  for _, cardGuid in ipairs(placedCardGuids) do
    local card = getObjectFromGUID(cardGuid)
    if (card ~= nil) then
      trash.putObject(card)
    end
  end
  trash.destruct()
  placedCardGuids = { }
end

function div(a,b)
    return (a - a % b) / b
end

end)
return __bundle_require("__root")