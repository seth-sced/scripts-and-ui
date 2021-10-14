BLESS_COLOR = { r=0.3, g=0.25, b=0.09 }
CURSE_COLOR = { r=0.2, g=0.08, b=0.24 }
MIN_VALUE = 1
MAX_VALUE = 10
IMAGE_URL = {
    Bless = "http://cloud-3.steamusercontent.com/ugc/1655601092778627699/339FB716CB25CA6025C338F13AFDFD9AC6FA8356/",
    Curse = "http://cloud-3.steamusercontent.com/ugc/1655601092778636039/2A25BD38E8C44701D80DD96BF0121DA21843672E/"
}

function onload()
    self.createButton({
        label="Add",
        click_function="addBlessToken",
        function_owner=self,
        position={-2.3,0.1,-0.5},
        height=150,
        width=300,
        scale={x=1.75, y=1.75, z=1.75},
        font_size=100,
        font_color={ r=1, g=1, b=1 },
        color=BLESS_COLOR
    })

    self.createButton({
        label="Remove",
        click_function="removeBlessToken",
        function_owner=self,
        position={-0.9,0.1,-0.5},
        height=150,
        width=450,
        scale={x=1.75, y=1.75, z=1.75},
        font_size=100,
        font_color={ r=1, g=1, b=1 },
        color=BLESS_COLOR
    })

    self.createButton({
        label="Take",
        click_function="takeBlessToken",
        function_owner=self,
        position={0.7,0.1,-0.5},
        height=150,
        width=350,
        scale={x=1.75, y=1.75, z=1.75},
        font_size=100,
        font_color={ r=1, g=1, b=1 },
        color=BLESS_COLOR
    })

    self.createButton({
        label="Return",
        click_function="returnBlessToken",
        function_owner=self,
        position={2.1,0.1,-0.5},
        height=150,
        width=400,
        scale={x=1.75, y=1.75, z=1.75},
        font_size=100,
        font_color={ r=1, g=1, b=1 },
        color=BLESS_COLOR
    })

    self.createButton({
        label="Add",
        click_function="addCurseToken",
        function_owner=self,
        position={-2.3,0.1,0.5},
        height=150,
        width=300,
        scale={x=1.75, y=1.75, z=1.75},
        font_size=100,
        font_color={ r=1, g=1, b=1 },
        color=CURSE_COLOR
    })

    self.createButton({
        label="Remove",
        click_function="removeCurseToken",
        function_owner=self,
        position={-0.9,0.1,0.5},
        height=150,
        width=450,
        scale={x=1.75, y=1.75, z=1.75},
        font_size=100,
        font_color={ r=1, g=1, b=1 },
        color=CURSE_COLOR
    })

    self.createButton({
        label="Take",
        click_function="takeCurseToken",
        function_owner=self,
        position={0.7,0.1,0.5},
        height=150,
        width=350,
        scale={x=1.75, y=1.75, z=1.75},
        font_size=100,
        font_color={ r=1, g=1, b=1 },
        color=CURSE_COLOR
    })

    self.createButton({
        label="Return",
        click_function="returnCurseToken",
        function_owner=self,
        position={2.1,0.1,0.5},
        height=150,
        width=400,
        scale={x=1.75, y=1.75, z=1.75},
        font_size=100,
        font_color={ r=1, g=1, b=1 },
        color=CURSE_COLOR
    })

    self.createButton({
        label="Reset", click_function="doReset", function_owner=self,
        position={0,0.3,1.8}, rotation={0,0,0}, height=350, width=800,
        font_size=250, color={0,0,0}, font_color={1,1,1}
    })

    numInPlay = { Bless=0, Curse=0 }
    tokensTaken = { Bless={}, Curse={} }
    Wait.time(initializeState, 1)

    addHotkey("Bless Curse Status", printStatus, false)
end

function initializeState()
    playerColor = "White"
    -- count tokens in the bag
    local chaosbag = getChaosBag()
    if chaosbag == nil then return end
    local tokens = {}
    for i,v in ipairs(chaosbag.getObjects()) do
        if v.name == "Bless" then
            numInPlay.Bless = numInPlay.Bless + 1
        elseif v.name == "Curse" then
            numInPlay.Curse = numInPlay.Curse + 1
        end
    end

    -- find tokens in the play area
    local objs = Physics.cast({
        origin = { x=-33, y=0, z=0.5 },
        direction = { x=0, y=1, z=0 },
        type = 3,
        size = { x=77, y=5, z=77 },
        orientation = { x=0, y=90, z=0 }
    })

    for i,v in ipairs(objs) do
        local obj = v.hit_object
        if obj.getName() == "Bless" then
            table.insert(tokensTaken.Bless, obj.getGUID())
            numInPlay.Bless = numInPlay.Bless + 1
        elseif obj.getName() == "Curse" then
            table.insert(tokensTaken.Curse, obj.getGUID())
            numInPlay.Curse = numInPlay.Curse + 1
        end
    end

    mode = "Bless"
    print("Bless Tokens " .. getTokenCount())
    mode = "Curse"
    print("Curse Tokens " .. getTokenCount())
end

function printStatus(player_color, hovered_object, world_position, key_down_up)
    mode = "Curse"
    broadcastToColor("Curse Tokens " .. getTokenCount(), player_color)
    mode = "Bless"
    broadcastToColor("Bless Tokens " .. getTokenCount(), player_color)
end

function doReset(_obj, _color, alt_click)
    playerColor = _color
    numInPlay = { Bless=0, Curse=0 }
    tokensTaken = { Bless={}, Curse={} }
    initializeState()
end

function addBlessToken(_obj, _color, alt_click)
    addToken("Bless", _color)
end

function addCurseToken(_obj, _color, alt_click)
    addToken("Curse", _color)
end

function addToken(type, _color)
    if numInPlay[type] == MAX_VALUE then
        printToColor(MAX_VALUE .. " tokens already in play, not adding any", _color)
    else
        mode = type
        spawnToken()
    end
end

function spawnToken()
    local pos = getChaosBagPosition()
    if pos == nil then return end
    local url = IMAGE_URL[mode]
    local obj = spawnObject({
        type = 'Custom_Tile',
        position = {pos.x, pos.y + 3, pos.z},
        rotation = {x = 0, y = 260, z = 0},
        callback_function = spawn_callback
    })
    obj.setCustomObject({
        type = 2,
        image = url,
        thickness = 0.10,
    })
    obj.scale {0.81, 1, 0.81}
    return obj
end

function spawn_callback(obj)
    obj.setName(mode)
    local guid = obj.getGUID()
    numInPlay[mode] = numInPlay[mode] + 1
    printToAll("Adding " .. mode .. " token " .. getTokenCount())
end

function removeBlessToken(_obj, _color, alt_click)
    takeToken("Bless", _color, true)
end

function removeCurseToken(_obj, _color, alt_click)
    takeToken("Curse", _color, true)
end

function takeBlessToken(_obj, _color, alt_click)
    takeToken("Bless", _color, false)
end

function takeCurseToken(_obj, _color, alt_click)
    takeToken("Curse", _color, false)
end

function takeToken(type, _color, remove)
    playerColor = _color
    local chaosbag = getChaosBag()
    if chaosbag == nil then return end
    local tokens = {}
    for i,v in ipairs(chaosbag.getObjects()) do
        if v.name == type then
            table.insert(tokens, v.guid)
        end
    end
    if #tokens == 0 then
        printToColor("No " .. type .. " tokens in the chaos bag", _color)
        return
    end
    local pos = self.getPosition()
    local callback = take_callback
    if remove then
        callback = remove_callback
        num = removeNum
    end
    local guid = table.remove(tokens)
    mode = type
    chaosbag.takeObject({
        guid = guid,
        position = {pos.x-2, pos.y, pos.z},
        smooth = false,
        callback_function = callback
    })
end

function remove_callback(obj)
    take_callback(obj, true)
end

function take_callback(obj, remove)
    local guid = obj.getGUID()
    if remove then
        numInPlay[mode] = numInPlay[mode] - 1
        printToAll("Removing " .. mode .. " token " .. getTokenCount())
        obj.destruct()
    else
        table.insert(tokensTaken[mode], guid)
        printToAll("Taking " .. mode .. " token " .. getTokenCount())
    end
end

function returnBlessToken(_obj, _color, alt_click)
    returnToken("Bless", _color)
end

function returnCurseToken(_obj, _color, alt_click)
    returnToken("Curse", _color)
end

function returnToken(type, _color)
    mode = type
    local guid = table.remove(tokensTaken[type])
    if guid == nil then
        printToColor("No " .. mode .. " tokens to return", _color)
        return
    end
    local token = getObjectFromGUID(guid)
    if token == nil then
        printToColor("Couldn't find token " .. guid .. ", not returning to bag", _color)
        return
    end
    playerColor = _color
    local chaosbag = getChaosBag()
    if chaosbag == nil then return end
    chaosbag.putObject(token)
    printToAll("Returning " .. type .. " token " .. getTokenCount())
end

function getChaosBag()
    local items = getObjectFromGUID("83ef06").getObjects()
    local chaosbag = nil
    for i,v in ipairs(items) do
        if v.getDescription() == "Chaos Bag" then
            chaosbag = getObjectFromGUID(v.getGUID())
            break
        end
    end
    if chaosbag == nil then printToColor("No chaos bag found", playerColor) end
    return chaosbag
end

function getChaosBagPosition()
    local chaosbag = getChaosBag()
    if chaosbag == nil then return nil end
    return chaosbag.getPosition()
end

function getTokenCount()
    return "(" .. (numInPlay[mode] - #tokensTaken[mode]) .. "/" ..
        #tokensTaken[mode] .. ")"
end