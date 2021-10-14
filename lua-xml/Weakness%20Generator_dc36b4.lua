local allCardsBagGuid = "15bb07"

function onLoad(saved_data)
  createDrawButton()
end

function createDrawButton()
    self.createButton({
        label="Draw Random\nWeakness", click_function="buttonClick_draw", function_owner=self,
        position={0,0.1,2.1}, rotation={0,0,0}, height=600, width=1800,
        font_size=250, color={0,0,0}, font_color={1,1,1}
    })
end

-- Draw a random weakness and spawn it below the object
function buttonClick_draw()
  local allCardsBag = getObjectFromGUID(allCardsBagGuid)
  local weaknessId = allCardsBag.call("getRandomWeaknessId")
  local card = allCardsBag.call("getCardById", { id = weaknessId })
  spawnObjectData({
    data = card.data,
    position = self.positionToWorld({0, 1, 5.5}),
    rotation = self.getRotation()})
end