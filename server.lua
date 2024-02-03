
local function RequestResourceVersionByUrl(url)
    PerformHttpRequest('https://raw.githubusercontent.com/Rexshack-RedM/rsg-canteen/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(GetCurrentResourceName(), 'version')

        if not text then 
            versionCheckPrint('error', 'Currently unable to run a version check.')
            return nil
        end

        return currentVersion, text
    end)
end

-- @GetTableLength returns the length of a table.
local GetTableLength = function(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then
    return
  end

  local length = GetTableLength(Config.Repositories)

  if length <= 0 then
     return
  end

  for _, resource in pairs (Config.Repositories) do
     local currentVersion, repoVersion = RequestResourceVersionByUrl(resource.Url)
      
     if currentVersion then

     end 

  end

end)
