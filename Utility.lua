local library = {}
getgenv().ChamContainers = {}

local rs = cloneref(game:GetService("RunService"))

function library:ChamsContainer(identifier: string, color: Color3, bool: boolean)
    local highlights = Workspace:FindFirstChild("Highlights")
    local container = nil
    if highlights then
        container = highlights:FindFirstChild(identifier)
        if container then
            return container
        else
            container = Instance.new("Model", highlights)
            ChamContainers[identifier] = container
        end
    else
        highlights = Instance.new("Folder",Workspace)
        container = Instance.new("Model", highlights)
        ChamContainers[identifier] = container
    end
    highlights.Name = "Highlights"
    container.Name = identifier
    if bool then
        Instance.new("Humanoid", container)
    end
    local highlight = Instance.new("Highlight")
    highlight.Adornee = container
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.97
    highlight.OutlineTransparency = 0.5
    highlight.Enabled = false
    highlight.Parent = container
    return container
end

function library:AddChams(identifier: string, part: BasePart | Model, color: Color3, prox: ProximityPrompt)
    local partClone = part:Clone()
    partClone.Parent = library:ChamsContainer(identifier, color)
    if partClone:IsA("BasePart") then
        if prox ~= nil then
            local cloneprox = partClone:FindFirstChildWhichIsA("ProximityPrompt",true)
            cloneprox.Triggered:Connect(function()
                fireproximityprompt(prox)
            end)
        end
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = part
        weld.Part1 = partClone
        partClone.Transparency = 0.99
        partClone.CanCollide = false
        partClone.Anchored = true
    end
    part.Destroying:Connect(function() partClone:Destroy() end)
end
return library
