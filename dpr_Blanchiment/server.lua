ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('dpr_Blanchiment:Blanchir')
AddEventHandler('dpr_Blanchiment:Blanchir', function(thune)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local taxe = 0.75

    thune = ESX.Math.Round(tonumber(thune))
	pourcentage = thune * taxe
	Total = ESX.Math.Round(tonumber(pourcentage))

    if thune > 0 and xPlayer.getAccount('black_money').money >= thune then 
        xPlayer.removeAccountMoney('black_money', thune)
        local xPlayers = ESX.GetPlayers()        
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            Citizen.Wait(500)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Blanchiment', 'Information', "J'te blanchit sa mec attend un peu !", 'CHAR_ARTHUR', 1)
            Citizen.Wait(10000)
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Blanchiment', 'Information', "Tien mon gars voila t'as thune: "..Total.."$ !", 'CHAR_ARTHUR', 1)
        end

        xPlayer.addMoney(Total)
    else
        local xPlayers = ESX.GetPlayers()        
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            Citizen.Wait(500)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Blanchiment', 'Information', "Tu t'fou d'ma gueule ? Du croit tu vas m'arnaquer ?", 'CHAR_ARTHUR', 1)
        end
    end
end)