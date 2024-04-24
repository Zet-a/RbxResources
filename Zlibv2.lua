local zlib = {
    Enabled = true,
    UsingLinoria = nil,
    Tools = {},
    Objects = setmetatable({},{__mode="kv"}),
    Overrides = {},
    BoxSize = Vector3.new(4,6,0),

}
local rs = cloneref(game:GetService("RunService"))
local plrs = cloneref(game:GetService("Players"))
local camera = workspace.CurrentCamera
local lp = plrs.LocalPlayer
local wtvp = camera.WorldToViewportPoint

local function draw(name: string,list: table)
    local obj = Drawing.new(name)
    for property, value in pairs(list) do
        obj[property] = value
    end
    return obj
end

function zlib:GetBodyParts(char)
    local bparts = {
        "Head",
        "Torso",
        "HumanoidRootPart",
        "Left Arm",
        "Right Arm",
        "Right Leg",
        "Left Leg",
        "UpperTorso",
        "LowerTorso",
        "LeftUpperArm",
        "LeftLowerArm",
        "LeftHand",
        "RightUpperArm",
        "RightLowerArm",
        "RightHand",
        "LeftUpperLeg",
        "LeftLowerLeg",
        "LeftFoot",
        "RightUpperLeg",
        "RightLowerLeg",
        "RightFoot",

    }
    local parts = {}
    for i,v in pairs(char:GetChildren()) do
        if table.find(bparts,v.Name) then
            table.insert(parts,v)
        end
    end
    return parts
end

function zlib:GetTeam(plr)
    local ov = self.Overrides.GetTeam
    if ov then
        return ov(plr)
    end
    return plr and plr.Team
end

function zlib:IsTeamMate(plr)
    local ov = self.Overrides.IsTeamMate
    if ov then
        return ov(plr)
    end
    return self:GetTeam(plr) == self:GetTeam(lp)
end

function zlib:GetPlrFromChar(char)
    local ov = self.Overrides.GetPlrFromChar
    if ov then
        return ov(char)
    end
    return plrs:GetPlayerFromCharacter(char)
end

function zlib:Toggle(bool)
    self.Enabled = bool
    if not bool then
        for i,v in pairs(self.Objects) do
            if v.Temporary then
                v:Remove()
            else
                for i,v in pairs(v.Components) do
                    v.Visible = false
                end
            end
        end
    end
end

function zlib:GetBox(obj)
    return self.Objects[obj]
end

local base = {}
base.__index = base

function base:Remove()
    zlib.Objects[self.Object] = nil
    for i,v in pairs(self.Components) do
        v.Visible = false
        v:Remove()
        self.Components[i] = nil
    end
end

function base:Update()
    if not self.PrimaryPart then
        return self:Remove()
    end
    local color

    local allow = true
    if zlib.Overrides.UpdateAllow and not zlib.Overrides.UpdateAllow(self) then
        allow = false
    end
    if self.Type == "Humanoid" and self.Player ~= nil then
        if self.Player and not zlib.Players then
            allow = false
        end
        if self.Player and not zlib.TeamMates and zlib:IsTeamMate(self.Player) then
            allow = false
        end
    end
    if self.IsEnabled and (type(self.IsEnabled) == "string" and not zlib[self.IsEnabled] or type(self.IsEnabled) == "function" and not self:IsEnabled()) then
        allow = false
    end 
    if not workspace:IsAncestorOf(self.PrimaryPart) and not self.RenderInNil then
        allow = false
    end

    if not allow then
        for i,v in pairs(self.Components) do
            v.Visible = false
        end
        return
    end

    if zlib.Highlighted == self.Object then
        color = zlib.HighlightColor
    end

    local cf,size
    
    if self.Object:IsA("BasePart") then
        cf,size = self.Object.CFrame, self.Size
    end

    if zlib.DynamicScaling then
        local bodyparts = zlib:GetBodyParts(self.Object)

        cf,size = workspace:GetBoundingBox(bodyparts, camera.CFrame)
    end
    
    local locs = {
        TagPos = cf * CFrame.new(0,size.Y/2,0),
    }

    if self.Type == "Text" then
        local Tagpos, vis = wtvp(camera, locs.TagPos.Position)

        if vis then
            self.Components.Text.Visible = true
            self.Components.Text.Position = Vector2.new(Tagpos.X,Tagpos.Y + self.Offset)
            self.Components.Text.Text = self.Name
            self.Components.Text.Color = color
        else
            self.Components.Text.Visible = false
        end
    end

end

function zlib:CreateText(obj: BasePart,options: table)
    local tab = setmetatable({
        Name = options.Name or obj.Name,
        Type = "Text",
        Color = options.Color,
        Size = options.size or self.BoxSize,
        Object = obj,
        PrimaryPart = options.PrimaryPart or obj.ClassName == "Model" and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or obj:IsA("BasePart") and obj,
        Components = {},
        IsEnabled = options.IsEnabled,
        Temporary = options.Temporary,
        ColorDynamic = options.ColorDynamic,
        RenderInNil = options.RenderInNil
    }, base)
    tab.Components["Text"] = draw("Text",{
        Text = tab.Name,
        Color = tab.Color,
        Center = true,
        Outline = true,
        Size = 18,
        Visible = self.Enabled
    })

    self.Objects[obj] = tab

    obj.AncestryChanged:Connect(function(_, parent)
        if parent == nil then
            tab:Remove()
        end
    end)
    obj:GetPropertyChangedSignal("Parent"):Connect(function()
        if obj.Parent == nil then
            tab:Remove()
        end
    end)

    local hum = obj:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.Died:Connect(function()
            tab:Remove()
        end)
    end

    return tab
end
function zlib:CreateQuad(obj: BasePart | Model)
    
end



rs.RenderStepped:Connect(function()
    for i,v in (zlib.Enabled and pairs or ipairs)(zlib.Objects) do
        if v.Update then
            local s,e = pcall(v.Update, v)
        end
    end
end)

return zlib
