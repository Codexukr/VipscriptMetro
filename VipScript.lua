local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

local input = loadstring(game:HttpGet('https://pastebin.com/raw/dYzQv3d8'))()

local Library = loadstring(Game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wizard"))()

local Home= Library:NewWindow("Combat")
local Option = Home:NewSection("Home")

local bypass= Library:NewWindow("Bypass")
local bypassOpt = bypass:NewSection("Home")


_G.Key = ""

_G.Farm = false
_G.Aura = false
_G.Block = false
_G.Stamina = false

local plr = game:GetService("Players").LocalPlayer

function Key()
    if _G.Key == "" then
        Notify("Warning!","Bypass Not Loaded!",3)
        return nil
    end
end

function Notify(Title,Desc,time)
    Notification:Notify(
        {Title = Title, Description = Desc},
        {OutlineColor = Color3.fromRGB(0, 153, 51),Time = time, Type = "default"}
    )
end

Notify("Hello niga","Im Fucked Skider",3)


function Alive()
	local character = plr.Character or plr.Character.Parent
	return character
end

local function ClosestPlayer(range)
	local char = plr.Character

	local maxdist = range
	local target

	for i,v in ipairs(game:GetService("Players"):GetChildren()) do
		if v.Name ~= plr.Name then
			local EChar = v.Character 

			if EChar then
				local ETorso = EChar:WaitForChild("Torso")
				local EHuman = EChar:WaitForChild("Humanoid")

				local distance = (char:WaitForChild("Torso").Position - ETorso.Position).Magnitude

				if ETorso and EHuman and EHuman.Health >= 1 and not EChar:FindFirstChild("ForceField") and plr.Team ~= v.Team and distance <= maxdist then
					target = v
				end
				
			end

		end
	end

	return target
end

function Aura(range)
    local EPlr = ClosestPlayer(range)

    if EPlr then
        local TPart = EPlr.Character:WaitForChild("Torso")
        local THuman = EPlr.Character:WaitForChild("Humanoid")
        plr.Backpack:WaitForChild("Кулаки").System.Events.Fists:FireServer("hi", _G.Key, TPart, THuman, "hi")
    end
end

function InfBlock()
    
    if plr.Backpack:FindFirstChild("Кулаки") then
        plr.Backpack:FindFirstChild("Кулаки").System.Events.Block:FireServer("niga", _G.Key, true, "niga")
    end

end

function InfStamina()
	local path = plr.PlayerGui.ScreenGui
	
	for i,v in pairs(path:GetChildren()) do
		if v.Name == "Stamina" and v.ClassName == "LocalScript" then
			local stamina = v
			
			stamina.Enabled = false
    		stamina.Enabled = true
		end
	end
end

local plr = game.Players.LocalPlayer

function FactoryFarm()
	local char = plr.Character

    local seller = workspace.map:WaitForChild("ikiSellerFactory").HumanoidRootPart
    local MetalSpawn = workspace.spawnable


    for i,v in ipairs(MetalSpawn:GetChildren()) do
        if v.ClassName == "UnionOperation" then
            local Metal = v
            local distance = (seller.Position - Metal.Position).Magnitude 
    
            if distance < 10 then
                --getting 
                if Metal then
                    char:FindFirstChild("HumanoidRootPart").CFrame = Metal.CFrame + Vector3.new(0,3,0)
                    fireproximityprompt(Metal:FindFirstChild("Attachment").ProximityPrompt,1,true)
                end

                --selling 
                if plr.Backpack:FindFirstChild("Ржавый металл") then
                    game:GetService("ReplicatedStorage").Events.Factory:FireServer("sell", "rust")
                end

            end
        end
    end

end

FactoryFarm()




--- UI FKFKFKF

Option:CreateToggle("Aura", function(value)
    if value then
        if Alive() then
            Key()

            _G.Aura = true
            while _G.Aura do
                Aura(12)
                task.wait(0.02)
            end
        end
    else
        _G.Aura = false
    end
end)

Option:CreateToggle("God", function(value)
    if value then
        if Alive() then
            Key()

            _G.Aura = true
            while _G.Aura do
                InfBlock()
                task.wait(1)
            end
        end
    else
        _G.Aura = false
    end
end)

Option:CreateToggle("Inf-Stamina", function(value)
    if value then
        if Alive() then
            _G.Stamina = true
            while _G.Stamina do
                InfStamina()
                task.wait(2.5)
            end
        end
    else
        _G.Stamina= false
    end
end)

Option:CreateToggle("Auto-Farm", function(value)
    if value then
        _G.Farm = true
        while _G.Farm do
            if Alive() then
                FactoryFarm()
                task.wait()
            end
        end
    else
        _G.Farm = false
    end
end)

--Adonis Bypass
loadstring(game:HttpGet("https://pastebin.com/raw/5Ti4Xkpp"))()


bypassOpt:CreateButton("Bypass", function()
    local char = plr.Character


    local namecall
    namecall = hookmetamethod(game,"__namecall",function(self,...)
        local args = {...}
        local method = getnamecallmethod()
        if tostring(self) == "Block" and method == "FireServer" then
            if _G.Key == "" then
                _G.Key = args[2]
            end
            return namecall(self,unpack(args))
        end
        return namecall(self,...)
    end)
    Notify("Bypass","Bypass Load...",2)
    task.wait(2)
    input.press(Enum.KeyCode.F)
    task.wait(1)
    if _G.Key == "" then
        Notify("Error/ Try Again",":(",5)
    end
    Notify("Key","Key:" .. _G.Key,3)
    Notify("Succes","Kill-Aura and God Working!!!",5)

end)


