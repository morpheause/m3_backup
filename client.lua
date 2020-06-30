Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/bk', 'Memurlara yardım çağrısında bulun.', {
    	{ name="Destek İsteği", help="1, 2, 3" }
	})
end)

RegisterNetEvent('m3:backup:getCoords')
AddEventHandler('m3:backup:getCoords', function(level)
	local player = GetPlayerPed(-1)
	local pCoords = GetEntityCoords(player)
	ESX.TriggerServerCallback('m3:backup:getCharName', function(fname, lname)
		if fname ~= nil and lname ~= nil then
			name = ''..fname..' '..lname..''
			TriggerServerEvent('m3:backup:onlyCops', pCoords, level, name)
			if level == '1' then
				TriggerServerEvent('m3:backup:onlyCopsNotify', '[BACKUP] - Destek Çağrısı - ' ..name.. ' - Konumuma acil destek gerekiyor!')
			end
			if level == '2' then
				TriggerServerEvent('m3:backup:onlyCopsNotify', '[BACKUP] - Silahlı Çatışma Bildirimi - ' ..name.. ' - Bulunduğum konumda silahlı çatışma çıktı!')
			end
			if level == '3' then
				TriggerServerEvent('m3:backup:onlyCopsNotify', '[BACKUP] - Yaralı Memur - ' ..name.. ' - Yaralandım, konumuma acil destek!')
			end
		end
	end)
end)

RegisterNetEvent('m3:backup:blip')
AddEventHandler('m3:backup:blip', function(coords, level, name)
	if level == '1' then
		local blip1 = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blip1, 381)
		SetBlipScale(blip1, 1.0)
		SetBlipColour(blip1, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Destek Lazım - ' .. name)
		EndTextCommandSetBlipName(blip1)
		Citizen.Wait(Config.BlipTime * 1000)
		RemoveBlip(blip1)
	end

	if level == '2' then
		local blip2 = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blip2, 381)
		SetBlipScale(blip2, 1.0)
		SetBlipColour(blip2, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Silahlı Çatışma - ' .. name)
		EndTextCommandSetBlipName(blip2)
		Citizen.Wait(Config.BlipTime * 1000)
		RemoveBlip(blip2)
	end

	if level == '3' then
		local blip3 = AddBlipForCoord(coords.x, coords.y, coords.z)
		SetBlipSprite(blip3, 381)
		SetBlipScale(blip3, 1.0)
		SetBlipColour(blip3, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Yaralıyım - ' .. name)
		EndTextCommandSetBlipName(blip3)
		Citizen.Wait(Config.BlipTime * 1000)
		RemoveBlip(blip3)
	end
end)