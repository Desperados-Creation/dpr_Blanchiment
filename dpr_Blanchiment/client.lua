ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Menu --
local open = false
local MenuBlanchiment = RageUI.CreateMenu("Blanchiment", "INTERATION")
MenuBlanchiment.Display.Header = true
MenuBlanchiment.Closed = function()
    open = false
end

function OpenMenuBlanchiment() 
    if open then 
        open = false
        RageUI.Visible(MenuBlanchiment, false)
        return
    else
        open = true
        RageUI.Visible(MenuBlanchiment, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(MenuBlanchiment, function()
                    RageUI.Separator("↓     ~r~Blanchiment     ~s~↓")
                    RageUI.Button("Blanchir", "~r~Taxe: 25%", {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            local thune = KeyboardInput("Combien as-tu à blanchir ?", "", 8)
                            TriggerServerEvent('dpr_Blanchiment:Blanchir', thune)
                        end
                    })

                    RageUI.Separator("↓     ~r~Fermeture     ~s~↓")
                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            RageUI.CloseAll()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        for k in pairs(Config.positionBlanchiment.InteractZone) do 
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local pos = Config.positionBlanchiment.InteractZone
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

            if dist <= Config.MarkerDistance then 
                wait = 0
                DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
                if dist <= 2.0 then 
                    wait = 0
                    Visual.Subtitle(Config.Text, 1)
                    if IsControlJustPressed(1, 51) then 
                        OpenMenuBlanchiment()
                    end
                end
            end
        end
    Wait(wait)
    end
end)

-- Ped --
DecorRegister("Blanchiment", 4)
pedHash = "a_m_y_soucent_02"
zone = vector3(974.92, -2358.15, 30.82)
Heading = 219.66
Ped = nil

Citizen.CreateThread(function()
    LoadModel(pedHash)
    Ped = CreatePed(2, GetHashKey(pedHash), zone, Heading, 0, 0)
    FreezeEntityPosition(Ped, 1)
    SetEntityInvincible(Ped, true)
    SetBlockingOfNonTemporaryEvents(Ped, 1)
end)

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(1)
    end
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end