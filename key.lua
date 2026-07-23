--[[
    Auto Mineral Route Walker - KEY SYSTEM
    This file handles key verification and loads the obfuscated main script
    DO NOT OBFUSCATE THIS FILE
]]

-- ============================================
-- KEY SYSTEM WITH ENCODED KEY
-- ============================================

local keySystem = {
    verified = false,
    linkvertiseUrl = "https://link-center.net/7725830/Lx9TBmZN4g94",
    validKey = nil,
    gui = nil
}

-- Decode the key using XOR encryption
local function decodeKey()
    local encoded = {107, 63, 52, 51, 55, 35, 63, 49, 42, 55, 63, 46}
    local decoded = {}
    
    for index = #encoded, 1, -1 do
        decoded[#decoded + 1] = string.char(bit32.bxor(encoded[index], 0x5A))
    end
    
    return table.concat(decoded)
end

-- Set the valid key
keySystem.validKey = decodeKey()

-- Function to show key GUI
local function showKeyGUI()
    local player = game:GetService("Players").LocalPlayer
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeySystemGUI"
    screenGui.Parent = player:WaitForChild("PlayerGui")
    keySystem.gui = screenGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 320)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -160)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 3
    mainFrame.BorderColor3 = Color3.fromRGB(255, 150, 50)
    mainFrame.Parent = screenGui
    
    -- Make draggable
    local dragging = false
    local dragStart
    local startPos
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
                startPos.Y.Offset + delta.Y)
        end
    end)
    
    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 15)
    title.BackgroundTransparency = 1
    title.Text = "🔐 ACCESS REQUIRED"
    title.TextColor3 = Color3.fromRGB(255, 150, 50)
    title.TextSize = 26
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Instructions
    local instructions = Instance.new("TextLabel")
    instructions.Size = UDim2.new(1, -30, 0, 60)
    instructions.Position = UDim2.new(0, 15, 0, 70)
    instructions.BackgroundTransparency = 1
    instructions.Text = "1. Click 'Get Key' to complete Linkvertise ads\n2. Copy your unique key\n3. Paste it below to unlock the script"
    instructions.TextColor3 = Color3.fromRGB(200, 200, 200)
    instructions.TextSize = 14
    instructions.Font = Enum.Font.Gotham
    instructions.TextXAlignment = Enum.TextXAlignment.Center
    instructions.LineHeight = 1.5
    instructions.Parent = mainFrame
    
    -- Get Key Button
    local getKeyButton = Instance.new("TextButton")
    getKeyButton.Size = UDim2.new(0.8, 0, 0, 45)
    getKeyButton.Position = UDim2.new(0.1, 0, 0, 140)
    getKeyButton.BackgroundColor3 = Color3.fromRGB(80, 40, 120)
    getKeyButton.BorderColor3 = Color3.fromRGB(80, 80, 100)
    getKeyButton.Text = "🔗 GET KEY (Linkvertise)"
    getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyButton.TextSize = 16
    getKeyButton.Font = Enum.Font.GothamBold
    getKeyButton.Parent = mainFrame
    
    getKeyButton.MouseButton1Click:Connect(function()
        -- Open Linkvertise
        game:GetService("GuiService"):OpenBrowserWindow(keySystem.linkvertiseUrl)
        
        -- Copy link to clipboard
        local success, err = pcall(function()
            setclipboard(keySystem.linkvertiseUrl)
        end)
        
        if success then
            statusLabel.Text = "📋 Link copied to clipboard! Complete the ads."
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            statusLabel.Text = "🔗 Link opened in browser! Complete the ads."
            statusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
        end
    end)
    
    -- Key input
    local keyInput = Instance.new("TextBox")
    keyInput.Size = UDim2.new(0.8, 0, 0, 40)
    keyInput.Position = UDim2.new(0.1, 0, 0, 195)
    keyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    keyInput.BorderColor3 = Color3.fromRGB(80, 80, 100)
    keyInput.PlaceholderText = "Paste your key here..."
    keyInput.Text = ""
    keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyInput.TextSize = 16
    keyInput.Font = Enum.Font.Gotham
    keyInput.Parent = mainFrame
    
    -- Verify Button
    local verifyButton = Instance.new("TextButton")
    verifyButton.Size = UDim2.new(0.4, 0, 0, 40)
    verifyButton.Position = UDim2.new(0.3, 0, 0, 245)
    verifyButton.BackgroundColor3 = Color3.fromRGB(60, 200, 60)
    verifyButton.BorderColor3 = Color3.fromRGB(80, 80, 100)
    verifyButton.Text = "✅ Unlock Script"
    verifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    verifyButton.TextSize = 16
    verifyButton.Font = Enum.Font.GothamBold
    verifyButton.Parent = mainFrame
    
    -- Status label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 25)
    statusLabel.Position = UDim2.new(0, 0, 0, 290)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Complete the Linkvertise ads to get your key"
    statusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    statusLabel.TextSize = 12
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame
    
    -- Verify function
    local function verifyKey()
        local inputKey = keyInput.Text:gsub("%s+", "")
        
        if inputKey == keySystem.validKey then
            keySystem.verified = true
            statusLabel.Text = "✅ ACCESS GRANTED! Loading script..."
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            verifyButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
            verifyButton.Text = "✅ UNLOCKED!"
            
            -- Log key usage
            print(string.format("🔑 Script unlocked by %s", player.Name))
            
            task.wait(0.5)
            screenGui:Destroy()
            keySystem.gui = nil
            
            -- Load the obfuscated main script from GitHub
            loadMainScript()
        else
            statusLabel.Text = "❌ Invalid key! Please check and try again."
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            keyInput.Text = ""
            keyInput:CaptureFocus()
            
            -- Shake animation
            local originalPos = mainFrame.Position
            for i = 1, 3 do
                mainFrame.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset + 10, originalPos.Y.Scale, originalPos.Y.Offset)
                task.wait(0.05)
                mainFrame.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset - 10, originalPos.Y.Scale, originalPos.Y.Offset)
                task.wait(0.05)
            end
            mainFrame.Position = originalPos
        end
    end
    
    verifyButton.MouseButton1Click:Connect(verifyKey)
    keyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            verifyKey()
        end
    end)
    
    -- Enter key also works
    keyInput:CaptureFocus()
end

-- ============================================
-- LOAD MAIN SCRIPT FROM GITHUB
-- ============================================

function loadMainScript()
    local success, err = pcall(function()
        -- URL to your OBFUSCATED main script
        -- This file should ONLY contain your main script, NO key system
        local mainScript = game:HttpGet("https://raw.githubusercontent.com/firefoxgon-lab/dribjsnf-q/refs/heads/main/main_obfuscated.lua")
        loadstring(mainScript)()
    end)
    
    if not success then
        print("❌ Failed to load main script: " .. tostring(err))
        
        -- Show error message to user
        local player = game:GetService("Players").LocalPlayer
        local errorGui = Instance.new("ScreenGui")
        errorGui.Name = "ErrorGUI"
        errorGui.Parent = player:WaitForChild("PlayerGui")
        
        local errorFrame = Instance.new("Frame")
        errorFrame.Size = UDim2.new(0, 400, 0, 150)
        errorFrame.Position = UDim2.new(0.5, -200, 0.5, -75)
        errorFrame.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
        errorFrame.BorderSizePixel = 3
        errorFrame.BorderColor3 = Color3.fromRGB(255, 50, 50)
        errorFrame.Parent = errorGui
        
        local errorTitle = Instance.new("TextLabel")
        errorTitle.Size = UDim2.new(1, 0, 0, 50)
        errorTitle.Position = UDim2.new(0, 0, 0, 10)
        errorTitle.BackgroundTransparency = 1
        errorTitle.Text = "❌ Script Load Failed"
        errorTitle.TextColor3 = Color3.fromRGB(255, 50, 50)
        errorTitle.TextSize = 24
        errorTitle.Font = Enum.Font.GothamBold
        errorTitle.Parent = errorFrame
        
        local errorMsg = Instance.new("TextLabel")
        errorMsg.Size = UDim2.new(1, -20, 0, 50)
        errorMsg.Position = UDim2.new(0, 10, 0, 65)
        errorMsg.BackgroundTransparency = 1
        errorMsg.Text = "Failed to load the main script.\nPlease try again later or contact support."
        errorMsg.TextColor3 = Color3.fromRGB(200, 200, 200)
        errorMsg.TextSize = 14
        errorMsg.Font = Enum.Font.Gotham
        errorMsg.TextWrapped = true
        errorMsg.Parent = errorFrame
        
        local closeButton = Instance.new("TextButton")
        closeButton.Size = UDim2.new(0.3, 0, 0, 35)
        closeButton.Position = UDim2.new(0.35, 0, 0, 105)
        closeButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
        closeButton.BorderColor3 = Color3.fromRGB(80, 80, 100)
        closeButton.Text = "Close"
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.TextSize = 14
        closeButton.Font = Enum.Font.GothamBold
        closeButton.Parent = errorFrame
        
        closeButton.MouseButton1Click:Connect(function()
            errorGui:Destroy()
        end)
    end
end

-- ============================================
-- STARTUP - Show key GUI first
-- ============================================

task.wait(0.5)
showKeyGUI()
