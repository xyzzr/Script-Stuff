local thing = [[
fart
]]


local encoded = thing:gsub(".", function(bb) return "\\" .. bb:byte() end) or thing .. "\""
local translation = (""..thing.."")
local pr = print
local scb = setclipboard

game.StarterGui:SetCore("SendNotification", {
Title = "System";
Text = "Copyed to clipboard!";
Icon = "rbxassetid://57254792";
Duration = 5;
})
game.StarterGui:SetCore("SendNotification", {
Title = "System";
Text = "F9 For more information";
Icon = "rbxassetid://57254792";
Duration = 5;
})
-- shit

scb(""..encoded.."")
pr(" ")
pr(""..encoded.."")
pr("  ")
pr("Translation = "..translation.."")
pr(" ")