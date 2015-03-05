-- Create a new array.
local blueTeamPlayers = {};

function addPlayerToBlueTeam(playerName)
	table.insert(blueTeamPlayers, Player:new(playerName));
end

addPlayerToBlueTeam('Centralan');
addPlayerToBlueTeam('Kruithne');

-- Loop all the players in the array and send them a message.
for index, player in pairs(blueTeamPlayers) do
	player:sendMessage('Hi');
end
