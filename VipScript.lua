--Toggles
local plr = game:GetService("Players").LocalPlayer

_G.Farm = false
_G.killall = false
_G.Aura = false
_G.god = false
_G.Sound = false

_G.Fall = nil
_G.GetFunction = nil

_G.Key = ""


--Rename 
if not workspace.map:FindFirstChild("god") then
	local path = workspace.map.Part:FindFirstChild("TouchInterest")
	path.Parent.Name = "god"
end

function killremote(EPlayer)
	-- goffy ah table	
	local ohTable7 = {
		[1] = 8.5,
		[2] = 1.3,
		[3] = true,
		[4] = 31.272254943847656,
		[5] = false,
		[6] = 10000,
		[7] = 1000
	}
	local ohTable8 = {
		[1] = 0.2,
		[2] = 0,
		[3] = false,
		[4] = false,
		[5] = game:GetService("Players").LocalPlayer.Backpack["Makarov PM"].GunScript_Server.IgniteScript,
		[6] = game:GetService("Players").LocalPlayer.Backpack["Makarov PM"].GunScript_Server.IcifyScript,
		[7] = 100,
		[8] = 100
	}
	local ohTable9 = {
		[1] = true,
		[2] = 35,
		[3] = 3
	}
	local ohInstance10 = workspace[EPlayer.Name].Head
	local ohTable11 = {
		[1] = false,
		[2] = {
			[1] = 1930359546
		},
		[3] = 1,
		[4] = 1.5,
		[5] = 1,
		[6] = game:GetService("Players").LocalPlayer.Backpack["Makarov PM"].GunScript_Local.GoreEffect
	}
	
	game:GetService("ReplicatedStorage").Remotes.InflictTarget:InvokeServer("trash",tostring(_G.Key), game:GetService("Players").LocalPlayer.Backpack["Makarov PM"], game:GetService("Players").LocalPlayer, workspace[EPlayer.Name].Humanoid, workspace[EPlayer.Name].HumanoidRootPart, ohTable7, ohTable8, ohTable9, ohInstance10, ohTable11, "Trash")
end

function Alive()
	local character = plr.Character or plr.Character.Parent
	return character
end

function GetMoney(MoneyPath)
	local char = plr.Character
	local HRP = char:FindFirstChild("HumanoidRootPart")
	local UnitCFrame = HRP.CFrame
	
	
	HRP.CFrame = MoneyPath.CFrame + Vector3.new(0, -0.8, 0)
	
	task.wait(0.5)
	fireclickdetector(MoneyPath:FindFirstChildOfClass("ClickDetector"))
	
	HRP.CFrame = UnitCFrame
	
end

local function ClosestPlayer(range)
	local char = plr.Character

	local maxdist = range
	local target

	for i,v in pairs(game:GetService("Players"):GetChildren()) do
		if v.Name ~= plr.Name and game:GetService("Workspace"):FindFirstChild(v.Name) then
			local EChar = v.Character 

			if EChar then
				local ETorso = EChar:FindFirstChild("Torso")
				local EHuman = EChar:FindFirstChild("Humanoid")

				local distance = (char:FindFirstChild("Torso").Position - ETorso.Position).Magnitude

				if ETorso and EHuman and EHuman.Health >= 1 and not EChar:FindFirstChild("ForceField") and plr.Team ~= v.Team and distance <= maxdist then
					target = v
				end
				
			end

		end
	end

	return target
end

function KillAll()
	for i,v in pairs(game:GetService("Players"):GetChildren()) do
		if v.Name ~= plr.Name then
			local EChar = v.Character

			if EChar then
				local EHuman = EChar:FindFirstChild("Humanoid")
				if EHuman.Health >= 1 and plr.Team ~= v.Team and not EChar:FindFirstChild("ForceField") then
					killremote(v)
				end
			end


		end
	end
end

function Aura(range)
	local EPlr = ClosestPlayer(range)

	if EPlr then
		killremote(EPlr)
	end
end

function shop(Item)
	local ItemName = Item
	game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.shop.RemoteEvent:FireServer(ItemName)
end

function FactoryFarm()
	local char = plr.Character

    local MetalSpawn = workspace.spawnable
	local Metal = MetalSpawn:WaitForChild("Ржавый металл")

    --getting 
	if Metal then
		char:FindFirstChild("HumanoidRootPart").CFrame = Metal.CFrame + Vector3.new(0,2.5,0)
		fireproximityprompt(Metal:FindFirstChild("Attachment").ProximityPrompt,1,true)
	end

	--selling 
	if plr.Backpack:FindFirstChild("Ржавый металл") then
		game:GetService("ReplicatedStorage").Events.Factory:FireServer("sell", "rust")
	end

end

function god(Type)
	local plr = game.Players.LocalPlayer
	local char = plr.Character

	local path = workspace.map:FindFirstChild("god")
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

function NoFall()
	local char = plr.Character
	local Human = char:FindFirstChild("Humanoid")

	if Human and Human.Sit then
		Human.Sit = false
	end

end

-------------UI
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()

local Wm = library:Watermark("By q3v3/Lerazz " .. " | " .. library:GetUsername())
local Notif = library:InitNotifications()

local LoadingXSX = Notif:Notify("You Fucked Niger", 3, "information") -- notification, alert, error, success, information

library.title = "Sperma-Na-Asfalte"

library:Introduction()
wait(1)
local Init = library:Init()
local Tab1 = Init:NewTab("Farm")
local Section1 = Tab1:NewSection("Farms")

local Tab2 = Init:NewTab("Misc")
local Section2 = Tab2:NewSection("Miscs")

local Tab3 = Init:NewTab("Combat/Etc.")
local Section3 = Tab3:NewSection("Combats")

local Tab4 = Init:NewTab("Bypass")
local Section4 = Tab4:NewSection("Bypass")


--Tab Farm

--Factory Farm 
local Toggle1 = Tab1:NewToggle("Factory Farm", false, function(value)
    if value then
		_G.Farm = true
		while _G.Farm do
			if Alive() then
				FactoryFarm()
			end
			task.wait()
		end
	else
		_G.Farm = false
	end
end)


local Keybind1 = Tab1:NewKeybind("Gui Toggle", Enum.KeyCode.RightAlt, function(key)
    Init:UpdateKeybind(Enum.KeyCode[key])
end)


--Tab Misc

--Grabing Money
local Toggle1 = Tab2:NewToggle("Grab-Money", false, function(value)
    if value then
        _G.GetFunction = game.Workspace.ChildAdded:Connect(function(child)
            if child.ClassName == "MeshPart" then
                GetMoney(child)
            end
        end)
    else
        _G.GetFunction:Disconnect()
    end
end)


--FE GOD
local Toggle1 = Tab2:NewToggle("FE-God", false, function(value)
    if value then
		_G.god = true
		while _G.god do
			if Alive() then
				god("start")
			end
			task.wait(0.05)
		end
	else
		god("stop")
		_G.god = false
	end
end)

-- No fall for Attack
local Toggle1 = Tab2:NewToggle("NoDamage Fall", false, function(value)
    if value then
		_G.Fall = plr.Character:FindFirstChild("Humanoid"):GetPropertyChangedSignal("Sit"):Connect(function()
			NoFall()
		end)
	else
		_G.Fall:Disconnect()
	end
end)

--Tab Combat

_G.AuraRange = 25

local Button1 = Tab3:NewButton("Buy-Pistol", function()
    shop("Makarov PM")
end)

local Slider1 = Tab3:NewSlider("Kill-Aura Range", "", true, "/", {min = 20, max = 85, default = 20}, function(value)
    _G.AuraRange = value
end)

local Label1 = Tab3:NewLabel("Buy Pistol and Load Bypass!", "Center")

local Toggle1 = Tab3:NewToggle("Kill All", false, function(value)
	if value then
		_G.killall = true
		while _G.killall do
			if Alive() then
				KillAll()
			end
			task.wait(0.01)
		end
	else
		_G.killall = false
	end
end)

local Toggle1 = Tab3:NewToggle("Kill-Aura", false, function(value)
    if value then
		_G.Aura = true
		while _G.Aura do
			if Alive() then
				Aura(_G.AuraRange)
			end
			task.wait(0.01)
		end
	else
		_G.Aura = false
	end
end):AddKeybind(Enum.KeyCode.J)

-- Bypass Tab

--Adonis Bypass
loadstring(game:HttpGet("https://pastebin.com/raw/5Ti4Xkpp"))()



local Adonis = Tab4:NewLabel("Adonis Bypassed")
local ddd = Tab4:NewLabel("------------")
local StatusByp = Tab4:NewLabel("Status: Not Bypassed")
local ConsoleByp = Tab4:NewLabel("Information: Nil")
local ddd = Tab4:NewLabel("------------")
local KeyByp = Tab4:NewLabel("Key: Waiting...")

--Checking
if _G.Key ~= "" then
	ConsoleByp:Text("Information: Nil")
	StatusByp:Text("Status: Bypassed")

	KeyByp:Text("Key: " .. _G.Key)
end

function Bypass()
    local char = plr.Character
    local backpack = plr.Backpack


    if backpack:FindFirstChild("Makarov PM") or char:FindFirstChild("Makarov PM") then
        ConsoleByp:Text("Information: Pistol Finded...")
        task.wait(3)
        ConsoleByp:Text("Information: Intializing Bypass..")

            local namecall
            namecall = hookmetamethod(game,"__namecall",function(self,...)
                local args = {...}
                local method = getnamecallmethod()
                if tostring(self) == "InflictTarget" and method == "InvokeServer" then
					if _G.Key == "" then
                    	_G.Key = args[2]
					end
                    return namecall(self,unpack(args))
                end
                return namecall(self,...)
            end)

        task.wait(3)
        ConsoleByp:Text("Information: Succes/Equip your pistol and shoot for player")
        repeat 
            print("Waiting")
            task.wait(0.5)
        until _G.Key ~= "" 
		ConsoleByp:Text("Information: Nil")
		StatusByp:Text("Status: Bypassed")

		KeyByp:Text("Key: " .. _G.Key)

        for i = 1, 5 do
            Notif:Notify("Sucessfully Bypassed/Kill-Aura Worked", 6, "succes")
        end
    else
        ConsoleByp:Text("Pistol Not Finded For Backpack")
    end
end

local Button1 = Tab4:NewButton("Start Bypass", function()
    Bypass()
end)




local FinishedLoading = Notif:Notify("Loaded Slovo-Picuna", 4, "success")
