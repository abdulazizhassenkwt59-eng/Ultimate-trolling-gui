-- Ultimate Trolling GUI Server-Side Script (No LocalScripts)
-- Place in ServerScriptService

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local Debris = game:GetService("Debris")

-- Admin check (only game creator by default)
local function isAdmin(player)
    return player.UserId == game.CreatorId
end

-- Function to create the trolling GUI and insert handling Script
local function createTrollGUI(targetPlayer)
    local playerGui = targetPlayer:WaitForChild("PlayerGui")
    
    -- Clean up existing
    local existing = playerGui:FindFirstChild("TrollGUI")
    if existing then existing:Destroy() end
    
    -- Main ScreenGui (server-created, replicates to client)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TrollGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    
    -- Add UIScale for device scaling
    local uiScale = Instance.new("UIScale")
    uiScale.Scale = 1
    uiScale.Parent = screenGui
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.BackgroundTransparency = 0.3
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Title Label
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Text = "Ultimate Troll Panel 😈"
    title.TextColor3 = Color3.fromRGB(255, 0, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Create a server Script (not LocalScript) to handle interactions in PlayerGui context
    local trollScript = Instance.new("Script")  -- Regular Script, runs per-player in PlayerGui
    trollScript.Name = "TrollHandler"
    trollScript.Source = [[
        -- Troll Handler Script (runs in PlayerGui context, no LocalScript)
        local screenGui = script.Parent
        local mainFrame = screenGui:WaitForChild("Frame")
        local Players = game:GetService("Players")
        local localPlayer = Players.LocalPlayer  -- Accessible here
        local Debris = game:GetService("Debris")
        local TweenService = game:GetService("TweenService")
        
        -- Rickroll Button
        local rickButton = mainFrame:WaitForChild("RickrollButton")
        rickButton.MouseButton1Click:Connect(function()
            local videoFrame = Instance.new("Frame")
            videoFrame.Size = UDim2.new(1, 0, 1, 0)
            videoFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            videoFrame.Parent = screenGui
            
            local videoLabel = Instance.new("TextLabel")
            videoLabel.Size = UDim2.new(1, 0, 1, 0)
            videoLabel.BackgroundTransparency = 1
            videoLabel.Text = "🎵 Never Gonna Give You Up 🎵\\n(Imagine Rick Astley dancing! Rickroll Activated!)\\n\\nClose in 10s..."
            videoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            videoLabel.TextScaled = true
            videoLabel.Font = Enum.Font.Gotham
            videoLabel.Parent = videoFrame
            
            Debris:AddItem(videoFrame, 10)
            rickButton.Text = "Rickrolled! 😂"
        end)
        
        -- Fake Ban Button
        local banButton = mainFrame:WaitForChild("BanButton")
        banButton.MouseButton1Click:Connect(function()
            local banScreen = Instance.new("Frame")
            banScreen.Size = UDim2.new(1, 0, 1, 0)
            banScreen.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            banScreen.Parent = screenGui
            
            local banText = Instance.new("TextLabel")
            banText.Size = UDim2.new(1, 0, 1, 0)
            banText.BackgroundTransparency = 1
            banText.Text = "🚫 YOU'VE BEEN BANNED! 🚫\\nReason: Too troll-y!\\nUnbanning in 10..."
            banText.TextColor3 = Color3.fromRGB(255, 0, 0)
            banText.TextScaled = true
            banText.Font = Enum.Font.GothamBold
            banText.Parent = banScreen
            
            -- Countdown (server-timed, but in player context)
            spawn(function()
                for i = 9, 0, -1 do
                    banText.Text = "🚫 YOU'VE BEEN BANNED! 🚫\\nReason: Too troll-y!\\nUnbanning in " .. i .. "..."
                    wait(1)
                end
                banScreen:Destroy()
            end)
            
            banButton.Text = "Banned! (Fake) 😄"
        end)
        
        -- Meme Spam Button (fires to server via chat simulation or direct)
        local memeButton = mainFrame:WaitForChild("MemeButton")
        memeButton.MouseButton1Click:Connect(function()
            -- Simulate chat spam by sending messages (uses Chatted equivalent)
            local memes = {"Doge says: Such troll! Wow!", "This is fine... 🐶🔥", "Troll level: Expert", "Never gonna give you up... again!", "Poggers! 😎"}
            spawn(function()
                for i = 1, 6 do
                    local message = memes[math.random(1, #memes)]
                    -- Use TextChatService directly (works in this context)
                    pcall(function()
                        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(message)
                    end)
                    wait(5)
                end
            end)
            memeButton.Text = "Memes sent! 📱"
        end)
        
        -- Invisible Button (server effect, but triggered here)
        local invisibleButton = mainFrame:WaitForChild("InvisibleButton")
        invisibleButton.MouseButton1Click:Connect(function()
            -- Trigger server-side invisibility via attribute or direct change
            localPlayer:SetAttribute("MakeInvisible", true)
            invisibleButton.Text = "Poof! Gone for 5s 👻"
        end)
        
        -- Close Button
        local closeButton = mainFrame:WaitForChild("CloseButton")
        closeButton.MouseButton1Click:Connect(function()
            screenGui:Destroy()
        end)
        
        -- Fallback for devices: Use Activated if needed (but MouseButton1Click works cross-device)
    ]]
    trollScript.Parent = screenGui  -- Parent to ScreenGui for per-player execution
    
    -- Now create buttons (after Script, so it can reference them)
    local rickButton = Instance.new("TextButton")
    rickButton.Name = "RickrollButton"
    rickButton.Size = UDim2.new(0.9, 0, 0, 40)
    rickButton.Position = UDim2.new(0.05, 0, 0, 60)
    rickButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    rickButton.Text = "Rickroll Me!"
    rickButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    rickButton.TextScaled = true
    rickButton.Parent = mainFrame
    
    local banButton = Instance.new("TextButton")
    banButton.Name = "BanButton"
    banButton.Size = UDim2.new(0.9, 0, 0, 40)
    banButton.Position = UDim2.new(0.05, 0, 0, 110)
    banButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    banButton.Text = "Fake Ban!"
    banButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    banButton.TextScaled = true
    banButton.Parent = mainFrame
    
    local memeButton = Instance.new("TextButton")
    memeButton.Name = "MemeButton"
    memeButton.Size = UDim2.new(0.9, 0, 0, 40)
    memeButton.Position = UDim2.new(0.05, 0, 0, 160)
    memeButton.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
    memeButton.Text = "Meme Spam Chat!"
    memeButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    memeButton.TextScaled = true
    memeButton.Parent = mainFrame
    
    local invisibleButton = Instance.new("TextButton")
    invisibleButton.Name = "InvisibleButton"
    invisibleButton.Size = UDim2.new(0.9, 0, 0, 40)
    invisibleButton.Position = UDim2.new(0.05, 0, 0, 210)
    invisibleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    invisibleButton.Text = "Go Invisible!"
    invisibleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    invisibleButton.TextScaled = true
    invisibleButton.Parent = mainFrame
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.9, 0, 0, 40)
    closeButton.Position = UDim2.new(0.05, 0, 0, 260)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "Close Troll Panel"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Parent = mainFrame
    
    print("Troll GUI created for " .. targetPlayer.Name)
end

-- Handle invisibility from player attributes (server listens)
Players.PlayerAdded:Connect(function(player)
    player.AttributeChanged:Connect(function(attr)
        if attr == "MakeInvisible" and player:GetAttribute("MakeInvisible") then
            local character = player.Character
            if character then
                for _, part in pairs(character:GetChildren()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.Transparency = 0.8
                    end
                end
                -- Revert after 5s
                spawn(function()
                    wait(5)
                    player:SetAttribute("MakeInvisible", nil)
                    if character.Parent then
                        for _, part in pairs(character:GetChildren()) do
                            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                                part.Transparency = 0
                            end
                        end
                    end
                end)
            end
        end
    end)
end)

-- Chat command activation
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        local lowerMsg = message:lower()
        if lowerMsg:match("^/troll") and isAdmin(player) then
            local args = message:split(" ")
            local target = player
            if args[2] then
                target = Players:FindFirstChild(args[2])
            end
            if target then
                createTrollGUI(target)
            else
                print("Target not found!")
            end
        end
    end)
end)

print("Fully Server-Side Trolling GUI loaded! Use /troll in chat.")