local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["-"] = 84,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}
local tabEnabled = false
local tabLoaded = true --false

function REQUEST_NUI_FOCUS(bool)
    SetNuiFocus(bool, bool) -- focus, cursor
    if bool == true then
        SendNUIMessage({showtab = true})
    else
        SendNUIMessage({hidetab = true})
    end
    return bool
end

RegisterNUICallback(
    "tablet-bus",
    function(data)
        -- Do tablet hide shit
        if data.load then
            print("Loaded the tablet")
            tabLoaded = true
        elseif data.hide then
            print("Hiding the tablet")
            SetNuiFocus(false, false) -- Don't REQUEST_NUI_FOCUS here
            tabEnabled = false
        elseif data.click then
        -- if u need click events
        end
    end
)

Citizen.CreateThread(function()

  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end


end)

Citizen.CreateThread(
    function()
        -- Wait for nui to load or just timeout
        local l = 0
        local timeout = false
        while not tabLoaded do
            Citizen.Wait(0)
            l = l + 1
            if l > 500 then
                tabLoaded = true --
                timeout = true
            end
        end

        if timeout == true then
            print("Failed to load tablet nui...")
        -- return ---- Quit
        end

        print("::The client lua for tablet loaded::")

        REQUEST_NUI_FOCUS(false) -- This is just in case the resources restarted whilst the NUI is focused.

        while true do
            -- Control ID 20 is the 'Z' key by default
            -- 244 = M
            -- Use https://wiki.fivem.net/wiki/Controls to find a different key
            if (IsControlJustPressed(0, 244)) and GetLastInputMethod( 0 ) then
                tabEnabled = not tabEnabled -- Toggle tablet visible state
                REQUEST_NUI_FOCUS(tabEnabled)
                print("The tablet state is: " .. tostring(tabEnabled))
                Citizen.Wait(0)
            end
            if (tabEnabled) then
                local ped = GetPlayerPed(-1)
                DisableControlAction(0, 1, tabEnabled) -- LookLeftRight
                DisableControlAction(0, 2, tabEnabled) -- LookUpDown
                DisableControlAction(0, 24, tabEnabled) -- Attack
                DisablePlayerFiring(ped, tabEnabled) -- Disable weapon firing
                DisableControlAction(0, 142, tabEnabled) -- MeleeAttackAlternate
                DisableControlAction(0, 106, tabEnabled) -- VehicleMouseControlOverride
            end
            Citizen.Wait(0)
        end
    end
)
