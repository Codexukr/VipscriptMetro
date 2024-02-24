
local plr = game:GetService("Players").LocalPlayer 

--Aura Settings
_G.Aura = false
_G.AuraRange = 30
_G.AuraState = "Rage"
_G.AuraCooldown = 0.1

_G.KillTarget = nil
_G.LoopKill = false
_G.KillAll = false


local WeaponTable = {"Baseball Bat","Blood Dagger","Chainsaw","Electric Guitar","Emerald Greatsword","Frost Spear","Katana","Knife","Mace","Machete","Pan","Pencil","Scythe","Tennis Racket","Trident","War Hammer"}

local function Alive()
	local char = plr.Character or plr.Character.Parent
	return char
end 

local function ClosestPlayer(range)
	local char = plr.Character

	local maxdist = range
	local target

	for i,v in ipairs(game:GetService("Players"):GetChildren()) do
		if v.Name ~= plr.Name then
			local EChar = v.Character 

			if EChar then
				local ETorso = EChar:FindFirstChild("Torso")
				local EHuman = EChar:FindFirstChild("Humanoid")

				local distance = (char:FindFirstChild("Torso").Position - ETorso.Position).Magnitude

				if ETorso and EHuman and EHuman.Health >= 1 and not EChar:FindFirstChild("ForceField") and distance <= maxdist then
					target = v
				end
				
			end

		end
	end

	return target
end


function Aura(range)
	local success, err = pcall(function()
		local char = plr.Character
		local EPlr = ClosestPlayer(range)

		if EPlr then
			local TPart = EPlr.Character:FindFirstChild("Torso")
			local THuman = EPlr.Character:FindFirstChild("Humanoid")
            if _G.AuraState == "Rage" then
                if char:FindFirstChildOfClass("Tool"):FindFirstChild("DamageRemote") then
                    char:FindFirstChildOfClass("Tool"):FindFirstChild("DamageRemote"):FireServer(THuman)
                else 
                    game:GetService("Players").LocalPlayer.Backpack:FindFirstChildOfClass("Tool"):FindFirstChild("DamageRemote"):FireServer(THuman)
                end
            else 
                char:FindFirstChildOfClass("Tool"):Activate()
            end 
		end
		
   	end)

end

function Sniper(state)
    repeat
        task.wait(0.5)
        for i,v in pairs(plr.Backpack:GetChildren()) do
            if table.find(WeaponTable,v.Name) then 
                v.Parent = plr.Character     -- Equip Tool
            end 
        end

        if plr.Character:FindFirstChildOfClass("Tool") == nil then return end -- Checking Have a tool 
        plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild("DamageRemote"):FireServer(game:GetService("Players")[_G.KillTarget].Character:FindFirstChild("Humanoid"))
        
    until game:GetService("Players")[_G.KillTarget].Character:FindFirstChild("Humanoid").Health <= 1 
    if state == "notify" then
        Fluent:Notify({Title = "Succes",Content = "Player Killed",Duration=3, })
    end
end

--[[
function KillAll()
    for i,v in pairs(plr.Backpack:GetChildren()) do
        if table.find(WeaponTable,v.Name) then 
            v.Parent = plr.Character     -- Equip Tool
        end 
    end

    if plr.Character:FindFirstChildOfClass("Tool") == nil then return end -- Checking Have a tool 
    
    for i,v in pairs(game:GetService("Players"):GetChildren()) do 
        if v.Name ~= plr.Name then 
            local Echar = v.Character 

            if Echar and not Echar:FindFirstChild("ForceField") and Echar:FindFirstChild("Humanoid").Health >= 1 then 
                plr.Character:FindFirstChildOfClass("Tool"):FindFirstChild("DamageRemote"):FireServer(Echar:FindFirstChild("Humanoid"))
            end 
        end
        task.wait(0.3)
    end 
    
end 
--]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Chaos(Remastered)",
    SubTitle = "UI: by dawid Main:Lerazz",
    TabWidth = 90,
    Size = UDim2.fromOffset(450, 350),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.M
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Combat", Icon = "swords" }),
    Sniper = Window:AddTab({ Title = "Stream-Sniper", Icon = "target" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    -- Combat Tab
    local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
        Title = "Aura-Mode",
        Values = {"Rage","Legit"},
        Multi = false,
        Default = 1,
        Callback = function(Value)
            _G.AuraState = Value
            if Value == "Legit" then 
                Fluent:Notify({Title = "Warning!",Content = "Legit Only Smalest Range(5-10)",SubContent = "Pisynom Blyat Poigrai",Duration=5, })
                _G.AuraCooldown = 0
            else 
                _G.AuraCooldown = 0.5
            end 
        end
    })

    local AuraRange = Tabs.Main:AddSlider("Aura-Cooldown", {
		Title = "Aura-Cooldown",
		Description = "KICK RISK!",
		Default = 0.5,
		Min = 0.1,
		Max = 1,
		Rounding = 1,
		Callback = function(Value)
			_G.AuraCooldown = Value
		end
    })

	local AuraRange = Tabs.Main:AddSlider("AuraRange", {
		Title = "Aura-Range",
		Description = "Pisunom blyat",
		Default = 20,
		Min = 5,
		Max = 80,
		Rounding = 0,
		Callback = function(Value)
			_G.AuraRange = Value
		end
    })

	local Toggle = Tabs.Main:AddToggle("MyToggle", {Title = "Aura", Default = false })

    Toggle:OnChanged(function(value)
		if value then 
			_G.Aura = true
			while _G.Aura do 
                if Alive() then
                    Aura(_G.AuraRange)
                    task.wait(_G.AuraCooldown)
                end
			end
		else
			_G.Aura = false
		end 
    end)

    --[[
    local All = Tabs.Main:AddToggle("MyToggle", {Title = "Auto Kill-all", Default = false })

    All:OnChanged(function(value)
		if value then 
			_G.KillAll = true
			while _G.KillAll do 
                KillAll()
                task.wait(0.5)
			end
		else
			_G.KillAll = false
		end 
    end)
    --]]

    -- Sniper Tab

    local Input = Tabs.Sniper:AddInput("Input", {
        Title = "Write-Target",
        Default = "Kill",
        Placeholder = "Placeholder",
        Numeric = false, 
        Finished = true,
        Callback = function(Value)
            --[[
            for i,v in pairs(game:GetService("Players"):GetChildren()) do
                if v.Name ~= then
                    Fluent:Notify({Title = "Error",Content = "Player Not Found",Duration=5, }) -- Checking if player valid
                    return
                end
            end 
            --]]
            _G.KillTarget = Value 
        end
    })
    
    Tabs.Sniper:AddButton({
        Title = "Kill",
        Description = "pisynom blyat poigrai",
        Callback = function()
            Sniper("notify")
        end
    })


    local LoopKill = Tabs.Sniper:AddToggle("MyToggle", {Title = "Loop-Kill", Default = false })

    LoopKill:OnChanged(function(value)
		if value then 
			_G.LoopKill = true
			while _G.LoopKill do 
                if Alive() then
                    Sniper()
                    task.wait(0.5)
                end
			end
		else
			_G.LoopKill = false
		end 
    end)

end
-- Addons:

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "Fluent",
    Content = "The script has been loaded.",
    Duration = 8
})
SaveManager:LoadAutoloadConfig()
