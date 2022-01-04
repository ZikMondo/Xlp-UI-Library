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

		function category:Sector(SectorName)
			local sector = {}

			local uilistlayout_L
			local uilistlayout_R
			local uilistlayout
			local uipadding 

			local L
			local R 

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

                L = xlp:Create("Frame", {
					Name = "L",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(0, 422, 0, 355),
				})

				R = xlp:Create("Frame", {
					Name = "R",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(1, 0, 0, 0),
					Size = UDim2.new(0, 422, 0, 355),
				})

				uilistlayout_L = xlp:Create("UIListLayout", {
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = "Vertical",
				})

				uilistlayout_R = xlp:Create("UIListLayout", {
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = "Vertical",
				})

				uilistlayout = xlp:Create("UIListLayout", {
					Padding = UDim.new(0, 0),
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = "Horizontal",
				})
	
				uipadding = xlp:Create("UIPadding", {
					PaddingBottom = UDim.new(0, 5),
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
					PaddingTop = UDim.new(0, 5),
				})

                category.Button.MouseButton1Down:Connect(function()
                    category["Container_"]["UIPageLayout"]:JumpTo(sector.container)
                end)

				uilistlayout_L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					local LargestListSize = 0

					LargestListSize = uilistlayout_L.AbsoluteContentSize.Y

					if uilistlayout_R.AbsoluteContentSize.Y > LargestListSize then
						LargestListSize = uilistlayout_R.AbsoluteContentSize.Y
					end

					sector.container.CanvasSize = UDim2.new(0, 0, 0, LargestListSize + 5)
				end)

				uilistlayout_R:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					local LargestListSize = 0

					LargestListSize = uilistlayout_L.AbsoluteContentSize.Y

					if uilistlayout_R.AbsoluteContentSize.Y > LargestListSize then
						LargestListSize = uilistlayout_R.AbsoluteContentSize.Y
					end

					sector.container.CanvasSize = UDim2.new(0, 0, 0, LargestListSize + 5)
				end)
			end

			sector.frame = xlp:Create("Frame", {
				Name = SectorName,
				Parent = sector.container,
				BackgroundColor3 = Color3.fromRGB(39, 35, 34),
				Position = UDim2.new(0.00243469304, 0, 0.0201197304, 0),
				Size = UDim2.new(0, 420.5, 0, 290),
				AutomaticSize = "None",
			})

			local textlabel = xlp:Create("TextLabel", {
				Name = "SectorName",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.07, 0),
				Size = UDim2.new(0, 419, 0, 25),
				Font = Enum.Font.GothamBlack,
				Text = SectorName..":",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextScaled = true,
				TextSize = 18,
				TextWrapped = true,
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

			uicorner2.Parent = sector.frame
			uipadding2.Parent = sector.frame
			textlabel.Parent = sector.frame

			uilistlayout2.Parent = sector.frame

			uilistlayout2.Changed:Connect(function()
				pcall(function()
					sector.frame.Size = UDim2.new(0, 420.5, 0, uilistlayout2.AbsoluteContentSize.Y)
				end)
			end)

			if uilistlayout then
				L.Parent = sector.container
				R.Parent = sector.container
				uilistlayout_L.Parent = L
				uilistlayout_R.Parent = R
				uilistlayout.Parent = sector.container
				uipadding.Parent = sector.container
			end

			local function calculateSector()
				local R_ = #sector.container.R:GetChildren() - 1
				local L_ = #sector.container.L:GetChildren() - 1
	
				if L_ > R_ then
					return "R"
				else
					return "L"
				end
			end

			sector.container.Parent = category["Container_"]
			sector.frame.Parent = sector.container[calculateSector()]

			function sector:Button(Name, Func, Info)
				local Button = xlp:Create("Frame", {
					Name = "Button",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.319809079, 0, 0.547335744, 0),
					Size = UDim2.new(0, 300, 0, 30),
				})

				local TextButton = xlp:Create("TextButton", {
					BackgroundColor3 = Color3.fromRGB(25, 22, 29),
					BorderColor3 = Color3.fromRGB(91, 70, 119),
					Position = UDim2.new(0.0500000007, 0, 0.200000003, 0),
                    Size = UDim2.new(0, 182, 0, 38),
					Font = Enum.Font.GothamBold,
					Text = Info.Text or Info.text,			
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
				})

				local TextLabel = xlp:Create("TextLabel", {
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 1,
					Position = UDim2.new(0.75, 0, 0.200000003, 0),
					Size = UDim2.new(0, 185, 0, 35),
					Font = Enum.Font.GothamBold,
					Text = Name or "",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Left,
				})

				local UIStroke = xlp:Create("UIStroke", {
					ApplyStrokeMode = "Border",
					Color = Color3.fromRGB(91, 70, 119),
					Thickness = 1.5,
				})

				local UICorner = xlp:Create("UICorner", {
					CornerRadius = UDim.new(0, 5),
				})

				Button.Parent = sector.frame
				TextButton.Parent = Button
				TextLabel.Parent = Button

				UICorner.Parent = TextButton
				UIStroke.Parent = TextButton

				TextButton.MouseButton1Click:Connect(Func)
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