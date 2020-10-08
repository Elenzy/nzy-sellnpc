ESX = nil

local PlayerData = {}

random = 0
spawned = false
satiyor = false

local tasking = false
local drugStorePed = 0


local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)






local rolexDropOffs = {
	[1] =  { ['x'] = 197.41,['y'] = -1499.97,['z'] = 29.14,['h'] = 47.34, ['info'] = ' 1' },
	[2] =  { ['x'] = 4.13,['y'] = -1476.94,['z'] =30.51,['h'] = 47.34, ['info'] = ' 2' },
	[3] =  { ['x'] = 58.5,['y'] = -1616.05,['z'] = 29.42,['h'] = 142.36, ['info'] = ' 3' },
	[4] =  { ['x'] = -173.78,['y'] = -1790.07,['z'] = 29.82,['h'] = 50.04, ['info'] = ' 4' },
	[5] =  { ['x'] = -37.9,['y'] = -1298.48,['z'] = 29.35,['h'] = 185.45, ['info'] = ' 5' },
	[6] =  { ['x'] = -158.98,['y'] = -1451.0,['z'] =  31.47,['h'] = 244.16, ['info'] = ' 6' },
	[7] =  { ['x'] = -299.29,['y'] =  -1368.69,['z'] = 31.27,['h'] = 11.04, ['info'] = ' 7' },
	[8] =  { ['x'] = 153.24,['y'] = -1441.38,['z'] =29.24,['h'] = 135.47, ['info'] = ' 8' },

	[9] =  { ['x'] = -39.33,['y'] = -1749.51,['z'] = 29.33,['h'] = 328.02, ['info'] = ' 9' },
	[10] =  { ['x'] = -197.42,['y'] = -1711.54,['z'] = 32.66,['h'] = 138.19, ['info'] = ' 10' },
	[11] =  { ['x'] = 103.63,['y'] = -1566.22,['z'] = 29.6,['h'] = 235.55, ['info'] = ' 11' },
	[12] =  { ['x'] = 162.0,['y'] = -1801.08,['z'] = 29.11,['h'] = 44.24, ['info'] = ' 12' },
	[13] =  { ['x'] = 131.75,['y'] = -1855.99,['z'] = 24.87,['h'] = 70.02, ['info'] = ' 13' },
	[14] =  { ['x'] = -1214.3,['y'] = -317.57,['z'] = 37.75,['h'] = 18.39, ['info'] = ' 14' },
	[15] =  { ['x'] = 431.9,['y'] = -1907.76,['z'] = 25.93,['h'] = 144.3, ['info'] = ' 15' },
	[16] =  { ['x'] = 145.13,['y'] = -1977.45,['z'] = 18.34,['h'] = 239.22, ['info'] = ' 16' },


}




local drugLocs = {

}











local pillWorker = Config.Place



local rnd = 0
local blip = 0
local deliveryPed = 0







function CreaterolexPed()

	local hashKey = `g_m_y_famdnf_01`




    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
	end

	deliveryPed = CreatePed(pedType, hashKey, rolexDropOffs[rnd]["x"],rolexDropOffs[rnd]["y"],rolexDropOffs[rnd]["z"], rolexDropOffs[rnd]["h"], 0, 0)



    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    SetPedKeepTask(deliveryPed, true)

end









function DeleteCreatedPed()
	print("Deleting Ped?")
	if DoesEntityExist(deliveryPed) then
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)

		Citizen.Wait(20000)
		DeletePed(deliveryPed)
	end
end




function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
	if rolexRun then
		blip = AddBlipForCoord(rolexDropOffs[rnd]["x"],rolexDropOffs[rnd]["y"],rolexDropOffs[rnd]["z"])
	end

    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Müşteri")
    EndTextCommandSetBlipName(blip)
end


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function playerAnim()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end
    end
end


function DoDropOff()
	local success = true
	local rolexChance = math.random(1,1000)
	local plycoords = GetEntityCoords(PlayerPedId())
	local dstcheck = #(plycoords - vector3(rolexDropOffs[rnd]["x"],rolexDropOffs[rnd]["y"],rolexDropOffs[rnd]["z"]))

	Citizen.Wait(1000)
	if dstcheck < 2.0 then



	playerAnim()




	Citizen.Wait(800)

	PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")

	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then

		local counter = math.random(50,200)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Citizen.Wait(1)
		end

		if success then
			local counter = math.random(100,300)
			while counter > 0 do
				local crds = GetEntityCoords(deliveryPed)
				counter = counter - 1
				Citizen.Wait(1)
			end
			giveAnim()
		end

		local crds = GetEntityCoords(deliveryPed)
		local crds2 = GetEntityCoords(PlayerPedId())

		if #(crds - crds2) > 3.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
			success = false
		end

		DeleteBlip()
		if success then


		   TriggerServerEvent("nzy-sellnpc:receiverolex")


			Citizen.Wait(2000)

		end
		DeleteCreatedPed()
	 end
  end

end





function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent("nzy_selltonpc:client")
AddEventHandler("nzy_selltonpc:client", function()

   while true do
	Citizen.Wait(0)

	if tasking then
		return
	end

	rnd = math.random(1,#rolexDropOffs)

	CreateBlip()

	local pedCreated = false

	tasking = true
	local toolong = 600000
	while tasking do

		Citizen.Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(rolexDropOffs[rnd]["x"],rolexDropOffs[rnd]["y"],rolexDropOffs[rnd]["z"]))
		local rolexVehCoords = GetEntityCoords(rolexVehicle)
		local dstcheck2 = #(plycoords - rolexVehCoords)


		local ped = GetPlayerPed(-1) -- nzy
		local playercoords = GetEntityCoords(ped)-- nzy
		if random == 0 then-- nzy
			random = math.random(1, 6)-- nzy
		end-- nzy

		if not spawned then
			RequestModel(866411749)
			while not HasModelLoaded(866411749) do
				Wait(1)
			end

			if dstcheck < 40.0  then
            TriggerEvent("notification","Müşteriye Yaklaştın" , 2)
			CreaterolexPed()
			SetBlockingOfNonTemporaryEvents(deliveryPed, true)
			SetPedDiesWhenInjured(deliveryPed, false)
			SetPedCanPlayAmbientAnims(deliveryPed, true)
			SetPedCanRagdollFromPlayerImpact(deliveryPed, false)
			SetEntityInvincible(D, true)
			SetEntityAsMissionEntity(deliveryPed)
			spawned = true
			print(rolexDropOffs[random].coords)

			end

		end






		local dstcheck = #(plycoords - vector3(rolexDropOffs[rnd]["x"],rolexDropOffs[rnd]["y"],rolexDropOffs[rnd]["z"]))



		if dstcheck < 3.0 then
		local plycoords = GetEntityCoords(PlayerPedId())
		local crds = GetEntityCoords(deliveryPed)
			if not satiyor then
				DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E]")
			end
		end




			if not IsPedInAnyVehicle(PlayerPedId()) and IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				Citizen.Wait(1500)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				DoDropOff()

				TriggerEvent('again')
				tasking = false



		end

	end
end


	DeleteCreatedPed()
	DeleteBlip()

end)


















RegisterNetEvent('again')
AddEventHandler('again', function()
	Citizen.Wait(5000)
	random = 0
	spawned = false
	satiyor = false
	CreateBlip()
end)


Citizen.CreateThread(function()



    while true do

	    Citizen.Wait(1)
	    local dropOff6 = #(GetEntityCoords(PlayerPedId()) - vector3(pillWorker["x"],pillWorker["y"],pillWorker["z"]))

		if dropOff6 < 1.6 and not rolexRun then

			DrawText3Ds(pillWorker["x"],pillWorker["y"],pillWorker["z"], "[E] 1500$ Teslimat Görevi.")
			if IsControlJustReleased(0,38) then
				TriggerServerEvent("nzy-sellnpc:server")
				local plyPed = GetPlayerPed(-1)

				Citizen.Wait(0)

				Citizen.Wait(1000)
			end
		end

    end

end)


















local firstdeal = false
Citizen.CreateThread(function()


    while true do

        if drugdealer then

	        Citizen.Wait(1000)

	        if firstdeal then
	        	Citizen.Wait(10000)
	        end

	        TriggerEvent("drugdelivery:client")

		    salecount = salecount + 1
		    if salecount == 12 then
		    	Citizen.Wait(600000)
		    	drugdealer = false
		    end

		    Citizen.Wait(150000)
		    firstdeal = false

		elseif rolexRun then

				if tasking then
			        Citizen.Wait(30000)
			    else
			        TriggerEvent("nzy_selltonpc:client")
				    salecount = salecount + 1
				    if salecount == Config.RunAmount then
						Citizen.Wait(300000)

				    	rolexRun = false
				    end
				end


	    else

	    	local close = false

	    	for i = 1, #drugLocs do

				local plycoords = GetEntityCoords(PlayerPedId())

				local dstcheck = #(plycoords - vector3(drugLocs[i]["x"],drugLocs[i]["y"],drugLocs[i]["z"]))



				if dstcheck < 5.0 then

					close = true

					local job = exports["isPed"]:isPed("job")

					if job ~= "police" then

						local price = 100

			    		DrawText3Ds(drugLocs[i]["x"],drugLocs[i]["y"],drugLocs[i]["z"], "[E] $" .. price .. " çalıntı mal satma teklifi (12).")

				    	if IsControlJustReleased(0,38) then

				    		local countpolice = exports["isPed"]:isPed("countpolice")
				    		local daytime = exports["isPed"]:isPed("daytime")

							if not daytime then
		            			TriggerEvent("notification","Çok Geç Müşteriyi Kaybettin",2)
		            		else
		            			mygang = drugLocs[i]["gang"]
					    		TriggerServerEvent("drugdelivery:server",price,"robbery",50)
					    		Citizen.Wait(1500)
					    	end

				    	end

			    	else

			    		Citizen.Wait(60000)

			    	end

			    	Citizen.Wait(1)

			    end

			end

			if not close then
				Citizen.Wait(2000)
			end

	    end

    end

end)

RegisterNetEvent("nzy-sellnpc:startDealing")
AddEventHandler("nzy-sellnpc:startDealing", function()
    local NearNPC = GetClosestPed()

	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	salecount = 0
	rolexRun = true
	firstdeal = true

end)