
local cardIdIndex = { }
local classAndLevelIndex = { }
local basicWeaknessList = { }

local indexingDone = false
local allowRemoval = false

function onLoad()
  self.addContextMenuItem("Rebuild Index", startIndexBuild)
  math.randomseed(os.time())
  Wait.frames(startIndexBuild, 30)
end

-- Called by Hotfix bags when they load.  If we are still loading indexes, then
-- the all cards and hotfix bags are being loaded together, and we can ignore
-- this call as the hotfix will be included in the initial indexing.  If it is
-- called once indexing is complete it means the hotfix bag has been added
-- later, and we should rebuild the index to integrate the hotfix bag.
function rebuildIndexForHotfix()
  if (indexingDone) then
    startIndexBuild()
  end
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

function onObjectLeaveContainer(container, object)
  if (container == self and not allowRemoval) then
    broadcastToAll(
        "Removing cards from the All Player Cards bag may break some functions.  Please replace the card.",
        {0.9, 0.2, 0.2}
    )
  end
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
  for i, cardData in ipairs(self.getData().ContainedObjects) do
    local cardMetadata = JSON.decode(cardData.GMNotes)
    if (cardMetadata ~= nil) then
      addCardToIndex(cardData, cardMetadata)
    end
    if (i % 20 == 0) then
      coroutine.yield(0)
    end
  end
  local hotfixBags = getObjectsWithTag("AllCardsHotfix")
  for _, hotfixBag in ipairs(hotfixBags) do
    if (#hotfixBag.getObjects() > 0) then
      for i, cardData in ipairs(hotfixBag.getData().ContainedObjects) do
        local cardMetadata = JSON.decode(cardData.GMNotes)
        if (cardMetadata ~= nil) then
          addCardToIndex(cardData, cardMetadata)
        end
      end
    end
  end
  buildSupplementalIndexes()
  indexingDone = true
  return 1
end

-- Adds a card to any indexes it should be a part of, based on its metadata.
-- Param cardData: TTS object data for the card
-- Param cardMetadata: SCED metadata for the card
function addCardToIndex(cardData, cardMetadata)
  cardIdIndex[cardMetadata.id] = { data = cardData, metadata = cardMetadata }
  if (cardMetadata.alternate_ids ~= nil) then
    for _, alternateId in ipairs(cardMetadata.alternate_ids) do
      cardIdIndex[alternateId] = { data = cardData, metadata = cardMetadata }
    end
  end
end

function buildSupplementalIndexes()
  for cardId, card in pairs(cardIdIndex) do
    local cardData = card.data
    local cardMetadata = card.metadata
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
    if (cardMetadata.class ~= nil and cardMetadata.level ~= nil) then
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
        table.insert(classAndLevelIndex["Guardian"..upgradeKey], cardMetadata.id)
      end
      if (isSeeker) then
        table.insert(classAndLevelIndex["Seeker"..upgradeKey], cardMetadata.id)
      end
      if (isMystic) then
        table.insert(classAndLevelIndex["Mystic"..upgradeKey], cardMetadata.id)
      end
      if (isRogue) then
        table.insert(classAndLevelIndex["Rogue"..upgradeKey], cardMetadata.id)
      end
      if (isSurvivor) then
        table.insert(classAndLevelIndex["Survivor"..upgradeKey], cardMetadata.id)
      end
      if (isNeutral) then
        table.insert(classAndLevelIndex["Neutral"..upgradeKey], cardMetadata.id)
      end
    end
  end
  for _, indexTable in pairs(classAndLevelIndex) do
    table.sort(indexTable, cardComparator)
  end
end

-- Comparison function used to sort the class card bag indexes.  Sorts by card
-- level, then name, then subname.
function cardComparator(id1, id2)
  local card1 = cardIdIndex[id1]
  local card2 = cardIdIndex[id2]
  if (card1.metadata.level ~= card2.metadata.level) then
    return card1.metadata.level < card2.metadata.level
  end
  if (card1.data.Nickname ~= card2.data.Nickname) then
    return card1.data.Nickname < card2.data.Nickname
  end
  return card1.data.Description < card2.data.Description
end

function isIndexReady()
  return indexingDone
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
  if (#basicWeaknessList > 1) then
    table.remove(basicWeaknessList, pickedIndex)
  else
    broadcastToAll("All weaknesses have been drawn!", {0.9, 0.2, 0.2})
  end

  return weaknessId
end