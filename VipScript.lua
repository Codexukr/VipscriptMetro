local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()



function Notify(Title,Desc,time)
    Notification:Notify(
        {Title = Title, Description = Desc},
        {OutlineColor = Color3.fromRGB(0, 153, 51),Time = time, Type = "default"}
    )
end

Notify("Hello niga","Script Fixed / data update: nikogda",3)


