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

CreateThread(function()
  while true do
    while not isPlayerLoaded do
      Wait(1000)
    end
    while isPlayerLoaded do
      Wait(1)
      -- 177293209 = WEAPON_HEAVYSNIPER_MK2
      if IsPlayerFreeAiming(PlayerId()) and GetSelectedPedWeapon(PlayerPedId()) == 177293209 then
        ShowHudComponentThisFrame(14)
      end
    end
    Wait(1)
  end
end)
