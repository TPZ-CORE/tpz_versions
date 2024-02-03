-- @GetTableLength returns the length of a table.
local function GetTableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function startsWith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

local function RequestResourceVersionByName(resourceName)
   PerformHttpRequest('https://raw.githubusercontent.com/TPZ-CORE/' .. resourceName .. '/main/version.txt', function(err, text, headers)
       local currentVersion = GetResourceMetadata(resourceName, 'version')

       if not text then 
           print('[error] Currently unable to run a version check for resource {' .. resourceName .. '}.')
           return nil
       end

       return currentVersion, text
   end)
end

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStart', function(resourceName)

   -- If the started resource does not start with `tpz_` which returns tpz-core scripts, we return the code.
   if not startsWith(resourceName, "tpz_") then
      return
   end
  
   -- We are now checking if the script which contains and started with the required string does exist in the `githubusercontent`.
   -- To return a valid version.
   local currentVersion, repoVersion = RequestResourceVersionByName(resourceName)

   if currentVersion == nil or repoVersion == nil then
      return
   end
      
   -- We print ONLY if the version is outdated.
   if currentVersion and (tostring(currentVersion) ~= tostring(repoVersion)) then
      local log = "(!) Outdated Resource Version - Checkout Github: https://github.com/TPZ-CORE/" .. resourceName
      print(('^5['.. resourceName..']%s %s^7'):format('^1', log))
   end 

end)
