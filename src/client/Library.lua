local xlp = {}
xlp.gs = {}

setmetatable(xlp.gs, {
	__index = function(_, service)
		return game:GetService(service)
	end,
	__newindex = function(t, i)
		t[i] = nil
		return
	end
})

function xlp:Create(class, properties)
	local object = Instance.new(class)

	for prop, val in next, properties do
		if object[prop] and prop ~= "Parent" then
			object[prop] = val
		end
	end

	return object
end

function xlp.new(ProjectName)
    local xlpData
    local xlpObject = {}
    local self = xlp

    local toggled = true
	local typing = false
    local savedposition = UDim2.new(0.5, 0, 0.5, 0)

	if not xlp.gs["RunService"]:IsStudio() and self.gs["CoreGui"]:FindFirstChild(cachename) then
		warn("xlp:", "instance already exists in coregui!")	
		return
	end

	xlpData = {
		UpConnection = nil,
		ToggleKey = Enum.KeyCode.Home,
	}

    xlpObject.ChangeToggleKey = function(NewKey)
		xlpData.ToggleKey = NewKey
		
		if not ProjectName then
			xlpObject.tip.Text = "Press '".. string.sub(tostring(NewKey), 14) .."' to hide this menu"
		end
		
		if xlpData.UpConnection then
			xlpData.UpConnection:Disconnect()
		end

		xlpData.UpConnection = xlp.gs["UserInputService"].InputEnded:Connect(function(Input)
			if Input.KeyCode == xlpData.ToggleKey and not typing then
                toggled = not toggled

                pcall(function() xlpObject.modal.Modal = toggled end)

                if toggled then
					pcall(xlpObject.container.TweenPosition, xlpObject.container, savedposition, "Out", "Sine", 0.5, true)
                else
                    savedposition = xlpObject.container.Position;
					pcall(xlpObject.container.TweenPosition, xlpObject.container, UDim2.new(savedposition.Width.Scale, savedposition.Width.Offset, 1.5, 0), "Out", "Sine", 0.5, true)
				end
			end
		end)
	end

    xlpData.UpConnection = xlp.gs["UserInputService"].InputEnded:Connect(function(Input)
		if Input.KeyCode == xlpData.ToggleKey and not typing then
			toggled = not toggled

			if toggled then
				xlpObject.container:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), "Out", "Sine", 0.5, true)
			else
				xlpObject.container:TweenPosition(UDim2.new(0.5, 0, 1.5, 0), "Out", "Sine", 0.5, true)
			end
		end
	end)

    xlpObject.ClientUI = self:Create("ScreenGui", {
		Name = ProjectName,
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		ResetOnSpawn = false,
	})

    xlpObject.Corner = self:Create("UICorner", {
		Name = "Corners",
	})

    xlpObject.Body = self:Create("Frame", {
		Name = "UIScreen",
        BackgroundColor3 = Color3.fromRGB(31, 27, 27),
        BorderColor3 = Color3.fromRGB(38, 34, 33),
        BorderSizePixel = 0,
        Position = UDim2.new(0.168461531, 0, 0.119018406, 0),
        Size = UDim2.new(0, 871, 0, 471),
	})

    xlpObject.Header = self:Create("Frame", {
        Name = "Header",
        BackgroundColor3 = Color3.fromRGB(17, 16, 15),
        BorderColor3 = Color3.fromRGB(17, 16, 15),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 9, 0, 13),
        Size = UDim2.new(0, 851, 0, 34),
	})

    xlpObject.TitleLabel = self:Create("ImageLabel", {
        Name = "TitleLabel",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.008225617, 0, 0, 0),
        Size = UDim2.new(0, 34, 0, 34),
        Image = "rbxassetid://7138214030",
	})

    xlpObject.Title = self:Create("TextLabel", {
        Name = "Title",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.0646298453, 0, 0.0882352963, 0),
        Size = UDim2.new(0, 187, 0, 28),
        Font = Enum.Font.GothamBold,
        Text = ProjectName,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
        TextSize = 14,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
	})

    xlpObject.vTitle = self:Create("TextLabel", {
        Name = "vTitle",
        Parent = Header,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1.000,
        Position = UDim2.new(0.768507659, 0, 0.0882352963, 0),
        Size = UDim2.new(0, 187, 0, 28),
        Font = Enum.Font.GothamBold,
        Text = "v1.0.0",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14.000,
        TextTransparency = 0.900,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Right,
	})

    xlpObject.Corner2 = self:Create("UICorner", {
        Name = "Corners",
        CornerRadius = UDim.new(0, 5),
	})

    xlpObject.List = self:Create("Frame", {	
        Name = "List",
        BackgroundColor3 = Color3.fromRGB(17, 16, 15),
        BorderColor3 = Color3.fromRGB(17, 16, 15),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 9, 0, 423),
        Size = UDim2.new(0, 851, 0, 33),
	})

    xlpObject.UIList = self:Create("UIListLayout", {	
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0.005, 0),
	})

    xlpObject.Container_ = xlp:Create("Frame", {
        Name = "Container_",
        BackgroundColor3 = Color3.fromRGB(17, 16, 15),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0.0109999999, 0, 0.119000003, 0),
        Size = UDim2.new(0, 851, 0, 360),
    })

    xlpObject.UIPage = xlp:Create("UIPageLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        EasingDirection = Enum.EasingDirection.InOut,
        EasingStyle = Enum.EasingStyle.Sine,
        TweenTime = 0.8,
    })

    function xlpObject:Category(name)
		local category = {}
		
        category["Container_"] = xlpObject.Container_

        local function calculateSector(Sector)
			local Num = category.Container_:FindFirstChild(Sector)

            if Num then
                return 2
            else
                return 1
            end
		end

        function category:Sector(SectorName)
			local sector = {}

            if category["Container_"]:FindFirstChild(name) then
                sector.container = category["Container_"]:FindFirstChild(name)
            else
                sector.container = xlp:Create("ScrollingFrame", {
                    Name = name,
                    Active = true,
                    BackgroundColor3 = Color3.fromRGB(17, 16, 15),
                    BorderColor3 = Color3.fromRGB(17, 16, 15),
                    BorderSizePixel = 0,
                    ClipsDescendants = true,
                    Position = UDim2.new(0, 0, -0.003, 0),
                    Size = UDim2.new(0, 853, 0, 360),
                    SizeConstraint = Enum.SizeConstraint.RelativeYY,
                    ScrollingDirection = "Y",
                    CanvasSize = UDim2.new(1, 0, 0, 999),
                    ScrollBarThickness = 8,
                })
            end

            sector.frame = xlp:Create("Frame", {
				Name = SectorName,
                LayoutOrder = calculateSector(name),
                Parent = sector.container,
                BackgroundColor3 = Color3.fromRGB(39, 35, 34),
                Position = UDim2.new(0.00243469304, 0, 0.0201197304, 0),
                Size = UDim2.new(0, 410, 0, 290),
			})
            
            local textlabel = xlp:Create("TextLabel", {
                Name = "SectorName",
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Position = UDim2.new(0.5, 0, 0.07, 0),
                Size = UDim2.new(0, 110, 0, 25),
                Font = Enum.Font.GothamBlack,
                Text = SectorName..":",
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextScaled = true,
                TextSize = 18,
                TextWrapped = true,
            })

            local uilistlayout = xlp:Create("UIListLayout", {
                Parent = sector.container,
                Padding = UDim.new(0, 20),
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = "Horizontal",
            })
        
            local uipadding = xlp:Create("UIPadding", {
                Parent = sector.container,
                PaddingBottom = UDim.new(0, 5),
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5),
                PaddingTop = UDim.new(0, 5),
            })

            local uicorner2 = xlp:Create("UICorner", {
                CornerRadius = UDim.new(0, 5),
			})

            local uilistlayout2 = xlp:Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0.03, 0),
			})

            local uipadding2 = xlp:Create("UIPadding", {
                PaddingBottom = UDim.new(0, 5),
                PaddingTop = UDim.new(0, 5),
			})

            if sector.frame.LayoutOrder == 1 then
                uilistlayout.Parent = sector.container
                uipadding.Parent = sector.container
            end

            uicorner2.Parent = sector.frame
            uipadding2.Parent = sector.frame
            textlabel.Parent = sector.frame

            uilistlayout2.Parent = sector.frame
			uilistlayout2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                local largestListSize = 0
            
                largestListSize = uilistlayout2.AbsoluteContentSize.Y
            
                sector.container.CanvasSize = UDim2.new(0, 0, 0, largestListSize + 10)
                sector.frame.Size = UDim2.new(0, 410, 0, largestListSize + 5)
            end)

            sector.container.Parent = category["Container_"]
            sector.frame.Parent = sector.container

            return sector
        end

        return category
    end

    if not xlp.gs["RunService"]:IsStudio() then
		xlpObject.ClientUI.Parent = self.gs["CoreGui"]
	else
		xlpObject.ClientUI.Parent = self.gs["Players"].LocalPlayer:WaitForChild("PlayerGui")
	end

    xlpObject.Body.Parent = xlpObject.ClientUI
    xlpObject.Corner.Parent = xlpObject.Body

    xlpObject.Container_.Parent = xlpObject.Body
    xlpObject.UIPage.Parent = xlpObject.Container_

    xlpObject.Header.Parent = xlpObject.Body
    xlpObject.TitleLabel.Parent = xlpObject.Header
    xlpObject.Title.Parent = xlpObject.Header
    xlpObject.vTitle.Parent = xlpObject.Header
    xlpObject.Corner2:Clone().Parent = xlpObject.Header

    xlpObject.List.Parent = xlpObject.Body
    xlpObject.Corner2.Parent = xlpObject.List
    xlpObject.UIList.Parent = xlpObject.List

    return xlpObject, xlpData
end

return xlp