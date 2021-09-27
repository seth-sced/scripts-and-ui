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
require("AllCardsBag")

end)
__bundle_register("AllCardsBag", function(require, _LOADED, __bundle_register, __bundle_modules)

local cardIdIndex = { }
local classAndLevelIndex = { }
local basicWeaknessList = { }

local indexingDone = false
local allowRemoval = false

function onLoad()
  self.addContextMenuItem("Rebuild Index", startIndexBuild)
  Wait.frames(startIndexBuild, 30)
end

-- Resets all current bag indexes
function clearIndexes()
  indexingDone = false
  cardIdIndex = { }
  classAndLevelIndex = { }
  classAndLevelIndex["Guardian-upgrade"] = { }
  classAndLevelIndex["Seeker-upgrade"] = { }
  classAndLevelIndex["Mystic-upgrade"] = { }
  classAndLevelIndex["Survivor-upgrade"] = { }
  classAndLevelIndex["Rogue-upgrade"] = { }
  classAndLevelIndex["Neutral-upgrade"] = { }
  classAndLevelIndex["Guardian-level0"] = { }
  classAndLevelIndex["Seeker-level0"] = { }
  classAndLevelIndex["Mystic-level0"] = { }
  classAndLevelIndex["Survivor-level0"] = { }
  classAndLevelIndex["Rogue-level0"] = { }
  classAndLevelIndex["Neutral-level0"] = { }
  basicWeaknessList = { }
end

-- Clears the bag indexes and starts the coroutine to rebuild the indexes
function startIndexBuild(playerColor)
  clearIndexes()
  startLuaCoroutine(self, "buildIndex")
end

-- Debug option to suppress the warning when cards are removed from the bag
function setAllowCardRemoval()
  allowRemoval = true
end

-- Create the card indexes by iterating all cards in the bag, parsing their
-- metadata, and creating the keyed lookup tables for the cards.  This is a
-- coroutine which will spread the workload by processing 20 cards before
-- yielding.  Based on the current count of cards this will require
-- approximately 60 frames to complete.
function buildIndex()
  indexingDone = false
  if (self.getData().ContainedObjects == nil) then
    return 1
  end
  for i,cardData in ipairs(self.getData().ContainedObjects) do
    local cardMetadata = JSON.decode(cardData.GMNotes)
    if (cardMetadata ~= nil) then
      addCardToIndex(cardData, cardMetadata)
    end
    if (i % 20 == 0) then
      coroutine.yield(0)
    end
  end
  for _, indexTable in pairs(classAndLevelIndex) do
    table.sort(indexTable, cardComparator)
  end
  indexingDone = true
  return 1
end

-- Adds a card to any indexes it should be a part of, based on its metadata.
-- Param cardData: TTS object data for the card
-- Param cardMetadata: SCED metadata for the card
function addCardToIndex(cardData, cardMetadata)
  -- Every card gets added to the ID index
  cardIdIndex[cardMetadata.id] = { data = cardData, metadata = cardMetadata }
  if (cardMetadata.alternate_ids ~= nil) then
    for _, alternateId in ipairs(cardMetadata.alternate_ids) do
      cardIdIndex[alternateId] = { data = cardData, metadata = cardMetadata }
    end
  end

  -- Add card to the basic weakness list, if appropriate.  Some weaknesses have
  -- multiple copies, and are added multiple times
  if (cardMetadata.weakness and cardMetadata.basicWeaknessCount ~= nil) then
    for i = 1, cardMetadata.basicWeaknessCount do
      table.insert(basicWeaknessList, cardMetadata.id)
    end
  end

  -- Add the card to the appropriate class and level indexes
  local isGuardian = false
  local isSeeker = false
  local isMystic = false
  local isRogue = false
  local isSurvivor = false
  local isNeutral = false
  local upgradeKey
  if (cardMetadata.class == nil or cardMetadata.level == nil) then
    -- If either class or level is missing, don't add this card to those indexes
    return
  end

  isGuardian = string.match(cardMetadata.class, "Guardian")
  isSeeker = string.match(cardMetadata.class, "Seeker")
  isMystic = string.match(cardMetadata.class, "Mystic")
  isRogue = string.match(cardMetadata.class, "Rogue")
  isSurvivor = string.match(cardMetadata.class, "Survivor")
  isNeutral = string.match(cardMetadata.class, "Neutral")
  if (cardMetadata.level > 0) then
    upgradeKey = "-upgrade"
  else
    upgradeKey = "-level0"
  end
  if (isGuardian) then
    table.insert(classAndLevelIndex["Guardian"..upgradeKey], { data = cardData, metadata = cardMetadata })
  end
  if (isSeeker) then
    table.insert(classAndLevelIndex["Seeker"..upgradeKey], { data = cardData, metadata = cardMetadata })
  end
  if (isMystic) then
    table.insert(classAndLevelIndex["Mystic"..upgradeKey], { data = cardData, metadata = cardMetadata })
  end
  if (isRogue) then
    table.insert(classAndLevelIndex["Rogue"..upgradeKey], { data = cardData, metadata = cardMetadata })
  end
  if (isSurvivor) then
    table.insert(classAndLevelIndex["Survivor"..upgradeKey], { data = cardData, metadata = cardMetadata })
  end
  if (isNeutral) then
    table.insert(classAndLevelIndex["Neutral"..upgradeKey], { data = cardData, metadata = cardMetadata })
  end
end

-- Comparison function used to sort the class card bag indexes.  Sorts by card
-- level, then name, then subname.
function cardComparator(card1, card2)
  if (card1.metadata.level ~= card2.metadata.level) then
    return card1.metadata.level < card2.metadata.level
  end
  if (card1.data.Nickname ~= card2.data.Nickname) then
    return card1.data.Nickname < card2.data.Nickname
  end
  return card1.data.Description < card2.data.Description
end

-- Returns a specific card from the bag, based on ArkhamDB ID
-- Params table:
--     id: String ID of the card to retrieve
-- Return: If the indexes are still being constructed, an empty table is
--     returned.  Otherwise, a single table with the following fields
--       cardData: TTS object data, suitable for spawning the card
--       cardMetadata: Table of parsed metadata
function getCardById(params)
  if (not indexingDone) then
    broadcastToAll("Still loading player cards, please try again in a few seconds", {0.9, 0.2, 0.2})
    return { }
  end
  return cardIdIndex[params.id]
end

-- Returns a list of cards from the bag matching a class and level (0 or upgraded)
-- Params table:
--     class: String class to retrieve ("Guardian", "Seeker", etc)
--     isUpgraded: true for upgraded cards (Level 1-5), false for Level 0
-- Return: If the indexes are still being constructed, returns an empty table.
--     Otherwise, a list of tables, each with the following fields
--       cardData: TTS object data, suitable for spawning the card
--       cardMetadata: Table of parsed metadata
function getCardsByClassAndLevel(params)
  if (not indexingDone) then
    broadcastToAll("Still loading player cards, please try again in a few seconds", {0.9, 0.2, 0.2})
    return { }
  end
  local upgradeKey
  if (params.upgraded) then
    upgradeKey = "-upgrade"
  else
    upgradeKey = "-level0"
  end
  return classAndLevelIndex[params.class..upgradeKey];
end

-- Gets a random basic weakness from the bag.  Once a given ID has been returned
-- it will be removed from the list and cannot be selected again until a reload
-- occurs or the indexes are rebuilt, which will refresh the list to include all
-- weaknesses.
-- Return: String ID of the selected weakness.
function getRandomWeaknessId()
  local pickedIndex = math.random(#basicWeaknessList)
  local weaknessId = basicWeaknessList[pickedIndex]
--  table.remove(basicWeaknessList, pickedIndex)

  return weaknessId
end

end)
return __bundle_require("__root")