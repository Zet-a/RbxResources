local zlib = {}
zlib.__Tools = {}
zlib.__Tools.camera = workspace.CurrentCamera
zlib.__Tools.RS = game:GetService("RunService")
zlib.__Tools.lp = game:GetService("Players").LocalPlayer
zlib.__Tools.plrs = game:GetService("Players")
getgenv().__Variables = {}
getgenv().Drawings = {}

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

function zlib:box(obj,name,list) -- Made by Throit
    if name == nil or "" then
    
    else
        if table.find(__Variables, name) then
        
        else
            getgenv().__Variables[name] = false
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
            if __Variables[name] == true then else for i,v in pairs(ltable) do v.Visible = false end return end
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
                    local distance = (zlib.__Tools.lp.Character:WaitForChild('HumanoidRootPart').Position - part.Position).magnitude
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
        end)
        obj.AncestryChanged:Connect(function()
            if not obj:IsDescendantOf(game) then
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

function zlib:text(obj,y,x,name,list) -- made by me
    if name == nil or "" then
    
    else
        if table.find(__Variables, name) then
        
        else
            __Variables[name] = false
        end
    end

    local txt = newdraw("Text",list)
    table.insert(Drawings,txt)
    local function updater()
        local c
        c = zlib.__Tools.RS.RenderStepped:Connect(function()
            if txt == nil then
               c:Disconnect()     
            end
            if __Variables[name] == true then else txt.Visible = false return end
            local partpos, onscreen = zlib.__Tools.camera:WorldToViewportPoint(obj.Position)
            if onscreen then
                txt.Visible = true
                txt.Position = Vector2.new(partpos.X + x,partpos.Y + y) -- x = offset y = idfk
            else
                txt.Visible = false
            end
        end)
        obj.AncestryChanged:Connect(function()
            if not obj:IsDescendantOf(game) then
                c:Disconnect()
                txt:Remove()
            end
        end)
    end
    coroutine.wrap(updater)()
    return txt
end
return zlib
