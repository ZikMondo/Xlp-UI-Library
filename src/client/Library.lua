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
		if prop ~= "Parent" then
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
	local savedposition = UDim2.new(0.5, 0, 0.1, 0)

	local ProjectString

	if not xlp.gs["RunService"]:IsStudio() and self.gs["CoreGui"]:FindFirstChild(ProjectName) then
		warn("xlp:", "instance already exists in coregui!")	
		return
	end

	xlpData = {
		UpConnection = nil,
		ToggleKey = Enum.KeyCode.J,
	}

	if not ProjectName then
		ProjectString = "Press '".. string.sub(tostring(xlpData.ToggleKey), 14) .."' to hide this menu"
	else
		ProjectString = ProjectName
	end

	xlpObject.ChangeToggleKey = function(NewKey)
		xlpData.ToggleKey = NewKey

		if xlpData.UpConnection then
			xlpData.UpConnection:Disconnect()
		end

		xlpData.UpConnection = xlp.gs["UserInputService"].InputEnded:Connect(function(Input)
			if Input.KeyCode == xlpData.ToggleKey and not typing then
				toggled = not toggled

				pcall(function() xlpObject.modaModal = toggled end)

				if toggled then
					pcall(xlpObject.Body.TweenPosition, xlpObject.Body, savedposition, "Out", "Sine", 0.5, true)
				else
					savedposition = xlpObject.Body.Position
					pcall(xlpObject.Body.TweenPosition, xlpObject.Body, UDim2.new(savedposition.X.Scale, 0, 1, 0), "Out", "Sine", 0.5, true)
				end
			end
		end)
	end

	xlpData.UpConnection = xlp.gs["UserInputService"].InputEnded:Connect(function(Input)
		if Input.KeyCode == xlpData.ToggleKey and not typing then
			toggled = not toggled

			if toggled then
				xlpObject.Body:TweenPosition(savedposition, "Out", "Sine", 0.5, true)
			else
				savedposition = xlpObject.Body.Position
				xlpObject.Body:TweenPosition(UDim2.new(savedposition.X.Scale, 0, 1, 0), "Out", "Sine", 0.5, true)
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
		Draggable = true,
		Active = true,
		BackgroundColor3 = Color3.fromRGB(31, 27, 27),
		BorderColor3 = Color3.fromRGB(38, 34, 33),
		BorderSizePixel = 0,
		Position = UDim2.new(0.1, 0, 0.1, 0),
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
		Image = "rbxassetid://8451147547",
	})

	xlpObject.Title = self:Create("TextLabel", {
		Name = "Title",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.0646298453, 0, 0.0882352963, 0),
		Size = UDim2.new(0, 745, 0, 28),
		Font = Enum.Font.GothamBold,
		Text = ProjectString,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextScaled = true,
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
	})

	xlpObject.vTitle = self:Create("TextLabel", {
		Name = "vTitle",
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

	xlpObject.UIPage = xlp:Create("UIPageLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		EasingDirection = Enum.EasingDirection.InOut,
		EasingStyle = Enum.EasingStyle.Sine,
		TweenTime = 0.8,
	})

	function xlpObject:Category(name)
		local category = {}



		category["Button"] = xlp:Create("TextButton", {
			Name = "Button",
			Parent = game.TestService.xlpUI.Body.List,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 101, 0, 33),
			Font = Enum.Font.Highway,
			Text = name,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 24,
			TextWrapped = true,
            AutoButtonColor = false,
		})

		category.Button.Parent = xlpObject.List 

        category.Button.MouseEnter:Connect(function()
			xlp.gs["TweenService"]:Create(category.Button, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
		end)

		category.Button.MouseLeave:Connect(function()
			xlp.gs["TweenService"]:Create(category.Button, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		end)

		category.Button.MouseButton1Up:Connect(function()
			xlp.gs["TweenService"]:Create(category.Button, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
		end)

		category.Button.MouseButton1Down:Connect(function()
			--[[ category["Container_"]["UIPageLayout"]:JumpTo(sector.container) ]]
		end)
		
		function category:Sector(SectorName)
			local sector = {}

			function sector:Button(Name, Func, Info)
				
			end

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