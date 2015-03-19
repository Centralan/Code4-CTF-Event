-- Create a new array.
local blueTeamPlayers = {};

function addPlayerToBlueTeam(playerName)
	--table.insert(blueTeamPlayers, playerName);
	blueTeamPlayers[playerName] = true;
end

function removePlayerFromBlueTeam(playerName)
	--table.remove(blueTeamPlayers, playerName);
	blueTeamPlayers[playerName] = nil;
end

function isPlayerOnBlueTeam(playerName)
	return 	blueTeamPlayers[playerName] ~= nil;
end

local greenTeamPlayers = {};

function addPlayerToGreenTeam(playerName)
	--table.insert(greenTeamPlayers, Player:new(playerName));
	greenTeamPlayers[playerName] = true;
end

function removePlayerFromGreenTeam(playerName)
	greenTeamPlayers[playerName] = nil;	
end

function isPlayerOnGreenTeam(playerName)
	return greenTeamPlayers[playerName] ~= nil;	
end

-- Team Chat Detection
--

local function hasPrefix(subject, prefix)
	return string.sub(subject, 1, string.len(prefix)) == prefix;
end

local function splitPlayerName(message, len)
	return string.sub(message, len, string.len(message));
end

function chatMonitor(data)
	-- Make sure it's you giving the command.
	if data.player == "Centralan" then
		local player = Player:new(data.player);
		local message = data.message;
		
		if hasPrefix(message, "#AddBluePlayer") then
			local playerName = splitPlayerName(message, 15);
			
			addPlayerToBlueTeam(playerName);
			player:sendMessage("Adding " .. playerName .. " to the &9Blue team!");
		elseif hasPrefix(message, "#AddGreenPlayer") then
			local playerName = splitPlayerName(message, 16);
			
			addPlayerToGreenTeam(playerName);
			player:sendMessage("Adding " .. playerName .. " to the &aGreen team!");
		elseif hasPrefix(message, "#RemoveBluePlayer") then
			local playerName = splitPlayerName(message, 18);
			
			removePlayerFromBlueTeam(playerName);
			player:sendMessage("Removing " .. playerName .. " from the &9Blue team!");
		elseif hasPrefix(message, "#RemoveGreenPlayer") then
			local playerName = splitPlayerName(message, 19);
			
			removePlayerFromGreenTeam(playerName);
			player:sendMessage("Removing " .. playerName .. " from the &aGreen team!");
		elseif hasPrefix(message, "#CheckTeam") then
			local playerName = splitPlayerName(message, 11);
			
			if isPlayerOnGreenTeam(playerName) then
				player:sendMessage(playerName .. " is currently on the green team.");
			elseif isPlayerOnBlueTeam(playerName) then
				player:sendMessage(playerName .. " is currently on the blue team.");
			else
				player:sendMessage(playerName .. " is not on a team.");
			end
		elseif hasPrefix(message, "#ListBlue") then
			local tempPlayerList = {};
			
			for playerName, v in pairs(blueTeamPlayers) do
				table.insert(tempPlayerList, playerName);
			end
			
			player:sendMessage("Blue team: " .. table.concat(tempPlayerList, ","));
		elseif hasPrefix(message, "#ListGreen") then
			local tempPlayerList = {};
			
			for playerName, v in pairs(greenTeamPlayers) do
				table.insert(tempPlayerList, playerName);
			end
			
			player:sendMessage("green team: " .. table.concat(tempPlayerList, ","));
		end
	end
end

registerHook("CHAT_MESSAGE", "chatMonitor", "Code4");

-- AI
--

local world = World:new('Code4');
local soundblock = Location:new(world, 0, 93, -30);
local Overlord = 'Horae'

function a_broadcast(msg)
	world:broadcast(msg);
end

function a_broadcast_npc(npc, msg)
	a_broadcast('&f[C4] &b' .. npc .. '&f: ' .. msg);
end


function a_whisper_npc(npc, msg, player)
	player:sendMessage('&f[C4] &b' .. npc .. ' &3-> &f' .. msg);
end


function EventOverlord_Standby(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "Code 4 is getting ready, please stand by!", player);
         soundblock:playSound('ZOMBIE_UNFECT', 10, 10);
end

function EventOverlord_Teams(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "Players are now being split into 2 teams at random!", player);
         soundblock:playSound('ZOMBIE_UNFECT', 10, 10);
end

function EventOverlord_Gear(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "Both Teams have started gearing up!", player);
         soundblock:playSound('ZOMBIE_UNFECT', 10, 10);
end


function EventOverlord_Start30(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "Code 4 initializing in 30 Seconds!", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

function EventOverlord_Start15(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "Code 4 initializing in 15 Seconds!", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

function EventOverlord_Start10(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "Code 4 initializing in 10 Seconds!", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

function EventOverlord_Start5(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "Code 4 initializing in 5 Seconds!", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

function EventOverlord_bscore(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "&9Blue Team Has Scored a Point!", player);
end

function EventOverlord_gscore(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "&aGreen Team Has Scored a Point!", player);
end

registerHook("INTERACT", "EventOverlord_Teams", 77, "Code4", -3, 86, -35);
registerHook("INTERACT", "EventOverlord_Start30", 77, "Code4", -1, 86, -35);
registerHook("INTERACT", "EventOverlord_Start15", 77, "Code4", 0, 86, -35);
registerHook("INTERACT", "EventOverlord_Start10", 77, "Code4", 1, 86, -35);
registerHook("INTERACT", "EventOverlord_Start5", 77, "Code4", 2, 86, -35);
registerHook("INTERACT", "EventOverlord_bscore", 77, "Code4", 3, 86, -34);
registerHook("INTERACT", "EventOverlord_gscore", 77, "Code4", -3, 86, -34);
registerHook("INTERACT", "EventOverlord_Standby", 77, "Code4", -4, 86, -35);
registerHook("INTERACT", "EventOverlord_Gear", 77, "Code4", -2, 86, -35);


-- Teleport
--

local myWorld = World:new('Code4');
local location = Location:new(myWorld, 44, 64, 0);

function blue_lobby_teleport(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "blue_lobby_teleport", "Code4-blta");

local myWorld = World:new('Code4');
local location = Location:new(myWorld, -44, 64, 0);

function green_lobby_teleport(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "green_lobby_teleport", "Code4-glta");

local myWorld = World:new('Code4');
local location = Location:new(myWorld, 0, 90, -51);

function lobby_catch(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "lobby_catch", "Code4-lobby_catch");

local myWorld = World:new('Code4');
local location = Location:new(myWorld, 0, 90, -51);

function ctf_catch(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "ctf_catch", "Code4-ctf_catch");

local myWorld = World:new('Code4');
local location = Location:new(myWorld, -44, 64, 0);

function gsafe_arena1(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "gsafe_arena1", "Code4-gsta1");

local myWorld = World:new('Code4');
local location = Location:new(myWorld, -44, 64, 0);

function gsafe_arena2(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "gsafe_arena2", "Code4-gsta2");

local myWorld = World:new('Code4');
local location = Location:new(myWorld, 44, 64, 0);

function bsafe_arena1(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "bsafe_arena1", "Code4-bsta1");

local myWorld = World:new('Code4');
local location = Location:new(myWorld, 44, 64, 0);

function bsafe_arena2(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "bsafe_arena2", "Code4-bsta2");

-- Team Gear Up
--

local world = World:new('Code4');
local BlueGearChest = Location:new(world, -4, 86, -39);
local BlueTeamGearUp = Location:new(world, 40, 66, 0);
local BluePlayers = {};

function Blue_Team_Gear(data)
	local player = Player:new(data.player);
	if BluePlayers[player.name] == nil then
		BluePlayers[player.name] = true;
		BlueGearChest:cloneChestToPlayer(player.name);
		player:sendMessage("&dGet your gear on and get ready for the glass to vanish!");
                BlueTeamGearUp:playSound('HORSE_SADDLE', 1, 0);
	end
end

registerHook("REGION_ENTER", "Blue_Team_Gear", "Code4-blta");

local world = World:new('Code4');
local GreenGearChest = Location:new(world, -4, 87, -42);
local GreenTeamGearUp = Location:new(world, -40, 66, 0);
local GreenPlayers = {};

function Green_Team_Gear(data)
	local player = Player:new(data.player);
	if GreenPlayers[player.name] == nil then
		GreenPlayers[player.name] = true;
		GreenGearChest:cloneChestToPlayer(player.name);
		player:sendMessage("&dGet your gear on and get ready for the glass to vanish!");
                GreenTeamGearUp:playSound('HORSE_SADDLE', 1, 0);
	end
end

registerHook("REGION_ENTER", "Green_Team_Gear", "Code4-glta");

-- Item Pickups
--

function ArrowPickUp1(data)
	local player = Player:new(data["player"]);
	player:addItem(262, 10, 1);
	player:sendMessage("&eYou walked over a dead body and looted 1 Arrow.");
end

registerHook("REGION_ENTER", "ArrowPickUp1", "Code4-arrowpickup1");

function ArrowPickUp2(data)
	local player = Player:new(data["player"]);
	player:addItem(262, 10, 1);
	player:sendMessage("&eYou walked over a dead body and you looted 1 Arrow.");
end

registerHook("REGION_ENTER", "ArrowPickUp2", "Code4-arrowpickup2");

function ArrowPickUp3(data)
	local player = Player:new(data["player"]);
	player:addItem(262, 10, 1);
	player:sendMessage("&eYou walked over a dead body and you looted 1 Arrow.");
end

registerHook("REGION_ENTER", "ArrowPickUp3", "Code4-arrowpickup3");

function ArrowPickUp4(data)
	local player = Player:new(data["player"]);
	player:addItem(262, 10, 1);
	player:sendMessage("&eYou walked over a dead body and you looted 1 Arrow.");
end

registerHook("REGION_ENTER", "ArrowPickUp4", "Code4-arrowpickup4");

-- Effects for Flags
--

local world = World:new('Code4');

local effects = {
        {"Green Flag", "CLOUD", 0.05, 20, 5},
        {"Green Flag", "HAPPY_VILLAGER", 20, 20, 5},
        {"Blue Flag", "CLOUD", 0.05, 20, 5},
        {"Blue Flag", "DRIP_WATER", 20, 20, 5}
};

function fireTick()
	processPlayers({world:getPlayers()});
end

function processPlayers(players)
	for index, playerName in pairs(players) do
		for key, effect in pairs(effects) do
			if playerName ~= nil then
				local player = Player:new(playerName);
				if player ~= nil and player:isOnline() then
					if player:hasItemWithName("Â§c" .. effect[1]) then
						local world, x, y, z = player:getLocation();
						local playerLoc = Location:new(world, x, y + effect[5], z);
						playerLoc:playEffect(effect[2], effect[3], effect[4], 20);
					end
				end
			end
		end
	end
end

registerHook("BLOCK_GAINS_CURRENT", "fireTick", "code4", -1, 82, -36);

-- Flag Pickups
--

function flag_perror(player)
	player:sendMessage("&4Sorry you can't take your own flag from your base.");
end

local world = World:new('Code4');
local bluefChest = Location:new(world, -4, 87, -40);
local greenfChest = Location:new(world, -4, 86, -41);

function get_blue_flag(data)
	local player = Player:new(data.player);
        if isPlayerOnGreenTeam(player.name) then
                bluefChest:cloneChestToPlayer(player.name);
		player:sendMessage("&bYou have the Blue Flag! Return it to the Green base!");
        else
               flag_perror(player)
        end

end

function get_green_flag(data)
	local player = Player:new(data.player);
        print(data.player);
        if isPlayerOnBlueTeam(player.name) then
                greenfChest:cloneChestToPlayer(player.name);
		player:sendMessage("&bYou have the Green Flag! Return it to the Blue base!");
        else
               flag_perror(player)
        end

end

registerHook("INTERACT", "get_blue_flag", 77, "Code4", 46, 75, -1);
registerHook("INTERACT", "get_green_flag", 77, "Code4", -46, 75, 1);

-- Flag Drops
--

-- Flag Carrier Deaths
--

-- Achievements
--

function ctf_event_prize(data)
        local p = Player:new(data["player"]);
        p:sendEvent("achievement.ctfeventmarch");
end

registerHook("REGION_ENTER", "ctf_event_prize", "spawn2-event_ctfportal");


