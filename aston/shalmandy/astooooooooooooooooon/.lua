local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Prefix = "+"

workspace.FallenPartsDestroyHeight = 0/0


pcall(function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Aston Script";
        Text = "By Shalmandy & Virus";
        Duration = 5;
    })
end)






local function getPlayerByName(name)
	name = name:lower()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr.Name:lower():sub(1, #name) == name or plr.DisplayName:lower():sub(1, #name) == name then
			return plr
		end
	end
	return nil
end

local function updateCharacterVars()
	Character = Player.Character or Player.CharacterAdded:Wait()
	Humanoid = Character:WaitForChild("Humanoid")
end

Player.CharacterAdded:Connect(updateCharacterVars)

-- واجهة GUI
local screenGui = Instance.new("ScreenGui", game.CoreGui)
screenGui.Name = "AstonGUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 420, 0, 360)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -180)
mainFrame.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
mainFrame.BackgroundTransparency = 0.3
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

local titleLabel = Instance.new("TextLabel", mainFrame)
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Aston"
titleLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 28

local closeButton = Instance.new("TextButton", mainFrame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(0, 5, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(140, 30, 30)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundTransparency = 0.4
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 18
closeButton.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)

local searchBox = Instance.new("TextBox", mainFrame)
searchBox.PlaceholderText = "ابحث عن أمر..."
searchBox.Size = UDim2.new(1, -20, 0, 30)
searchBox.Position = UDim2.new(0, 10, 0, 50)
searchBox.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
searchBox.BackgroundTransparency = 0.3
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.Font = Enum.Font.SourceSans
searchBox.TextSize = 18
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 8)

local cmdsFrame = Instance.new("ScrollingFrame", mainFrame)
cmdsFrame.Size = UDim2.new(1, -20, 1, -90)
cmdsFrame.Position = UDim2.new(0, 10, 0, 90)
cmdsFrame.BackgroundTransparency = 1
cmdsFrame.ScrollBarThickness = 6
cmdsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

local UIListLayout = Instance.new("UIListLayout", cmdsFrame)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local Commands = {
       "speed [رقم] - تغيير سرعه اللاعب",
	"Jump [رقم] - تغيير قوة القفز",
	"Cmds - عرض قائمة الأوامر",
	"Noclip - تفعيل اختراق الجدران",
	"Unnoclip - تعطيل اختراق الجدران",
	"Esp - تفعيل رؤية اللاعبين خلف الجدران",
	"Unesp - تعطيل الرؤية خلف الجدران",
	"Bang [اسم اللاعب] - الالتصاق خلف لاعب",
	"Unbang - فك الالتصاق",
	"Sit - الجلوس",
        "antibang - حماية من bang",
     "rj - اعاده الدخول للسيرفر",
         "vatb - حمایه مطوره من bang",
     "antilag - لتقليل اللاق",
}

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	cmdsFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end)

for _, text in ipairs(Commands) do
	local label = Instance.new("TextLabel", cmdsFrame)
	label.Size = UDim2.new(1, 0, 0, 25)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(255, 200, 200)
	label.Font = Enum.Font.SourceSans
	label.TextSize = 18
	label.TextXAlignment = Enum.TextXAlignment.Left
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local searchText = searchBox.Text:lower()
	for _, child in pairs(cmdsFrame:GetChildren()) do
		if child:IsA("TextLabel") then
			child.Visible = (searchText == "" or child.Text:lower():find(searchText))
		end
	end
end)


local function rejoin()
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local player = Players.LocalPlayer
    local placeId = game.PlaceId
    local jobId = game.JobId
    
    -- إعادة توجيه اللاعب لنفس السيرفر (rejoin)
    TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
end

-- Noclip
local noclip = false
RunService.Stepped:Connect(function()
	if noclip and Character then
		for _, part in ipairs(Character:GetDescendants()) do
			if part:IsA("BasePart") and not part.Anchored then
				part.CanCollide = false
			end
		end
	end
end)


local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")


local isEnabled = false
local savedPosition = nil

local shalmandy = Instance.new("ScreenGui", PlayerGui)
shalmandy.Name = "star"
shalmandy.ResetOnSpawn = false

local starframe = Instance.new("Frame", shalmandy)
starframe.Name = "antibang"
starframe.Size = UDim2.new(0, 340, 0, 140)
starframe.Position = UDim2.new(0.5, -170, 0.5, -70)
starframe.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
starframe.BorderSizePixel = 0
starframe.Active = true
starframe.Draggable = true
starframe.Visible = false -- تبدأ مخفية

local corner = Instance.new("UICorner", starframe)
corner.CornerRadius = UDim.new(0, 18)
local stroke = Instance.new("UIStroke", starframe)
stroke.Color = Color3.fromRGB(80, 150, 255)

local title = Instance.new("TextLabel", starframe)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🔒 AntiBang System"
title.TextColor3 = Color3.fromRGB(180, 220, 255)
title.Font = Enum.Font.GothamSemibold
title.TextSize = 20

local saveBtn = Instance.new("TextButton", starframe)
saveBtn.Size = UDim2.new(0, 150, 0, 40)
saveBtn.Position = UDim2.new(0, 15, 0, 45)
saveBtn.Text = "📍 Save Location"
saveBtn.BackgroundColor3 = Color3.fromRGB(60, 150, 255)
saveBtn.TextColor3 = Color3.new(1, 1, 1)
saveBtn.Font = Enum.Font.GothamBold
saveBtn.TextSize = 16
Instance.new("UICorner", saveBtn)

local toggleBtn = Instance.new("TextButton", starframe)
toggleBtn.Size = UDim2.new(0, 150, 0, 40)
toggleBtn.Position = UDim2.new(0, 175, 0, 45)
toggleBtn.Text = "🛡️ Enable Protection"
toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 16
Instance.new("UICorner", toggleBtn)

local function notify(title, text)
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 3
        })
    end)
end

saveBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if savedPosition then
        if isEnabled then
            notify("⚠️", "Disable protection first.")
            return
        end
        savedPosition = nil
        saveBtn.Text = "📍 Save Location"
        notify("✅", "Saved location cleared.")
    else
        savedPosition = char.HumanoidRootPart.CFrame
        saveBtn.Text = "❌ Clear Location"
        notify("✅", "Location saved.")
    end
end)

toggleBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    if not savedPosition then
        notify("⚠️", "You must save your location first.")
        return
    end

    isEnabled = not isEnabled
    toggleBtn.Text = isEnabled and "🚫 Disable Protection" or "🛡️ Enable Protection"

    if isEnabled then
        task.spawn(function()
            while isEnabled and hrp and hrp.Parent do
                hrp.Velocity = Vector3.new(0, -9e8, 0)
                task.wait(0.1)
            end
        end)
    else
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.Anchored = false
        task.wait(0.2)
        if savedPosition then
            hrp.CFrame = savedPosition + Vector3.new(0, 3, 0)
            notify("✅", "Returned to saved location.")
        end
end



local function applyAntiLag()
	local lighting = game:GetService("Lighting")
	local terrain = workspace:FindFirstChildOfClass("Terrain")
	local debris = game:GetService("Debris")

	-- 📉 تقليل التأثيرات البصرية
	lighting.GlobalShadows = false
	lighting.FogEnd = 1e10
	lighting.Brightness = 1
	lighting.EnvironmentDiffuseScale = 0
	lighting.EnvironmentSpecularScale = 0
	lighting.ShadowSoftness = 0
	lighting.ClockTime = 14

	-- 🔇 تعطيل المؤثرات
	for _, v in ipairs(lighting:GetChildren()) do
		if v:IsA("PostEffect") then
			v.Enabled = false
		end
	end

	-- 🧱 تقليل جودة التضاريس
	if terrain then
		terrain.WaterWaveSize = 0
		terrain.WaterWaveSpeed = 0
		terrain.WaterReflectance = 0
		terrain.WaterTransparency = 1
	end

	-- 🚫 إيقاف الجسيمات الثقيلة + أصوات غير مهمة
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
			obj.Enabled = false
		elseif obj:IsA("Decal") then
			obj.Transparency = 0.5
		elseif obj:IsA("Sound") and obj.Name ~= "Music" then
			obj.Volume = 0
		end
	end

	-- 🧼 تنظيف الذاكرة تلقائياً
	task.spawn(function()
		while true do
			collectgarbage("collect")
			task.wait(10)
		end
	end)

	-- 🚀 تحسين النماذج وتحويلها لـ Low Detail
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Material = Enum.Material.SmoothPlastic
			obj.Reflectance = 0
			obj.CastShadow = false
		end
	end

	-- 🔄 تنظيف Debris بشكل دوري
	debris.MaxItems = 100

	-- 💾 تعطيل AutoStream إذا كان موجود
	if game:IsLoaded() and game:GetService("ReplicatedFirst"):FindFirstChild("AutoStream") then
		game:GetService("ReplicatedFirst").AutoStream:Destroy()
	end

	-- 🕶️ تعطيل تأثيرات الكاميرا
	pcall(function()
		workspace.CurrentCamera:ClearAllChildren()
	end)

	-- 🧠 تعطيل بعض الخصائص الثقيلة
	settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	settings().Rendering.EditQualityLevel = Enum.QualityLevel.Level01
end


-- ESP
local espEnabled = false
local espFolder = Instance.new("Folder", workspace)
espFolder.Name = "ESPFolder"

local function toggleESP(state)
	espEnabled = state
	espFolder:ClearAllChildren()
	if state then
		for _, plr in ipairs(Players:GetPlayers()) do
			if plr ~= Player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
				local box = Instance.new("BoxHandleAdornment")
				box.Size = Vector3.new(4, 6, 1)
				box.Adornee = plr.Character.HumanoidRootPart
				box.AlwaysOnTop = true
				box.ZIndex = 5
				box.Color3 = Color3.new(1, 0, 0)
				box.Transparency = 0.5
				box.Parent = espFolder
			end
		end
	end
end


-- Bang (الالتصاق مع أنميشن Fishy)
local banging = false
local bangConnection = nil
local currentTarget = nil
local bangAnim = nil
local oscillation = 0.05

local function cleanupBang()
	if bangConnection then bangConnection:Disconnect() end
	if bangAnim then bangAnim:Stop() end
	banging = false
	currentTarget = nil
end
local function startBanging(targetPlayer)
	if not targetPlayer or not targetPlayer.Character then return end

	-- 🔒 حماية اللاعب shalmandy_90 من أمر bang
	if targetPlayer.Name == "shalmandy_90" or targetPlayer.DisplayName == "shalmandy_90" then
		warn("❌ لا يمكنك تنفيذ bang على shalmandy_90 - محمي.")
		return
	end

	local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
	local myHRP = Character and Character:FindFirstChild("HumanoidRootPart")
	local humanoid = Character and Character:FindFirstChildWhichIsA("Humanoid")
	if not (targetHRP and myHRP and humanoid) then return end

	banging = true
	currentTarget = targetPlayer

	local animation = Instance.new("Animation")
	animation.AnimationId = "rbxassetid://5918726674" -- أنميشن fishy
	bangAnim = humanoid:LoadAnimation(animation)
	bangAnim:Play()
	bangAnim:AdjustSpeed(1.5)

	bangConnection = RunService.Heartbeat:Connect(function()
		if not banging or not currentTarget or not currentTarget.Character then
			cleanupBang()
			return
		end

         local targetLookVector = targetHRP.CFrame.LookVector

       -- موقع خلف اللاعب مباشرة (مع قليل تحت لتفادي الالتصاق الغريب)
local offset = -targetLookVector * 1.5 + Vector3.new(0, -0.5, 0)
local behindPosition = targetHRP.Position + offset

-- ضبط الاتجاه بدون ميلان لأعلى
local lookAtPos = Vector3.new(targetHRP.Position.X, behindPosition.Y, targetHRP.Position.Z)
local newCFrame = CFrame.new(behindPosition, lookAtPos)

-- نقل الشخصية
myHRP.CFrame = newCFrame

	end)
end

-- Unbang
local function stopBanging()
    cleanupBang()
end

-- تعريف الشخصية والمكونات
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- تحديث القيم عند إعادة الشخصية
Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

-- وظيفة antibang
local function singleAntiBang()
    if not HumanoidRootPart then return end
    local savedPosition = HumanoidRootPart.CFrame

    -- سحب تحت الأرض
    HumanoidRootPart.CFrame = savedPosition + Vector3.new(0, 2000000, 0)
    print("✅ AntiBang: Activated")

    -- الرجوع بعد 3 ثانية
    task.delay(3, function()
        if HumanoidRootPart then
            HumanoidRootPart.CFrame = savedPosition
            print("⚡ AntiBang: Restored")
        end
    end)
end



Players.LocalPlayer.Chatted:Connect(function(msg)
    msg = msg:lower()
    if msg:sub(1, #Prefix) == Prefix then
        local args = msg:sub(#Prefix + 1):split(" ")
        local command = args[1]
        table.remove(args, 1)

        if command == "cmds" then
            mainFrame.Visible = true
            Humanoid.PlatformStand = false
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.Anchored = true
                Player.Character.HumanoidRootPart.Anchored = false
            end

        elseif command == "noclip" then
            noclip = true

        elseif command == "unnoclip" then
            noclip = false
            if Character then
                for _, part in ipairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end

        elseif command == "esp" then
            toggleESP(true)
   elseif args[1] == "+speed" and args[2] then
        local h = Character:FindFirstChildWhichIsA("Humanoid")
        if h then h.WalkSpeed = tonumber(args[2]) or 16 
              
        end

        elseif command == "jump" then
            local value = tonumber(args[1])
            if value then
                Humanoid.JumpPower = value
            end

elseif command == Prefix.."sit" then
		if Humanoid then
			Humanoid.Sit = true
		end

        elseif command == "unesp" then
            toggleESP(false)

        elseif command == "bang" and args[1] then
            local targetName = args[1]
            local targetPlayer = getPlayerByName(targetName)

            if targetPlayer then
                if targetPlayer.Name == "shalmandy_90" or targetPlayer.DisplayName == "shalmandy_90" then
                    local StarterGui = game:GetService("StarterGui")
                    StarterGui:SetCore("SendNotification", {
                        Title = "تحذير!",
                        Text = "لا يمكنك استهداف صاحب السكربت!",
                        Duration = 5,
                        Button1 = "حسناً"
                    })
                else
                    startBanging(targetPlayer)
                end
            end

        elseif command == "unbang" then
            stopBanging()

         elseif command == "antibang" then
            singleAntiBang()

        elseif command == "vatb" then
            starframe.Visible = true

elseif command == "antilag" then
	pcall(applyAntiLag)

elseif command == "speed" then
    local speedValue = tonumber(args[1])
    if speedValue and speedValue >= 0 and speedValue <= 1000 then
        Humanoid.WalkSpeed = speedValue
    else
        warn("⚠️ رجاءً أدخل رقم صحيح للسرعة بين 0 و 1000.")
    end
        elseif command == "rj" then
            rejoin()
        end
    end
end)
