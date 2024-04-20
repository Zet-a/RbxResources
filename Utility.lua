local library = {}
getgenv().ChamContainers = {}
function library:ChamsContainer(identifier: string, color: Color3)
    local highlights = Workspace:FindFirstChild("Highlights")
    local container
    if highlights then
        container = highlights:FindFirstChild(identifier)
        if container then
            return container
        else
            container = Instance.new("Model", highlights)
            table.insert(ChamContainers,unpack({identifier = container})
        end
    else
        highlights = Instance.new("Folder",Workspace)
        container = Instance.new("Model", highlights)
        ChamContainers[identifier] = container
    end
    highlights.Name = "Highlights"
    container.Name = identifier
    Instance.new("Humanoid", container)
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

function library:AddChams(identifier: string, part: BasePart | Model, color: Color3)
    local partClone = part:Clone()
    partClone.Parent = library:ChamsContainer(identifier, color)
    if partClone:IsA("BasePart") then
        partClone.Transparency = 0.99
        partClone.CanCollide = false
        partClone.Anchored = true
    end
    part.Destroying:Connect(function() partClone:Destroy() end)
end
return library
