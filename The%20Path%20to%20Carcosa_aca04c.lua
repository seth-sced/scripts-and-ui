
function onload(saved_data)
    createDownloadButton()
end


--Beginning Setup


--Make Download button
function createDownloadButton()
    self.createButton({
        label="Download", click_function="buttonClick_download", function_owner=self,
        position={0,0.1,6}, rotation={0,0,0}, height=500, width=1600,
        font_size=350, color={0,0,0}, font_color={1,1,1}
    })
end



--Triggered by download button,
function buttonClick_download()
    local url = self.getGMNotes()
    local request = WebRequest.get(url, function (request) complete_obj_download(request) end )
    request_obj = request
    startLuaCoroutine(Global, 'my_coroutine')
end

function complete_obj_download(request)
  assert(request.is_done)
  if request.is_error or request.response_code ~= 200 then
    print('error: ' .. request.error)
  else
    if pcall(function ()
               local replaced_object = self
                 spawnObjectJSON({json = request.text, position = replaced_object.getPosition(), rotation = replaced_object.getRotation()})
                 destroyObject(replaced_object)
             
             end) then
      print('Object loaded.')
    else
      print('Error loading object.')
    end
  end

  request_obj = nil
  UI.setAttribute('download_progress', 'percentage', 100)
end