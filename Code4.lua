-- Create a new array.
local blueTeamPlayers = {};

function addPlayerToBlueTeam(playerName)
	table.insert(blueTeamPlayers, Player:new(playerName));
end

addPlayerToBlueTeam('Centralan');
addPlayerToBlueTeam('JettKuso');

-- Loop all the players in the array and send them a message.
for index, player in pairs(blueTeamPlayers) do
	player:sendMessage('&9You are now on the Blue team!');
end

local greenTeamPlayers = {};

function addPlayerToGreenTeam(playerName)
	table.insert(greenTeamPlayers, Player:new(playerName));
end

addPlayerToGreenTeam('Kruithne');
addPlayerToGreenTeam('MrMarc45689');

-- Loop all the players in the array and send them a message.
for index, player in pairs(greenTeamPlayers) do
	player:sendMessage('&aYou are now on the Green team!');
end

-- Team Chat Detection
--

local function hasPrefix(subject, prefix)
	return string.sub(subject, 1, string.len(prefix)) == prefix;
end

function chatMonitor(data)
	-- Make sure it's you giving the command.
	if data.player == "Centralan" then
		if hasPrefix(data.message, "#AddBluePlayer") then
			local playerName = string.sub(data.message, 14, string.len(data.message));
                        local player = Player:new(data.player);
                        addPlayerToBlueTeam(playerName);
                        player:sendMessage("Adding " .. playerName .. " to the &9Blue team!")
                elseif hasPrefix(data.message, "#AddGreenPlayer") then
                	local playerName = string.sub(data.message, 15, string.len(data.message));
                	local player = Player:new(data.player);
                        addPlayerToGreenTeam(playerName);
                	player:sendMessage("Adding " .. playerName .. " to the &aGreen team!");
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
local location = Location:new(myWorld, 50, 65, 0);

function blue_lobby_teleport(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "blue_lobby_teleport", "Code4-blta");

local myWorld = World:new('Code4');
local location = Location:new(myWorld, -50, 65, 0);

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

-- Chest Cloning
--

local world = World:new('Code4');
local BlueGearChest = Location:new(world, 54, 65, 0);
local BluePlayers = {};

function Blue_Team_Gear(data)
	local player = Player:new(data.player);
	if BluePlayers[player.name] == nil then
		BluePlayers[player.name] = true;
		BlueGearChest:cloneChestToPlayer(player.name);
		player:sendMessage("&dAs fast as you can get your gear on and into place then jump into the water!");
	end
end

registerHook("INTERACT", "Blue_Team_Gear", 54, "Code4", 54, 65, 0);

local world = World:new('Code4');
local GreenGearChest = Location:new(world, -54, 65, 0);
local GreenPlayers = {};

function Green_Team_Gear(data)
	local player = Player:new(data.player);
	if GreenPlayers[player.name] == nil then
		GreenPlayers[player.name] = true;
		GreenGearChest:cloneChestToPlayer(player.name);
		player:sendMessage("&dAs fast as you can get your gear on and into place then jump into the water!");
	end
end

registerHook("INTERACT", "Green_Team_Gear", 54, "Code4", -54, 65, 0);

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

-- Flag Drops
--

-- Flag Carrier Deaths
--

-- Flag Detection
--

