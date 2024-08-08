local Window = Rayfield:CreateWindow({
   Name = "Moon Hub Bens Casino V1",
   LoadingTitle = "Moon Hub Light",
   LoadingSubtitle = "by Uni",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },
   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Moon Hub Light Key System",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "MK1", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"https://pastebin.com/2ViZBX4s"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})
local Tab = Window:CreateTab("Slots", nil) -- Title, Image
local Section = Tab:CreateSection("Auto")
local Toggle = Tab:CreateToggle({
   Name = "Auto lever",
   CurrentValue = false,
   Flag = "leverpull", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
      local args = {
         [1] = "PullLever"
     }
     
     workspace:WaitForChild("Games"):WaitForChild("Slots"):WaitForChild("CatalogHaven"):WaitForChild("Remotes"):WaitForChild("PlayerAction"):FireServer(unpack(args))
     
   end,
})
