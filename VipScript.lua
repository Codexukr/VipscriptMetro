local plr = game:GetService("Players").LocalPlayer

_G.God = false
_G.Gift =false

function Alive()
    local char = plr.Character or plr.Character.Parent 
    return char
end

function god(Type)
	local plr = game.Players.LocalPlayer
	local char = plr.Character

	local path = workspace.SafeZones.Zone.Main
	local Root = char:FindFirstChild("Head")

	if Type == "start" then
		if not char:FindFirstChildOfClass("ForceField") then
			firetouchinterest(Root,path,1)
			firetouchinterest(Root,path,0)
		else
			firetouchinterest(Root,path,0)
		end
	else
		firetouchinterest(Root,path,1)
	end
end

function GetGift()
    local char = plr.Character
    local HRP = char:FindFirstChild("HumanoidRootPart")


    local GiftPath = workspace.Gifts

    
    for i,v in pairs(GiftPath:GetChildren()) do
        local gift = v:FindFirstChild("Gift")
        if gift:FindFirstChildOfClass("TouchTransmitter") then
            print(v)
            firetouchinterest(HRP,gift,1)
            firetouchinterest(HRP,gift,0)
        end
    end

end

----------------UI
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Pussy Destroyer", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local Tab = Window:MakeTab({
	Name = "Tab 1",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local Section = Tab:AddSection({
	Name = "Pussy Destroyer?..."
})

Tab:AddToggle({
	Name = "FE-God",
	Default = false,
	Callback = function(Value)
        if Value then
            _G.God = true
            while _G.God do
                if Alive() then
                    god("start")
                    task.wait(0.2)
                end
            end
        else
            god("stop")
            _G.God = false
        end
	end    
})

Tab:AddToggle({
	Name = "Auto-Gift",
	Default = false,
	Callback = function(Value)
        if Value then
            _G.Gift = true
            while _G.Gift do
                if Alive() then
                    GetGift()
                    task.wait(0.1)
                end
            end
        else
            _G.Gift = false
        end
	end    
})
