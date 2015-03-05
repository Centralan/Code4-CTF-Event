-- Default both flags to true.
local blueTeamFlagAtBase = true;
local greenTeamFlagAtBase = true;

-- Call this function when a player clicks on the
-- button at the blue base.
function takeBlueFlag(data)
	-- Check the blue flag actually exists at the base.
	if blueTeamFlagAtBase then
		-- This is the player who just took the flag.
		local takingPlayer = Player:new(data.player);
		
		-- ToDo: Do something to check this player is actually on the green team here.
		
		-- ToDo: If the player is on the blue team, check if they are carrying the
		-- green teams flag, if they are, remove it from them and cap it, giving them
		-- a point to their team. If they are on the green team, carry on with the
		-- things below.
		
		-- ToDo: Remove the physical flag from the world.
		
		-- Set the flag as taken.
		blueTeamFlagAtBase = false;
	
		-- ToDo: Give the flag item to the player who took the flag
		-- ToDo: Broadcast to the world that the blue flag was taken.
	end
end

function takeGreenFlag(data)
	-- Check the green flag actually exists at the base.
	if greenTeamFlagAtBase then
		-- This is the player who just took the flag.
		local takingPlayer = Player:new(data.player);
		
		-- ToDo: Do something to check this player is actually on the blue team.
		
		-- ToDo: If the player is on the green team, check if they are carrying the
		-- blue teams flag, if they are, remove it from them and cap it, giving them a
		-- point to their team. If they are on the blue team, carry on with the
		-- things below.
		
		-- ToDo: Remove the physical flag from the world.
		
		-- Set the flag as taken.
		greenTeamFlagAtBase = false;
		
		-- ToDo: Give the flag item to the player that took the flag.
		-- ToDo: Broadcast to the world that the green flag was taken.
		
	end
end
