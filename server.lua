ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)






RegisterServerEvent('nzy-sellnpc:server')
AddEventHandler('nzy-sellnpc:server', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local item = xPlayer.getInventoryItem(Config.Item)
	local miktar = 1


	if xPlayer.get('money') >= Config.StartRolexPayment then

		xPlayer.removeMoney(1500)
		TriggerClientEvent('notification', source, 'Lokasyonlar Belirtilicek')
		TriggerClientEvent("nzy-sellnpc:startDealing", source)

	else 
		TriggerClientEvent('notification', source, 'Yeterli Paran Yok', 2)
	end	
end)



AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        if GetCurrentResourceName() == 'nzy-sellnpc' then
            Citizen.Wait(5000)
            print('[nzy:selltonpc] - Started!')
        else
            print('[nzy:sellnpc] - Please rename it as nzy-sellnpc!')
            print('[nzy:sellnpc - Please rename it as nzy-sellnpc!')
            print('[nzy:sellnpc] - Please rename it as nzy-sellnpc!')
            StopResource(GetCurrentResourceName())
        end
    end
end)

RegisterServerEvent('nzy-sellnpc:receiverolex')
AddEventHandler('nzy-sellnpc:receiverolex', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	local item = xPlayer.getInventoryItem(Config.Item)
	local miktar = Config.rolexAmount



if item.count >=  miktar then 


	
	if Config.KanDurdurucuSans > math.random(30 , 40) then
		xPlayer.addInventoryItem(Config.KanDurdurucuItem, Config.KanDurdurucuAmount)
		xPlayer.removeInventoryItem(Config.Item, 1)
		TriggerClientEvent('notification', source, 'Telefon geldi , teslimat iyiydi , sıradaki müşteriyi bekle')
	
	else
	

	 	 xPlayer.addMoney(Config.Payment)
		 xPlayer.removeInventoryItem(Config.Item, Config.rolexAmount)
		 TriggerClientEvent('notification', source, 'Telefon geldi , teslimat iyiydi , sıradaki müşteriyi bekle')
	end 
	
else
	TriggerClientEvent('notification', source, 'Üstünde Saat Bulunmamakta')
end	

	
 		 


end)










RegisterServerEvent('nzy-sellnpc:receivemoneyyy')
AddEventHandler('nzy-sellnpc:receivemoneyyy', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addMoney(Config.Payment)
end)



