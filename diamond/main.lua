--[[ =================================================
     VISUAL DIAMOND SYSTEM (CLIENT ONLY)
     ANTI-SPAM • QUEUED • STABLE • UI GUARANTEED
================================================= ]]

-- ================= CONFIG ==================
local SPEED_UP   = 0.02
local SPEED_DOWN = 0.015
local CLAIM_SOUND_ID = "rbxassetid://138312061848927"
local SOUND_COOLDOWN = 0.35 -- cegah sound spam

-- ================= SERVICES =================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ================= SAFE FIND DIAMOND UI =====
local function getDiamondLabel()
	local ok, label = pcall(function()
		return playerGui.Interface.DiamondCount.Count
	end)
	return ok and label or nil
end

-- ================= CLAIM SOUND (LOCAL ONLY) ==
local claimSound = Instance.new("Sound")
claimSound.Name = "VisualDiamondClaim"
claimSound.SoundId = CLAIM_SOUND_ID
claimSound.Volume = 1
claimSound.Parent = SoundService

local lastSoundTime = 0
local function playClaimSoundSafe()
	local now = os.clock()
	if now - lastSoundTime >= SOUND_COOLDOWN then
		lastSoundTime = now
		claimSound:Stop()
		claimSound:Play()
	end
end

-- ================= ANIMATION CORE ===========
local function animateTo(label, fromValue, toValue, speed, onDone)
	local current = fromValue
	local diff = math.abs(toValue - fromValue)
	local step = math.max(1, math.floor(diff / 60))
	local dir = (toValue > fromValue) and 1 or -1

	task.spawn(function()
		while current ~= toValue do
			current += step * dir
			if (dir == 1 and current > toValue) or (dir == -1 and current < toValue) then
				current = toValue
			end
			label.Text = tostring(current)
			task.wait(speed)
		end
		if onDone then onDone() end
	end)
end

-- ================= WAIT DIAMOND LABEL =======
local diamondLabel
repeat
	task.wait()
	diamondLabel = getDiamondLabel()
until diamondLabel

-- ================= STATE ====================
local visualBalance   = tonumber(diamondLabel.Text:match("%d+")) or 0
local lastRealBalance = visualBalance

-- GLOBAL LOCK (ANTI-SPAM)
local busy = false

-- ================= REAL UI LISTENER =========
diamondLabel:GetPropertyChangedSignal("Text"):Connect(function()
	if busy then return end

	local realNow = tonumber(diamondLabel.Text:match("%d+"))
	if not realNow then return end

	local delta = realNow - lastRealBalance
	lastRealBalance = realNow
	if delta == 0 then return end

	busy = true
	local from = visualBalance
	local to

	if delta > 0 then
		-- REAL GAIN
		to = visualBalance + delta
		visualBalance = to
		playClaimSoundSafe()
		animateTo(diamondLabel, from, to, SPEED_UP, function()
			busy = false
		end)
	else
		-- REAL SPEND
		to = math.max(0, visualBalance + delta)
		visualBalance = to
		animateTo(diamondLabel, from, to, SPEED_DOWN, function()
			busy = false
		end)
	end
end)

-- ================= MANUAL VISUAL API ========
_G.VisualAddDiamond = function(amount)
	if type(amount) ~= "number" or amount == 0 then return end
	if busy then return end

	busy = true
	local from = visualBalance
	local to   = math.max(0, visualBalance + amount)
	visualBalance = to

	if amount > 0 then
		playClaimSoundSafe()
		animateTo(diamondLabel, from, to, SPEED_UP, function()
			busy = false
		end)
	else
		animateTo(diamondLabel, from, to, SPEED_DOWN, function()
			busy = false
		end)
	end
end

-- =================================================
-- ===================== GUI ========================
-- =================================================

local gui = Instance.new("ScreenGui")
gui.Name = "VisualDiamondGUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromOffset(320, 180)
frame.Position = UDim2.fromScale(0.5, 0.55)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
frame.Active = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)

-- ================= HEADER ===================
local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1,0,0,36)
header.BackgroundColor3 = Color3.fromRGB(45,45,60)
header.Active = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0,14)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1,-80,1,0)
title.Position = UDim2.new(0,10,0,0)
title.Text = "💎 Diamond Multiplier by Kixdev 💎"
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextColor3 = Color3.new(1,1,1)
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.fromOffset(30,24)
minimizeBtn.Position = UDim2.new(1,-36,0,6)
minimizeBtn.Text = "−"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 18
minimizeBtn.TextColor3 = Color3.new(1,1,1)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(70,70,90)
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0,8)

-- ================= CONTENT ==================
local content = Instance.new("Frame", frame)
content.Position = UDim2.new(0,0,0,36)
content.Size = UDim2.new(1,0,1,-36)
content.BackgroundTransparency = 1

local label = Instance.new("TextLabel", content)
label.Size = UDim2.new(1,-40,0,18)
label.Position = UDim2.new(0,20,0,0)
label.Text = "Add / Reduce Amount"
label.Font = Enum.Font.Gotham
label.TextSize = 12
label.TextColor3 = Color3.fromRGB(180,180,180)
label.TextXAlignment = Enum.TextXAlignment.Left
label.BackgroundTransparency = 1

local input = Instance.new("TextBox", content)
input.Size = UDim2.new(1,-40,0,36)
input.Position = UDim2.new(0,20,0,20)
input.Text = ""
input.ClearTextOnFocus = true
input.Font = Enum.Font.Gotham
input.TextSize = 20
input.TextColor3 = Color3.new(1,1,1)
input.BackgroundColor3 = Color3.fromRGB(45,45,60)
Instance.new("UICorner", input).CornerRadius = UDim.new(0,10)

local runBtn = Instance.new("TextButton", content)
runBtn.Size = UDim2.new(1,-40,0,36)
runBtn.Position = UDim2.new(0,20,0,70)
runBtn.Text = "RUN"
runBtn.Font = Enum.Font.GothamBold
runBtn.TextSize = 14
runBtn.TextColor3 = Color3.new(1,1,1)
runBtn.BackgroundColor3 = Color3.fromRGB(80,140,255)
Instance.new("UICorner", runBtn).CornerRadius = UDim.new(0,10)

runBtn.MouseButton1Click:Connect(function()
	if busy then return end
	local amount = tonumber(input.Text)
	if amount then
		_G.VisualAddDiamond(amount)
	end
end)

-- ================= DRAG =====================
do
	local dragging, dragStart, startPos = false

	header.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = i.Position
			startPos = frame.Position
			i.Changed:Connect(function()
				if i.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = i.Position - dragStart
			frame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

-- ================= MINIMIZE =================
local minimized = false
local normalSize = frame.Size

minimizeBtn.MouseButton1Click:Connect(function()
	if minimized then
		frame.Size = normalSize
		content.Visible = true
		minimizeBtn.Text = "−"
	else
		normalSize = frame.Size
		frame.Size = UDim2.new(frame.Size.X.Scale, frame.Size.X.Offset, 0, 36)
		content.Visible = false
		minimizeBtn.Text = "+"
	end
	minimized = not minimized
end)
