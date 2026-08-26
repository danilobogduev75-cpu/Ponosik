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
			while tick() - startTime < 5.0 do
				local t = (tick() - startTime) * 3
				local r = math.abs(math.sin(t))
				textLabel.TextStrokeColor3 = Color3.fromRGB(r * 50, r * 50, r * 50)
				RunService.RenderStepped:Wait()
			end
			introGui:Destroy()
			blur:Destroy()
		end)
	end

	-- Окно ввода ключа (Key System)
	local keyFrame = Instance.new("Frame")
	keyFrame.Size = UDim2.new(0, 300, 0, 180)
	keyFrame.Position = UDim2.new(0.5, -150, 0.5, -90)
	keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	keyFrame.BorderSizePixel = 0
	keyFrame.Active = true
	keyFrame.Draggable = true
	keyFrame.Parent = screenGui
	
	Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 12)
	applyRGB(Instance.new("UIStroke", keyFrame, {Thickness = 2}))

	-- Заголовок окна ключа (как на твоем скриншоте)
	local keyTitle = Instance.new("TextLabel")
	keyTitle.Size = UDim2.new(1, 0, 0, 40)
	keyTitle.Position = UDim2.new(0, 0, 0, 10)
	keyTitle.BackgroundTransparency = 1
	keyTitle.Text = "🔑 Enter Access Key"
	keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyTitle.Font = Enum.Font.GothamBold
	keyTitle.TextSize = 13
	keyTitle.Parent = keyFrame

	local keyBox = Instance.new("TextBox")
	keyBox.Size = UDim2.new(1, -40, 0, 40)
	keyBox.Position = UDim2.new(0, 20, 0, 60)
	keyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	keyBox.PlaceholderText = "Enter key..."
	keyBox.Text = ""
	keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyBox.Font = Enum.Font.Gotham
	keyBox.TextSize = 13
	keyBox.Parent = keyFrame
	Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

	local submitBtn = Instance.new("TextButton")
	submitBtn.Size = UDim2.new(1, -40, 0, 35)
	submitBtn.Position = UDim2.new(0, 20, 0, 118)
	submitBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
	submitBtn.Text = "Confirm"
	submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	submitBtn.Font = Enum.Font.GothamBold
	submitBtn.TextSize = 13
	submitBtn.Parent = keyFrame
	Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 8)

	-- Главное меню (иконка черепа 💀)
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
	applyRGB(Instance.new("UIStroke", iconBtn, {Thickness = 2}))

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
	applyRGB(Instance.new("UIStroke", mainFrame, {Thickness = 2}))

	-- Панель More (ESP + Aimbot с настройкой сенсы и NPC)
	local moreFrame = Instance.new("Frame")
	moreFrame.Size = UDim2.new(0, 280, 0, 345)
	moreFrame.Position = UDim2.new(0.5, 150, 0.5, -167)
	moreFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	moreFrame.BorderSizePixel = 0
	moreFrame.Active = true
	moreFrame.Draggable = true
	moreFrame.Visible = false
	moreFrame.Parent = screenGui
	Instance.new("UICorner", moreFrame).CornerRadius = UDim.new(0, 12)
	applyRGB(Instance.new("UIStroke", moreFrame, {Thickness = 2}))

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
			if not mainFrame.Visible then moreFrame.Visible = false end
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

	-- Кнопка Collision
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
				if humanoid.SeatPart.Parent:IsA("Model") then vehicleModel = humanoid.SeatPart.Parent end
			end
			local targetInstance = vehicleModel or char
			for _, part in ipairs(targetInstance:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = not state end
			end
		end
	end

	collisionBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			collisionActive = not collisionActive
			collisionBtn.Text = collisionActive and "Collision: [ON]" or "Collision: [OFF]"
			collisionBtn.BackgroundColor3 = collisionActive and Color3.fromRGB(40, 120, 70) or Color3.fromRGB(120, 40, 40)
			updateCollision(collisionActive)
		end
	end)

	-- Скорость
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

	local speedMinus = Instance.new("TextButton", mainFrame)
	speedMinus.Size = UDim2.new(0, 120, 0, 28)
	speedMinus.Position = UDim2.new(0, 10, 0, 148)
	speedMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	speedMinus.Text = "- 50"
	speedMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedMinus.Font = Enum.Font.GothamBold
	speedMinus.TextSize = 11
	Instance.new("UICorner", speedMinus).CornerRadius = UDim.new(0, 6)

	local speedPlus = Instance.new("TextButton", mainFrame)
	speedPlus.Size = UDim2.new(0, 120, 0, 28)
	speedPlus.Position = UDim2.new(0, 150, 0, 148)
	speedPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	speedPlus.Text = "+ 50"
	speedPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedPlus.Font = Enum.Font.GothamBold
	speedPlus.TextSize = 11
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

	local pcInfo = Instance.new("TextLabel", mainFrame)
	pcInfo.Size = UDim2.new(1, -20, 0, 32)
	pcInfo.Position = UDim2.new(0, 10, 0, 182)
	pcInfo.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	pcInfo.Text = "💻 PC: WASD | E (Up) | Q (Down) | F (Fly)"
	pcInfo.TextColor3 = Color3.fromRGB(170, 170, 190)
	pcInfo.Font = Enum.Font.Gotham
	pcInfo.TextSize = 10
	Instance.new("UICorner", pcInfo).CornerRadius = UDim.new(0, 6)

	local mobGuiBtn = Instance.new("TextButton", mainFrame)
	mobGuiBtn.Size = UDim2.new(1, -20, 0, 35)
	mobGuiBtn.Position = UDim2.new(0, 10, 0, 222)
	mobGuiBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	mobGuiBtn.Text = "Mobile WASD Pad: [ON]"
	mobGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	mobGuiBtn.Font = Enum.Font.GothamBold
	mobGuiBtn.TextSize = 11
	Instance.new("UICorner", mobGuiBtn).CornerRadius = UDim.new(0, 8)

	local moreBtn = Instance.new("TextButton", mainFrame)
	moreBtn.Size = UDim2.new(1, -20, 0, 32)
	moreBtn.Position = UDim2.new(0, 10, 0, 264)
	moreBtn.BackgroundColor3 = Color3.fromRGB(50, 40, 80)
	moreBtn.Text = "More >>"
	moreBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	moreBtn.Font = Enum.Font.GothamBold
	moreBtn.TextSize = 11
	Instance.new("UICorner", moreBtn).CornerRadius = UDim.new(0, 8)

	moreBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			moreFrame.Visible = not moreFrame.Visible
			moreBtn.Text = moreFrame.Visible and "More <<" or "More >>"
		end
	end)

	-- ==========================================
	-- МЕНЮ MORE (ESP + AIMBOT С СЕНСОЙ И NPC)
	-- ==========================================
	local moreTitle = Instance.new("TextLabel", moreFrame)
	moreTitle.Size = UDim2.new(1, 0, 0, 30)
	moreTitle.Position = UDim2.new(0, 0, 0, 5)
	moreTitle.BackgroundTransparency = 1
	moreTitle.Text = "👁️ ESP & Aimbot (Players + NPCs)"
	moreTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	moreTitle.Font = Enum.Font.GothamBold
	moreTitle.TextSize = 11

	-- Кнопка ESP
	local espActive = false
	local espBtn = Instance.new("TextButton", moreFrame)
	espBtn.Size = UDim2.new(1, -20, 0, 30)
	espBtn.Position = UDim2.new(0, 10, 0, 38)
	espBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
	espBtn.Text = "Player ESP: [OFF]"
	espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	espBtn.Font = Enum.Font.GothamBold
	espBtn.TextSize = 11
	Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 8)

	local function getTeamColor(player)
		if not player or not player.Team then return Color3.fromRGB(0, 255, 100) end
		local tName = player.Team.Name:lower()
		if string.find(tName, "police") or string.find(tName, "cop") then return Color3.fromRGB(0, 120, 255)
		elseif string.find(tName, "crim") or string.find(tName, "prisoner") then return Color3.fromRGB(255, 140, 0)
		elseif string.find(tName, "border") then return Color3.fromRGB(255, 220, 0)
		elseif string.find(tName, "fbi") then return Color3.fromRGB(80, 80, 255)
		elseif string.find(tName, "swat") then return Color3.fromRGB(40, 40, 90)
		elseif string.find(tName, "army") or string.find(tName, "military") then return Color3.fromRGB(75, 140, 75)
		else return Color3.fromRGB(0, 255, 100) end
	end

	local activeHighlights = {}
	RunService.RenderStepped:Connect(function()
		if espActive then
			for _, p in ipairs(Players:GetPlayers()) do
				if p ~= LocalPlayer and p.Character then
					local hl = activeHighlights[p]
					if not hl or not hl.Parent then
						if hl then pcall(function() hl:Destroy() end) end
						hl = Instance.new("Highlight", p.Character)
						hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						hl.FillTransparency = 0.5
						activeHighlights[p] = hl
					end
					local col = getTeamColor(p)
					hl.FillColor = col
					hl.OutlineColor = col
				end
			end
		end
	end)

	espBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			espActive = not espActive
			espBtn.Text = espActive and "Player ESP: [ON]" or "Player ESP: [OFF]"
			espBtn.BackgroundColor3 = espActive and Color3.fromRGB(40, 120, 70) or Color3.fromRGB(120, 40, 40)
			if not espActive then
				for _, hl in pairs(activeHighlights) do pcall(function() hl:Destroy() end) end
				activeHighlights = {}
			end
		end
	end)

	-- AIMBOT
	local aimbotActive = false
	local followMouseMode = false
	local fovRadius = 140
	local aimSmooth = 5
	local camera = workspace.CurrentCamera

	local aimBtn = Instance.new("TextButton", moreFrame)
	aimBtn.Size = UDim2.new(1, -20, 0, 30)
	aimBtn.Position = UDim2.new(0, 10, 0, 73)
	aimBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
	aimBtn.Text = "Aimbot: [OFF]"
	aimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	aimBtn.Font = Enum.Font.GothamBold
	aimBtn.TextSize = 11
	Instance.new("UICorner", aimBtn).CornerRadius = UDim.new(0, 8)

	-- Настройка чувствительности (Smooth)
	local smoothLabel = Instance.new("TextLabel", moreFrame)
	smoothLabel.Size = UDim2.new(1, -20, 0, 16)
	smoothLabel.Position = UDim2.new(0, 10, 0, 108)
	smoothLabel.BackgroundTransparency = 1
	smoothLabel.Text = "Aim Smooth (Sens): 5 (1=Fast, 10=Slow)"
	smoothLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
	smoothLabel.Font = Enum.Font.GothamBold
	smoothLabel.TextSize = 9
	smoothLabel.TextXAlignment = Enum.TextXAlignment.Left

	local smoothMinus = Instance.new("TextButton", moreFrame)
	smoothMinus.Size = UDim2.new(0, 120, 0, 24)
	smoothMinus.Position = UDim2.new(0, 10, 0, 126)
	smoothMinus.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	smoothMinus.Text = "- Sens"
	smoothMinus.TextColor3 = Color3.fromRGB(255, 255, 255)
	smoothMinus.Font = Enum.Font.GothamBold
	smoothMinus.TextSize = 10
	Instance.new("UICorner", smoothMinus).CornerRadius = UDim.new(0, 6)

	local smoothPlus = Instance.new("TextButton", moreFrame)
	smoothPlus.Size = UDim2.new(0, 120, 0, 24)
	smoothPlus.Position = UDim2.new(0, 150, 0, 126)
	smoothPlus.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	smoothPlus.Text = "+ Sens"
	smoothPlus.TextColor3 = Color3.fromRGB(255, 255, 255)
	smoothPlus.Font = Enum.Font.GothamBold
	smoothPlus.TextSize = 10
	Instance.new("UICorner", smoothPlus).CornerRadius = UDim.new(0, 6)

	smoothMinus.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			aimSmooth = math.clamp(aimSmooth - 1, 1, 20)
			smoothLabel.Text = "Aim Smooth (Sens): " .. aimSmooth
		end
	end)

	smoothPlus.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			aimSmooth = math.clamp(aimSmooth + 1, 1, 20)
			smoothLabel.Text = "Aim Smooth (Sens): " .. aimSmooth
		end
	end)

	-- Кнопка режима (Центр / Мышь)
	local modeBtn = Instance.new("TextButton", moreFrame)
	modeBtn.Size = UDim2.new(1, -20, 0, 30)
	modeBtn.Position = UDim2.new(0, 10, 0, 155)
	modeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
	modeBtn.Text = "Aim Mode: [Center / Phone]"
	modeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	modeBtn.Font = Enum.Font.GothamBold
	modeBtn.TextSize = 10
	Instance.new("UICorner", modeBtn).CornerRadius = UDim.new(0, 8)

	-- FOV Круг
	local fovGui = Instance.new("Frame", screenGui)
	fovGui.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
	fovGui.AnchorPoint = Vector2.new(0.5, 0.5)
	fovGui.BackgroundTransparency = 1
	fovGui.Visible = false
	Instance.new("UIStroke", fovGui, {Thickness = 1.5, Color = Color3.fromRGB(255, 255, 255)})
	Instance.new("UICorner", fovGui).CornerRadius = UDim.new(1, 0)

	local function toggleAimMode()
		followMouseMode = not followMouseMode
		if followMouseMode then
			modeBtn.Text = "Aim Mode: [Mouse / PC (G)]"
			modeBtn.BackgroundColor3 = Color3.fromRGB(80, 50, 120)
		else
			modeBtn.Text = "Aim Mode: [Center / Phone (G)]"
			modeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
		end
	end

	modeBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			toggleAimMode()
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gp)
		if not gp and input.KeyCode == Enum.KeyCode.G then
			toggleAimMode()
		end
	end)

	aimBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			aimbotActive = not aimbotActive
			fovGui.Visible = aimbotActive
			aimBtn.Text = aimbotActive and "Aimbot: [ON]" or "Aimbot: [OFF]"
			aimBtn.BackgroundColor3 = aimbotActive and Color3.fromRGB(40, 120, 70) or Color3.fromRGB(120, 40, 40)
		end
	end)

	local function isEnemyPlayer(player)
		if player == LocalPlayer then return false end
		if not player.Team or not LocalPlayer.Team then return true end
		local myTeam = LocalPlayer.Team.Name:lower()
		local pTeam = player.Team.Name:lower()
		if myTeam == pTeam then return false end
		if string.find(myTeam, "civilian") or string.find(myTeam, "citizen") then return true end
		local isMyGov = string.find(myTeam, "police") or string.find(myTeam, "cop") or string.find(myTeam, "fbi") or string.find(myTeam, "swat") or string.find(myTeam, "army") or string.find(myTeam, "border")
		local isTargetGov = string.find(pTeam, "police") or string.find(pTeam, "fbi") or string.find(pTeam, "swat") or string.find(pTeam, "army") or string.find(pTeam, "border")
		if isMyGov and isTargetGov then return false end
		return true
	end

	-- Поиск лучшей цели (Игроки + NPC)
	local function getBestTarget()
		local refPoint
		if followMouseMode then
			refPoint = UserInputService:GetMouseLocation()
		else
			refPoint = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
		end

		local bestTarget = nil
		local shortestDist = fovRadius

		-- 1. Игроки
		for _, player in ipairs(Players:GetPlayers()) do
			if isEnemyPlayer(player) and player.Character then
				local char = player.Character
				local humanoid = char:FindFirstChildOfClass("Humanoid")
				local head = char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")

				if humanoid and humanoid.Health > 0 and head then
					local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
					if onScreen then
						local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - refPoint).Magnitude
						if screenDist < shortestDist then
							local origin = camera.CFrame.Position
							local direction = (head.Position - origin)
							local rayParams = RaycastParams.new()
							rayParams.FilterType = Enum.RaycastFilterType.Blacklist
							rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
							
							local result = workspace:Raycast(origin, direction, rayParams)
							if not result or result.Instance:IsDescendantOf(char) then
								shortestDist = screenDist
								bestTarget = head
							end
						end
					end
				end
			end
		end

		-- 2. NPC
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Model") and obj ~= LocalPlayer.Character then
				local humanoid = obj:FindFirstChildOfClass("Humanoid")
				local head = obj:FindFirstChild("Head") or obj:FindFirstChild("HumanoidRootPart")
				if humanoid and humanoid.Health > 0 and head and not Players:GetPlayerFromCharacter(obj) then
					local screenPos, onScreen = camera:WorldToViewportPoint(head.Position)
					if onScreen then
						local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - refPoint).Magnitude
						if screenDist < shortestDist then
							local origin = camera.CFrame.Position
							local direction = (head.Position - origin)
							local rayParams = RaycastParams.new()
							rayParams.FilterType = Enum.RaycastFilterType.Blacklist
							rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
							
							local result = workspace:Raycast(origin, direction, rayParams)
							if not result or result.Instance:IsDescendantOf(obj) then
								shortestDist = screenDist
								bestTarget = head
							end
						end
					end
				end
			end
		end

		return bestTarget
	end

	-- Наведение Aimbot
	RunService.RenderStepped:Connect(function()
		if aimbotActive then
			if followMouseMode then
				local mPos = UserInputService:GetMouseLocation()
				fovGui.Position = UDim2.new(0, mPos.X, 0, mPos.Y)
			else
				fovGui.Position = UDim2.new(0.5, 0, 0.5, 0)
			end

			local targetHead = getBestTarget()
			if targetHead and (UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UserInputService:IsMouseButtonPressed(Enum.UserInputType.Touch)) then
				local targetCFrame = CFrame.new(camera.CFrame.Position, targetHead.Position)
				camera.CFrame = camera.CFrame:Lerp(targetCFrame, 1 / math.max(aimSmooth, 1))
			end
		end
	end)

	-- Мобильный пульт
	local mobileControlGui = Instance.new("Frame", screenGui)
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
		applyRGB(Instance.new("UIStroke", btn, {Thickness = 1.5}))

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
	end

	createControlBtn("W", "W", Color3.fromRGB(30, 30, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 50, 0, 0))
	createControlBtn("A", "A", Color3.fromRGB(30, 30, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 0, 0, 50))
	createControlBtn("S", "S", Color3.fromRGB(30, 30, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 50, 0, 50))
	createControlBtn("D", "D", Color3.fromRGB(30, 30, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 100, 0, 50))
	createControlBtn("E", "UP", Color3.fromRGB(40, 90, 50), UDim2.new(0, 45, 0, 45), UDim2.new(0, 100, 0, 0))
	createControlBtn("Q", "DOWN", Color3.fromRGB(90, 40, 40), UDim2.new(0, 45, 0, 45), UDim2.new(0, 0, 0, 100))

	mobGuiBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			mobileControlGui.Visible = not mobileControlGui.Visible
			mobGuiBtn.Text = mobileControlGui.Visible and "Mobile WASD Pad: [ON]" or "Mobile WASD Pad: [OFF]"
			mobGuiBtn.BackgroundColor3 = mobileControlGui.Visible and Color3.fromRGB(40, 120, 70) or Color3.fromRGB(50, 50, 70)
		end
	end)

	-- Логика полёта
	local flyActive = false
	local attachment, linearVelocity, alignOrientation
	local function toggleFly()
		flyActive = not flyActive
		local char = LocalPlayer.Character
		local humanoid = char and char:FindFirstChildOfClass("Humanoid")
		local targetPart = (humanoid and humanoid.SeatPart and (humanoid.SeatPart.Parent.PrimaryPart or humanoid.SeatPart)) or (char and char:FindFirstChild("HumanoidRootPart"))

		if flyActive then
			flyBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
			flyBtn.Text = "Safe Fly (F): [ON]"
			if targetPart then
				attachment = Instance.new("Attachment", targetPart)
				linearVelocity = Instance.new("LinearVelocity", targetPart)
				linearVelocity.Attachment0 = attachment
				linearVelocity.MaxForce = math.huge
				linearVelocity.VectorVelocity = Vector3.zero
				linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
				
				alignOrientation = Instance.new("AlignOrientation", targetPart)
				alignOrientation.Attachment0 = attachment
				alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
				alignOrientation.RigidityEnabled = true
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
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then toggleFly() end
	end)
	UserInputService.InputBegan:Connect(function(input, gp)
		if not gp and input.KeyCode == Enum.KeyCode.F then toggleFly() end
	end)

	RunService.RenderStepped:Connect(function()
		if flyActive and LocalPlayer.Character then
			local char = LocalPlayer.Character
			local humanoid = char and char:FindFirstChildOfClass("Humanoid")
			local targetPart = (humanoid and humanoid.SeatPart and (humanoid.SeatPart.Parent.PrimaryPart or humanoid.SeatPart)) or char:FindFirstChild("HumanoidRootPart")

			if targetPart and linearVelocity then
				local cam = workspace.CurrentCamera
				local moveV = Vector3.zero
				if UserInputService:IsKeyDown(Enum.KeyCode.W) or mobileStates.W then moveV += cam.CFrame.LookVector end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) or mobileStates.S then moveV -= cam.CFrame.LookVector end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) or mobileStates.A then moveV -= cam.CFrame.RightVector end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) or mobileStates.D then moveV += cam.CFrame.RightVector end
				if UserInputService:IsKeyDown(Enum.KeyCode.E) or mobileStates.E then moveV += Vector3.new(0, 1, 0) end
				if UserInputService:IsKeyDown(Enum.KeyCode.Q) or mobileStates.Q then moveV -= Vector3.new(0, 1, 0) end

				linearVelocity.VectorVelocity = moveV * currentSpeed
				targetPart.AssemblyAngularVelocity = Vector3.zero
			end
		end
	end)
end)
