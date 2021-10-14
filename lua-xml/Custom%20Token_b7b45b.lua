

function onSave()
   saved_data = JSON.encode({tid=tableImageData, cd=checkData})
   --saved_data = ""
   return saved_data
end

function onload(saved_data)
   --Loads the tracking for if the game has started yet
   if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        tableImageData = loaded_data.tid
        checkData = loaded_data.cd
   else
       tableImageData = {}
       checkData = {move=false, scale=false}
   end

   --Disables interactable status of objects with GUID in list
   for _, guid in ipairs(ref_noninteractable) do
       local obj = getObjectFromGUID(guid)
       if obj then obj.interactable = false end
   end



   obj_surface = getObjectFromGUID("721ba2")


   controlActive = false
   createOpenCloseButton()
end



--Activation/deactivation of control panel



--Activated by clicking on
function click_toggleControl(_, color)
   if permissionCheck(color) then
       if not controlActive then
           --Activate control panel
           controlActive = true
           self.clearButtons()
           createOpenCloseButton()
           createSurfaceInput()
           createSurfaceButtons()

       else
           --Deactivate control panel
           controlActive = false
           self.clearButtons()
           self.clearInputs()
           createOpenCloseButton()

       end
   end
end




--Table surface control



--Changes table surface
function click_applySurface(_, color)
   if permissionCheck(color) then
       updateSurface()
       broadcastToAll("New Playmat Image Applied", {0.2,0.9,0.2})
   end
end

--Updates surface from the values in the input field
function updateSurface()
   local customInfo = obj_surface.getCustomObject()
   customInfo.image = self.getInputs()[1].value
   obj_surface.setCustomObject(customInfo)
   obj_surface = obj_surface.reload()
end



--Information gathering



--Checks if a color is promoted or host
function permissionCheck(color)
   if Player[color].host==true or Player[color].promoted==true then
       return true
   else
       return false
   end
end

--Locates a string saved within memory file
function findInImageDataIndex(...)
   for _, str in ipairs({...}) do
       for i, v in ipairs(tableImageData) do
           if v.url == str or v.name == str then
               return i
           end
       end
   end
   return nil
end

--Round number (num) to the Nth decimal (dec)
function round(num, dec)
 local mult = 10^(dec or 0)
 return math.floor(num * mult + 0.5) / mult
end

--Locates a button with a helper function
function findButton(obj, func)
   if func==nil then error("No func supplied to findButton") end
   for _, v in ipairs(obj.getButtons()) do
       if func(v) then
           return v
       end
   end
   return nil
end



--Creation of buttons/inputs



function createOpenCloseButton()
   local tooltip = "Open Playmat Panel"
   if controlActive then
       tooltip = "Close Playmat Panel"
   end
   self.createButton({
       click_function="click_toggleControl", function_owner=self,
       position={0,0,0}, rotation={-45,0,0}, height=1500, width=1500,
       color={1,1,1,0}, tooltip=tooltip
   })
end

function createSurfaceInput()
   local currentURL = obj_surface.getCustomObject().diffuse
   local nickname = ""
   if findInImageDataIndex(currentURL) ~= nil then
       nickname = tableImageData[findInImageDataIndex(currentURL)].name
   end

   self.createInput({
       label="URL", input_function="none", function_owner=self,
       alignment=3, position={0,0.15,3}, height=224, width=4000,
       font_size=200, tooltip="Enter URL for playmat image",
       value=currentURL
   })
end

function createSurfaceButtons()
   --Label
   self.createButton({
       label="Playmat Image Swapper", click_function="none",
       position={0,0.15,2.2}, height=0, width=0, font_size=300, font_color={1,1,1}
   })
   --Functional
   self.createButton({
       label="Apply Image\nTo Playmat", click_function="click_applySurface",
       function_owner=self, tooltip="Apply URL as playmat image",
       position={0,0.15,4}, height=440, width=1400, font_size=200,
   })

end






--Data tables




ref_noninteractable = {
   "afc863","c8edca","393bf7","12c65e","f938a2","9f95fd","35b95f",
   "5af8f2","4ee1f2","bd69bd"
}

ref_playerColor = {
   "White", "Brown", "Red", "Orange", "Yellow",
   "Green", "Teal", "Blue", "Purple", "Pink", "Black"
}

--Dummy function, absorbs unwanted triggers
function none() end