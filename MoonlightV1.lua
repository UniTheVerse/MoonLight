local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Uni's Test hub",
    LoadingTitle = "Uni Test 2.1",
    LoadingSubtitle = "by Uni Meow",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Cutiesmeows"
    },
    Discord = {
       Enabled = true,
       Invite = "6RCqGXKPJJ", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "Uni's exploit hub ;)",
       Subtitle = "Linky in discord: 6RCqGXKPJJt",
       Note = "Join server in Misc",
       FileName = "Uniskey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"https://pastebin.com/raw/J0P7gnbR"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })
--HOME
 local MainTab = Window:CreateTab("HOME", nil) -- Title, Image
 local MainSection = MainTab:CreateSection("Player")

 Rayfield:Notify({
    Title = "UNI HAS RATTED YOU HAHA",
    Content = "W EXPLOIT",
    Duration = 6.5,
    Image = nil,
    Actions = { -- Notification Buttons
       Ignore = {
          Name = "OH YES",
          Callback = function()
          print("The user tapped Okay!")
       end
    },
 },
 })

 local Button = MainTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
            end
        end)
    end,
 })
 

 local Slider = MainTab:CreateSlider({
    Name = "Walkspeed",
    Range = {0, 300},
    Increment = 1,
    Suffix = "ZOOM",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = Value
    -- The variable (Value) is a number which correlates to the value the slider is currently at
    end,
 })

 local Slider = MainTab:CreateSlider({
    Name = "Jump Power",
    Range = {0, 300},
    Increment = 1,
    Suffix = "Boing",
    CurrentValue = 50,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        game.Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = Value
    -- The variable (Value) is a number which correlates to the value the slider is currently at
    end,
 })

 local Toggle = MainTab:CreateToggle({
   Name = "Toggle Example",
   CurrentValue = false,
   Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
      loadstring(game:HttpGet('https://pastebin.com/xqf8MsJ6'))()
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})


 
--Visuals
local VisualsTab = Window:CreateTab("Visuals", nil) -- Title, Image
 local VisualsSection = VisualsTab:CreateSection("ESP")

 local Button = VisualsTab:CreateButton({
   Name = "Name ESP (click again to update)",
   Callback = function()
      local function createBillboard(player)
         local billboardGui = Instance.new("BillboardGui")
         billboardGui.Size = UDim2.new(0, 100, 0, 50)
         billboardGui.Adornee = player.Character.Head
         billboardGui.StudsOffset = Vector3.new(0, 3, 0) -- Adjusted to be slightly higher
         billboardGui.Name = "PlayerNameBillboard"
         
         local nameLabel = Instance.new("TextLabel", billboardGui)
         nameLabel.Text = player.Name
         nameLabel.Size = UDim2.new(1, 0, 1, 0)
         nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Green color
         nameLabel.BackgroundTransparency = 1
         nameLabel.Font = Enum.Font.SourceSans
         nameLabel.TextSize = 20
         
         billboardGui.Parent = game.Workspace
      end
      
      -- Function to add billboard GUI for all existing players and listen for new ones
      local function setupBillboards()
         for _, player in ipairs(game.Players:GetPlayers()) do
             createBillboard(player)
         end
         game.Players.PlayerAdded:Connect(function(player)
             createBillboard(player)
         end)
      end
      
      -- Call the setup function when the script starts
      setupBillboards()
   end,
})