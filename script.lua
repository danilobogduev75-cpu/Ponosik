-- ==========================================
-- НАСТРОЙКА КЛЮЧА И НАЗВАНИЯ
local SECRET_KEY = "free"
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

	-- Функция для красивого интро (Welcome с блюром и анимацией обводки)
	local function playWelcomeIntro()
		-- Создаем размытие экрана (Blur)
		local blur = Instance.new("BlurEffect")
		blur.Size = 24
		blur.Parent = Lighting

		-- Контейнер для интро
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
		textLabel.TextStrokeTransparency = 0 -- Включаем стандартную обводку
		textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		textLabel.Parent = introGui

		-- Плавная анимация: держим 5 секунд, затем плавно гасим и блюр, и текст
		task.spawn(function()
			local startTime = tick()
			local duration = 5.0 -- 5 секунд

			while tick() - startTime < duration do
				-- Эффект погони обводки: меняем цвет обводки по кругу (чёрный/белый/цветной)
				local t = (tick() - startTime) * 3
				local r = math.abs(math.sin(t))
				textLabel.TextStrokeColor3 = Color3.fromRGB(r * 50, r * 50, r * 50)
				RunService.RenderStepped:Wait()
			end

			-- Плавное исчезновение (fade out)
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
	keyTitle.Text = "🔑 Введите ключ доступа"
	keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
	keyTitle.Font = Enum.Font.GothamBold
	keyTitle.TextSize = 14
	keyTitle.Parent = keyFrame

	local keyBox = Instance.new("TextBox")
	keyBox.Size = UDim2.new(1, -40, 0, 40)
	keyBox.Position = UDim2.new(0, 20, 0, 50)
	keyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	keyBox.Text = ""
	keyBox.PlaceholderText = "Введите ключ..."
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
	submitBtn.Text = "Подтвердить"
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

	-- Проверка ключа
	submitBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if keyBox.Text == SECRET_KEY then
				keyFrame:Destroy()
				playWelcomeIntro() -- Запускаем крутое интро
				iconBtn.Visible = true
				mainFrame.Visible = true
			else
				keyBox.Text = ""
				keyBox.PlaceholderText = "Неверный ключ!"
			end
		end
	end)

	iconBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			mainFrame.Visible = not mainFrame.Visible
		end
	end)

	-- Заголовок
	local titleLabel = Instance.new("TextLabel", mainFrame)
	titleLabel.Size = UDim2.new(1, 0, 0, 35)
	titleLabel.Position = UDim2.new(0, 0, 0, 5)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "⭐ San diego cheat ⭐"
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

	-- Коллизия (Collision) — бывший ноуклип
	local collisionActive = false
	local collisionBtn = Instance.new("TextButton", mainFrame)
	collisionBtn.Size = UDim2.new(1, -20, 0, 35)
	collisionBtn.Position = UDim2.new(0, 10, 0, 85)
	collisionBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
	collisionBtn.Text = "Collision: [ON]"
	collisionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	collisionBtn.Font = Enum.Font.GothamBold
	collisionBtn.TextSize = 11
	collisionBtn.ZIndex = 2
	Instance.new("UICorner", collisionBtn).CornerRadius = UDim.new(0, 8)

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
		end
	end)

	-- Настройка скорости (до 1000)
	local currentSpeed = 50

	local speedLabel = Instance.new("TextLabel", mainFrame)
	speedLabel.Size = UDim2.new(1, -20, 0, 20)
	speedLabel.Position = UDim2.new(0, 10, 0, 125)
	speedLabel.BackgroundTransparency = 1
	speedLabel.Text = "Скорость: 50 (до 1000)"
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
			speedLabel.Text = "Скорость: " .. currentSpeed .. " (до 1000)"
		end
	end)

	speedPlus.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			currentSpeed = math.clamp(currentSpeed + 50, 0, 1000)
			speedLabel.Text = "Скорость: " .. currentSpeed .. " (до 1000)"
		end
	end)

	-- Текст ПК
	local pcInfo = Instance.new("TextLabel", mainFrame)
	pcInfo.Size = UDim2.new(1, -20, 0, 32)
	pcInfo.Position = UDim2.new(0, 10, 0, 182)
	pcInfo.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	pcInfo.Text = "💻 ПК: WASD | E (Вверх) | Q (Вниз) | F (Бинд)"
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
	mobGuiBtn.Text = "Мобильный пульт WASD: [ВКЛ]"
	mobGuiBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	mobGuiBtn.Font = Enum.Font.GothamBold
	mobGuiBtn.TextSize = 11
	mobGuiBtn.ZIndex = 2
	Instance.new("UICorner", mobGuiBtn).CornerRadius = UDim.new(0, 8)

	-- Кнопка закрытия/скрытия меню снизу
	local closeBtn = Instance.new("TextButton", mainFrame)
	closeBtn.Size = UDim2.new(1, -20, 0, 32)
	closeBtn.Position = UDim2.new(0, 10, 0, 264)
	closeBtn.BackgroundColor3 = Color3.fromRGB(70, 40, 40)
	closeBtn.Text = "Свернуть меню"
	closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 11
	closeBtn.ZIndex = 2
	Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)

	closeBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			mainFrame.Visible = false
		end
	end)

	-- Мобильный пульт
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
				mobGuiBtn.Text = "Мобильный пульт WASD: [ВКЛ]"
				mobGuiBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 70)
			else
				mobGuiBtn.Text = "Мобильный пульт WASD: [ВЫКЛ]"
				mobGuiBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
			end
		end
	end)

	-- Логика полёта
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

	-- Логика коллизии (Collision)
	RunService.Stepped:Connect(function()
		local char = LocalPlayer.Character
		if char then
			local humanoid = char:FindFirstChildOfClass("Humanoid")
			local vehicleModel = nil

			if humanoid and humanoid.SeatPart and humanoid.SeatPart.Parent then
				if humanoid.SeatPart.Parent:IsA("Model") then
					vehicleModel = humanoid.SeatPart.Parent
				end
			end

			if not collisionActive then
				if vehicleModel then
					for _, part in ipairs(vehicleModel:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				else
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end
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
