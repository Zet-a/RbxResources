local zlib = {}
zlib.__Tools = {}
zlib.__Tools.camera = workspace.CurrentCamera
zlib.__Tools.RS = game:GetService("RunService")
zlib.__Tools.lp = game:GetService("Players").LocalPlayer
zlib.__Tools.plrs = game:GetService("Players")
zlib.CustomSupport = {
    ["Trident Survival"] = 9570110925,
}
zlib.CustomCharacter = nil
zlib.UsingLinoria = false
local character = nil
zlib.Variables = {}

if table.find(zlib.CustomSupport,game.PlaceId) then
    if game.PlaceId == 9570110925 then
        zlib.CustomCharacter = workspace.Ignore --.LocalCharacter
    end
end

task.spawn(function()
    if table.find(zlib.CustomSupport,game.PlaceId) then
        if game.PlaceId == 9570110925 then
            character = workspace.Ignore.LocalCharacter
        end
    end
end)

local function newdraw(t,table,snd)
    local txt = Drawing.new(t)
    if table and typeof(table) == "table" then
        for property,value in pairs(table) do
            if snd == "sensitive" then
               if property == Size or Thickness then

               else
                txt[property] = value
               end
            else
            txt[property] = value
            end
        end
    end
    return txt
end

function zlib:CreateVariable(name)
    [name] = {
        ["Toggle"] = false,
        ["HaveSlider"] = false,
        ["Slider"] = 0,
        ["Box"] = false,
        ["Title"] = false,
    } 
end

function zlib:box(obj,name,list,optional) -- Made by Throit, modified by Zeta
    if name ~= nil or name ~= "" then
        if zlib.Variables[name] then

        else
            zlib.Variables[name] = {
                ["Toggle"] = false,
                ["HaveSlider"] = false,
                ["Slider"] = 0,
                ["Box"] = false,
                ["Title"] = false,
            } 
            if optional and typeof(optional) == "table" then
               for i,v in pairs(optional) do
                  zlib.Variables[name][i] = v  
               end
            end
        end
    end
    local part = obj
    local ltable = {
        line1 = newdraw("Line",list),
        line2 = newdraw("Line",list),
        line3 = newdraw("Line",list),
        line4 = newdraw("Line",list),
        line5 = newdraw("Line",list),
        line6 = newdraw("Line",list),
        line7 = newdraw("Line",list),
        line8 = newdraw("Line",list),
        line9 = newdraw("Line",list),
        line10 = newdraw("Line",list),
        line11 = newdraw("Line",list),
        line12 = newdraw("Line",list)
    }
    local function Update()
        local run
        run = zlib.__Tools.RS.RenderStepped:Connect(function()
                if zlib.Variables[name].HaveSlider == true then
                    if character ~= nil then
                        if game.PlaceId == 9570110925 and character:FindFirstChild("Middle") then
                            if zlib.Variables[name].Slider >= (obj.Position - character.Middle.Position).magnitude then
                                
                            else
                                for i,v in pairs(ltable) do
                                    v.Visible = false
                                end
                                return
                            end
                        end
                    elseif zlib.__Tools.lp.Character and zlib.__Tools.lp.Character:FindFirstChild("HumanoidRootPart") and character == nil then
                        if zlib.Variables[name].Slider >= (obj.Position - zlib.__Tools.lp.Character:FindFirstChild("HumanoidRootPart").Position).magnitude then
                        else
                            for i,v in pairs(ltable) do 
                                v.Visible = false 
                            end 
                            return
                        end
                    end
                end
            if zlib.Variables[name].Toggle == true and zlib.Variables[name].Box == true then else for i,v in pairs(ltable) do v.Visible = false end return end
            local partpos, onscreen = zlib.__Tools.camera:WorldToViewportPoint(part.Position)
            if onscreen then
                local X = part.Size.X/2
                local Y = part.Size.Y/2
                local Z = part.Size.Z/2

                local Top1 = zlib.__Tools.camera:WorldToViewportPoint((part.CFrame * CFrame.new(-X,Y,-Z)).p)
                local Top2 = zlib.__Tools.camera:WorldToViewportPoint((part.CFrame * CFrame.new(-X,Y,Z)).p)
                local Top3 = zlib.__Tools.camera:WorldToViewportPoint((part.CFrame * CFrame.new(X,Y,Z)).p)
                local Top4 = zlib.__Tools.camera:WorldToViewportPoint((part.CFrame * CFrame.new(X,Y,-Z)).p)

                local Bottom1 = zlib.__Tools.camera:WorldToViewportPoint((part.CFrame * CFrame.new(-X,-Y,-Z)).p)
                local Bottom2 = zlib.__Tools.camera:WorldToViewportPoint((part.CFrame * CFrame.new(-X,-Y,Z)).p)
                local Bottom3 = zlib.__Tools.camera:WorldToViewportPoint((part.CFrame * CFrame.new(X,-Y,Z)).p)
                local Bottom4 = zlib.__Tools.camera:WorldToViewportPoint((part.CFrame * CFrame.new(X,-Y,-Z)).p)
                
                ltable.line1.From = Vector2.new(Top1.X, Top1.Y)
                ltable.line1.To = Vector2.new(Top2.X, Top2.Y)

                ltable.line2.From = Vector2.new(Top2.X, Top2.Y)
                ltable.line2.To = Vector2.new(Top3.X, Top3.Y)

                ltable.line3.From = Vector2.new(Top3.X, Top3.Y)
                ltable.line3.To = Vector2.new(Top4.X, Top4.Y)

                ltable.line4.From = Vector2.new(Top4.X, Top4.Y)
                ltable.line4.To = Vector2.new(Top1.X, Top1.Y)

                ltable.line5.From = Vector2.new(Bottom1.X, Bottom1.Y)
                ltable.line5.To = Vector2.new(Bottom2.X, Bottom2.Y)

                ltable.line6.From = Vector2.new(Bottom2.X, Bottom2.Y)
                ltable.line6.To = Vector2.new(Bottom3.X, Bottom3.Y)

                ltable.line7.From = Vector2.new(Bottom3.X, Bottom3.Y)
                ltable.line7.To = Vector2.new(Bottom4.X, Bottom4.Y)

                ltable.line8.From = Vector2.new(Bottom4.X, Bottom4.Y)
                ltable.line8.To = Vector2.new(Bottom1.X, Bottom1.Y)

                ltable.line9.From = Vector2.new(Bottom1.X, Bottom1.Y)
                ltable.line9.To = Vector2.new(Top1.X, Top1.Y)

                ltable.line10.From = Vector2.new(Bottom2.X, Bottom2.Y)
                ltable.line10.To = Vector2.new(Top2.X, Top2.Y)

                ltable.line11.From = Vector2.new(Bottom3.X, Bottom3.Y)
                ltable.line11.To = Vector2.new(Top3.X, Top3.Y)

                ltable.line12.From = Vector2.new(Bottom4.X, Bottom4.Y)
                ltable.line12.To = Vector2.new(Top4.X, Top4.Y)

                if autothick then
                    local distance
                    if character ~= nil then
                        if game.PlaceId == 9570110925 then
                            distance = (character:WaitForChild('Middle').Position - part.Position).magnitude
                        end
                    else
                        distance = (zlib.__Tools.lp.Character:WaitForChild('HumanoidRootPart').Position - part.Position).magnitude
                    end
                    local value = math.clamp(1/distance*100, 0.1, 4) --0.1 is min thickness, 6 is max
                    for u, x in pairs(ltable) do
                        x.Thickness = value
                    end
                else 
                    for u, x in pairs(ltable) do
                        x.Thickness = 1
                    end
                end

                for u, x in pairs(ltable) do
                    x.Visible = true
                end
            else
                for u, x in pairs(ltable) do
                    x.Visible = false
                end
            end
            if zlib.UsingLinoria then
                if Library.Unloaded then
                    run:Disconnect()
                    for k,v in pairs(ltable) do
                        v:Remove()
                    end
                end
            end
        end)
        obj.AncestryChanged:Connect(function()
            if not obj:IsDescendantOf(game) and ltable.line1 ~= nil then
                run:Disconnect()
                for k,v in pairs(ltable) do
                    v:Remove()
                end
            end
        end)
    end
    coroutine.wrap(Update)()
    return ltable
end

function zlib:text(obj,y,x,name,list,optional) -- made by me
    if name ~= nil or name ~= "" then
        if zlib.Variables[name] then

        else
            zlib.Variables[name] = {
                ["Toggle"] = false,
                ["HaveSlider"] = false,
                ["Slider"] = 0,
                ["Box"] = false,
                ["Title"] = false,
            } 
            if optional and typeof(optional) == "table" then
               for i,v in pairs(optional) do
                  zlib.Variables[name][i] = v  
               end
            end
        end
    end
    local txt = newdraw("Text",list)
    local function updater()
        local c
        c = zlib.__Tools.RS.RenderStepped:Connect(function()
            if zlib.Variables[name].HaveSlider == true then
                if character ~= nil then
                    if game.PlaceId == 9570110925 and character:FindFirstChild("Middle") then
                        if zlib.Variables[name].Slider >= (obj.Position - character.Middle.Position).magnitude then
                        else
                            txt.Visible = false
                            return
                        end
                    end
                elseif zlib.__Tools.lp.Character and zlib.__Tools.lp.Character:FindFirstChild("HumanoidRootPart") and character == nil then
                    if zlib.Variables[name].Slider >= (obj.Position - zlib.__Tools.lp.Character:FindFirstChild("HumanoidRootPart").Position).magnitude then
                    else
                        txt.Visible = false
                        return
                    end
                end
            end
            if zlib.Variables[name].Toggle == true and zlib.Variables[name].Title == true then else txt.Visible = false return end
            local partpos, onscreen = zlib.__Tools.camera:WorldToViewportPoint(obj.Position)
            if onscreen then
                txt.Visible = true
                txt.Position = Vector2.new(partpos.X + x,partpos.Y + y)
            else
                txt.Visible = false
            end
            if zlib.UsingLinoria then
                if Library.Unloaded then
                   c:Disconnect()
                   txt:Remove()
               end
           end
        end)
        obj.AncestryChanged:Connect(function()
            if not obj:IsDescendantOf(game) and txt ~= nil then
                c:Disconnect()
                txt:Remove()
            end
        end)
    end
    coroutine.wrap(updater)()
    return txt
end
return zlib
