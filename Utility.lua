local library = {}
function library:ChamsContainer(identifier: string, color: Color3)
    local container = Workspace:FindFirstChild(identifier)
    if container then
        return container
    else
        container = Instance.new("Model", Workspace)
    end
    container.Name = identifier
    Instance.new("Humanoid", container)
    local highlight = Instance.new("Highlight")
    highlight.Adornee = container
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = color
    highlight.OutlineColor = color
    highlight.FillTransparency = 0.97
    highlight.OutlineTransparency = 0.5
    highlight.Enabled = true
    highlight.Parent = container
    return container
end

function library:AddChams(identifier: string, part: BasePart | Model, color: Color3)
    local partClone = part:Clone()
    partClone.Parent = highlightContainer(identifier, color)
    if partClone:IsA("BasePart") then
        partClone.Transparency = 0.99
        partClone.CanCollide = false
    end
    part.Destroying:Connect(function() partClone:Destroy() end)
end
return library
