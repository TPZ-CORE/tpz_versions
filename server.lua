
local RequestResourceVersionByUrl = function(url, resource)
    PerformHttpRequest('https://raw.githubusercontent.com/TPZ-CORE/' .. url .. '/main/version.txt', function(err, text, headers)
        local currentVersion = GetResourceMetadata(resource, 'version')

        if not text then 
            print('[error] Currently unable to run a version check for resource {' .. resource .. '}.'
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
  local currentResourceName = GetCurrentResourceName()

  -- If the started resource is tpz_updates, we dont run
  -- the rest of the code.
  if currentResourceName == resourceName then
     return
  end 

  local length = GetTableLength(Config.Repositories)

  -- In case the length of Config.Repositories is empty,
  -- dont run the rest of the code. 
  if length <= 0 then
     return
  end

  -- Checking if the started resource exists in Config.Repositories
  -- before we request for the version.
  for _, resource in pairs (Config.Repositories) do

    if resourceName == resource.Name then
       local currentVersion, repoVersion = RequestResourceVersionByUrl(resource.Url, resource.Name)
      
       -- Printing only if the currentVersion of the script is not null and is outdated version.
       if currentVersion and (tostring(currentVersion) ~= tostring(repoVersion)) then
          print("(!) Outdated Resource Version - Checkout Github: https://github.com/TPZ-CORE/" .. resource.Url)
       end 

    end

  end

end)
