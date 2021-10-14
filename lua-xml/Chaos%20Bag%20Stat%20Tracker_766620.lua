function onload(saved_data)
    light_mode = false

    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        light_mode = loaded_data[1]
    end
    createAll()
end

-- functions delegated to Global
function printStats(object, player, isRightClick)
  -- local toPosition = self.positionToWorld(DRAWN_CHAOS_TOKEN_OFFSET)
  if isRightClick then
    Global.call("resetStats")
  else
    Global.call("printStats")
  end
end

function updateSave()
    local data_to_save = {light_mode }
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
      click_function="printStats",
      function_owner=self,
      position={0,0.05,0},
      height=600,
      width=1000,
      alignment = 3,
      tooltip = "Left Click to print stats. Right Click to reset them.",
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

function setTooltips()
    self.editInput({
        index = 0,
        value = self.getName(),
        tooltip = "Left click to show stats. Right click to reset them."
        })
end

function keepSample(_obj, _string, value)
    reloadAll()
end

function onDestroy()
  if timerID and type(timerID) == 'object' then
    Timer.destroy(timerID)
  end
end