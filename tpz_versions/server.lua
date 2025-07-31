-----------------------------------------------------------
--[[ Local Functions  ]]--
-----------------------------------------------------------

local function StartsWith(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end

-----------------------------------------------------------
--[[ Base Events  ]]--
-----------------------------------------------------------

AddEventHandler('onResourceStart', function(resourceName)

   -- If the started resource does not start with `tpz_` which returns tpz-core scripts, we return the code.
   if not StartsWith(resourceName, "tpz_") then
      return
   end
  
   -- We are now checking if the script which contains and started with the required string does exist in the `githubusercontent`.
   -- To return a valid version.

   PerformHttpRequest('https://raw.githubusercontent.com/TPZ-CORE/' .. resourceName .. '/main/version.txt', function(err, text, headers)
      local currentVersion = GetResourceMetadata(resourceName, 'version')

      if not text then 
         -- print('[warn] Currently unable to run a version check for resource {' .. resourceName .. '}.')
         return nil
      end

      Wait(5000)
      
      -- We print ONLY if the version is outdated.
      if tonumber(currentVersion) ~= tonumber(text) then
         local log = "(!) Outdated Resource Version - Checkout Github: https://github.com/TPZ-CORE/" .. resourceName
         print(('^5['.. resourceName..']%s %s^7'):format('^1', log))
      end

   end)

end)
