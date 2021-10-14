--Counting Bowl    by MrStump

--Table of items which can be counted in this Bowl
--Each entry has 2 things to enter
    --a name (what is in the name field of that object)
    --a value (how much it is worth)
--A number in the items description will override the number entry in this table
validCountItemList = {
    ["Clue"] = 1,
    [""] = 1,
    --["Name3"] = 2,
    --["Name4"] = 31,
    --Add more entries as needed
    --Remove the -- from before a line for the script to use it
}

--END OF CODE TO EDIT

function onLoad()
    timerID = self.getGUID()..math.random(9999999999999)
    --Sets position/color for the button, spawns it
    self.createButton({
        label="", click_function="removeAllClues", function_owner=self,
        position={0,0,0}, rotation={0,8,0}, height=0, width=0,
        font_color={0,0,0}, font_size=2000
    })
    --Start timer which repeats forever, running countItems() every second
    Timer.create({
        identifier=timerID,
        function_name="countItems", function_owner=self,
        repetitions=0, delay=1
    })
    exposedValue = 0 
    trashCan = getObjectFromGUID("147e80")
end

function findValidItemsInSphere()
    return filterByValidity(findItemsInSphere())
end

--Activated once per second, counts items in bowls
function countItems()
    local totalValue = -1
    local countableItems = findValidItemsInSphere()
    for ind, entry in ipairs(countableItems) do
        local descValue = tonumber(entry.hit_object.getDescription())
        local stackMult = math.abs(entry.hit_object.getQuantity())
        --Use value in description if available
        if descValue ~= nil then
            totalValue = totalValue + descValue * stackMult
        else
            --Otherwise use the value in validCountItemList
            totalValue = totalValue + validCountItemList[entry.hit_object.getName()] * stackMult
        end
    end
    exposedValue = totalValue
    --Updates the number display
    self.editButton({index=0, label=totalValue})
end

function filterByValidity(items)
    retval = {}
    for _, entry in ipairs(items) do
      --Ignore the bowl
        if entry.hit_object ~= self then
          --Ignore if not in validCountItemList
          local tableEntry = validCountItemList[entry.hit_object.getName()]
          if tableEntry ~= nil then
            table.insert(retval, entry)
          end
        end
    end
    return retval
end


--Gets the items in the bowl for countItems to count
function findItemsInSphere()
    --Find scaling factor
    local scale = self.getScale()
    --Set position for the sphere
    local pos = self.getPosition()
    pos.y=pos.y+(1.25*scale.y)
    --Ray trace to get all objects
    return Physics.cast({
        origin=pos, direction={0,1,0}, type=2, max_distance=0,
        size={6*scale.x,6*scale.y,6*scale.z}, --debug=true
    })
end

function removeAllClues()
  startLuaCoroutine(self, "clueRemovalCoroutine")
end

function clueRemovalCoroutine()
  for _, entry in ipairs(findValidItemsInSphere()) do
    -- Do not put the table in the garbage
    if entry.hit_object.getGUID() ~= "4ee1f2" then
      --delay for animation purposes
      for k=1,10 do
        coroutine.yield(0)
      end
      trashCan.putObject(entry.hit_object)
    end
  end
  --coroutines must return a value
  return 1
end


function onDestroy()
  if timerID and type(timerID) == 'object' then
    Timer.destroy(timerID)
  end
end