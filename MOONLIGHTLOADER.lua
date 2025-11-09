local Source = [=[
local cloneref = cloneref or function(Service) return Service; end

-- Services
local function GetService(Service)
	return cloneref(game:GetService(Service));
end

local Players = GetService("Players");
local RunService = GetService("RunService");
local TweenService = GetService("TweenService");

-- Functions
local Elements = {}; do
	function Elements:New(Class, Properties)
		local Object = Instance.new(Class);

		for Property, Value in Properties do
			Object[Property] = Value;
		end

		return Object;
	end
end

-- Variables
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = (RunService:IsStudio() and LocalPlayer.PlayerGui) or GetService("CoreGui");

local GothamFont = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);

-- Loading Screen
local function CreateLoadingScreen()
	local LoadingScreen = Elements:New("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		Parent = PlayerGui;
	});

	local LoadingFrame = Elements:New("Frame", {
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.fromRGB(16, 16, 16);
		Size = UDim2.new(0, 0, 0, 0);
		Position = UDim2.new(0.5, 0, 0.5, 0);
		AnchorPoint = Vector2.new(0.5, 0.5);
		BorderColor3 = Color3.fromRGB(0, 0, 0);
		Parent = LoadingScreen;
	});

	local UICorner = Elements:New("UICorner", {
		CornerRadius = UDim.new(0, 8);
		Parent = LoadingFrame;
	});

	local UIStroke = Elements:New("UIStroke", {
		Color = Color3.fromRGB(45, 45, 45);
		Thickness = 2;
		Parent = LoadingFrame;
	});

	local LoadingText = Elements:New("TextLabel", {
		Text = "Loading MoonLight...";
		TextWrapped = true;
		BorderSizePixel = 0;
		TextScaled = true;
		BackgroundTransparency = 1;
		FontFace = GothamFont;
		TextSize = 18;
		Size = UDim2.new(0.8, 0, 0.3, 0);
		Position = UDim2.new(0.1, 0, 0.2, 0);
		TextColor3 = Color3.fromRGB(255, 255, 255);
		Parent = LoadingFrame;
	});

	local UIGradient = Elements:New("UIGradient", {
		Color = ColorSequence.new{ 
			ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
		};
		Parent = LoadingText;
	});

	local SpinnerContainer = Elements:New("Frame", {
		BackgroundTransparency = 1;
		Size = UDim2.new(0.3, 0, 0.3, 0);
		Position = UDim2.new(0.35, 0, 0.5, 0);
		Parent = LoadingFrame;
	});

	local Spinner = Elements:New("ImageLabel", {
		BackgroundTransparency = 1;
		Size = UDim2.new(1, 0, 1, 0);
		Image = "rbxassetid://106296997";
		ImageColor3 = Color3.fromRGB(138, 43, 226);
		Parent = SpinnerContainer;
	});

	-- Animate loading screen entrance
	TweenService:Create(LoadingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.15, 0, 0.2, 0)
	}):Play();

	-- Spin animation
	task.spawn(function()
		while LoadingScreen.Parent do
			TweenService:Create(Spinner, TweenInfo.new(1, Enum.EasingStyle.Linear), {
				Rotation = 360
			}):Play();
			task.wait(1);
			Spinner.Rotation = 0;
		end
	end);

	-- Gradient animation
	task.spawn(function()
		while LoadingScreen.Parent do
			TweenService:Create(UIGradient, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
				Offset = Vector2.new(1, 0)
			}):Play();
			task.wait(2);
		end
	end);

	return LoadingScreen;
end

-- Main
task.spawn(function()
	local LoadingScreen = CreateLoadingScreen();
	task.wait(0.5);

	local LoaderUI = Elements:New("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		Parent = PlayerGui;
	});

	local Holder = Elements:New("Frame", {
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.fromRGB(16, 16, 16);
		Size = UDim2.new(0, 0, 0, 0);
		Position = UDim2.new(0.364177, 0, 0.325, 0);
		BorderColor3 = Color3.fromRGB(0, 0, 0);
		Parent = LoaderUI;
	}); do
		local Bottom = Elements:New("Frame", {
			BorderSizePixel = 0;
			BackgroundColor3 = Color3.fromRGB(22, 22, 22);
			Size = UDim2.new(1, 0, 0.25, 0);
			Position = UDim2.new(0, 0, 0.75, 0);
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			Parent = Holder;
		});

		local UIStroke_4 = Elements:New("UIStroke", {
			Color = Color3.fromRGB(45, 45, 45);
			Parent = Bottom;
		});

		local UICorner_4 = Elements:New("UICorner", {
			CornerRadius = UDim.new(0, 4);
			Parent = Bottom;
		});

		local LoadButton = Elements:New("TextButton", {
			TextWrapped = true;
			BorderSizePixel = 0;
			AutoButtonColor = false;
			TextScaled = true;
			BackgroundColor3 = Color3.fromRGB(24, 24, 24);
			FontFace = GothamFont;
			TextSize = 14;
			Size = UDim2.new(0.9, 0, 0.6, 0);
			Position = UDim2.new(0.05, 0, 0.2, 0);
			TextColor3 = Color3.fromRGB(255, 255, 255);
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			Text = "Load MoonLight";
			Parent = Bottom;
		}); do
			local UICorner_3 = Elements:New("UICorner", {
				CornerRadius = UDim.new(0, 4);
				Parent = LoadButton;
			});

			local UIStroke_3 = Elements:New("UIStroke", {
				Color = Color3.fromRGB(45, 45, 45);
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Parent = LoadButton;
			});

			LoadButton.MouseButton1Click:Connect(function()
				LoadButton.Text = "Loading...";
				LoadButton.BackgroundColor3 = Color3.fromRGB(18, 18, 18);
				
				task.wait(0.3);
				
				local Success, Error = pcall(function()
					loadstring(game:HttpGet("https://raw.githubusercontent.com/UniTheVerse/MoonLight/refs/heads/main/MoonHook"))();
				end)
				
				if Success then
					LoaderUI:Destroy();
				else
					LoadButton.Text = "Failed to Load";
					LoadButton.BackgroundColor3 = Color3.fromRGB(180, 30, 30);
					task.wait(2);
					LoadButton.Text = "Load MoonLight";
					LoadButton.BackgroundColor3 = Color3.fromRGB(24, 24, 24);
				end
			end)
			
			LoadButton.MouseEnter:Connect(function()
				TweenService:Create(LoadButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}):Play();
			end)
			
			LoadButton.MouseLeave:Connect(function()
				TweenService:Create(LoadButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}):Play();
			end)
		end

		local ContentFrame = Elements:New("Frame", {
			BorderSizePixel = 0;
			BackgroundColor3 = Color3.fromRGB(20, 20, 20);
			Size = UDim2.new(1, 0, 0.62, 0);
			Position = UDim2.new(0, 0, 0.13, 0);
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			Parent = Holder;
		}); do
			local Description = Elements:New("TextLabel", {
				TextWrapped = true;
				BorderSizePixel = 0;
				TextScaled = true;
				BackgroundColor3 = Color3.fromRGB(255, 255, 255);
				FontFace = GothamFont;
				TextSize = 14;
				Size = UDim2.new(0.9, 0, 0.8, 0);
				Position = UDim2.new(0.05, 0, 0.1, 0);
				TextColor3 = Color3.fromRGB(180, 180, 180);
				BorderColor3 = Color3.fromRGB(0, 0, 0);
				Text = "Click the button below to load MoonLight script executor.";
				BackgroundTransparency = 1;
				TextXAlignment = Enum.TextXAlignment.Center;
				TextYAlignment = Enum.TextYAlignment.Center;
				Parent = ContentFrame;
			});
		end
	end

	local UIStroke = Elements:New("UIStroke", {
		Color = Color3.fromRGB(45, 45, 45);
		Parent = Holder;
	});

	local Top = Elements:New("Frame", {
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.fromRGB(22, 22, 22);
		Size = UDim2.new(1, 0, 0.13, 0);
		Position = UDim2.new(0, 0, 0, 0);
		BorderColor3 = Color3.fromRGB(0, 0, 0);
		Parent = Holder;
	}); do
		local Title = Elements:New("TextLabel", {
			Text = "MoonLight Loader";
			TextWrapped = true;
			BorderSizePixel = 0;
			TextScaled = true;
			BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			FontFace = GothamFont;
			TextSize = 14;
			Size = UDim2.new(1, 0, 1, 0);
			TextColor3 = Color3.fromRGB(255, 255, 255);
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			BackgroundTransparency = 1;
			Parent = Top;
		}); do
			local UIGradient = Elements:New("UIGradient", {
				Color = ColorSequence.new{ 
					ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(75, 0, 130)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
				};
				Parent = Title;
			});
			
			-- Animate gradient
			task.spawn(function()
				while LoaderUI.Parent do
					TweenService:Create(UIGradient, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Offset = Vector2.new(1, 0)}):Play();
					task.wait(3);
				end
			end)
		end

		local UIDragDetector = Elements:New("UIDragDetector", {
			BoundingUI = LoaderUI;
			ReferenceUIInstance = Top;
			Parent = Holder;
		});

		local UICorner = Elements:New("UICorner", {
			CornerRadius = UDim.new(0, 4);
			Parent = Top;
		});

		local UIStroke_1 = Elements:New("UIStroke", {
			Color = Color3.fromRGB(45, 45, 45);
			Parent = Top;
		});
	end

	local UICorner_1 = Elements:New("UICorner", {
		CornerRadius = UDim.new(0, 4);
		Parent = Holder;
	});

	-- Animate main UI entrance
	task.wait(0.3);
	TweenService:Create(LoadingScreen:FindFirstChild("Frame"), TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
		Size = UDim2.new(0, 0, 0, 0)
	}):Play();
	
	task.wait(0.3);
	LoadingScreen:Destroy();
	
	TweenService:Create(Holder, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		Size = UDim2.new(0.271032, 0, 0.35, 0)
	}):Play();
end)
]=]

if not EnvShared or not Require then
    local Identity = identifyexecutor() or ""

    Identity = Identity:lower()

    local RunFunction
    local Actor

    if string.find(Identity, "wave") then
        RunFunction = run_on_actor
        Actor = getdeletedactors()[1]
    elseif string.find(Identity, "zenith") or string.find(Identity, "potassium") then
        RunFunction = run_on_thread
        Actor = getactorthreads()[1]
    else
        setfflag("DebugRunParallelLuaOnMainThread", "True")

        queue_on_teleport([=[
            repeat task.wait() until game:IsLoaded()

            task.wait(1);
        ]=] .. Source)

        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)

        return
    end

    RunFunction(Actor, Source)

    return
end

loadstring(Source)()
