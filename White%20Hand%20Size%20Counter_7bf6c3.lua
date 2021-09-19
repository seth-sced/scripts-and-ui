function onload(save_state)
    val = 0
    playerColor = "Orange"
    if save_state ~= nil then
        local obj = JSON.decode(save_state)
        if obj ~= nil and obj.playerColor ~= nil then
            playerColor = obj.playerColor
        end
    end
    des = false
    loopId = Wait.time(|| updateValue(), 1, -1)
    self.addContextMenuItem("Bind to my color", bindColor)
end

function bindColor(player_color)
    playerColor = player_color
    self.setName(player_color .. " Hand Size Counter")
end

function onSave()
    return JSON.encode({ playerColor = playerColor })
end

function onHover(player_color)
    if not (player_color == playerColor) then return end
    Wait.stop(loopId)
    des = not des
    updateValue()
    des = not des
    loopId = Wait.time(|| updateValue(), 1, -1)
end

function updateDES(player, value, id)
    if (value == "True") then des = true
    else des = false
    end
    updateValue()
end

function updateValue()
    local hand = Player[playerColor].getHandObjects()
    local size = 0

    if (des) then
        self.UI.setAttribute("handSize", "color", "#00FF00")
        -- count by name for Dream Enhancing Serum
        local cardHash = {}
        for key, obj in pairs(hand) do
            if obj != nil and obj.tag == "Card" then
                local name = obj.getName()
                local title, xp = string.match(name, '(.+)(%s%(%d+%))')
                if title ~= nil then name = title end
                cardHash[name] = obj
            end
        end
        for key, obj in pairs(cardHash) do
            size = size + 1
        end
    else
        self.UI.setAttribute("handSize", "color", "#FFFFFF")
        -- otherwise count individually
        for key, obj in pairs(hand) do
            if obj != nil and obj.tag == "Card" then
                size = size + 1
            end
        end
    end

    val = size
    self.UI.setValue("handSize", val)
end