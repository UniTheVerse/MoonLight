local UILib = loadstring(game:HttpGet('https://raw.githubusercontent.com/UniTheVerse/e/main/Main'))()
local Window = UILib.new("MOONLIGHT", game.Players.LocalPlayer.UserId, "Buyer")
local Category1 = Window:Category("Main", "http://www.roblox.com/asset/?id=8395621517")
local SubButton1 = Category1:Button("Player", "http://www.roblox.com/asset/?id=2706340901")
local Section1 = SubButton1:Section("Section", "Left")
local SubButton2 = Category1:Button("Visuals", "http://www.roblox.com/asset/?id=11346388439")
local Section2 = SubButton2:Section("Section", "Left")
local SubButton3 = Category1:Button("Combat", "http://www.roblox.com/asset/?id=11346388439")
local Section3 = SubButton3:Section("Section", "Left")
Section1:Slider({
    Title = "Walkspeed",
    Description = "Go fast",
    Default = 16,
    Min = 0,
    Max = 320
    }, function(Value)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = Value
end)

Section1:Slider({
    Title = "JumpPower",
    Description = "Jump high",
    Default = 50,
    Min = 0,
    Max = 520
    }, function(Value)
     game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = Value
end)

Section2:Toggle({
    Title = "Box ESP",
    Description = "Optional Description here",
    Default = false
    }, function(value)
        local highlightingEnabled = true -- Variable to control whether highlighting is enabled or not

        -- Function to highlight a player
        local function highlightPlayer(player)
            local function createHighlight()
                local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    local highlight = Instance.new("SelectionBox")
                    highlight.Name = "PlayerHighlight"
                    highlight.Adornee = humanoid.Parent
                    highlight.Color3 = Color3.fromRGB(0, 255, 0) -- You can change the color here
                    highlight.LineThickness = 0.05
                    highlight.SurfaceTransparency = 1 -- Adjust this value to control visibility through walls
                    highlight.Parent = game.Workspace.CurrentCamera
                    return highlight
                end
            end
            
            local highlight = createHighlight()
        
            player.CharacterAdded:Connect(function(character)
                if highlightingEnabled then -- Only create highlight if highlighting is enabled
                    highlight = createHighlight()
                end
            end)
        
            player.Character:WaitForChild("Humanoid").Died:Connect(function()
                if highlight then
                    highlight:Destroy()
                end
            end)
        end
        
        -- Function to highlight all players in the game
        local function highlightAllPlayers()
            for _, player in ipairs(game.Players:GetPlayers()) do
                highlightPlayer(player)
            end
        end
        
        -- Function to handle new player joining
        local function onPlayerAdded(player)
            highlightPlayer(player)
        end
        
        -- Function to periodically check and highlight players without the highlight
        local function checkAndHighlightPlayers()
            if highlightingEnabled then -- Only check and highlight players if highlighting is enabled
                for _, player in ipairs(game.Players:GetPlayers()) do
                    if not player.Character or not player.Character:FindFirstChild("PlayerHighlight") then
                        highlightPlayer(player)
                    end
                end
            end
        end
        
        -- Connect the function to highlight all players when the script starts
        highlightAllPlayers()
        
        -- Connect the function to handle new player joining
        game.Players.PlayerAdded:Connect(onPlayerAdded)
        
        -- Periodically check and highlight players without the highlight
        while true do
            wait(10) -- Wait for 10 seconds
            checkAndHighlightPlayers()
        end
        
        -- Function to turn off highlighting
        local function turnOffHighlighting()
            highlightingEnabled = false
            -- Destroy the script itself to turn off the highlighting functionality
            script:Destroy()
        end
        
        -- Example of how to turn off highlighting
        -- You can call this function from anywhere in your code when you want to turn off highlighting
        -- turnOffHighlighting()
        

end)

Section3:Toggle({
    Title = "Legit Aimbot",
    Description = "Gyatt",
    Default = false
    }, function(value)
  -- Define variables
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Camera = game.Workspace.CurrentCamera
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local isLockedOn = false
local targetPlayer = nil

-- Function to check if the local player's camera is facing a target player
local function isFacingTarget(targetPlayer)
    local targetPosition = targetPlayer.Character.Head.Position
    local cameraPosition = Camera.CFrame.Position
    local cameraLookVector = Camera.CFrame.LookVector
    local cameraToTargetVector = (targetPosition - cameraPosition).unit

    -- Check if the dot product of the camera's look vector and the vector to the target is positive
    -- This indicates that the camera is facing towards the target
    return cameraLookVector:Dot(cameraToTargetVector) > 0
end

-- Function to find the closest visible player that the local player is facing
local function findClosestVisibleFacingPlayer()
    local closestPlayer = nil
    local closestDistance = math.huge
    local cameraPosition = Camera.CFrame.Position

    for _, plyr in ipairs(Players:GetPlayers()) do
        if plyr ~= player then
            local char = plyr.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local targetPosition = char.HumanoidRootPart.Position
                local ray = Ray.new(cameraPosition, (targetPosition - cameraPosition).unit * 1000)
                local part = workspace:FindPartOnRay(ray, player.Character, false, true)
                if part and part:IsDescendantOf(char) and isFacingTarget(plyr) then
                    local distance = (targetPosition - cameraPosition).magnitude
                    if distance < closestDistance then
                        closestPlayer = plyr
                        closestDistance = distance
                    end
                end
            end
        end
    end

    return closestPlayer
end

-- Function to smoothly move the camera towards the target
local function moveToTarget(targetPosition)
    local cameraPosition = Camera.CFrame.Position
    local distance = (targetPosition - cameraPosition).magnitude
    local speed = 0.1 -- Adjust the speed as needed

    Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(cameraPosition, targetPosition), speed)

    return distance
end

-- Function to lock onto the closest visible facing player
local function lockOntoClosestPlayer()
    local closestPlayer = findClosestVisibleFacingPlayer()
    if closestPlayer then
        isLockedOn = true
        targetPlayer = closestPlayer
        local targetPosition = targetPlayer.Character.Head.Position
        moveToTarget(targetPosition)
    end
end

-- Event listener for right-click press
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        lockOntoClosestPlayer()
    end
end)

-- Event listener for right-click release
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        isLockedOn = false
        targetPlayer = nil
    end
end)

-- Render step function to continuously update camera position
game:GetService("RunService").RenderStepped:Connect(function()
    if isLockedOn and targetPlayer then
        local targetPosition = targetPlayer.Character.Head.Position
        moveToTarget(targetPosition)
    end
end)

end)
