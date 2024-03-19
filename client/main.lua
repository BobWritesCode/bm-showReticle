QBCore = exports['qb-core']:GetCoreObject()

local isPlayerLoaded = false

AddEventHandler('onResourceStart', function(resourceName)
  if GetCurrentResourceName() == resourceName then
    local player = QBCore.Functions.GetPlayerData()
    if player then
      isPlayerLoaded = true
    end
  end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  isPlayerLoaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
  isPlayerLoaded = false
end)

-- Return true/false depending if weapon player is holding aiming with is in Config.Weapons
function CheckWeapon()
  for _, value in pairs(Config.Weapons) do
    if GetSelectedPedWeapon(PlayerPedId()) == value then
      return true
    end
  end
  return false
end

CreateThread(function()
  while true do
    while not isPlayerLoaded do
      Wait(1000)
    end
    while isPlayerLoaded do
      Wait(1)
      if IsPlayerFreeAiming(PlayerId()) then
        if CheckWeapon() then
          ShowHudComponentThisFrame(14)
        else
          HideHudComponentThisFrame(14)
        end
      end
    end
    Wait(1)
  end
end)

print("^4[Log] ^3bm-showReticle ^2started^7")
