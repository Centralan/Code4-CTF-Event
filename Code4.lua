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
	return blueTeamPlayers[playerName] == true;
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
	return greenTeamPlayers[playerName] == true;	
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
	if data.player == "Centralan" or data.player == "iliketoeatpenuts" then
		local player = Player:new(data.player);
		local message = data.message;
		
		if hasPrefix(message, "#AddBluePlayer") then
			local playerName = splitPlayerName(message, 16);
			
			addPlayerToBlueTeam(playerName);
			player:sendMessage("Adding " .. playerName .. " to the &9Blue team!");
		elseif hasPrefix(message, "#AddGreenPlayer") then
			local playerName = splitPlayerName(message, 17);
			
			addPlayerToGreenTeam(playerName);
			player:sendMessage("Adding " .. playerName .. " to the &aGreen team!");
		elseif hasPrefix(message, "#RemoveBluePlayer") then
			local playerName = splitPlayerName(message, 19);
			
			removePlayerFromBlueTeam(playerName);
			player:sendMessage("Removing " .. playerName .. " from the &9Blue team!");
		elseif hasPrefix(message, "#RemoveGreenPlayer") then
			local playerName = splitPlayerName(message, 20);
			
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
local Overlord = 'Symvan'

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
        a_broadcast_npc(Overlord, "&6Code 4 is getting ready, please stand by!", player);
         soundblock:playSound('ZOMBIE_UNFECT', 10, 10);
end

function EventOverlord_Teams(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "&6Players are now being split into 2 teams at random!", player);
         soundblock:playSound('ZOMBIE_UNFECT', 10, 10);
end

function EventOverlord_Gear(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "&6Both Teams have started gearing up!", player);
         soundblock:playSound('ZOMBIE_UNFECT', 10, 10);
end


function EventOverlord_Start30(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "&6Code 4 initializing in &d30 Seconds&6!", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

function EventOverlord_Start15(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "&6Code 4 initializing in &d15 Seconds&6!", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

function EventOverlord_Start10(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "&6Code 4 initializing in &d10 Seconds&6!", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

function EventOverlord_Start5(data)
        local player = Player:new(data.player);
        a_broadcast_npc(Overlord, "&6Code 4 initializing in &d5 Seconds&6!", player);
         soundblock:playSound('NOTE_PLING', 1000, 10);
         soundblock:playSound('ORB_PICKUP', 1000, 10);
end

registerHook("INTERACT", "EventOverlord_Teams", 77, "Code4", -4, 86, -36);
registerHook("INTERACT", "EventOverlord_Start30", 77, "Code4", -4, 86, -38);
registerHook("INTERACT", "EventOverlord_Start15", 77, "Code4", -4, 86, -39);
registerHook("INTERACT", "EventOverlord_Start10", 77, "Code4", -4, 86, -40);
registerHook("INTERACT", "EventOverlord_Start5", 77, "Code4", -4, 86, -41);
registerHook("INTERACT", "EventOverlord_Standby", 77, "Code4", -4, 86, -35);
registerHook("INTERACT", "EventOverlord_Gear", 77, "Code4", -4, 86, -37);


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

--local myWorld = World:new('Code4');
--local location = Location:new(myWorld, 0, 90, -51);

--function lobby_catch(data)
--       local targetPlayer = Player:new(data.player);
--       targetPlayer:teleport(location);
--end

--registerHook("REGION_ENTER", "lobby_catch", "Code4-lobby_catch");

local location = Location:new(world, 0, 90, -51);

function ctf_catch(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "ctf_catch", "Code4-ctf_catch");

local location = Location:new(world, -44, 64, 0);

function gsafe_arena1(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "gsafe_arena1", "Code4-gsta1");

local location = Location:new(world, -44, 64, 0);

function gsafe_arena2(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "gsafe_arena2", "Code4-gsta2");

local location = Location:new(world, 44, 64, 0);

function bsafe_arena1(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "bsafe_arena1", "Code4-bsta1");

local location = Location:new(world, 44, 64, 0);

function bsafe_arena2(data)
       local targetPlayer = Player:new(data.player);
       targetPlayer:teleport(location);
end

registerHook("REGION_ENTER", "bsafe_arena2", "Code4-bsta2");

-- Team Gear Up
--

local BlueGearChest = Location:new(world, 1, 86, -43);
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
local GreenGearChest = Location:new(world, 4, 85, -43);
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

-- Effects for Flags
--

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
					if player:hasItemWithName("" .. effect[1]) then
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

-- Flag Get
--

function flag_perror(player)
	player:sendMessage("&4Sorry you can't take your own flag from your base.");
end

local bluefChest = Location:new(world, 2, 85, -43);
local greenfChest = Location:new(world, 3, 86, -43);

local greenFlagIsTaken = false;
local blueFlagIsTaken = false;

function get_blue_flag(data)
	local player = Player:new(data.player);
	
	if blueFlagIsTaken then
		-- The flag isn't available, stop here.
		return;
	end
	
	if isPlayerOnGreenTeam(player.name) then
		bluefChest:cloneChestToPlayer(player.name);
		a_broadcast_npc(Overlord, data.player .. " has stolen the &9Blue Flag&f!")
		player:sendMessage("&cReturn the Blue flag to your base to score a point!");
		soundblock:playSound('AMBIENCE_THUNDER', 1000, 3);
		
		-- Set the blue flag as taken.
		blueFlagIsTaken = true;
	else
		flag_perror(player)
	end
end

function get_green_flag(data)
	local player = Player:new(data.player);
	
	if greenFlagIsTaken then
		-- The flag isn't available, stop here.
		return;
	end
	
	if isPlayerOnBlueTeam(player.name) then
		greenfChest:cloneChestToPlayer(player.name);
		a_broadcast_npc(Overlord, data.player .. " has stolen the &aGreen Flag&f!")
		player:sendMessage("&cReturn the Green flag to your base to score a point!");
		soundblock:playSound('AMBIENCE_THUNDER', 1000, 3);
		
		-- Set the green flag as taken.
		greenFlagIsTaken = true;
	else
	   flag_perror(player)
	end
end

registerHook("INTERACT", "get_blue_flag", 77, "Code4", 46, 75, -1);
registerHook("INTERACT", "get_green_flag", 77, "Code4", -46, 75, 1);

-- Flag Pickup
--

local flagRemovalTimer = Timer:new("removeInventoryFlags", 1);
local flagRemovalPipe = {};

function removeInventoryFlags()
	for k, v in pairs(flagRemovalPipe) do
		v:removeItemByName("Blue Flag");
		v:removeItemByName("Green Flag");
		
		flagRemovalPipe[k] = nil;
	end
end

-- This is called when a player picks up an item.
function item_pickup(data)
         local player = Player:new(data.player);
		 
		 -- Check which flag was picked up, either green or blue.
         if data.itemName == "Blue Flag" then
			-- Blue flag was picked up.
			if isPlayerOnBlueTeam(player.name) then
				-- The player has picked up their own flag, return it to the base.
				blueFlagIsTaken = false;
				flagRemovalTimer:start();
				a_broadcast_npc(Overlord, player.name .. " has returned the &9Blue Flag&f!");
			else
				-- The player has picked up the enemy flag, what a bastard!
				a_broadcast_npc(Overlord, player.name .. " has picked up the &9Blue Flag&f!");
			end
		elseif data.itemName == "Green Flag" then
			-- Green flag was picked up.
			if isPlayerOnGreenTeam(player.name) then
				-- The player has picked up their own flag, return it to the base.
				greenFlagIsTaken = false;	
				flagRemovalTimer:start();
				a_broadcast_npc(Overlord, player.name .. " has returned the &aGreen Flag&f!");
			else
				-- The player has picked up the enemy flag, what a bastard!
				a_broadcast_npc(Overlord, player.name .. " has picked up the &aGreen Flag&f!");
			end
		end
end

registerHook("PLAYER_ITEM_PICKUP", "item_pickup", "Code4");

-- Flag Drops
--

function green_down(data, key, location)
         local player = Player:new(data.player);
         if data.itemName == ("Green Flag") then
         a_broadcast_npc(Overlord, data.player .. " has dropped the &aGreen Flag&f!");
    end
end

function blue_down(data, key, location)
         local player = Player:new(data.player);
         if data.itemName == ("Blue Flag") then
         a_broadcast_npc(Overlord, data.player .. " has dropped the &9Blue Flag&f!");
    end
end

registerHook("PLAYER_ITEM_DROP", "green_down", "Code4");
registerHook("PLAYER_ITEM_DROP", "blue_down", "Code4");

-- Flag Score
--

local blueScore = 0;
local greenScore = 0;
local maxScore = 5;

function checkScores()
	if blueScore >= maxScore then
		-- Blue team wins!
		matchComplete();
		
		a_broadcast_npc(Overlord, "&bThe &9Blue Team &bhas won CTF!");
		
		return;
	end
	
	if greenScore >= maxScore then
		-- Green team wins!
		matchComplete();
		
		a_broadcast_npc(Overlord, "&aThe &2Green Team &ahas won CTF!");
		
		return;
	end
end

function flag_score_error(player)
	player:sendMessage("&4You need the correct flag to score!");
end

function green_flag_score(data, key, location)
	local player = Player:new(data.player);
	
	if player:hasItemWithName('Green Flag') then
		if not blueFlagIsTaken then
			a_broadcast_npc(Overlord, data.player .. " &6has captured the Green Flag!");
			a_broadcast_npc(Overlord, "&bThe &9Blue Team &bhas Scored a Point!");
			soundblock:playSound('LAVA_POP', 1000, 50);
			
			blueScore = blueScore + 1; -- Add a point to the blue team.
			checkScores(); -- Check the scores.
		else
			player:sendMessage("&4Your own flag must be at your base to capture the enemy flag!");
		end
	else
		flag_score_error(player);
	end
end

function blue_flag_score(data, key, location)
	local player = Player:new(data.player);
		
	if player:hasItemWithName('Blue Flag') then
		if not greenFlagIsTaken then
			a_broadcast_npc(Overlord, data.player .. " &6has captured the &bBlue Flag&6!");
			a_broadcast_npc(Overlord, "&aThe &2Green Team &ahas Scored a Point!");
			soundblock:playSound('LAVA_POP', 1000, 50);
			
			greenScore = greenScore + 1; -- Add a point to the green team.
			checkScores(); -- Check the scores.
		else
			player:sendMessage("&4Your own flag must be at your base to capture the enemy flag!");
		end
	else
		flag_score_error(player);
	end
end

registerHook("INTERACT", "green_flag_score", 77, "Code4", 46, 75, 1);
registerHook("INTERACT", "blue_flag_score", 77, "Code4", -46, 75, -1);

-- Game Over
--

local startLocation = Location:new(myWorld, 0, 90, -52);

function matchComplete()
    local players = {myWorld:getPlayers()};

    for index, playerName in pairs(players) do
        local player = Player:new(playerName);
        player:teleport(startLocation);
    end
end

-- Achievements
--

function ctf_event_prize(data)
        local p = Player:new(data["player"]);
        p:sendEvent("achievement.ctfeventmarch");
end

registerHook("REGION_ENTER", "ctf_event_prize", "spawn2-event_ctfportal");

-- Green Scoreboard
--

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, -1.0, 92.0, 30.0),
	Location:new(world, -2.0, 92.0, 30.0),
	Location:new(world, -3.0, 92.0, 30.0),
	Location:new(world, -4.0, 92.0, 30.0),
	Location:new(world, -5.0, 92.0, 30.0),
	Location:new(world, -6.0, 92.0, 30.0),
	Location:new(world, -7.0, 92.0, 30.0),
	Location:new(world, -8.0, 92.0, 30.0),
	Location:new(world, -9.0, 92.0, 30.0),
	Location:new(world, -10.0, 92.0, 30.0),
	Location:new(world, -1.0, 91.0, 30.0),
	Location:new(world, -2.0, 91.0, 30.0),
	Location:new(world, -3.0, 91.0, 30.0),
	Location:new(world, -4.0, 91.0, 30.0),
	Location:new(world, -5.0, 91.0, 30.0),
	Location:new(world, -6.0, 91.0, 30.0),
	Location:new(world, -7.0, 91.0, 30.0),
	Location:new(world, -8.0, 91.0, 30.0),
	Location:new(world, -9.0, 91.0, 30.0),
	Location:new(world, -10.0, 91.0, 30.0),
	Location:new(world, -1.0, 90.0, 30.0),
	Location:new(world, -2.0, 90.0, 30.0),
	Location:new(world, -3.0, 90.0, 30.0),
	Location:new(world, -4.0, 90.0, 30.0),
	Location:new(world, -5.0, 90.0, 30.0),
	Location:new(world, -6.0, 90.0, 30.0),
	Location:new(world, -7.0, 90.0, 30.0),
	Location:new(world, -8.0, 90.0, 30.0),
	Location:new(world, -9.0, 90.0, 30.0),
	Location:new(world, -10.0, 90.0, 30.0),
	Location:new(world, -1.0, 89.0, 30.0),
	Location:new(world, -2.0, 89.0, 30.0),
	Location:new(world, -3.0, 89.0, 30.0),
	Location:new(world, -4.0, 89.0, 30.0),
	Location:new(world, -5.0, 89.0, 30.0),
	Location:new(world, -6.0, 89.0, 30.0),
	Location:new(world, -7.0, 89.0, 30.0),
	Location:new(world, -8.0, 89.0, 30.0),
	Location:new(world, -9.0, 89.0, 30.0),
	Location:new(world, -10.0, 89.0, 30.0),
	Location:new(world, -1.0, 88.0, 30.0),
	Location:new(world, -2.0, 88.0, 30.0),
	Location:new(world, -3.0, 88.0, 30.0),
	Location:new(world, -4.0, 88.0, 30.0),
	Location:new(world, -5.0, 88.0, 30.0),
	Location:new(world, -6.0, 88.0, 30.0),
	Location:new(world, -7.0, 88.0, 30.0),
	Location:new(world, -8.0, 88.0, 30.0),
	Location:new(world, -9.0, 88.0, 30.0),
	Location:new(world, -10.0, 88.0, 30.0),
	Location:new(world, -1.0, 87.0, 30.0),
	Location:new(world, -2.0, 87.0, 30.0),
	Location:new(world, -3.0, 87.0, 30.0),
	Location:new(world, -4.0, 87.0, 30.0),
	Location:new(world, -5.0, 87.0, 30.0),
	Location:new(world, -6.0, 87.0, 30.0),
	Location:new(world, -7.0, 87.0, 30.0),
	Location:new(world, -8.0, 87.0, 30.0),
	Location:new(world, -9.0, 87.0, 30.0),
	Location:new(world, -10.0, 87.0, 30.0),
	Location:new(world, -1.0, 86.0, 30.0),
	Location:new(world, -2.0, 86.0, 30.0),
	Location:new(world, -3.0, 86.0, 30.0),
	Location:new(world, -4.0, 86.0, 30.0),
	Location:new(world, -5.0, 86.0, 30.0),
	Location:new(world, -6.0, 86.0, 30.0),
	Location:new(world, -7.0, 86.0, 30.0),
	Location:new(world, -8.0, 86.0, 30.0),
	Location:new(world, -9.0, 86.0, 30.0),
	Location:new(world, -10.0, 86.0, 30.0),
	Location:new(world, -1.0, 85.0, 30.0),
	Location:new(world, -2.0, 85.0, 30.0),
	Location:new(world, -3.0, 85.0, 30.0),
	Location:new(world, -4.0, 85.0, 30.0),
	Location:new(world, -5.0, 85.0, 30.0),
	Location:new(world, -6.0, 85.0, 30.0),
	Location:new(world, -7.0, 85.0, 30.0),
	Location:new(world, -8.0, 85.0, 30.0),
	Location:new(world, -9.0, 85.0, 30.0),
	Location:new(world, -10.0, 85.0, 30.0),
	Location:new(world, -1.0, 84.0, 30.0),
	Location:new(world, -2.0, 84.0, 30.0),
	Location:new(world, -3.0, 84.0, 30.0),
	Location:new(world, -4.0, 84.0, 30.0),
	Location:new(world, -5.0, 84.0, 30.0),
	Location:new(world, -6.0, 84.0, 30.0),
	Location:new(world, -7.0, 84.0, 30.0),
	Location:new(world, -8.0, 84.0, 30.0),
	Location:new(world, -9.0, 84.0, 30.0),
	Location:new(world, -10.0, 84.0, 30.0),
	Location:new(world, -1.0, 83.0, 30.0),
	Location:new(world, -2.0, 83.0, 30.0),
	Location:new(world, -3.0, 83.0, 30.0),
	Location:new(world, -4.0, 83.0, 30.0),
	Location:new(world, -5.0, 83.0, 30.0),
	Location:new(world, -6.0, 83.0, 30.0),
	Location:new(world, -7.0, 83.0, 30.0),
	Location:new(world, -8.0, 83.0, 30.0),
	Location:new(world, -9.0, 83.0, 30.0),
	Location:new(world, -10.0, 83.0, 30.0),

};

function green_blank(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	green_score_blank();
end

function green_score_blank()
	for index, key in ipairs(blocks) do
		key:setBlock(173, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, -3.0, 91.0, 30.0),
	Location:new(world, -4.0, 91.0, 30.0),
	Location:new(world, -5.0, 91.0, 30.0),
	Location:new(world, -6.0, 91.0, 30.0),
	Location:new(world, -7.0, 91.0, 30.0),
	Location:new(world, -8.0, 91.0, 30.0),
	Location:new(world, -8.0, 90.0, 30.0),
	Location:new(world, -8.0, 89.0, 30.0),
	Location:new(world, -8.0, 88.0, 30.0),
	Location:new(world, -8.0, 87.0, 30.0),
	Location:new(world, -8.0, 86.0, 30.0),
	Location:new(world, -8.0, 85.0, 30.0),
	Location:new(world, -8.0, 84.0, 30.0),
	Location:new(world, -7.0, 84.0, 30.0),
	Location:new(world, -6.0, 84.0, 30.0),
	Location:new(world, -5.0, 84.0, 30.0),
	Location:new(world, -4.0, 84.0, 30.0),
	Location:new(world, -3.0, 84.0, 30.0),
	Location:new(world, -3.0, 85.0, 30.0),
	Location:new(world, -3.0, 86.0, 30.0),
	Location:new(world, -3.0, 87.0, 30.0),
	Location:new(world, -3.0, 88.0, 30.0),
	Location:new(world, -3.0, 89.0, 30.0),
	Location:new(world, -3.0, 90.0, 30.0),

};

function green_0(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	green_score_0();
end

function green_score_0()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, -3.0, 84.0, 30.0),
	Location:new(world, -4.0, 84.0, 30.0),
	Location:new(world, -5.0, 84.0, 30.0),
	Location:new(world, -6.0, 84.0, 30.0),
	Location:new(world, -7.0, 84.0, 30.0),
	Location:new(world, -8.0, 84.0, 30.0),
	Location:new(world, -5.0, 85.0, 30.0),
	Location:new(world, -6.0, 85.0, 30.0),
	Location:new(world, -5.0, 86.0, 30.0),
	Location:new(world, -6.0, 86.0, 30.0),
	Location:new(world, -5.0, 87.0, 30.0),
	Location:new(world, -6.0, 87.0, 30.0),
	Location:new(world, -5.0, 88.0, 30.0),
	Location:new(world, -6.0, 88.0, 30.0),
	Location:new(world, -5.0, 89.0, 30.0),
	Location:new(world, -6.0, 89.0, 30.0),
	Location:new(world, -5.0, 90.0, 30.0),
	Location:new(world, -6.0, 90.0, 30.0),
	Location:new(world, -5.0, 91.0, 30.0),
	Location:new(world, -6.0, 91.0, 30.0),
	Location:new(world, -4.0, 90.0, 30.0),
	Location:new(world, -3.0, 89.0, 30.0),
};

function green_1(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	green_score_1();
end

function green_score_1()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, -3.0, 91.0, 30.0),
	Location:new(world, -4.0, 91.0, 30.0),
	Location:new(world, -5.0, 91.0, 30.0),
	Location:new(world, -6.0, 91.0, 30.0),
	Location:new(world, -7.0, 91.0, 30.0),
	Location:new(world, -8.0, 91.0, 30.0),
	Location:new(world, -8.0, 90.0, 30.0),
	Location:new(world, -8.0, 89.0, 30.0),
	Location:new(world, -8.0, 88.0, 30.0),
	Location:new(world, -7.0, 88.0, 30.0),
	Location:new(world, -6.0, 88.0, 30.0),
	Location:new(world, -5.0, 88.0, 30.0),
	Location:new(world, -4.0, 88.0, 30.0),
	Location:new(world, -3.0, 88.0, 30.0),
	Location:new(world, -3.0, 87.0, 30.0),
	Location:new(world, -3.0, 86.0, 30.0),
	Location:new(world, -3.0, 85.0, 30.0),
	Location:new(world, -3.0, 84.0, 30.0),
	Location:new(world, -4.0, 84.0, 30.0),
	Location:new(world, -5.0, 84.0, 30.0),
	Location:new(world, -6.0, 84.0, 30.0),
	Location:new(world, -7.0, 84.0, 30.0),
	Location:new(world, -8.0, 84.0, 30.0),

};

function green_2(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	green_score_2();
end

function green_score_2()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, -3.0, 91.0, 30.0),
	Location:new(world, -4.0, 91.0, 30.0),
	Location:new(world, -5.0, 91.0, 30.0),
	Location:new(world, -6.0, 91.0, 30.0),
	Location:new(world, -7.0, 91.0, 30.0),
	Location:new(world, -8.0, 91.0, 30.0),
	Location:new(world, -8.0, 90.0, 30.0),
	Location:new(world, -8.0, 89.0, 30.0),
	Location:new(world, -8.0, 88.0, 30.0),
	Location:new(world, -8.0, 87.0, 30.0),
	Location:new(world, -8.0, 86.0, 30.0),
	Location:new(world, -8.0, 85.0, 30.0),
	Location:new(world, -8.0, 84.0, 30.0),
	Location:new(world, -4.0, 88.0, 30.0),
	Location:new(world, -5.0, 88.0, 30.0),
	Location:new(world, -6.0, 88.0, 30.0),
	Location:new(world, -7.0, 88.0, 30.0),
	Location:new(world, -4.0, 87.0, 30.0),
	Location:new(world, -5.0, 87.0, 30.0),
	Location:new(world, -6.0, 87.0, 30.0),
	Location:new(world, -7.0, 87.0, 30.0),
	Location:new(world, -3.0, 84.0, 30.0),
	Location:new(world, -4.0, 84.0, 30.0),
	Location:new(world, -5.0, 84.0, 30.0),
	Location:new(world, -6.0, 84.0, 30.0),
	Location:new(world, -7.0, 84.0, 30.0),
};

function green_3(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	green_score_3();
end

function green_score_3()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, -8.0, 91.0, 30.0),
	Location:new(world, -8.0, 90.0, 30.0),
	Location:new(world, -8.0, 89.0, 30.0),
	Location:new(world, -8.0, 88.0, 30.0),
	Location:new(world, -8.0, 87.0, 30.0),
	Location:new(world, -8.0, 86.0, 30.0),
	Location:new(world, -8.0, 85.0, 30.0),
	Location:new(world, -3.0, 91.0, 30.0),
	Location:new(world, -3.0, 90.0, 30.0),
	Location:new(world, -3.0, 89.0, 30.0),
	Location:new(world, -3.0, 88.0, 30.0),
	Location:new(world, -4.0, 88.0, 30.0),
	Location:new(world, -5.0, 88.0, 30.0),
	Location:new(world, -6.0, 88.0, 30.0),
	Location:new(world, -7.0, 88.0, 30.0),
};

function green_4(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	green_score_4();
end

function green_score_4()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

registerHook("INTERACT", "green_blank", 77, "Code4", -2, 88, -36);
registerHook("INTERACT", "green_0", 77, "Code4", -1, 88, -36);
registerHook("INTERACT", "green_1", 77, "Code4", 0, 88, -36);
registerHook("INTERACT", "green_2", 77, "Code4", 1, 88, -36);
registerHook("INTERACT", "green_3", 77, "Code4", 2, 88, -36);
registerHook("INTERACT", "green_4", 77, "Code4", 3, 88, -36);

-- Blue Scoreboard
--

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, 1.0, 92.0, 30.0),
	Location:new(world, 2.0, 92.0, 30.0),
	Location:new(world, 3.0, 92.0, 30.0),
	Location:new(world, 4.0, 92.0, 30.0),
	Location:new(world, 5.0, 92.0, 30.0),
	Location:new(world, 6.0, 92.0, 30.0),
	Location:new(world, 7.0, 92.0, 30.0),
	Location:new(world, 8.0, 92.0, 30.0),
	Location:new(world, 9.0, 92.0, 30.0),
	Location:new(world, 10.0, 92.0, 30.0),
	Location:new(world, 1.0, 91.0, 30.0),
	Location:new(world, 2.0, 91.0, 30.0),
	Location:new(world, 3.0, 91.0, 30.0),
	Location:new(world, 4.0, 91.0, 30.0),
	Location:new(world, 5.0, 91.0, 30.0),
	Location:new(world, 6.0, 91.0, 30.0),
	Location:new(world, 7.0, 91.0, 30.0),
	Location:new(world, 8.0, 91.0, 30.0),
	Location:new(world, 9.0, 91.0, 30.0),
	Location:new(world, 10.0, 91.0, 30.0),
	Location:new(world, 1.0, 90.0, 30.0),
	Location:new(world, 2.0, 90.0, 30.0),
	Location:new(world, 3.0, 90.0, 30.0),
	Location:new(world, 4.0, 90.0, 30.0),
	Location:new(world, 5.0, 90.0, 30.0),
	Location:new(world, 6.0, 90.0, 30.0),
	Location:new(world, 7.0, 90.0, 30.0),
	Location:new(world, 8.0, 90.0, 30.0),
	Location:new(world, 9.0, 90.0, 30.0),
	Location:new(world, 10.0, 90.0, 30.0),
	Location:new(world, 1.0, 89.0, 30.0),
	Location:new(world, 2.0, 89.0, 30.0),
	Location:new(world, 3.0, 89.0, 30.0),
	Location:new(world, 4.0, 89.0, 30.0),
	Location:new(world, 5.0, 89.0, 30.0),
	Location:new(world, 6.0, 89.0, 30.0),
	Location:new(world, 7.0, 89.0, 30.0),
	Location:new(world, 8.0, 89.0, 30.0),
	Location:new(world, 9.0, 89.0, 30.0),
	Location:new(world, 10.0, 89.0, 30.0),
	Location:new(world, 1.0, 88.0, 30.0),
	Location:new(world, 2.0, 88.0, 30.0),
	Location:new(world, 3.0, 88.0, 30.0),
	Location:new(world, 4.0, 88.0, 30.0),
	Location:new(world, 5.0, 88.0, 30.0),
	Location:new(world, 6.0, 88.0, 30.0),
	Location:new(world, 7.0, 88.0, 30.0),
	Location:new(world, 8.0, 88.0, 30.0),
	Location:new(world, 9.0, 88.0, 30.0),
	Location:new(world, 10.0, 88.0, 30.0),
	Location:new(world, 1.0, 87.0, 30.0),
	Location:new(world, 2.0, 87.0, 30.0),
	Location:new(world, 3.0, 87.0, 30.0),
	Location:new(world, 4.0, 87.0, 30.0),
	Location:new(world, 5.0, 87.0, 30.0),
	Location:new(world, 6.0, 87.0, 30.0),
	Location:new(world, 7.0, 87.0, 30.0),
	Location:new(world, 8.0, 87.0, 30.0),
	Location:new(world, 9.0, 87.0, 30.0),
	Location:new(world, 10.0, 87.0, 30.0),
	Location:new(world, 1.0, 86.0, 30.0),
	Location:new(world, 2.0, 86.0, 30.0),
	Location:new(world, 3.0, 86.0, 30.0),
	Location:new(world, 4.0, 86.0, 30.0),
	Location:new(world, 5.0, 86.0, 30.0),
	Location:new(world, 6.0, 86.0, 30.0),
	Location:new(world, 7.0, 86.0, 30.0),
	Location:new(world, 8.0, 86.0, 30.0),
	Location:new(world, 9.0, 86.0, 30.0),
	Location:new(world, 10.0, 86.0, 30.0),
	Location:new(world, 1.0, 85.0, 30.0),
	Location:new(world, 2.0, 85.0, 30.0),
	Location:new(world, 3.0, 85.0, 30.0),
	Location:new(world, 4.0, 85.0, 30.0),
	Location:new(world, 5.0, 85.0, 30.0),
	Location:new(world, 6.0, 85.0, 30.0),
	Location:new(world, 7.0, 85.0, 30.0),
	Location:new(world, 8.0, 85.0, 30.0),
	Location:new(world, 9.0, 85.0, 30.0),
	Location:new(world, 10.0, 85.0, 30.0),
	Location:new(world, 1.0, 84.0, 30.0),
	Location:new(world, 2.0, 84.0, 30.0),
	Location:new(world, 3.0, 84.0, 30.0),
	Location:new(world, 4.0, 84.0, 30.0),
	Location:new(world, 5.0, 84.0, 30.0),
	Location:new(world, 6.0, 84.0, 30.0),
	Location:new(world, 7.0, 84.0, 30.0),
	Location:new(world, 8.0, 84.0, 30.0),
	Location:new(world, 9.0, 84.0, 30.0),
	Location:new(world, 10.0, 84.0, 30.0),
	Location:new(world, 1.0, 83.0, 30.0),
	Location:new(world, 2.0, 83.0, 30.0),
	Location:new(world, 3.0, 83.0, 30.0),
	Location:new(world, 4.0, 83.0, 30.0),
	Location:new(world, 5.0, 83.0, 30.0),
	Location:new(world, 6.0, 83.0, 30.0),
	Location:new(world, 7.0, 83.0, 30.0),
	Location:new(world, 8.0, 83.0, 30.0),
	Location:new(world, 9.0, 83.0, 30.0),
	Location:new(world, 10.0, 83.0, 30.0),
};

function blue_blank(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	blue_score_blank();
end

function blue_score_blank()
	for index, key in ipairs(blocks) do
		key:setBlock(173, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, 3.0, 91.0, 30.0),
	Location:new(world, 4.0, 91.0, 30.0),
	Location:new(world, 5.0, 91.0, 30.0),
	Location:new(world, 6.0, 91.0, 30.0),
	Location:new(world, 7.0, 91.0, 30.0),
	Location:new(world, 8.0, 91.0, 30.0),
	Location:new(world, 8.0, 90.0, 30.0),
	Location:new(world, 8.0, 89.0, 30.0),
	Location:new(world, 8.0, 88.0, 30.0),
	Location:new(world, 8.0, 87.0, 30.0),
	Location:new(world, 8.0, 86.0, 30.0),
	Location:new(world, 8.0, 85.0, 30.0),
	Location:new(world, 8.0, 84.0, 30.0),
	Location:new(world, 7.0, 84.0, 30.0),
	Location:new(world, 6.0, 84.0, 30.0),
	Location:new(world, 5.0, 84.0, 30.0),
	Location:new(world, 4.0, 84.0, 30.0),
	Location:new(world, 3.0, 84.0, 30.0),
	Location:new(world, 3.0, 85.0, 30.0),
	Location:new(world, 3.0, 86.0, 30.0),
	Location:new(world, 3.0, 87.0, 30.0),
	Location:new(world, 3.0, 88.0, 30.0),
	Location:new(world, 3.0, 89.0, 30.0),
	Location:new(world, 3.0, 90.0, 30.0),

};

function blue_0(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	blue_score_0();
end

function blue_score_0()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, 3.0, 84.0, 30.0),
	Location:new(world, 4.0, 84.0, 30.0),
	Location:new(world, 5.0, 84.0, 30.0),
	Location:new(world, 6.0, 84.0, 30.0),
	Location:new(world, 7.0, 84.0, 30.0),
	Location:new(world, 8.0, 84.0, 30.0),
	Location:new(world, 5.0, 85.0, 30.0),
	Location:new(world, 6.0, 85.0, 30.0),
	Location:new(world, 5.0, 86.0, 30.0),
	Location:new(world, 6.0, 86.0, 30.0),
	Location:new(world, 5.0, 87.0, 30.0),
	Location:new(world, 6.0, 87.0, 30.0),
	Location:new(world, 5.0, 88.0, 30.0),
	Location:new(world, 6.0, 88.0, 30.0),
	Location:new(world, 5.0, 89.0, 30.0),
	Location:new(world, 6.0, 89.0, 30.0),
	Location:new(world, 5.0, 90.0, 30.0),
	Location:new(world, 6.0, 90.0, 30.0),
	Location:new(world, 5.0, 91.0, 30.0),
	Location:new(world, 6.0, 91.0, 30.0),
	Location:new(world, 7.0, 90.0, 30.0),
	Location:new(world, 8.0, 89.0, 30.0),
};

function blue_1(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	blue_score_1();
end

function blue_score_1()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, 3.0, 91.0, 30.0),
	Location:new(world, 4.0, 91.0, 30.0),
	Location:new(world, 5.0, 91.0, 30.0),
	Location:new(world, 6.0, 91.0, 30.0),
	Location:new(world, 7.0, 91.0, 30.0),
	Location:new(world, 8.0, 91.0, 30.0),
	Location:new(world, 3.0, 90.0, 30.0),
	Location:new(world, 3.0, 89.0, 30.0),
	Location:new(world, 3.0, 88.0, 30.0),
	Location:new(world, 3.0, 87.0, 30.0),
	Location:new(world, 3.0, 86.0, 30.0),
	Location:new(world, 3.0, 85.0, 30.0),
	Location:new(world, 8.0, 84.0, 30.0),
	Location:new(world, 4.0, 88.0, 30.0),
	Location:new(world, 5.0, 88.0, 30.0),
	Location:new(world, 6.0, 88.0, 30.0),
	Location:new(world, 7.0, 88.0, 30.0),
	Location:new(world, 4.0, 87.0, 30.0),
	Location:new(world, 5.0, 87.0, 30.0),
	Location:new(world, 6.0, 87.0, 30.0),
	Location:new(world, 7.0, 87.0, 30.0),
	Location:new(world, 3.0, 84.0, 30.0),
	Location:new(world, 4.0, 84.0, 30.0),
	Location:new(world, 5.0, 84.0, 30.0),
	Location:new(world, 6.0, 84.0, 30.0),
	Location:new(world, 7.0, 84.0, 30.0),
};

function blue_3(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	blue_score_3();
end

function blue_score_3()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, 8.0, 91.0, 30.0),
	Location:new(world, 8.0, 90.0, 30.0),
	Location:new(world, 8.0, 89.0, 30.0),
	Location:new(world, 8.0, 88.0, 30.0),
	Location:new(world, 3.0, 87.0, 30.0),
	Location:new(world, 3.0, 86.0, 30.0),
	Location:new(world, 3.0, 85.0, 30.0),
	Location:new(world, 3.0, 91.0, 30.0),
	Location:new(world, 3.0, 90.0, 30.0),
	Location:new(world, 3.0, 89.0, 30.0),
	Location:new(world, 3.0, 88.0, 30.0),
	Location:new(world, 4.0, 88.0, 30.0),
	Location:new(world, 5.0, 88.0, 30.0),
	Location:new(world, 6.0, 88.0, 30.0),
	Location:new(world, 7.0, 88.0, 30.0),
};

function blue_4(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	blue_score_4();
end

function blue_score_4()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

local current = 1;
local maxData = 14;
local blocks = {
	Location:new(world, 3.0, 91.0, 30.0),
	Location:new(world, 4.0, 91.0, 30.0),
	Location:new(world, 5.0, 91.0, 30.0),
	Location:new(world, 6.0, 91.0, 30.0),
	Location:new(world, 7.0, 91.0, 30.0),
	Location:new(world, 8.0, 91.0, 30.0),
	Location:new(world, 8.0, 90.0, 30.0),
	Location:new(world, 8.0, 89.0, 30.0),
	Location:new(world, 8.0, 88.0, 30.0),
	Location:new(world, 7.0, 88.0, 30.0),
	Location:new(world, 6.0, 88.0, 30.0),
	Location:new(world, 5.0, 88.0, 30.0),
	Location:new(world, 4.0, 88.0, 30.0),
	Location:new(world, 3.0, 88.0, 30.0),
	Location:new(world, 3.0, 87.0, 30.0),
	Location:new(world, 3.0, 86.0, 30.0),
	Location:new(world, 3.0, 85.0, 30.0),
	Location:new(world, 3.0, 84.0, 30.0),
	Location:new(world, 4.0, 84.0, 30.0),
	Location:new(world, 5.0, 84.0, 30.0),
	Location:new(world, 6.0, 84.0, 30.0),
	Location:new(world, 7.0, 84.0, 30.0),
	Location:new(world, 8.0, 84.0, 30.0),

};

function blue_5(data)
	if current == maxData then
		current = 1;
	else
		current = current + 1;
	end
	blue_score_5();
end

function blue_score_5()
	for index, key in ipairs(blocks) do
		key:setBlock(89, current);
	end
end

registerHook("INTERACT", "blue_blank", 77, "Code4", -2, 86, -36);
registerHook("INTERACT", "blue_0", 77, "Code4", -1, 86, -36);
registerHook("INTERACT", "blue_1", 77, "Code4", 0, 86, -36);
registerHook("INTERACT", "blue_3", 77, "Code4", 2, 86, -36);
registerHook("INTERACT", "blue_4", 77, "Code4", 3, 86, -36);
registerHook("INTERACT", "blue_5", 77, "Code4", 4, 86, -36);
