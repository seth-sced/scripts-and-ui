MIN_VALUE = -99
MAX_VALUE = 999

function onload(saved_data)
    light_mode = false
    val = 0

    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        light_mode = loaded_data[1]
        val = loaded_data[2]
    end
    p1ClueCounter = getObjectFromGUID("37be78")
    p2ClueCounter = getObjectFromGUID("1769ed")
    p3ClueCounter = getObjectFromGUID("032300")
    p4ClueCounter = getObjectFromGUID("d86b7c")

    timerID = self.getGUID()..math.random(9999999999999)
    Timer.create({
        identifier=timerID,
        function_name="totalCounters", function_owner=self,
        repetitions=0, delay=1
    })
    createAll()
end

function loadPlayerCounters()
  p1ClueCounter = getObjectFromGUID("37be78")
  p2ClueCounter = getObjectFromGUID("1769ed")
  p3ClueCounter = getObjectFromGUID("032300")
  p4ClueCounter = getObjectFromGUID("d86b7c")
end


function totalCounters()
    if p1ClueCounter == nil or p2ClueCounter == nil or p3ClueCounter == nil or p4ClueCounter == nil then
      loadPlayerCounters()
    end
    local p1ClueCount = p1ClueCounter.getVar("exposedValue")
    local p2ClueCount = p2ClueCounter.getVar("exposedValue")
    local p3ClueCount = p3ClueCounter.getVar("exposedValue")
    local p4ClueCount = p4ClueCounter.getVar("exposedValue")
    val = tonumber(p1ClueCount) + tonumber(p2ClueCount) + tonumber(p3ClueCount) + tonumber(p4ClueCount)
    updateVal()
    updateSave()
end

function updateSave()
    local data_to_save = {light_mode, val}
    saved_data = JSON.encode(data_to_save)
    self.script_state = saved_data
end

function createAll()
    s_color = {0.5, 0.5, 0.5, 95}

    if light_mode then
        f_color = {1,1,1,95}
    else
        f_color = {0,0,0,100}
    end

    self.createButton({
      label=tostring(val),
      click_function="removeAllPlayerClues",
      function_owner=self,
      position={0,0.05,0},
      height=600,
      width=1000,
      alignment = 3,
      tooltip = "Click button to remove all clues from all investigators",
      scale={x=1.5, y=1.5, z=1.5},
      font_size=600,
      font_color=f_color,
      color={0,0,0,0}
      })

    if light_mode then
        lightButtonText = "[ Set dark ]"
    else
        lightButtonText = "[ Set light ]"
    end

end

function removeAll()
    self.removeInput(0)
    self.removeInput(1)
    self.removeButton(0)
    self.removeButton(1)
    self.removeButton(2)
end

function removeAllPlayerClues()
  p1ClueCounter.call("removeAllClues")
  p2ClueCounter.call("removeAllClues")
  p3ClueCounter.call("removeAllClues")
  p4ClueCounter.call("removeAllClues")
end


function reloadAll()
    removeAll()
    createAll()
    updateSave()
end

function swap_fcolor(_obj, _color, alt_click)
    light_mode = not light_mode
    reloadAll()
end

function swap_align(_obj, _color, alt_click)
    center_mode = not center_mode
    reloadAll()
end

function editName(_obj, _string, value)
    self.setName(value)
    setTooltips()
end

function updateVal()
    self.editButton({
        index = 0,
        label = tostring(val),

        })
end

function reset_val()
    val = 0
    updateVal()
    updateSave()
end

function setTooltips()
    self.editInput({
        index = 0,
        value = self.getName(),
        tooltip = "Click button to remove all clues from all investigators"
        })
    self.editButton({
        index = 0,
        value = tostring(val),

        })
end

function null()
end

function keepSample(_obj, _string, value)
    reloadAll()
end

function onDestroy()
  if timerID and type(timerID) == 'object' then
    Timer.destroy(timerID)
  end
end