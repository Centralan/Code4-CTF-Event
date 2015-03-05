-- Create a new array.
local blueTeamPlayers = {};

-- Create a player.
local myPlayer = Player:new('Centralan');

-- Add the player to the array.
table.insert(blueTeamPlayers, myPlayer);

-- Loop all the players in the array and send them a message.
for index, player in pairs(blueTeamPlayers) do
	player:sendMessage('Hi');
end

-- Clear the array.
blueTeamPlayers = {};
