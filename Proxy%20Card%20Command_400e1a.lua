---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Whimsical.
--- DateTime: 2021-08-24 6:11 p.m.
---

command_name = "proxy-card"

---@type ArkhamImport_Command_RunDirectives
runOn = {
    instructions = true,
    handlers = true
}

local back_image_default = "https://images-ext-2.discordapp.net/external/QY_dmo_UnAHEi1pgWwaRr1-HSB8AtrAv0W74Mh_Z6vg/https/i.imgur.com/EcbhVuh.jpg"

---@param parameters ArkhamImport_Command_DescriptionInstructionArguments
---@return ArkhamImport_Command_DescriptionInstructionResults
function do_instruction(parameters)
    local args = parameters.arguments
    if (#args<4 or #args>6) then
        return {
            is_successful = false,
            error_message = "Move Command requires between 4 or 6 arguments. " .. #args .. " were provided."
        }
    end

    if not parameters.command_state["proxy-card"] then
        parameters.command_state["proxy-card"] = {}
        parameters.command_state["proxy-card-offset"] = 0.1
    end

    parameters.command_state["proxy-card"][args[1]] = {
        name = args[2],
        subtitle = args[3],
        image_uri = args[4],
        zone = args[5] or "default",
        back_image_uri = args[6] or back_image_default
    }

    return {
        command_state = parameters.command_state,
        is_successful = true
    }
end

---@param parameters ArkhamImport_Command_HandlerArguments
---@return ArkhamImport_Command_HandlerResults
function handle_card(parameters)
    local state = parameters.command_state["proxy-card"] or {}

    local card_data = state[parameters.card.code]

    if not card_data then return { is_successful = true } end

    local offset = parameters.command_state["proxy-card-offset"]
    parameters.command_state["proxy-card-offset"] = offset + 0.1

    local zone = parameters.configuration.zones[card_data.zone]

    if not zone then
        return {
            is_successful = false,
            error_message = "Proxy Card [" .. tostring(parameters.card.code) .. "]: Zone \"" .. tostring(card_data.zone) .. "\" was not found."
        }
    end

    local source = getObjectFromGUID(parameters.source_guid)
    local position = zone.is_absolute and zone.position or source:positionToWorld(zone.position)

    for _=1, parameters.card.count do
        local new = spawnObject {
            type = "CardCustom",
            position = position + Vector(0, offset, 0),
            rotation = source:getRotation() + Vector(0, 0, zone.is_facedown and 180 or 0),
            ---@param card TTSObject
            callback_function = function (card)
                card:setName(card_data.name)
                card:setDescription(card_data.subtitle)
            end
        }

        new:setCustomObject {
            type = 0,
            face = card_data.image_uri,
            back = card_data.back_image_uri
        }
    end

    return { handled = true, is_successful = true }
end