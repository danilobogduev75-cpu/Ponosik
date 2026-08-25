-- ==========================================
-- НАСТРОЙКА КЛЮЧА И НАЗВАНИЯ
local SECRET_KEY = "Zolo"
-- ==========================================

task.spawn(function()
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local Lighting = game:GetService("Lighting")
	local LocalPlayer = Players.LocalPlayer

	local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
	if not playerGui then return end

	if playerGui:FindFirstChild("SanDiegoCheatHub") then
		playerGui.SanDiegoCheatHub:Destroy()
	end

	-- ScreenGui
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "SanDiegoCheatHub"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.Parent = playerGui

	-- Функция для плавного RGB эффекта
	local function applyRGB(stroke)
		task.spawn(function()
			local hue = 0
			while stroke and stroke.Parent do
				hue = (hue + 0.005) % 1
				stroke.Color = Color3.fromHSV(hue, 1, 1)
				RunService.RenderStepped:Wait()
			end
		end)
	end

	-- Функция для интро (Welcome)
	local function playWelcomeIntro()
		local blur = Instance.new("BlurEffect")
		blur.Size = 24
		blur.Parent = Lighting

		local introGui = Instance.new("ScreenGui")
		introGui.Name = "WelcomeIntro"
		introGui.IgnoreGuiInset = true
		introGui.Parent = playerGui

		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, 0, 1, 0)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "Welcome"
		textLabel.Font = Enum.Font.FredokaOne
		textLabel.TextSize = 60
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextStrokeTransparency = 0
		textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.Parent = introGui

		task.spawn(function()
			local startTime = tick()
			local duration = 5.0

			while tick() - startTime < duration do
				local t = (tick() - startTime) * 3
				local r = math.abs(math.sin(t))
				textLabel.TextStrokeColor3 = Color3.fromRGB(r * 50, r * 50, r * 50)
				RunService.RenderStepped:Wait()
			end

			local fadeDuration = 1.0
			local fadeStart = tick()
			while tick() - fadeStart < fadeDuration do
				local alpha = (tick() - fadeStart) / fadeDuration
				textLabel.TextTransparency = alpha
				textLabel.TextStrokeTransparency = alpha
				blur.Size = 24 * (1 - alpha)
				RunService.RenderStepped:Wait()
			end

			introGui:Destroy()
			blur:Destroy()
		end)
	end

	-- Окно ввода ключа (Key System)
	local keyFrame = Instance.new("Frame")
	keyFrame.Size = UDim2.new(0, 300, 0, 160)
	keyFrame.Position = UDim2.new(0.5, -150, 0.5, -80)
	keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	keyFrame.BorderSizePixel = 0
	keyFrame.Active = true
	keyFrame.Draggable = true
	keyFrame.Parent = screenGui
	
	Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)
	local keyStroke = Instance.new("UIStroke", keyFrame, {Thickness = 2})
	applyRGB(keyStroke)

	local keyTitle = Instance.new("TextLabel")
	keyTitle.Size = UDim2.new(1, 0, 0, 40)
	keyTitle.Position = UDim2.new(0, 0, 0, 5)
	keyTitle.BackgroundTransparency = 1
	keyTitle.Text = "🔑 Enter Access Key"
	keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyTitle.Font = Enum.Font.GothamBold
	keyTitle.TextSize = 14
	keyTitle.Parent = keyFrame

	local keyBox = Instance.new("TextBox")
	keyBox.Size = UDim2.new(1, -40, 0, 40)
	keyBox.Position = UDim2.new(0, 20, 0, 50)
	keyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	keyBox.Text = ""
	keyBox.PlaceholderText = "Enter key..."
	keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
	keyBox.Font = Enum.Font.Gotham
	keyBox.TextSize = 13
	keyBox.Parent = keyFrame
	
	Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

	local submitBtn = Instance.new("TextButton")
	submitBtn.Size = UDim2.new(1, -40, 0, 35)
	submitBtn.Position = UDim2.new(0, 20, 0, 105)
	submitBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
	submitBtn.Text = "Confirm"
	submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	submitBtn.Font = Enum.Font.GothamBold
	submitBtn.TextSize = 13
	submitBtn.Parent = keyFrame
	
	Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 8)

	-- Главное меню (с иконкой черепа 💀)
	local iconBtn = Instance.new("TextButton")
	iconBtn.Size = UDim2.new(0, 50, 0, 50)
	iconBtn.Position = UDim2.new(0, 30, 0, 100)
	iconBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	iconBtn.Text = "💀"
	iconBtn.TextSize = 26
	iconBtn.Active = true
	iconBtn.Draggable = true
	iconBtn.Visible = false
	iconBtn.Parent = screenGui
	
	Instance.new("UICorner", iconBtn).CornerRadius = UDim.new(1, 0)
	local iconStroke = Instance.new("UIStroke", iconBtn, {Thickness = 2})
	applyRGB(iconStroke)

	-- Главная панель
	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 280, 0, 335)
	mainFrame.Position = UDim2.new(0.5, -140, 0.5, -167)
	mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	mainFrame.BorderSizePixel = 0
	mainFrame.Active = true
	mainFrame.Draggable = true
	mainFrame.Visible = false
	mainFrame.Parent = screenGui
	
	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)
	local mainStroke = Instance.new("UIStroke", mainFrame, {Thickness = 2})
	applyRGB(mainStroke)

	-- Панель More (Дополнительное меню для ESP)
	local moreFrame = Instance.new("Frame")
	moreFrame.Size = UDim2.new(0, 280, 0, 250)
	moreFrame.Position = UDim2.new(0.5, 150, 0.5, -167)
	moreFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	moreFrame.BorderSizePixel = 0
	moreFrame.Active = true
	moreFrame.Draggable = true
	moreFrame.Visible = false
	moreFrame.Parent = screenGui
	
	Instance.new("UICorner", moreFrame).CornerRadius = UDim.new(0, 12)
	local moreStroke = Instance.new("UIStroke", moreFrame, {Thickness = 2})
	applyRGB(moreStroke)

	-- Проверка ключа
	submitBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if keyBox.Text == SECRET_KEY then
				keyFrame:Destroy()
				playWelcomeIntro()
				iconBtn.Visible = true
				mainFrame.Visible = true
			else
				keyBox.Text = ""
				keyBox.PlaceholderText = "Wrong key!"
			end
		end
	end)

	iconBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			mainFrame.Visible = not mainFrame.Visible
			if not mainFrame.Visible then
				moreFrame.Visible = false
			end
		end
	end)

	-- Заголовок главного меню
	local titleLabel = Instance.new("TextLabel", mainFrame)
	titleLabel.Size = UDim2.new(1, 0, 0, 35)
	titleLabel.Position = UDim2.new(0, 0, 0, 5)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "⭐ San Diego Cheat ⭐"
	titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 13
	titleLabel.ZIndex = 2

	-- Кнопка Safe Fly
	local flyBtn = Instance.new("TextButton", mainFrame)
	flyBtn.Size = UDim2.new(1, -20, 0, 38)
	flyBtn.Position = UDim2.new(0, 10, 0, 42)
	flyBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
	flyBtn.Text = "Safe Fly (F): [OFF]"
	flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	flyBtn.Font = Enum.Font.GothamBold
	flyBtn.TextSize = 13
	flyBtn.ZIndex = 2
	Instance.new("UICorner", flyBtn).CornerRadius = UDim.new(0, 8)

	-- Функция применения коллизии без дергания (срабатывает при клике)
	local collisionActive = false
	local collisionBtn = Instance.new("TextButton", mainFrame)
	collisionBtn.Size = UDim2.new(1, -20, 0, 35)
	collisionBtn.Position = UDim2.new(0, 10, 0, 85)
	collisionBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
	collisionBtn.Text = "Collision: [OFF]"
	collisionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	collisionBtn.Font = Enum.Font.GothamBold
	collisionBtn.TextSize = 11
	collisionBtn.ZIndex = 2
	Instance.new("UICorner", collisionBtn).CornerRadius = UDim.new(0, 8)

	local function updateCollision(state)
		local char = LocalPlayer.Character
		if char then
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			local vehicleModel = nil

			if humanoid and humanoid.SeatPart and humanoid.SeatPart.Parent then
				if humanoid.SeatPart.Parent:IsA("Model") then
					vehicleModel = humanoid.SeatPart.Parent
				end
			end

			if state then
				-- ВКЛ (сквозь стены)
				if vehicleModel then
					for _, part in ipairs(vehicleModel:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
				else
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = false end
					end
				end
			else
				-- ВЫКЛ (обычный режим)
				if vehicleModel then
					for _, part in ipairs(vehicleModel:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = true end
					end
				else
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then part.CanCollide = true end
					end
				end
			end
		end
	end

	collisionBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			collisionActive = not collisionActive
			if collisionActive then
				collisionBtn.Text = "Collision: [ON]"
				collisionBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
			else
				collisionBtn.Text = "Collision: [OFF]"
				collisionBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
			end
			updateCollision(collisionActive)
		end
	end)

	-- Настройка скорости (Speed)
	local currentSpeed = 50

	local speedLabel = Instance.new("TextLabel", mainFrame)
	speedLabel.Size = UDim2.new(1, -20, 0, 20)
	speedLabel.Position = UDim2.new(0, 10, 0, 125)
	speedLabel.BackgroundTransparency = 1
	speedLabel.Text = "Speed: 50 (max 1000)"
	speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedLabel.Font = Enum.Font.GothamBold
	speedLabel.TextSize = 11
	speedLabel.TextXAlignment = Enum.TextXAlignment.Left
	speedLabel.ZIndex = 2

	local speedMinus = Instance.new("TextButton", mainFrame)
	speedMinus.Size = UDim2.new(0, 120, 0, 28)
	speedMinus.Position = UDim2.new(0, 10, 0, 148)
	speedMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	speedMinus.Text = "- 50"
	speedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedMinus.Font = Enum.Font.GothamBold
	speedMinus.TextSize = 11
	speedMinus.ZIndex = 2
	Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 6)

	local speedPlus = Instance.new("TextButton", mainFrame)
	speedPlus.Size = UDim2.new(0, 120, 0, 28)
	speedPlus.Position = UDim2.new(0, 150, 0, 148)
	speedPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	speedPlus.Text = "+ 50"
	speedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedPlus.Font = Enum.Font.GothamBold
	speedPlus.TextSize = 11
	speedPlus.ZIndex = 2
	Instance.new("UICorner", speedPlus).CornerRadius = UDim.new(0, 6)

	speedMinus.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			currentSpeed = math.clamp(currentSpeed - 50, 0, 1000)
			speedLabel.Text = "Speed: " .. currentSpeed .. " (max 1000)"
		end
	end)

	speedPlus.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			currentSpeed = math.clamp(currentSpeed + 50, 0, 1000)
			speedLabel.Text = "Speed: " .. currentSpeed .. " (max 1000)"
		end
	end)

	-- Текст подсказки для ПК
	local pcInfo = Instance.new("TextLabel", mainFrame)
	pcInfo.Size = UDim2.new(1, -20, 0, 32)
	pcInfo.Position = UDim2.new(0, 10, 0, 182)
	pcInfo.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	pcInfo.Text = "💻 PC: WASD | E (Up) | Q (Down) | F (Fly)"
	pcInfo.TextColor3 = Color3.fromRGB(170, 170, 190)
	pcInfo.Font = Enum.Font.Gotham
	pcInfo.TextSize = 10
	pcInfo.ZIndex = 2
	Instance.new("UICorner", pcInfo).CornerRadius = UDim.new(0, 6)

	-- Кнопка мобильного пульта
	local mobGuiBtn = Instance.new("TextButton", mainFrame)
	mobGuiBtn.Size = UDim2.new(1, -20, 0, 35)
	mobGuiBtn.Position = UDim2.new(0, 10, 0, 222)
	mobGuiBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	mobGuiBtn.Text = "Mobile WASD Pad: [ON]"
	mobGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	mobGuiBtn.Font = Enum.Font.GothamBold
	mobGuiBtn.TextSize = 11
	mobGuiBtn.ZIndex = 2
	Instance.new("UICorner", mobGuiBtn).CornerRadius = UDim.new(0, 8)

	-- Кнопка открытия меню MORE
	local moreBtn = Instance.new("TextButton", mainFrame)
	moreBtn.Size = UDim2.new(1, -20, 0, 32)
	moreBtn.Position = UDim2.new(0, 10, 0, 264)
	moreBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 80)
	moreBtn.Text = "More >>"
	moreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	moreBtn.Font = Enum.Font.GothamBold
	moreBtn.TextSize = 11
	moreBtn.ZIndex = 2
	Instance.new("UICorner", moreBtn).CornerRadius = UDim.new(0, 8)

	moreBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			moreFrame.Visible = not moreFrame.Visible
			if moreFrame.Visible then
				moreBtn.Text = "More <<"
			else
				moreBtn.Text = "More >>"
			end
		end
	end)

	-- Наполнение меню MORE (ESP)
	local moreTitle = Instance.new("TextLabel", moreFrame)
	moreTitle.Size = UDim2.new(1, 0, 0, 35)
	moreTitle.Position = UDim2.new(0, 0, 0, 5)
	moreTitle.BackgroundTransparency = 1
	moreTitle.Text = "👁️ ESP Player Highlights"
	moreTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	moreTitle.Font = Enum.Font.GothamBold
	moreTitle.TextSize = 13
	moreTitle.ZIndex = 2

	local espActive = false
	local espBtn = Instance.new("TextButton", moreFrame)
	espBtn.Size = UDim2.new(1, -20, 0, 38)
	espBtn.Position = UDim2.new(0, 10, 0, 45)
	espBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
	espBtn.Text = "Player ESP: [OFF]"
	espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	espBtn.Font = Enum.Font.GothamBold
	espBtn.TextSize = 13
	espBtn.ZIndex = 2
	Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 8)

	local infoEsp = Instance.new("TextLabel", moreFrame)
	infoEsp.Size = UDim2.new(1, -20, 0, 130)
	infoEsp.Position = UDim2.new(0, 10, 0, 95)
	infoEsp.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	infoEsp.Text = "Colors:\n🔵 Police = Blue\n🟠 Criminal = Orange\n🟡 Border Patrol = Yellow\n🟢 Civilian = Green"
	infoEsp.TextColor3 = Color3.fromRGB(200, 200, 220)
	infoEsp.Font = Enum.Font.Gotham
	infoEsp.TextSize = 11
	infoEsp.ZIndex = 2
	Instance.new("UICorner", infoEsp).CornerRadius = UDim.new(0, 8)

	local function getTeamColor(player)
		local teamName = player.Team and player.Team.Name:lower() or ""
		if string.find(teamName, "police") or string.find(teamName, "cop") or string.find(teamName, "policía") then
			return Color3.fromRGB(0, 120, 255)
		elseif string.find(teamName, "criminal") or string.find(teamName, "crim") or string.find(teamName, "prisoner") then
			return Color3.fromRGB(255, 140, 0)
		elseif string.find(teamName, "border") or string.find(teamName, "patrol") then
			return Color3.fromRGB(255, 220, 0)
		else
			return Color3.fromRGB(0, 255, 100)
		end
	end

	local activeHighlights = {}

	local function updateEsp()
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				local char = player.Character
				if espActive then
					if not activeHighlights[player] then
						local hl = Instance.new("Highlight")
						hl.Name = "SanDiegoESP"
						hl.Adornee = char
						hl.FillTransparency = 0.5
						hl.OutlineTransparency = 0
						hl.Parent = char
						activeHighlights[player] = hl
					end
					local hl = activeHighlights[player]
					if hl and hl.Parent then
						local col = getTeamColor(player)
						hl.FillColor = col
						hl.OutlineColor = col
					end
				else
					if activeHighlights[player] then
						activeHighlights[player]:Destroy()
						activeHighlights[player] = nil
					end
				end
			end
		end
	end

	espBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			espActive = not espActive
			if espActive then
				espBtn.Text = "Player ESP: [ON]"
				espBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
			else
				espBtn.Text = "Player ESP: [OFF]"
				espBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
				for p, hl in pairs(activeHighlights) do
					if hl then hl:Destroy() end
				end
				activeHighlights = {}
			end
		end
	end)

	RunService.RenderStepped:Connect(function()
		if espActive then
			updateEsp()
		end
	end)

	-- Мобильный пульт управления
	local mobileControlGui = Instance.new("Frame", screenGui)
	mobileControlGui.Name = "MobileControls"
	mobileControlGui.Size = UDim2.new(0, 160, 0, 160)
	mobileControlGui.Position = UDim2.new(1, -190, 1, -340)
	mobileControlGui.BackgroundTransparency = 1
	mobileControlGui.Visible = false

	local mobileStates = {W = false, A = false, S = false, D = false, E = false, Q = false}

	local function createControlBtn(name, text, bgColor, size, pos)
		local btn = Instance.new("TextButton", mobileControlGui)
		btn.Size = size
		btn.Position = pos
		btn.BackgroundColor3 = bgColor
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Text = text
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 14
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
		local btnStroke = Instance.new("UIStroke", btn, {Thickness = 1.5})
		applyRGB(btnStroke)

		btn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				mobileStates[name] = true
				btn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
			end
		end)
		
		btn.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				mobileStates[name] = false
				btn.BackgroundColor3 = bgColor
			end
		end)
		
		return btn
	end

	createControlBtn("W", "W", Color3.fromRGB(30, 30, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 50, 0, 0))
	createControlBtn("A", "A", Color3.fromRGB(30, 30, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 0, 0, 50))
	createControlBtn("S", "S", Color3.fromRGB(30, 30, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 50, 0, 50))
	createControlBtn("D", "D", Color3.fromRGB(30, 30, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 100, 0, 50))
	createControlBtn("E", "UP", Color3.fromRGB(40, 90, 50), UDim2.new(0, 45, 0, 45), UDim2.new(0, 100, 0, 0))
	createControlBtn("Q", "DOWN", Color3.fromRGB(90, 40, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 0, 0, 100))

	mobGuiBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			local mobGuiActive = not mobileControlGui.Visible
			mobileControlGui.Visible = mobGuiActive
			if mobGuiActive then
				mobGuiBtn.Text = "Mobile WASD Pad: [ON]"
				mobGuiBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
			else
				mobGuiBtn.Text = "Mobile WASD Pad: [OFF]"
				mobGuiBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
			end
		end
	end)

	-- Логика полёта (Fly)
	local flyActive = false
	local attachment, linearVelocity, alignOrientation

	local function toggleFly()
		flyActive = not flyActive

		local char = LocalPlayer.Character
		local humanoid = char and char:FindFirstChildOfClass("Humanoid")
		local targetPart = nil

		if humanoid and humanoid.SeatPart then
			local seat = humanoid.SeatPart
			if seat.Parent and seat.Parent:IsA("Model") then
				targetPart = seat.Parent.PrimaryPart or seat.Parent:FindFirstChildWhichIsA("BasePart")
			end
			if not targetPart then targetPart = seat end
		else
			targetPart = char and (char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart)
		end

		if flyActive then
			flyBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
			flyBtn.Text = "Safe Fly (F): [ON]"

			if targetPart then
				attachment = Instance.new("Attachment", targetPart)

				linearVelocity = Instance.new("LinearVelocity")
				linearVelocity.Attachment0 = attachment
				linearVelocity.MaxForce = math.huge
				linearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
				linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
				linearVelocity.Parent = targetPart
				
				alignOrientation = Instance.new("AlignOrientation")
				alignOrientation.Attachment0 = attachment
				alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
				alignOrientation.RigidityEnabled = true
				alignOrientation.Parent = targetPart
			end
		else
			flyBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
			flyBtn.Text = "Safe Fly (F): [OFF]"
			if attachment then attachment:Destroy() end
			if linearVelocity then linearVelocity:Destroy() end
			if alignOrientation then alignOrientation:Destroy() end
		end
	end

	flyBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			toggleFly()
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed and input.KeyCode == Enum.KeyCode.F then
			toggleFly()
		end
	end)

	RunService.RenderStepped:Connect(function()
		if flyActive and LocalPlayer.Character then
			local char = LocalPlayer.Character
			local humanoid = char and char:FindFirstChildOfClass("Humanoid")
			local targetPart = nil

			if humanoid and humanoid.SeatPart then
				local seat = humanoid.SeatPart
				if seat.Parent and seat.Parent:IsA("Model") then
					targetPart = seat.Parent.PrimaryPart or seat.Parent:FindFirstChildWhichIsA("BasePart")
				end
				if not targetPart then targetPart = seat end
			else
				targetPart = char:FindFirstChild("HumanoidRootPart")
			end

			if targetPart and linearVelocity then
				local camera = workspace.CurrentCamera
				local moveVector = Vector3.new(0, 0, 0)

				if UserInputService:IsKeyDown(Enum.KeyCode.W) or mobileStates.W then
					moveVector = moveVector + camera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) or mobileStates.S then
					moveVector = moveVector - camera.CFrame.LookVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) or mobileStates.A then
					moveVector = moveVector - camera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) or mobileStates.D then
					moveVector = moveVector + camera.CFrame.RightVector
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.E) or mobileStates.E then
					moveVector = moveVector + Vector3.new(0, 1, 0)
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Q) or mobileStates.Q then
					moveVector = moveVector - Vector3.new(0, 1, 0)
				end

				linearVelocity.VectorVelocity = moveVector * currentSpeed
				linearVelocity.MaxForce = math.huge 
				targetPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			end
		end
	end)
end)
