local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local httpService = game:GetService("HttpService")

local Mobile = not RunService:IsStudio() and table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform()) ~= nil

local RenderStepped = RunService.RenderStepped

-- Height of the top bar, in pixels, and the window corner radius. Every window
-- offset is derived from these, so changing them re-lays the whole window out.
local TITLEBAR_HEIGHT = Mobile and 54 or 48
local WINDOW_CORNER = 10

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end
local ParentUi = LocalPlayer:FindFirstChild("PlayerGui")

local Themes = {
	Names = {
		"Dark",
		"Darker",
		"AMOLED",
		"Light",
		"Balloon",
		"SoftCream",
		"Aqua",
		"Amethyst",
		"Rose",
		"Midnight",
		"Forest",
		"Sunset",
		"Ocean",
		"Emerald",
		"Sapphire",
		"Cloud",
		"Grape",
		"Bloody",
		"Arctic"
	},
	Dark = {
		Name = "Dark",
		Accent = Color3.fromRGB(96, 205, 255),
		AcrylicMain = Color3.fromRGB(60, 60, 60),
		AcrylicBorder = Color3.fromRGB(90, 90, 90),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(40, 40, 40), Color3.fromRGB(40, 40, 40)),
		AcrylicNoise = 0.9,
		TitleBarLine = Color3.fromRGB(75, 75, 75),
		Tab = Color3.fromRGB(120, 120, 120),
		Element = Color3.fromRGB(120, 120, 120),
		ElementBorder = Color3.fromRGB(35, 35, 35),
		InElementBorder = Color3.fromRGB(90, 90, 90),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(120, 120, 120),
		ToggleToggled = Color3.fromRGB(42, 42, 42),
		SliderRail = Color3.fromRGB(120, 120, 120),
		DropdownFrame = Color3.fromRGB(160, 160, 160),
		DropdownHolder = Color3.fromRGB(45, 45, 45),
		DropdownBorder = Color3.fromRGB(35, 35, 35),
		DropdownOption = Color3.fromRGB(120, 120, 120),
		Keybind = Color3.fromRGB(120, 120, 120),
		Input = Color3.fromRGB(160, 160, 160),
		InputFocused = Color3.fromRGB(10, 10, 10),
		InputIndicator = Color3.fromRGB(150, 150, 150),
		Dialog = Color3.fromRGB(45, 45, 45),
		DialogHolder = Color3.fromRGB(35, 35, 35),
		DialogHolderLine = Color3.fromRGB(30, 30, 30),
		DialogButton = Color3.fromRGB(45, 45, 45),
		DialogButtonBorder = Color3.fromRGB(80, 80, 80),
		DialogBorder = Color3.fromRGB(70, 70, 70),
		DialogInput = Color3.fromRGB(55, 55, 55),
		DialogInputLine = Color3.fromRGB(160, 160, 160),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(120, 120, 120),
		HoverChange = 0.07,
	},
	Darker = {
		Name = "Darker",
		Accent = Color3.fromRGB(56, 109, 223),
		AcrylicMain = Color3.fromRGB(30, 30, 30),
		AcrylicBorder = Color3.fromRGB(60, 60, 60),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(17, 17, 17), Color3.fromRGB(18, 18, 18)),
		AcrylicNoise = 0.94,
		TitleBarLine = Color3.fromRGB(65, 65, 65),
		Tab = Color3.fromRGB(100, 100, 100),
		Element = Color3.fromRGB(70, 70, 70),
		ElementBorder = Color3.fromRGB(25, 25, 25),
		InElementBorder = Color3.fromRGB(55, 55, 55),
		ElementTransparency = 0.82,
		DropdownFrame = Color3.fromRGB(120, 120, 120),
		DropdownHolder = Color3.fromRGB(35, 35, 35),
		DropdownBorder = Color3.fromRGB(25, 25, 25),
		Dialog = Color3.fromRGB(35, 35, 35),
		DialogHolder = Color3.fromRGB(25, 25, 25),
		DialogHolderLine = Color3.fromRGB(20, 20, 20),
		DialogButton = Color3.fromRGB(35, 35, 35),
		DialogButtonBorder = Color3.fromRGB(55, 55, 55),
		DialogBorder = Color3.fromRGB(50, 50, 50),
		DialogInput = Color3.fromRGB(45, 45, 45),
		DialogInputLine = Color3.fromRGB(120, 120, 120),
		ToggleSlider = Color3.fromRGB(100, 100, 100),
		ToggleToggled = Color3.fromRGB(22, 22, 22),
		SliderRail = Color3.fromRGB(100, 100, 100),
		DropdownOption = Color3.fromRGB(100, 100, 100),
		Keybind = Color3.fromRGB(100, 100, 100),
		Input = Color3.fromRGB(140, 140, 140),
		InputFocused = Color3.fromRGB(10, 10, 10),
		InputIndicator = Color3.fromRGB(130, 130, 130),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(165, 165, 165),
		Hover = Color3.fromRGB(100, 100, 100),
		HoverChange = 0.06,
	},
	AMOLED = {
		Name = "AMOLED",
		Accent = Color3.fromRGB(255, 255, 255),
		AcrylicMain = Color3.fromRGB(0, 0, 0),
		AcrylicBorder = Color3.fromRGB(20, 20, 20),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0)),
		AcrylicNoise = 1,
		TitleBarLine = Color3.fromRGB(25, 25, 25),
		Tab = Color3.fromRGB(40, 40, 40),
		Element = Color3.fromRGB(15, 15, 15),
		ElementBorder = Color3.fromRGB(0, 0, 0),
		InElementBorder = Color3.fromRGB(40, 40, 40),
		ElementTransparency = 0.95,
		ToggleSlider = Color3.fromRGB(40, 40, 40),
		ToggleToggled = Color3.fromRGB(255, 255, 255),
		SliderRail = Color3.fromRGB(40, 40, 40),
		DropdownFrame = Color3.fromRGB(20, 20, 20),
		DropdownHolder = Color3.fromRGB(0, 0, 0),
		DropdownBorder = Color3.fromRGB(0, 0, 0),
		DropdownOption = Color3.fromRGB(40, 40, 40),
		Keybind = Color3.fromRGB(40, 40, 40),
		Input = Color3.fromRGB(40, 40, 40),
		InputFocused = Color3.fromRGB(0, 0, 0),
		InputIndicator = Color3.fromRGB(60, 60, 60),
		InputIndicatorFocus = Color3.fromRGB(255, 255, 255),
		Dialog = Color3.fromRGB(0, 0, 0),
		DialogHolder = Color3.fromRGB(0, 0, 0),
		DialogHolderLine = Color3.fromRGB(20, 20, 20),
		DialogButton = Color3.fromRGB(15, 15, 15),
		DialogButtonBorder = Color3.fromRGB(30, 30, 30),
		DialogBorder = Color3.fromRGB(27, 27, 27),
		DialogInput = Color3.fromRGB(15, 15, 15),
		DialogInputLine = Color3.fromRGB(60, 60, 60),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(40, 40, 40),
		HoverChange = 0.04
	},
	Light = {
		Name = "Light",
		Accent = Color3.fromRGB(0, 103, 192),
		AcrylicMain = Color3.fromRGB(200, 200, 200),
		AcrylicBorder = Color3.fromRGB(120, 120, 120),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)),
		AcrylicNoise = 0.96,
		TitleBarLine = Color3.fromRGB(160, 160, 160),
		Tab = Color3.fromRGB(90, 90, 90),
		Element = Color3.fromRGB(255, 255, 255),
		ElementBorder = Color3.fromRGB(180, 180, 180),
		InElementBorder = Color3.fromRGB(150, 150, 150),
		ElementTransparency = 0.65,
		ToggleSlider = Color3.fromRGB(40, 40, 40),
		ToggleToggled = Color3.fromRGB(255, 255, 255),
		SliderRail = Color3.fromRGB(40, 40, 40),
		DropdownFrame = Color3.fromRGB(200, 200, 200),
		DropdownHolder = Color3.fromRGB(240, 240, 240),
		DropdownBorder = Color3.fromRGB(200, 200, 200),
		DropdownOption = Color3.fromRGB(150, 150, 150),
		Keybind = Color3.fromRGB(120, 120, 120),
		Input = Color3.fromRGB(200, 200, 200),
		InputFocused = Color3.fromRGB(100, 100, 100),
		InputIndicator = Color3.fromRGB(80, 80, 80),
		InputIndicatorFocus = Color3.fromRGB(0, 103, 192),
		Dialog = Color3.fromRGB(255, 255, 255),
		DialogHolder = Color3.fromRGB(240, 240, 240),
		DialogHolderLine = Color3.fromRGB(228, 228, 228),
		DialogButton = Color3.fromRGB(255, 255, 255),
		DialogButtonBorder = Color3.fromRGB(190, 190, 190),
		DialogBorder = Color3.fromRGB(140, 140, 140),
		DialogInput = Color3.fromRGB(250, 250, 250),
		DialogInputLine = Color3.fromRGB(160, 160, 160),
		Text = Color3.fromRGB(0, 0, 0),
		SubText = Color3.fromRGB(40, 40, 40),
		Hover = Color3.fromRGB(50, 50, 50),
		HoverChange = 0.16,
	},
	Balloon = {
		Name = "Balloon",
		Accent = Color3.fromRGB(100, 170, 255),
		AcrylicMain = Color3.fromRGB(189, 224, 255),
		AcrylicBorder = Color3.fromRGB(160, 227, 255),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(240, 250, 255), Color3.fromRGB(210, 235, 250)),
		AcrylicNoise = 1,
		TitleBarLine = Color3.fromRGB(150, 200, 255),
		Tab = Color3.fromRGB(153, 185, 255),
		Element = Color3.fromRGB(160, 200, 255),
		ElementBorder = Color3.fromRGB(130, 170, 230),
		InElementBorder = Color3.fromRGB(120, 174, 240),
		ElementTransparency = 0.80,
		ToggleSlider = Color3.fromRGB(93, 163, 255),
		ToggleToggled = Color3.fromRGB(60, 112, 180),
		SliderRail = Color3.fromRGB(170, 220, 255),
		DropdownFrame = Color3.fromRGB(175, 235, 255),
		DropdownHolder = Color3.fromRGB(200, 220, 240),
		DropdownBorder = Color3.fromRGB(130, 170, 230),
		DropdownOption = Color3.fromRGB(146, 202, 255),
		Keybind = Color3.fromRGB(170, 220, 255),
		Input = Color3.fromRGB(170, 220, 255),
		InputFocused = Color3.fromRGB(75, 95, 140),
		InputIndicator = Color3.fromRGB(190, 250, 255),
		InputIndicatorFocus = Color3.fromRGB(100, 170, 255),
		Dialog = Color3.fromRGB(189, 230, 255),
		DialogHolder = Color3.fromRGB(201, 239, 255),
		DialogHolderLine = Color3.fromRGB(197, 236, 250),
		DialogButton = Color3.fromRGB(219, 252, 255),
		DialogButtonBorder = Color3.fromRGB(160, 200, 255),
		DialogBorder = Color3.fromRGB(175, 220, 255),
		DialogInput = Color3.fromRGB(160, 200, 255),
		DialogInputLine = Color3.fromRGB(185, 230, 255),
		Text = Color3.fromRGB(30, 30, 30),
		SubText = Color3.fromRGB(90, 90, 90),
		Hover = Color3.fromRGB(170, 220, 255),
		HoverChange = 0.03
	},
	SoftCream = {
		Name = "SoftCream",
		Accent = Color3.fromRGB(206, 163, 90),
		AcrylicMain = Color3.fromRGB(255, 245, 220),
		AcrylicBorder = Color3.fromRGB(255, 230, 200),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(255, 245, 220), Color3.fromRGB(255, 235, 210)),
		AcrylicNoise = 0.93,
		TitleBarLine = Color3.fromRGB(255, 220, 190),
		Tab = Color3.fromRGB(199, 165, 112),
		Element = Color3.fromRGB(255, 216, 161),
		ElementBorder = Color3.fromRGB(234, 193, 111),
		InElementBorder = Color3.fromRGB(255, 212, 143),
		ElementTransparency = 0.80,
		ToggleSlider = Color3.fromRGB(214, 175, 97),
		ToggleToggled = Color3.fromRGB(200, 160, 100),
		SliderRail = Color3.fromRGB(255, 220, 190),
		DropdownFrame = Color3.fromRGB(255, 228, 164),
		DropdownHolder = Color3.fromRGB(250, 240, 225),
		DropdownBorder = Color3.fromRGB(255, 210, 180),
		DropdownOption = Color3.fromRGB(255, 190, 115),
		Keybind = Color3.fromRGB(255, 220, 190),
		Input = Color3.fromRGB(255, 220, 190),
		InputFocused = Color3.fromRGB(180, 140, 80),
		InputIndicator = Color3.fromRGB(255, 250, 205),
		InputIndicatorFocus = Color3.fromRGB(255, 236, 158),
		Dialog = Color3.fromRGB(255, 255, 240),
		DialogHolder = Color3.fromRGB(255, 245, 220),
		DialogHolderLine = Color3.fromRGB(255, 240, 210),
		DialogButton = Color3.fromRGB(255, 255, 240),
		DialogButtonBorder = Color3.fromRGB(255, 210, 180),
		DialogBorder = Color3.fromRGB(255, 220, 190),
		DialogInput = Color3.fromRGB(255, 210, 180),
		DialogInputLine = Color3.fromRGB(255, 225, 205),
		Text = Color3.fromRGB(30, 30, 30),
		SubText = Color3.fromRGB(90, 90, 90),
		Hover = Color3.fromRGB(255, 220, 190),
		HoverChange = 0.03
	},
	Aqua = {
		Name = "Aqua",
		Accent = Color3.fromRGB(38, 166, 178),
		AcrylicMain = Color3.fromRGB(18, 54, 61),
		AcrylicBorder = Color3.fromRGB(80, 118, 130),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(41, 101, 139), Color3.fromRGB(11, 132, 128)),
		AcrylicNoise = 0.92,
		TitleBarLine = Color3.fromRGB(68, 135, 136),
		Tab = Color3.fromRGB(126, 175, 180),
		Element = Color3.fromRGB(66, 130, 160),
		ElementBorder = Color3.fromRGB(40, 100, 122),
		InElementBorder = Color3.fromRGB(75, 109, 110),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(100, 152, 160),
		ToggleToggled = Color3.fromRGB(25, 70, 95),
		SliderRail = Color3.fromRGB(115, 150, 160),
		DropdownFrame = Color3.fromRGB(158, 194, 200),
		DropdownHolder = Color3.fromRGB(39, 99, 116),
		DropdownBorder = Color3.fromRGB(33, 119, 120),
		DropdownOption = Color3.fromRGB(121, 152, 160),
		Keybind = Color3.fromRGB(108, 153, 160),
		Input = Color3.fromRGB(112, 156, 160),
		InputFocused = Color3.fromRGB(14, 35, 40),
		InputIndicator = Color3.fromRGB(137, 181, 190),
		Dialog = Color3.fromRGB(27, 113, 130),
		DialogHolder = Color3.fromRGB(33, 99, 109),
		DialogHolderLine = Color3.fromRGB(34, 81, 86),
		DialogButton = Color3.fromRGB(27, 128, 130),
		DialogButtonBorder = Color3.fromRGB(62, 100, 110),
		DialogBorder = Color3.fromRGB(26, 86, 100),
		DialogInput = Color3.fromRGB(36, 107, 105),
		DialogInputLine = Color3.fromRGB(70, 120, 130),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(112, 155, 160),
		HoverChange = 0.04,
	},
	Amethyst = {
		Name = "Amethyst",
		Accent = Color3.fromRGB(126, 44, 182),
		AcrylicMain = Color3.fromRGB(40, 12, 71),
		AcrylicBorder = Color3.fromRGB(85, 45, 120),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(34, 19, 49), Color3.fromRGB(41, 24, 57)),
		AcrylicNoise = 0.92,
		TitleBarLine = Color3.fromRGB(95, 55, 130),
		Tab = Color3.fromRGB(135, 75, 170),
		Element = Color3.fromRGB(115, 55, 150),
		ElementBorder = Color3.fromRGB(60, 35, 85),
		InElementBorder = Color3.fromRGB(85, 45, 110),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(135, 65, 160),
		ToggleToggled = Color3.fromRGB(59, 30, 79),
		SliderRail = Color3.fromRGB(135, 65, 160),
		DropdownFrame = Color3.fromRGB(145, 85, 170),
		DropdownHolder = Color3.fromRGB(50, 30, 70),
		DropdownBorder = Color3.fromRGB(60, 35, 85),
		DropdownOption = Color3.fromRGB(135, 65, 160),
		Keybind = Color3.fromRGB(135, 65, 160),
		Input = Color3.fromRGB(135, 65, 160),
		InputFocused = Color3.fromRGB(25, 15, 35),
		InputIndicator = Color3.fromRGB(155, 85, 180),
		InputIndicatorFocus = Color3.fromRGB(126, 44, 182),
		Dialog = Color3.fromRGB(50, 30, 70),
		DialogHolder = Color3.fromRGB(40, 25, 60),
		DialogHolderLine = Color3.fromRGB(35, 20, 55),
		DialogButton = Color3.fromRGB(50, 30, 70),
		DialogButtonBorder = Color3.fromRGB(90, 50, 120),
		DialogBorder = Color3.fromRGB(80, 45, 110),
		DialogInput = Color3.fromRGB(60, 35, 80),
		DialogInputLine = Color3.fromRGB(145, 75, 170),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(135, 65, 160),
		HoverChange = 0.04
	},
	Rose = {
		Name = "Rose",
		Accent = Color3.fromRGB(219, 48, 123),
		AcrylicMain = Color3.fromRGB(35, 25, 30),
		AcrylicBorder = Color3.fromRGB(145, 35, 75),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(65, 25, 45), Color3.fromRGB(75, 30, 50)),
		AcrylicNoise = 0.92,
		TitleBarLine = Color3.fromRGB(150, 65, 95),
		Tab = Color3.fromRGB(190, 85, 115),
		Element = Color3.fromRGB(170, 60, 90),
		ElementBorder = Color3.fromRGB(95, 35, 55),
		InElementBorder = Color3.fromRGB(120, 50, 70),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(190, 75, 105),
		ToggleToggled = Color3.fromRGB(45, 15, 25),
		SliderRail = Color3.fromRGB(190, 75, 105),
		DropdownFrame = Color3.fromRGB(200, 95, 125),
		DropdownHolder = Color3.fromRGB(75, 30, 45),
		DropdownBorder = Color3.fromRGB(95, 35, 55),
		DropdownOption = Color3.fromRGB(190, 75, 105),
		Keybind = Color3.fromRGB(190, 75, 105),
		Input = Color3.fromRGB(190, 75, 105),
		InputFocused = Color3.fromRGB(35, 15, 20),
		InputIndicator = Color3.fromRGB(210, 95, 125),
		InputIndicatorFocus = Color3.fromRGB(219, 48, 123),
		Dialog = Color3.fromRGB(75, 30, 45),
		DialogHolder = Color3.fromRGB(65, 25, 40),
		DialogHolderLine = Color3.fromRGB(60, 20, 35),
		DialogButton = Color3.fromRGB(75, 30, 45),
		DialogButtonBorder = Color3.fromRGB(115, 45, 65),
		DialogBorder = Color3.fromRGB(105, 40, 60),
		DialogInput = Color3.fromRGB(85, 35, 50),
		DialogInputLine = Color3.fromRGB(200, 85, 115),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(190, 75, 105),
		HoverChange = 0.04
	},
	Midnight = {
		Name = "Midnight",
		Accent = Color3.fromRGB(52, 50, 178),
		AcrylicMain = Color3.fromRGB(20, 20, 20),
		AcrylicBorder = Color3.fromRGB(83, 83, 130),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(1, 1, 39), Color3.fromRGB(6, 6, 54)),
		AcrylicNoise = 0.96,
		TitleBarLine = Color3.fromRGB(77, 75, 126),
		Tab = Color3.fromRGB(126, 127, 180),
		Element = Color3.fromRGB(111, 108, 160),
		ElementBorder = Color3.fromRGB(32, 32, 59),
		InElementBorder = Color3.fromRGB(85, 83, 110),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(120, 117, 160),
		ToggleToggled = Color3.fromRGB(30, 12, 68),
		SliderRail = Color3.fromRGB(117, 117, 160),
		DropdownFrame = Color3.fromRGB(161, 161, 200),
		DropdownHolder = Color3.fromRGB(35, 36, 80),
		DropdownBorder = Color3.fromRGB(32, 30, 65),
		DropdownOption = Color3.fromRGB(116, 116, 160),
		Keybind = Color3.fromRGB(110, 123, 160),
		Input = Color3.fromRGB(116, 112, 160),
		InputFocused = Color3.fromRGB(20, 10, 30),
		InputIndicator = Color3.fromRGB(136, 140, 190),
		Dialog = Color3.fromRGB(37, 37, 80),
		DialogHolder = Color3.fromRGB(24, 24, 65),
		DialogHolderLine = Color3.fromRGB(25, 26, 60),
		DialogButton = Color3.fromRGB(46, 44, 80),
		DialogButtonBorder = Color3.fromRGB(71, 72, 110),
		DialogBorder = Color3.fromRGB(72, 70, 100),
		DialogInput = Color3.fromRGB(55, 55, 85),
		DialogInputLine = Color3.fromRGB(133, 131, 190),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(119, 121, 160),
		HoverChange = 0.04,
	},
	Forest = {
		Name = "Forest",
		Accent = Color3.fromRGB(46, 141, 70),
		AcrylicMain = Color3.fromRGB(20, 35, 25),
		AcrylicBorder = Color3.fromRGB(50, 90, 60),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(15, 35, 20), Color3.fromRGB(20, 40, 25)),
		AcrylicNoise = 0.92,
		TitleBarLine = Color3.fromRGB(60, 100, 70),
		Tab = Color3.fromRGB(80, 140, 90),
		Element = Color3.fromRGB(70, 120, 80),
		ElementBorder = Color3.fromRGB(30, 50, 35),
		InElementBorder = Color3.fromRGB(60, 90, 70),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(90, 150, 100),
		ToggleToggled = Color3.fromRGB(19, 57, 21),
		SliderRail = Color3.fromRGB(90, 150, 100),
		DropdownFrame = Color3.fromRGB(100, 160, 110),
		DropdownHolder = Color3.fromRGB(35, 60, 40),
		DropdownBorder = Color3.fromRGB(30, 50, 35),
		DropdownOption = Color3.fromRGB(90, 150, 100),
		Keybind = Color3.fromRGB(90, 150, 100),
		Input = Color3.fromRGB(90, 150, 100),
		InputFocused = Color3.fromRGB(15, 25, 18),
		InputIndicator = Color3.fromRGB(110, 170, 120),
		InputIndicatorFocus = Color3.fromRGB(46, 141, 70),
		Dialog = Color3.fromRGB(35, 60, 40),
		DialogHolder = Color3.fromRGB(30, 50, 35),
		DialogHolderLine = Color3.fromRGB(25, 45, 30),
		DialogButton = Color3.fromRGB(35, 60, 40),
		DialogButtonBorder = Color3.fromRGB(70, 110, 80),
		DialogBorder = Color3.fromRGB(60, 100, 70),
		DialogInput = Color3.fromRGB(45, 70, 50),
		DialogInputLine = Color3.fromRGB(100, 160, 110),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(90, 150, 100),
		HoverChange = 0.04
	},
	Sunset = {
		Name = "Sunset",
		Accent = Color3.fromRGB(255, 128, 0),
		AcrylicMain = Color3.fromRGB(40, 25, 25),
		AcrylicBorder = Color3.fromRGB(130, 80, 60),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(70, 35, 20), Color3.fromRGB(60, 30, 20)),
		AcrylicNoise = 0.92,
		TitleBarLine = Color3.fromRGB(140, 90, 70),
		Tab = Color3.fromRGB(180, 120, 90),
		Element = Color3.fromRGB(160, 100, 70),
		ElementBorder = Color3.fromRGB(70, 40, 30),
		InElementBorder = Color3.fromRGB(110, 70, 50),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(180, 110, 80),
		ToggleToggled = Color3.fromRGB(62, 34, 21),
		SliderRail = Color3.fromRGB(180, 110, 80),
		DropdownFrame = Color3.fromRGB(190, 130, 100),
		DropdownHolder = Color3.fromRGB(60, 35, 25),
		DropdownBorder = Color3.fromRGB(70, 40, 30),
		DropdownOption = Color3.fromRGB(180, 110, 80),
		Keybind = Color3.fromRGB(180, 110, 80),
		Input = Color3.fromRGB(180, 110, 80),
		InputFocused = Color3.fromRGB(30, 20, 15),
		InputIndicator = Color3.fromRGB(200, 130, 100),
		InputIndicatorFocus = Color3.fromRGB(255, 128, 0),
		Dialog = Color3.fromRGB(60, 35, 25),
		DialogHolder = Color3.fromRGB(50, 30, 20),
		DialogHolderLine = Color3.fromRGB(45, 25, 15),
		DialogButton = Color3.fromRGB(60, 35, 25),
		DialogButtonBorder = Color3.fromRGB(100, 65, 45),
		DialogBorder = Color3.fromRGB(90, 55, 40),
		DialogInput = Color3.fromRGB(70, 45, 35),
		DialogInputLine = Color3.fromRGB(190, 120, 90),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(180, 110, 80),
		HoverChange = 0.04
	},
	Ocean = {
		Name = "Ocean",
		Accent = Color3.fromRGB(0, 141, 255),
		AcrylicMain = Color3.fromRGB(20, 25, 40),
		AcrylicBorder = Color3.fromRGB(40, 60, 100),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(15, 25, 45), Color3.fromRGB(20, 30, 50)),
		AcrylicNoise = 0.92,
		TitleBarLine = Color3.fromRGB(50, 70, 120),
		Tab = Color3.fromRGB(70, 90, 160),
		Element = Color3.fromRGB(60, 80, 140),
		ElementBorder = Color3.fromRGB(30, 40, 70),
		InElementBorder = Color3.fromRGB(50, 60, 100),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(80, 100, 170),
		ToggleToggled = Color3.fromRGB(11, 35, 67),
		SliderRail = Color3.fromRGB(80, 100, 170),
		DropdownFrame = Color3.fromRGB(90, 110, 180),
		DropdownHolder = Color3.fromRGB(25, 35, 60),
		DropdownBorder = Color3.fromRGB(30, 40, 70),
		DropdownOption = Color3.fromRGB(80, 100, 170),
		Keybind = Color3.fromRGB(80, 100, 170),
		Input = Color3.fromRGB(80, 100, 170),
		InputFocused = Color3.fromRGB(15, 20, 35),
		InputIndicator = Color3.fromRGB(100, 120, 190),
		InputIndicatorFocus = Color3.fromRGB(0, 141, 255),
		Dialog = Color3.fromRGB(25, 35, 60),
		DialogHolder = Color3.fromRGB(20, 30, 55),
		DialogHolderLine = Color3.fromRGB(15, 25, 50),
		DialogButton = Color3.fromRGB(25, 35, 60),
		DialogButtonBorder = Color3.fromRGB(45, 65, 110),
		DialogBorder = Color3.fromRGB(40, 60, 100),
		DialogInput = Color3.fromRGB(35, 45, 70),
		DialogInputLine = Color3.fromRGB(90, 110, 180),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(80, 100, 170),
		HoverChange = 0.04
	},
	Emerald = {
		Name = "Emerald",
		Accent = Color3.fromRGB(0, 168, 107),
		AcrylicMain = Color3.fromRGB(20, 35, 30),
		AcrylicBorder = Color3.fromRGB(30, 100, 80),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(20, 55, 45), Color3.fromRGB(25, 60, 50)),
		AcrylicNoise = 0.92,
		TitleBarLine = Color3.fromRGB(40, 110, 90),
		Tab = Color3.fromRGB(50, 130, 100),
		Element = Color3.fromRGB(40, 120, 95),
		ElementBorder = Color3.fromRGB(25, 75, 60),
		InElementBorder = Color3.fromRGB(35, 85, 70),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(45, 130, 100),
		ToggleToggled = Color3.fromRGB(15, 40, 30),
		SliderRail = Color3.fromRGB(45, 130, 100),
		DropdownFrame = Color3.fromRGB(55, 140, 110),
		DropdownHolder = Color3.fromRGB(20, 70, 55),
		DropdownBorder = Color3.fromRGB(25, 75, 60),
		DropdownOption = Color3.fromRGB(45, 130, 100),
		Keybind = Color3.fromRGB(45, 130, 100),
		Input = Color3.fromRGB(45, 130, 100),
		InputFocused = Color3.fromRGB(10, 35, 25),
		InputIndicator = Color3.fromRGB(55, 150, 120),
		InputIndicatorFocus = Color3.fromRGB(0, 168, 107),
		Dialog = Color3.fromRGB(20, 70, 55),
		DialogHolder = Color3.fromRGB(15, 65, 50),
		DialogHolderLine = Color3.fromRGB(15, 60, 45),
		DialogButton = Color3.fromRGB(20, 70, 55),
		DialogButtonBorder = Color3.fromRGB(30, 90, 70),
		DialogBorder = Color3.fromRGB(25, 85, 65),
		DialogInput = Color3.fromRGB(25, 75, 60),
		DialogInputLine = Color3.fromRGB(50, 140, 110),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(45, 130, 100),
		HoverChange = 0.04
	},
	Sapphire = {
		Name = "Sapphire",
		Accent = Color3.fromRGB(0, 105, 255),
		AcrylicMain = Color3.fromRGB(24, 30, 85),
		AcrylicBorder = Color3.fromRGB(25, 80, 150),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(13, 33, 94), Color3.fromRGB(21, 44, 127)),
		AcrylicNoise = 0.88,
		TitleBarLine = Color3.fromRGB(50, 120, 200),
		Tab = Color3.fromRGB(60, 140, 220),
		Element = Color3.fromRGB(42, 98, 176),
		ElementBorder = Color3.fromRGB(23, 66, 113),
		InElementBorder = Color3.fromRGB(27, 65, 126),
		ElementTransparency = 0.85,
		ToggleSlider = Color3.fromRGB(50, 140, 210),
		ToggleToggled = Color3.fromRGB(20, 50, 80),
		SliderRail = Color3.fromRGB(50, 140, 210),
		DropdownFrame = Color3.fromRGB(60, 150, 230),
		DropdownHolder = Color3.fromRGB(15, 60, 100),
		DropdownBorder = Color3.fromRGB(30, 90, 140),
		DropdownOption = Color3.fromRGB(50, 140, 210),
		Keybind = Color3.fromRGB(50, 140, 210),
		Input = Color3.fromRGB(50, 140, 210),
		InputFocused = Color3.fromRGB(15, 40, 60),
		InputIndicator = Color3.fromRGB(60, 160, 240),
		InputIndicatorFocus = Color3.fromRGB(0, 105, 255),
		Dialog = Color3.fromRGB(10, 60, 100),
		DialogHolder = Color3.fromRGB(15, 50, 90),
		DialogHolderLine = Color3.fromRGB(15, 45, 80),
		DialogButton = Color3.fromRGB(10, 60, 100),
		DialogButtonBorder = Color3.fromRGB(30, 100, 160),
		DialogBorder = Color3.fromRGB(20, 80, 130),
		DialogInput = Color3.fromRGB(30, 90, 140),
		DialogInputLine = Color3.fromRGB(55, 150, 230),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(50, 140, 210),
		HoverChange = 0.05
	},
	Cloud = {
		Name = "Cloud",
		Accent = Color3.fromRGB(27, 114, 138),
		AcrylicMain = Color3.fromRGB(13, 62, 77),
		AcrylicBorder = Color3.fromRGB(80, 118, 130),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(51, 74, 83), Color3.fromRGB(4, 47, 66)),
		AcrylicNoise = 0.94,
		TitleBarLine = Color3.fromRGB(97, 97, 97),
		Tab = Color3.fromRGB(126, 175, 180),
		Element = Color3.fromRGB(66, 130, 160),
		ElementBorder = Color3.fromRGB(40, 100, 122),
		InElementBorder = Color3.fromRGB(75, 109, 110),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(100, 152, 160),
		ToggleToggled = Color3.fromRGB(26, 59, 80),
		SliderRail = Color3.fromRGB(115, 150, 160),
		DropdownFrame = Color3.fromRGB(158, 194, 200),
		DropdownHolder = Color3.fromRGB(39, 99, 116),
		DropdownBorder = Color3.fromRGB(33, 119, 120),
		DropdownOption = Color3.fromRGB(121, 152, 160),
		Keybind = Color3.fromRGB(108, 153, 160),
		Input = Color3.fromRGB(112, 156, 160),
		InputFocused = Color3.fromRGB(14, 35, 40),
		InputIndicator = Color3.fromRGB(137, 181, 190),
		Dialog = Color3.fromRGB(11, 75, 88),
		DialogHolder = Color3.fromRGB(18, 77, 93),
		DialogHolderLine = Color3.fromRGB(33, 76, 86),
		DialogButton = Color3.fromRGB(43, 72, 80),
		DialogButtonBorder = Color3.fromRGB(62, 100, 110),
		DialogBorder = Color3.fromRGB(26, 86, 100),
		DialogInput = Color3.fromRGB(4, 97, 107),
		DialogInputLine = Color3.fromRGB(70, 120, 130),
		Text = Color3.fromRGB(209, 240, 233),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(112, 155, 160),
		HoverChange = 0.04,
	},
	Grape = {
		Name = "Grape",
		Accent = Color3.fromRGB(183, 176, 223),
		AcrylicMain = Color3.fromRGB(0, 0, 0),
		AcrylicBorder = Color3.fromRGB(20, 20, 20),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(6, 0, 16), Color3.fromRGB(6, 0, 16)),
		AcrylicNoise = 1,
		TitleBarLine = Color3.fromRGB(25, 25, 25),
		Tab = Color3.fromRGB(40, 40, 40),
		Element = Color3.fromRGB(15, 15, 15),
		ElementBorder = Color3.fromRGB(6, 0, 16),
		InElementBorder = Color3.fromRGB(40, 40, 40),
		ElementTransparency = 1,
		ToggleSlider = Color3.fromRGB(255, 255, 255),
		ToggleToggled = Color3.fromRGB(19, 16, 36),
		SliderRail = Color3.fromRGB(40, 40, 40),
		DropdownFrame = Color3.fromRGB(20, 20, 20),
		DropdownHolder = Color3.fromRGB(12, 0, 34),
		DropdownBorder = Color3.fromRGB(6, 0, 16),
		DropdownOption = Color3.fromRGB(40, 40, 40),
		Keybind = Color3.fromRGB(40, 40, 40),
		Input = Color3.fromRGB(40, 40, 40),
		InputFocused = Color3.fromRGB(6, 0, 16),
		InputIndicator = Color3.fromRGB(60, 60, 60),
		InputIndicatorFocus = Color3.fromRGB(255, 255, 255),
		Dialog = Color3.fromRGB(7, 0, 18),
		DialogHolder = Color3.fromRGB(7, 0, 18),
		DialogHolderLine = Color3.fromRGB(7, 0, 18),
		DialogButton = Color3.fromRGB(13, 0, 33),
		DialogButtonBorder = Color3.fromRGB(30, 30, 30),
		DialogBorder = Color3.fromRGB(27, 27, 27),
		DialogInput = Color3.fromRGB(7, 0, 18),
		DialogInputLine = Color3.fromRGB(60, 60, 60),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(123, 144, 170),
		Hover = Color3.fromRGB(40, 40, 40),
		HoverChange = 0.04
	},
	Bloody = {
		Name = "Bloody",
		Accent = Color3.fromRGB(144, 0, 0),
		AcrylicMain = Color3.fromRGB(61, 0, 0),
		AcrylicBorder = Color3.fromRGB(86, 0, 0),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(90, 0, 0), Color3.fromRGB(100, 0, 0)),
		AcrylicNoise = 0.92,
		TitleBarLine = Color3.fromRGB(126, 0, 0),
		Tab = Color3.fromRGB(134, 0, 0),
		Element = Color3.fromRGB(156, 0, 0),
		ElementBorder = Color3.fromRGB(91, 0, 0),
		InElementBorder = Color3.fromRGB(106, 0, 0),
		ElementTransparency = 0.86,
		ToggleSlider = Color3.fromRGB(130, 5, 5),
		ToggleToggled = Color3.fromRGB(66, 0, 0),
		SliderRail = Color3.fromRGB(150, 30, 30),
		DropdownFrame = Color3.fromRGB(150, 30, 30),
		DropdownHolder = Color3.fromRGB(79, 0, 0),
		DropdownBorder = Color3.fromRGB(116, 0, 0),
		DropdownOption = Color3.fromRGB(150, 30, 30),
		Keybind = Color3.fromRGB(150, 30, 30),
		Input = Color3.fromRGB(150, 30, 30),
		InputFocused = Color3.fromRGB(40, 10, 10),
		InputIndicator = Color3.fromRGB(113, 1, 1),
		Dialog = Color3.fromRGB(85, 0, 1),
		DialogHolder = Color3.fromRGB(77, 0, 8),
		DialogHolderLine = Color3.fromRGB(88, 4, 4),
		DialogButton = Color3.fromRGB(115, 14, 21),
		DialogButtonBorder = Color3.fromRGB(83, 0, 1),
		DialogBorder = Color3.fromRGB(43, 4, 5),
		DialogInput = Color3.fromRGB(108, 20, 21),
		DialogInputLine = Color3.fromRGB(91, 1, 1),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(131, 131, 131),
		Hover = Color3.fromRGB(181, 0, 0),
		HoverChange = 0.04
	},
	Arctic = {
		Name = "Arctic",
		Accent = Color3.fromRGB(64, 224, 255),
		AcrylicMain = Color3.fromRGB(10, 18, 25),
		AcrylicBorder = Color3.fromRGB(35, 55, 70),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(15, 25, 35), Color3.fromRGB(18, 30, 40)),
		AcrylicNoise = 0.94,
		TitleBarLine = Color3.fromRGB(45, 70, 90),
		Tab = Color3.fromRGB(70, 110, 140),
		Element = Color3.fromRGB(60, 95, 120),
		ElementBorder = Color3.fromRGB(60, 95, 120),
		InElementBorder = Color3.fromRGB(70, 110, 140),
		ElementTransparency = 0.88,
		ToggleSlider = Color3.fromRGB(90, 140, 180),
		ToggleToggled = Color3.fromRGB(15, 25, 35),
		SliderRail = Color3.fromRGB(90, 140, 180),
		DropdownFrame = Color3.fromRGB(110, 170, 220),
		DropdownHolder = Color3.fromRGB(30, 45, 60),
		DropdownBorder = Color3.fromRGB(60, 95, 120),
		DropdownOption = Color3.fromRGB(90, 140, 180),
		Keybind = Color3.fromRGB(90, 140, 180),
		Input = Color3.fromRGB(90, 140, 180),
		InputFocused = Color3.fromRGB(10, 18, 25),
		InputIndicator = Color3.fromRGB(130, 200, 255),
		InputIndicatorFocus = Color3.fromRGB(64, 224, 255),
		Dialog = Color3.fromRGB(30, 45, 60),
		DialogHolder = Color3.fromRGB(18, 30, 40),
		DialogHolderLine = Color3.fromRGB(15, 25, 35),
		DialogButton = Color3.fromRGB(30, 45, 60),
		DialogButtonBorder = Color3.fromRGB(45, 70, 90),
		DialogBorder = Color3.fromRGB(40, 60, 80),
		DialogInput = Color3.fromRGB(35, 55, 70),
		DialogInputLine = Color3.fromRGB(110, 170, 220),
		Text = Color3.fromRGB(240, 250, 255),
		SubText = Color3.fromRGB(180, 200, 220),
		Hover = Color3.fromRGB(90, 140, 180),
		HoverChange = 0.04
	}

}

local Library = {
	Version = "1.2.2",

	OpenFrames = {},
	Options = {},
	Themes = Themes.Names,
	Windows = {},

	Window = nil,
	WindowFrame = nil,
	Unloaded = false,

	Creator = nil,

	Theme = "Dark",
	DialogOpen = false,
	UseAcrylic = false,
	Acrylic = false,
	Transparency = true,
	MinimizeKeybind = nil,
	MinimizeKey = Enum.KeyCode.LeftControl,
}

local function isMotor(value)
	local motorType = tostring(value):match("^Motor%((.+)%)$")

	if motorType then
		return true, motorType
	else
		return false
	end
end

local Connection = {}

Connection.__index = Connection

function Connection.new(signal, handler)
	return setmetatable({
		signal = signal,
		connected = true,
		_handler = handler,
	}, Connection)
end

function Connection:disconnect()
	if self.connected then
		self.connected = false

		for index, connection in pairs(self.signal._connections) do
			if connection == self then
				table.remove(self.signal._connections, index)
				return
			end
		end
	end
end

local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_connections = {},
		_threads = {},
	}, Signal)
end

function Signal:fire(...)
	for _, connection in pairs(self._connections) do
		task.spawn(connection._handler, ...)
	end

	for _, thread in pairs(self._threads) do
		task.spawn(thread, ...)
	end

	self._threads = {}
end

function Signal:connect(handler)
	local connection = Connection.new(self, handler)
	table.insert(self._connections, connection)
	return connection
end

function Signal:wait()
	local thread = coroutine.running()
	table.insert(self._threads, thread)
	return coroutine.yield()
end

local Linear = {}
Linear.__index = Linear

function Linear.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")

	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_velocity = options.velocity or 1,
	}, Linear)
end

function Linear:step(state, dt)
	local position = state.value
	local velocity = self._velocity
	local goal = self._targetValue

	local dPos = dt * velocity

	local complete = dPos >= math.abs(goal - position)
	position = position + dPos * (goal > position and 1 or -1)
	if complete then
		position = self._targetValue
		velocity = 0
	end

	return {
		complete = complete,
		value = position,
		velocity = velocity,
	}
end

local Instant = {}
Instant.__index = Instant

function Instant.new(targetValue)
	return setmetatable({
		_targetValue = targetValue,
	}, Instant)
end

function Instant:step()
	return {
		complete = true,
		value = self._targetValue,
	}
end

local VELOCITY_THRESHOLD = 0.001
local POSITION_THRESHOLD = 0.001

local EPS = 0.0001

local Spring = {}
Spring.__index = Spring

function Spring.new(targetValue, options)
	assert(targetValue, "Missing argument #1: targetValue")
	options = options or {}

	return setmetatable({
		_targetValue = targetValue,
		_frequency = options.frequency or 4,
		_dampingRatio = options.dampingRatio or 1,
	}, Spring)
end

function Spring:step(state, dt)

	local d = self._dampingRatio
	local f = self._frequency * 2 * math.pi
	local g = self._targetValue
	local p0 = state.value
	local v0 = state.velocity or 0

	local offset = p0 - g
	local decay = math.exp(-d * f * dt)

	local p1, v1

	if d == 1 then
		p1 = (offset * (1 + f * dt) + v0 * dt) * decay + g
		v1 = (v0 * (1 - f * dt) - offset * (f * f * dt)) * decay
	elseif d < 1 then
		local c = math.sqrt(1 - d * d)

		local i = math.cos(f * c * dt)
		local j = math.sin(f * c * dt)

		local z
		if c > EPS then
			z = j / c
		else
			local a = dt * f
			z = a + ((a * a) * (c * c) * (c * c) / 20 - c * c) * (a * a * a) / 6
		end

		local y
		if f * c > EPS then
			y = j / (f * c)
		else
			local b = f * c
			y = dt + ((dt * dt) * (b * b) * (b * b) / 20 - b * b) * (dt * dt * dt) / 6
		end

		p1 = (offset * (i + d * z) + v0 * y) * decay + g
		v1 = (v0 * (i - z * d) - offset * (z * f)) * decay
	else
		local c = math.sqrt(d * d - 1)

		local r1 = -f * (d - c)
		local r2 = -f * (d + c)

		local co2 = (v0 - offset * r1) / (2 * f * c)
		local co1 = offset - co2

		local e1 = co1 * math.exp(r1 * dt)
		local e2 = co2 * math.exp(r2 * dt)

		p1 = e1 + e2 + g
		v1 = e1 * r1 + e2 * r2
	end

	local complete = math.abs(v1) < VELOCITY_THRESHOLD and math.abs(p1 - g) < POSITION_THRESHOLD

	return {
		complete = complete,
		value = complete and g or p1,
		velocity = v1,
	}
end

local noop = function() end

local BaseMotor = {}
BaseMotor.__index = BaseMotor

function BaseMotor.new()
	return setmetatable({
		_onStep = Signal.new(),
		_onStart = Signal.new(),
		_onComplete = Signal.new(),
	}, BaseMotor)
end

function BaseMotor:onStep(handler)
	return self._onStep:connect(handler)
end

function BaseMotor:onStart(handler)
	return self._onStart:connect(handler)
end

function BaseMotor:onComplete(handler)
	return self._onComplete:connect(handler)
end

function BaseMotor:start()
	if not self._connection then
		self._connection = RunService.RenderStepped:Connect(function(deltaTime)
			self:step(deltaTime)
		end)
	end
end

function BaseMotor:stop()
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end
end
BaseMotor.destroy = BaseMotor.stop

BaseMotor.step = noop
BaseMotor.getValue = noop
BaseMotor.setGoal = noop

function BaseMotor:__tostring()
	return "Motor"
end

local SingleMotor = setmetatable({}, BaseMotor)
SingleMotor.__index = SingleMotor

function SingleMotor.new(initialValue, useImplicitConnections)
	assert(initialValue, "Missing argument #1: initialValue")
	assert(typeof(initialValue) == "number", "initialValue must be a number!")

	local self = setmetatable(BaseMotor.new(), SingleMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._goal = nil
	self._state = {
		complete = true,
		value = initialValue,
	}

	return self
end

function SingleMotor:step(deltaTime)
	if self._state.complete then
		return true
	end

	local newState = self._goal:step(self._state, deltaTime)

	self._state = newState
	self._onStep:fire(newState.value)

	if newState.complete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._onComplete:fire()
	end

	return newState.complete
end

function SingleMotor:getValue()
	return self._state.value
end

function SingleMotor:setGoal(goal)
	self._state.complete = false
	self._goal = goal

	self._onStart:fire()

	if self._useImplicitConnections then
		self:start()
	end
end

function SingleMotor:__tostring()
	return "Motor(Single)"
end

local GroupMotor = setmetatable({}, BaseMotor)
GroupMotor.__index = GroupMotor

local function toMotor(value)
	if isMotor(value) then
		return value
	end

	local valueType = typeof(value)

	if valueType == "number" then
		return SingleMotor.new(value, false)
	elseif valueType == "table" then
		return GroupMotor.new(value, false)
	end

	error(("Unable to convert %q to motor; type %s is unsupported"):format(value, valueType), 2)
end

function GroupMotor.new(initialValues, useImplicitConnections)
	assert(initialValues, "Missing argument #1: initialValues")
	assert(typeof(initialValues) == "table", "initialValues must be a table!")
	assert(
		not initialValues.step,
		'initialValues contains disallowed property "step". Did you mean to put a table of values here?'
	)

	local self = setmetatable(BaseMotor.new(), GroupMotor)

	if useImplicitConnections ~= nil then
		self._useImplicitConnections = useImplicitConnections
	else
		self._useImplicitConnections = true
	end

	self._complete = true
	self._motors = {}

	for key, value in pairs(initialValues) do
		self._motors[key] = toMotor(value)
	end

	return self
end

function GroupMotor:step(deltaTime)
	if self._complete then
		return true
	end

	local allMotorsComplete = true

	for _, motor in pairs(self._motors) do
		local complete = motor:step(deltaTime)
		if not complete then

			allMotorsComplete = false
		end
	end

	self._onStep:fire(self:getValue())

	if allMotorsComplete then
		if self._useImplicitConnections then
			self:stop()
		end

		self._complete = true
		self._onComplete:fire()
	end

	return allMotorsComplete
end

function GroupMotor:setGoal(goals)
	assert(not goals.step, 'goals contains disallowed property "step". Did you mean to put a table of goals here?')

	self._complete = false
	self._onStart:fire()

	for key, goal in pairs(goals) do
		local motor = assert(self._motors[key], ("Unknown motor for key %s"):format(key))
		motor:setGoal(goal)
	end

	if self._useImplicitConnections then
		self:start()
	end
end

function GroupMotor:getValue()
	local values = {}

	for key, motor in pairs(self._motors) do
		values[key] = motor:getValue()
	end

	return values
end

function GroupMotor:__tostring()
	return "Motor(Group)"
end

local Flipper = {
	SingleMotor = SingleMotor,
	GroupMotor = GroupMotor,

	Instant = Instant,
	Linear = Linear,
	Spring = Spring,

	isMotor = isMotor,
}

local Creator = {
	Registry = {},
	Signals = {},
	TransparencyMotors = {},
	DefaultProperties = {
		ScreenGui = {
			ResetOnSpawn = false,
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
			AutoLocalize = false,
		},
		Frame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
		ScrollingFrame = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ScrollBarImageColor3 = Color3.new(0, 0, 0),
		},
		TextLabel = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			BackgroundTransparency = 1,
			TextScaled = false,
			TextSize = 14,
		},
		TextButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		TextBox = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			ClearTextOnFocus = false,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = "",
			TextColor3 = Color3.new(0, 0, 0),
			TextSize = 14,
		},
		ImageLabel = {
			BackgroundTransparency = 1,
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
			ResampleMode = Enum.ResamplerMode.Pixelated,
		},
		ImageButton = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			AutoButtonColor = false,
			ResampleMode = Enum.ResamplerMode.Pixelated,
		},
		CanvasGroup = {
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderColor3 = Color3.new(0, 0, 0),
			BorderSizePixel = 0,
		},
	},
}

local function ApplyCustomProps(Object, Props)
	if Props.ThemeTag then
		Creator.AddThemeObject(Object, Props.ThemeTag)
	end
end

function Creator.AddSignal(Signal, Function)
	local Connected = Signal:Connect(Function)
	table.insert(Creator.Signals, Connected)
	return Connected
end

function Creator.Disconnect()
	for Idx = #Creator.Signals, 1, -1 do
		local Connection = table.remove(Creator.Signals, Idx)
		if Connection.Disconnect then
			Connection:Disconnect()
		end
	end
end

Creator.Themes = Themes
Creator.Theme = Creator.Theme or "Dark"

function Creator.GetThemeProperty(Property)
	local Theme = Creator.Themes[Creator.Theme]
	if Theme then
		return Theme[Property]
	end
	return Creator.Themes.Dark[Property]
end

function Creator.UpdateTheme()
	if not Creator.Themes[Creator.Theme] then
		Creator.Theme = "Dark"
	end

	for Instance, Object in next, Creator.Registry do
		for Property, ColorIdx in next, Object.Properties do
			local themeValue = Creator.GetThemeProperty(ColorIdx)
			if themeValue then
				Instance[Property] = themeValue
			end
		end
	end

	local transparency = Creator.GetThemeProperty("ElementTransparency")
	if transparency then
		for _, Motor in next, Creator.TransparencyMotors do
			Motor:setGoal(Flipper.Instant.new(transparency))
		end
	end
end

local function _applyThemeToObject(Object, Properties)
	for Property, ColorIdx in next, Properties do
		local themeValue = Creator.GetThemeProperty(ColorIdx)
		if themeValue then
			Object[Property] = themeValue
		end
	end
end

function Creator.AddThemeObject(Object, Properties)
	local Idx = #Creator.Registry + 1
	local Data = {
		Object = Object,
		Properties = Properties,
		Idx = Idx,
	}

	Creator.Registry[Object] = Data
	_applyThemeToObject(Object, Properties)
	return Object
end

function Creator.OverrideTag(Object, Properties)
	Creator.Registry[Object].Properties = Properties
	_applyThemeToObject(Object, Properties)
end

function Creator.GetThemeProperty(Property)
	if Themes[Library.Theme][Property] then
		return Themes[Library.Theme][Property]
	end
	return Themes["Dark"][Property]
end

local MiniMessageColors = {
	["black"] = "#000000",
	["dark_blue"] = "#0000AA",
	["dark_green"] = "#00AA00",
	["dark_aqua"] = "#00AAAA",
	["dark_red"] = "#AA0000",
	["dark_purple"] = "#AA00AA",
	["gold"] = "#FFAA00",
	["gray"] = "#AAAAAA",
	["grey"] = "#AAAAAA",
	["dark_gray"] = "#555555",
	["dark_grey"] = "#555555",
	["blue"] = "#5555FF",
	["green"] = "#55FF55",
	["aqua"] = "#55FFFF",
	["cyan"] = "#55FFFF",
	["red"] = "#FF5555",
	["light_purple"] = "#FF55FF",
	["magenta"] = "#FF55FF",
	["yellow"] = "#FFFF55",
	["white"] = "#FFFFFF",
	["reset"] = "#FFFFFF",
	["orange"] = "#FFAA00",
	["pink"] = "#FF55FF",
	["lime"] = "#55FF55",
	["brown"] = "#AA5500",
}

local function MiniMessageToRichText(text)
	if type(text) ~= "string" or text == "" then
		return text
	end

	if not text:match("<[^>]+>") then
		return text
	end

	local result = text
	result = result:gsub("<br>", "\n")
	result = result:gsub("<br/>", "\n")
	result = result:gsub("<br />", "\n")
	result = result:gsub("<nl>", "\n")
	result = result:gsub("<newline>", "\n")

	result = result:gsub("<reset>", "</font></b></i></u></s>")

	result = result:gsub("<obfuscated>(.-)</obfuscated>", "%1")
	result = result:gsub("<obfuscated>", "")
	result = result:gsub("</obfuscated>", "")

	local function hexToRgb(hex)
		hex = hex:gsub("#", "")
		local r = tonumber("0x" .. hex:sub(1, 2))
		local g = tonumber("0x" .. hex:sub(3, 4))
		local b = tonumber("0x" .. hex:sub(5, 6))
		return r, g, b
	end

	local function rgbToHex(r, g, b)
		return string.format("#%02X%02X%02X", math.floor(r), math.floor(g), math.floor(b))
	end

	local function interpolateColor(color1Hex, color2Hex, t)
		local r1, g1, b1 = hexToRgb(color1Hex)
		local r2, g2, b2 = hexToRgb(color2Hex)
		local r = r1 + (r2 - r1) * t
		local g = g1 + (g2 - g1) * t
		local b = b1 + (b2 - b1) * t
		return rgbToHex(r, g, b)
	end

	for i = 1, 10 do
		local newResult = result:gsub("<gradient:([^>]+)>(.-)</gradient>", function(colorsStr, content)
			local colors = {}

			for colorMatch in colorsStr:gmatch("(#%x%x%x%x%x%x)") do
				table.insert(colors, colorMatch)
			end

			if #colors == 0 then
				for colorMatch in colorsStr:gmatch("(%x%x%x%x%x%x)") do
					table.insert(colors, "#" .. colorMatch)
				end
			end

			if #colors < 2 then
				if #colors == 1 then
					return '<font color="' .. colors[1] .. '">' .. content .. '</font>'
				else
					return content
				end
			end

			local cleanText = content:gsub("<[^>]+>", "")
			local textLength = #cleanText

			if textLength == 0 then
				return content
			end

			if textLength == 1 then
				return '<font color="' .. colors[1] .. '">' .. content .. '</font>'
			end

			local parts = {}
			local pos = 1
			local charIndex = 0

			while pos <= #content do
				if content:sub(pos, pos) == "<" then
					local tagEnd = content:find(">", pos)
					if tagEnd then
						local tag = content:sub(pos, tagEnd)
						table.insert(parts, {type = "tag", value = tag})
						pos = tagEnd + 1
					else
						table.insert(parts, {type = "char", value = content:sub(pos, pos), index = charIndex})
						charIndex = charIndex + 1
						pos = pos + 1
					end
				else
					local char = content:sub(pos, pos)
					table.insert(parts, {type = "char", value = char, index = charIndex})
					charIndex = charIndex + 1
					pos = pos + 1
				end
			end

			local function getGradientColor(t)
				t = math.max(0, math.min(1, t))

				if #colors == 2 then
					return interpolateColor(colors[1], colors[2], t)
				end

				local numSegments = #colors - 1
				local segmentSize = 1 / numSegments

				local segmentIndex = math.floor(t / segmentSize)
				if segmentIndex >= numSegments then
					segmentIndex = numSegments - 1
					t = 1.0
				end

				local segmentStart = segmentIndex * segmentSize
				local segmentEnd = (segmentIndex + 1) * segmentSize

				local segmentT = 0
				if segmentEnd > segmentStart then
					segmentT = (t - segmentStart) / (segmentEnd - segmentStart)
				else
					segmentT = (t >= segmentEnd) and 1.0 or 0.0
				end

				segmentT = math.max(0, math.min(1, segmentT))

				local color1Index = segmentIndex + 1
				local color2Index = segmentIndex + 2

				if color1Index < 1 then color1Index = 1 end
				if color2Index > #colors then color2Index = #colors end
				if color1Index > #colors then color1Index = #colors end

				return interpolateColor(colors[color1Index], colors[color2Index], segmentT)
			end

			local gradientText = ""
			local currentSegment = ""
			local currentColor = nil
			local segments = {}

			for _, part in ipairs(parts) do
				if part.type == "tag" then
					if currentSegment ~= "" and currentColor ~= nil then
						table.insert(segments, {text = currentSegment, color = currentColor})
						currentSegment = ""
						currentColor = nil
					end
					table.insert(segments, {text = part.value, color = nil})
				else
					local t = part.index / (textLength - 1)
					if textLength == 1 then t = 0 end
					local charColor = getGradientColor(t)

					if currentColor == charColor then
						currentSegment = currentSegment .. part.value
					else
						if currentSegment ~= "" and currentColor ~= nil then
							table.insert(segments, {text = currentSegment, color = currentColor})
						end
						currentSegment = part.value
						currentColor = charColor
					end
				end
			end

			if currentSegment ~= "" and currentColor ~= nil then
				table.insert(segments, {text = currentSegment, color = currentColor})
			end

			local hasTextSegments = false
			for _, segment in ipairs(segments) do
				if segment.text and segment.text ~= "" then
					hasTextSegments = true
					break
				end
			end

			if not hasTextSegments and textLength > 0 then
				local fallbackText = ""
				for i = 1, textLength do
					local t = (i - 1) / (textLength - 1)
					if textLength == 1 then t = 0 end
					local charColor = getGradientColor(t)
					local char = cleanText:sub(i, i)
					fallbackText = fallbackText .. '<font color="' .. charColor .. '">' .. char .. '</font>'
				end
				return fallbackText
			end

			for _, segment in ipairs(segments) do
				if segment.color and segment.text and segment.text ~= "" then
					gradientText = gradientText .. '<font color="' .. segment.color .. '">' .. segment.text .. '</font>'
				elseif segment.text then
					gradientText = gradientText .. segment.text
				end
			end

			if gradientText == "" or gradientText == nil or not gradientText:match('<font color=') then
				local fallbackText = ""
				for i = 1, textLength do
					local t = (i - 1) / (textLength - 1)
					if textLength == 1 then t = 0 end
					local charColor = getGradientColor(t)
					local char = cleanText:sub(i, i)
					fallbackText = fallbackText .. '<font color="' .. charColor .. '">' .. char .. '</font>'
				end
				return fallbackText
			end

			return gradientText
		end)
		if newResult == result then
			break
		end
		result = newResult
	end

	result = result:gsub("<color:(#%x%x%x%x%x%x)>(.-)</color>", '<font color="%1">%2</font>')
	result = result:gsub("<color:(#%x%x%x%x%x%x)>", '<font color="%1">')
	result = result:gsub("<color:(%x%x%x%x%x%x)>(.-)</color>", function(hex, content)
		return '<font color="#' .. hex .. '">' .. content .. '</font>'
	end)
	result = result:gsub("<color:(%x%x%x%x%x%x)>", function(hex)
		return '<font color="#' .. hex .. '">'
	end)
	result = result:gsub("</color>", "</font>")

	result = result:gsub("<(#%x%x%x%x%x%x)>(.-)</#%x%x%x%x%x%x>", '<font color="%1">%2</font>')
	result = result:gsub("<(#%x%x%x%x%x%x)>", '<font color="%1">')
	result = result:gsub("</(#%x%x%x%x%x%x)>", "</font>")

	local colorNames = {}
	for colorName, _ in pairs(MiniMessageColors) do
		table.insert(colorNames, colorName)
	end
	table.sort(colorNames, function(a, b) return #a > #b end)

	for _, colorName in ipairs(colorNames) do
		local hexColor = MiniMessageColors[colorName]
		result = result:gsub("<" .. colorName .. ">(.-)</" .. colorName .. ">", '<font color="' .. hexColor .. '">%1</font>')
		result = result:gsub("<" .. colorName .. ">", '<font color="' .. hexColor .. '">')
		result = result:gsub("</" .. colorName .. ">", "</font>")
	end

	result = result:gsub("<bold>(.-)</bold>", "<b>%1</b>")
	result = result:gsub("<bold>", "<b>")
	result = result:gsub("</bold>", "</b>")

	result = result:gsub("<italic>(.-)</italic>", "<i>%1</i>")
	result = result:gsub("<italic>", "<i>")
	result = result:gsub("</italic>", "</i>")

	result = result:gsub("<underline>(.-)</underline>", "<u>%1</u>")
	result = result:gsub("<underlined>(.-)</underlined>", "<u>%1</u>")
	result = result:gsub("<underline>", "<u>")
	result = result:gsub("<underlined>", "<u>")
	result = result:gsub("</underline>", "</u>")
	result = result:gsub("</underlined>", "</u>")

	result = result:gsub("<strikethrough>(.-)</strikethrough>", "<s>%1</s>")
	result = result:gsub("<strike>(.-)</strike>", "<s>%1</s>")
	result = result:gsub("<strikethrough>", "<s>")
	result = result:gsub("<strike>", "<s>")
	result = result:gsub("</strikethrough>", "</s>")
	result = result:gsub("</strike>", "</s>")

	result = result:gsub('<font color="[^"]+"></font>', "")

	result = result:gsub("</font></font>", "</font>")
	result = result:gsub("</b></b>", "</b>")
	result = result:gsub("</i></i>", "</i>")
	result = result:gsub("</u></u>", "</u>")
	result = result:gsub("</s></s>", "</s>")

	return result
end

local TextElements = {}
local TextElementConnections = {}

local function setupMiniMessageSupport(object, properties)
	if not (object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox")) then
		return
	end

	local richTextExplicitlySet = properties and properties.RichText ~= nil
	if not richTextExplicitlySet then
		object.RichText = true
	elseif properties.RichText == false then
		object.RichText = false
	end

	local lastText = object.Text or ""
	local isConverting = false

	local function convertTextIfNeeded(text)
		if not text or type(text) ~= "string" then
			return text
		end

		local hasRichTextTags = text:match('<font color="[^"]+">')

		if hasRichTextTags then
			return text
		end

		if text:match("<[^>]+>") then
		local hasMiniMessagePattern =
			text:match("<%w+>") or
			text:match("<color:") or
			text:match("<#[%x%x%x%x%x%x]>") or
			text:match("<gradient:") or
			text:match("<reset>") or
			text:match("<obfuscated>") or
			text:match("</%w+>") or
			text:match("</color>")

			if hasMiniMessagePattern then
				if not object.RichText then
					object.RichText = true
				end
				return MiniMessageToRichText(text)
			end
		end

		return text
	end

	local connection = object:GetPropertyChangedSignal("Text"):Connect(function()
		if isConverting then
			return
		end

		local currentText = object.Text or ""

		if currentText ~= lastText then
			local converted = convertTextIfNeeded(currentText)
			if converted ~= currentText then
				isConverting = true
				object.Text = converted
				lastText = converted
				isConverting = false
			else
				lastText = currentText
			end
		end
	end)

	table.insert(TextElementConnections, connection)
	TextElements[object] = true

	if object.Text then
		local converted = convertTextIfNeeded(object.Text)
		if converted ~= object.Text then
			object.Text = converted
			lastText = converted
		end
	end
end

function Creator.New(Name, Properties, Children)
	local Object = Instance.new(Name)

	for Name, Value in next, Creator.DefaultProperties[Name] or {} do
		Object[Name] = Value
	end

	local originalText = Properties and Properties.Text

	for Name, Value in next, Properties or {} do
		if Name ~= "ThemeTag" then
			Object[Name] = Value
		end
	end

	if originalText and type(originalText) == "string" and originalText:match("<[^>]+>") then
		Object.Text = MiniMessageToRichText(originalText)
		if Properties and Properties.RichText == nil then
			Object.RichText = true
		end
	end

	for _, Child in next, Children or {} do
		Child.Parent = Object
	end

	ApplyCustomProps(Object, Properties)

	setupMiniMessageSupport(Object, Properties)

	return Object
end

function Creator.SpringMotor(Initial, Instance, Prop, IgnoreDialogCheck, ResetOnThemeChange)
	IgnoreDialogCheck = IgnoreDialogCheck or false
	ResetOnThemeChange = ResetOnThemeChange or false
	local Motor = Flipper.SingleMotor.new(Initial)
	Motor:onStep(function(value)
		Instance[Prop] = value
	end)

	if ResetOnThemeChange then
		table.insert(Creator.TransparencyMotors, Motor)
	end

	local function SetValue(Value, Ignore)
		Ignore = Ignore or false
		if not IgnoreDialogCheck then
			if not Ignore then
				if Prop == "BackgroundTransparency" and Library.DialogOpen then
					return
				end
			end
		end
		Motor:setGoal(Flipper.Spring.new(Value, { frequency = 8 }))
	end

	return Motor, SetValue
end

Library.Creator = Creator

Library.MiniMessageToRichText = MiniMessageToRichText

local New = Creator.New

local GUI = New("ScreenGui", {Parent = ParentUi})
Library.GUI = GUI
ProtectGui(GUI)

function Library:SafeCallback(Function, ...)
	if not Function then
		return
	end

	local Success, Event = pcall(Function, ...)
	if not Success then
		local _, i = Event:find(":%d+: ")

		if not i then
			return Library:Notify({
				Title = "Interface",
				Content = "Callback error",
				SubContent = Event,
				Duration = 5,
			})
		end

		return Library:Notify({
			Title = "Interface",
			Content = "Callback error",
			SubContent = Event:sub(i + 1),
			Duration = 5,
		})
	end
end
function Library:Round(Number, Factor)
	if Factor == 0 then
		return math.floor(Number)
	end
	Number = tostring(Number)
	return Number:find("%.") and tonumber(Number:sub(1, Number:find("%.") + Factor)) or Number
end

local function map(value, inMin, inMax, outMin, outMax)
	return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin
end

local function viewportPointToWorld(location, distance)
	local unitRay = game:GetService("Workspace").CurrentCamera:ScreenPointToRay(location.X, location.Y)
	return unitRay.Origin + unitRay.Direction * distance
end

local function getOffset()
	local viewportSizeY = game:GetService("Workspace").CurrentCamera.ViewportSize.Y
	return map(viewportSizeY, 0, 2560, 8, 56)
end

local viewportPointToWorld, getOffset = unpack({ viewportPointToWorld, getOffset })

local BlurFolder = Instance.new("Folder")
BlurFolder.Name = "FluentBlur"
do
	local ws = game:GetService("Workspace")
	local function attachToCurrentCamera()
		local cam = ws.CurrentCamera
		if cam and BlurFolder.Parent ~= cam then
			BlurFolder.Parent = cam
		end
	end
	attachToCurrentCamera()
	ws:GetPropertyChangedSignal("CurrentCamera"):Connect(attachToCurrentCamera)
end

local function createAcrylic()
	local Part = Creator.New("Part", {
		Name = "Body",
		Color = Color3.new(0, 0, 0),
		Material = Enum.Material.Glass,
		Size = Vector3.new(1, 1, 0),
		Anchored = true,
		CanCollide = false,
		Locked = true,
		CastShadow = false,
		Transparency = 0.98,
	}, {
		Creator.New("SpecialMesh", {
			Name = "Mesh",
			MeshType = Enum.MeshType.Brick,
			Offset = Vector3.new(0, 0, -0.000001),
		}),
	})

	return Part
end

function AcrylicBlur()
	local function createAcrylicBlur(distance)
		local cleanups = {}

		distance = distance or 0.001
		local positions = {
			topLeft = Vector2.new(),
			topRight = Vector2.new(),
			bottomRight = Vector2.new(),
		}
		local model = createAcrylic()
		model.Parent = BlurFolder

		local function updatePositions(size, position)
			positions.topLeft = position
			positions.topRight = position + Vector2.new(size.X, 0)
			positions.bottomRight = position + size
		end

		local function render()
			local res = game:GetService("Workspace").CurrentCamera
			if res then
				res = res.CFrame
			end
			local cond = res
			if not cond then
				cond = CFrame.new()
			end

			local camera = cond
			local topLeft = positions.topLeft
			local topRight = positions.topRight
			local bottomRight = positions.bottomRight

			local topLeft3D = viewportPointToWorld(topLeft, distance)
			local topRight3D = viewportPointToWorld(topRight, distance)
			local bottomRight3D = viewportPointToWorld(bottomRight, distance)

			local width = (topRight3D - topLeft3D).Magnitude
			local height = (topRight3D - bottomRight3D).Magnitude

			model.CFrame = CFrame.fromMatrix((topLeft3D + bottomRight3D) / 2, camera.XVector, camera.YVector, camera.ZVector)
			model.Mesh.Scale = Vector3.new(width, height, 0)
		end

		local function onChange(rbx)
			local offset = getOffset()
			local size = rbx.AbsoluteSize - Vector2.new(offset, offset)
			local position = rbx.AbsolutePosition + Vector2.new(offset / 2, offset / 2)

			updatePositions(size, position)
			task.spawn(render)
		end

		local function renderOnChange()
			local camera = game:GetService("Workspace").CurrentCamera
			if not camera then
				return
			end
			table.insert(cleanups, camera:GetPropertyChangedSignal("CFrame"):Connect(render))
			table.insert(cleanups, camera:GetPropertyChangedSignal("ViewportSize"):Connect(render))
			table.insert(cleanups, camera:GetPropertyChangedSignal("FieldOfView"):Connect(render))
			task.spawn(render)
		end

		model.Destroying:Connect(function()
			for _, item in cleanups do
				pcall(function()
					item:Disconnect()
				end)
			end
		end)

		renderOnChange()

		return onChange, model
	end

	return function(distance)
		local Blur = {}
		local onChange, model = createAcrylicBlur(distance)

		local comp = Creator.New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
		})

		Creator.AddSignal(comp:GetPropertyChangedSignal("AbsolutePosition"), function()
			onChange(comp)
		end)

		Creator.AddSignal(comp:GetPropertyChangedSignal("AbsoluteSize"), function()
			onChange(comp)
		end)

		Blur.AddParent = function(Parent)
			Creator.AddSignal(Parent:GetPropertyChangedSignal("Visible"), function()
				Blur.SetVisibility(Parent.Visible)
			end)
		end

		Blur.SetVisibility = function(Value)
			model.Transparency = Value and 0.98 or 1
		end

		Blur.Frame = comp
		Blur.Model = model

		return Blur
	end
end

function AcrylicPaint()
	local New = Creator.New
	local AcrylicBlur = AcrylicBlur()

	return function(props)
		local AcrylicPaint = {}

		AcrylicPaint.Frame = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 0.9,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BorderSizePixel = 0,
		}, {
			New("ImageLabel", {
				Image = "",
				ScaleType = "Slice",
				SliceCenter = Rect.new(Vector2.new(99, 99), Vector2.new(99, 99)),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(1, 120, 1, 116),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BackgroundTransparency = 1,
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 0.7,
			}),

			New("UICorner", {
				CornerRadius = UDim.new(0, WINDOW_CORNER),
			}),

			New("Frame", {
				BackgroundTransparency = 0.45,
				Size = UDim2.fromScale(1, 1),
				Name = "Background",
				ThemeTag = {
					BackgroundColor3 = "AcrylicMain",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, WINDOW_CORNER),
				}),
			}),

			New("Frame", {
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 0.4,
				Size = UDim2.fromScale(1, 1),
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, WINDOW_CORNER),
				}),

				New("UIGradient", {
					Rotation = 90,
					ThemeTag = {
						Color = "AcrylicGradient",
					},
				}),
			}),

			New("ImageLabel", {
				Image = "",
				ImageTransparency = 0.98,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.new(0, 128, 0, 128),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, WINDOW_CORNER),
				}),
			}),

			New("ImageLabel", {
				Image = "",
				ImageTransparency = 0.9,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.new(0, 128, 0, 128),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageTransparency = "AcrylicNoise",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, WINDOW_CORNER),
				}),
			}),

			New("Frame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				ZIndex = 2,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, WINDOW_CORNER),
				}),
				New("UIStroke", {
					Transparency = 0.5,
					Thickness = 1,
					ThemeTag = {
						Color = "AcrylicBorder",
					},
				}),
			}),
		})

		local Blur

		if Library.UseAcrylic then
			Blur = AcrylicBlur()
			Blur.Frame.Parent = AcrylicPaint.Frame
			AcrylicPaint.Model = Blur.Model
			AcrylicPaint.AddParent = Blur.AddParent
			AcrylicPaint.SetVisibility = Blur.SetVisibility
		end

		return AcrylicPaint
	end
end

local Acrylic = {
	AcrylicBlur = AcrylicBlur(),
	CreateAcrylic = createAcrylic,
	AcrylicPaint = AcrylicPaint(),
}

function Acrylic.init()
	local baseEffect = Instance.new("DepthOfFieldEffect")
	baseEffect.FarIntensity = 0
	baseEffect.InFocusRadius = 0.1
	baseEffect.NearIntensity = 1

	local depthOfFieldDefaults = {}

	function Acrylic.Enable()
		for _, effect in pairs(depthOfFieldDefaults) do
			effect.Enabled = false
		end
		baseEffect.Parent = game:GetService("Lighting")
	end

	function Acrylic.Disable()
		for _, effect in pairs(depthOfFieldDefaults) do
			effect.Enabled = effect.enabled
		end
		baseEffect.Parent = nil
	end

	local function registerDefaults()
		local function register(object)
			if object:IsA("DepthOfFieldEffect") then
				depthOfFieldDefaults[object] = { enabled = object.Enabled }
			end
		end

		for _, child in pairs(game:GetService("Lighting"):GetChildren()) do
			register(child)
		end

		if game:GetService("Workspace").CurrentCamera then
			for _, child in pairs(game:GetService("Workspace").CurrentCamera:GetChildren()) do
				register(child)
			end
		end
	end

	registerDefaults()
	Acrylic.Enable()
end

local Components = {
	Assets = {
		Close = "rbxassetid://9886659671",
		Min = "rbxassetid://9886659276",
		Max = "rbxassetid://9886659406",
		Restore = "rbxassetid://9886659001",
	},
}

Components.Element = (function()
	local New = Creator.New

	local Spring = Flipper.Spring.new

	return function(Title, Desc, Parent, Hover, Options)
		local Element = {}
		local Options = Options or {}

		Element.TitleLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			Text = Title,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Element.Header = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 14),
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 5),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
		})

		if Options and Options.Icon then
			local iconImage = Options.Icon
			pcall(function()
				if Library and Library.GetIcon then
					local resolved = Library:GetIcon(Options.Icon)
					if resolved then iconImage = resolved end
				end
			end)
			Element.IconImage = New("ImageLabel", {
				Image = iconImage,
				Size = UDim2.fromOffset(16, 16),
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			})
			Element.IconImage.Parent = Element.Header
		end

		Element.TitleLabel.Parent = Element.Header

		local descText = Desc or ""

		descText = descText:gsub("\\n", "\n")

		Element.DescLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = descText,
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 12,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 0),
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		Element.LabelHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(10, 0),
			Size = UDim2.new(1, -28, 0, 0),
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			New("UIPadding", {
				PaddingBottom = UDim.new(0, 13),
				PaddingTop = UDim.new(0, 13),
			}),
			Element.Header,
			Element.DescLabel,
		})

		Element.Border = New("UIStroke", {
			Transparency = 0.5,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(0, 0, 0),
			ThemeTag = {
				Color = "ElementBorder",
			},
		})

		Element.Frame = New("TextButton", {
			Visible = Options.Visible and Options.Visible or true,
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 0.89,
			BackgroundColor3 = Color3.fromRGB(130, 130, 130),
			Parent = Parent,
			AutomaticSize = Enum.AutomaticSize.Y,
			Text = "",
			LayoutOrder = 7,
			ThemeTag = {
				BackgroundColor3 = "Element",
				BackgroundTransparency = "ElementTransparency",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			Element.Border,
			Element.LabelHolder,
		})

		function Element:SetTitle(Set)
			Element.TitleLabel.Text = Set
			local hasTitle = (Set ~= nil and Set ~= "")
			Element.Header.Visible = hasTitle

			if not hasTitle then
				if Element.IconImage then
					if not Element.DescRow then
						Element.DescRow = New("Frame", {
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 14),
							LayoutOrder = 2,
						}, {
							New("UIListLayout", {
								Padding = UDim.new(0, 5),
								FillDirection = Enum.FillDirection.Horizontal,
								SortOrder = Enum.SortOrder.LayoutOrder,
								VerticalAlignment = Enum.VerticalAlignment.Center,
							}),
						})
						Element.DescRow.Parent = Element.LabelHolder
					end

					if not Element.DescIconImage then
						Element.DescIconImage = New("ImageLabel", {
							Image = Element.IconImage.Image,
							Size = UDim2.fromOffset(16, 16),
							BackgroundTransparency = 1,
							LayoutOrder = 1,
							ThemeTag = {
								ImageColor3 = "Text",
							},
						})
						Element.DescIconImage.Parent = Element.DescRow
					else
						Element.DescIconImage.Image = Element.IconImage.Image
						Element.DescIconImage.Parent = Element.DescRow
					end

					Element.DescLabel.Parent = Element.DescRow
					Element.DescLabel.LayoutOrder = 2
					Element.DescLabel.Size = UDim2.new(1, -24, 0, 0)
				else
					if Element.DescRow then
						Element.DescRow:Destroy()
						Element.DescRow = nil
						Element.DescIconImage = nil
					end
					Element.DescLabel.Parent = Element.LabelHolder
					Element.DescLabel.LayoutOrder = 2
					Element.DescLabel.Size = UDim2.new(1, 0, 0, 0)
				end
			else
				if Element.DescRow then
					Element.DescRow:Destroy()
					Element.DescRow = nil
					Element.DescIconImage = nil
				end
				Element.DescLabel.Parent = Element.LabelHolder
				Element.DescLabel.LayoutOrder = 2
				Element.DescLabel.Size = UDim2.new(1, 0, 0, 0)
			end
			if Library.Window and Library.Window.AllElements and Library.Window.AllElements[Element.Frame] then
				Library.Window.AllElements[Element.Frame].title = Set
			elseif Library.Windows and #Library.Windows > 0 then
				local currentWindow = Library.Windows[#Library.Windows]
				if currentWindow and currentWindow.AllElements and currentWindow.AllElements[Element.Frame] then
					currentWindow.AllElements[Element.Frame].title = Set
				end
			end
		end

		function Element:Visible(Bool)
			Element.Frame.Visible = Bool
		end

		function Element:SetDesc(Set)
			if Set == nil then
				Set = ""
			end

			if type(Set) == "string" then
				Set = Set:gsub("\\n", "\n")
			end
			if Set == "" then
				Element.DescLabel.Visible = false
			else
				Element.DescLabel.Visible = true
			end
			Element.DescLabel.Text = Set
			if Library.Window and Library.Window.AllElements and Library.Window.AllElements[Element.Frame] then
				Library.Window.AllElements[Element.Frame].description = Set
			elseif Library.Windows and #Library.Windows > 0 then
				local currentWindow = Library.Windows[#Library.Windows]
				if currentWindow and currentWindow.AllElements and currentWindow.AllElements[Element.Frame] then
					currentWindow.AllElements[Element.Frame].description = Set
				end
			end
		end

		function Element:GetTitle()
			return Element.TitleLabel.Text
		end

		function Element:GetDesc()
			return Element.DescLabel.Text
		end

		function Element:Destroy()
			Element.Frame:Destroy()
		end

		Element.Header.Visible = not (Title == nil or Title == "")

		Element:SetTitle(Title or "")
		Element:SetDesc(Desc)

		if Library.Window and Library.Window.RegisterElement then
			Library.Window.RegisterElement(Element.Frame, Title, "Element", Desc)
		elseif Library.Windows and #Library.Windows > 0 then
			local currentWindow = Library.Windows[#Library.Windows]
			if currentWindow and currentWindow.RegisterElement then
				currentWindow.RegisterElement(Element.Frame, Title, "Element", Desc)
			end
		end

		if Hover then
			local Themes = Library.Themes
			local Motor, SetTransparency = Creator.SpringMotor(
				Creator.GetThemeProperty("ElementTransparency"),
				Element.Frame,
				"BackgroundTransparency",
				false,
				true
			)

			Creator.AddSignal(Element.Frame.MouseEnter, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"))
			end)
			Creator.AddSignal(Element.Frame.MouseLeave, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency"))
			end)
			Creator.AddSignal(Element.Frame.MouseButton1Down, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") + Creator.GetThemeProperty("HoverChange"))
			end)
			Creator.AddSignal(Element.Frame.MouseButton1Up, function()
				SetTransparency(Creator.GetThemeProperty("ElementTransparency") - Creator.GetThemeProperty("HoverChange"))
			end)
		end

		return Element
	end
end)()
Components.Section = (function()
	local New = Creator.New

	return function(Title, Parent, Icon)
		local Section = {}

		Section.Layout = New("UIListLayout", {
			Padding = UDim.new(0, 5),
		})

		Section.Container = New("Frame", {
			Size = UDim2.new(1, 0, 0, 26),
			Position = UDim2.fromOffset(0, 24),
			BackgroundTransparency = 1,
		}, {
			Section.Layout,
		})

		local SectionHeader = New("Frame", {
			Size = UDim2.new(1, -16, 0, 18),
			Position = UDim2.fromOffset(0, 2),
			BackgroundTransparency = 1,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 5),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			Icon and New("ImageLabel", {
				Image = Icon,
				Size = UDim2.fromOffset(16, 16),
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			}) or nil,
			New("TextLabel", {
				RichText = true,
				Text = Title,
				TextTransparency = 0,
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				Size = UDim2.fromScale(0, 1),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				LayoutOrder = 2,
				ThemeTag = {
					TextColor3 = "Text",
				},
			}),
		})

		Section.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 26),
			LayoutOrder = 7,
			Parent = Parent,
		}, {
			SectionHeader,
			Section.Container,
		})

		Creator.AddSignal(Section.Layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Section.Container.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y)
			Section.Root.Size = UDim2.new(1, 0, 0, Section.Layout.AbsoluteContentSize.Y + 25)
		end)

		if Library.Window and Library.Window.RegisterElement then
			Library.Window.RegisterElement(Section.Root, Title, "Section")
		elseif Library.Windows and #Library.Windows > 0 then
			local currentWindow = Library.Windows[#Library.Windows]
			if currentWindow and currentWindow.RegisterElement then
				currentWindow.RegisterElement(Section.Root, Title, "Section")
			end
		end

		return Section
	end
end)()
Components.Tab = (function()
	local New = Creator.New
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local Components = Components

	local TabModule = {
		Window = nil,
		Tabs = {},
		Containers = {},
		SelectedTab = 0,
		TabCount = 0,
		AnimationTask = nil,
		CurrentAnimationTab = 0,
	}

	function TabModule:Init(Window)
		TabModule.Window = Window
		return TabModule
	end

	function TabModule:GetCurrentTabPos()
		local TabHolderPos = TabModule.Window.TabHolder.AbsolutePosition.Y
		local TabPos = TabModule.Tabs[TabModule.SelectedTab].Frame.AbsolutePosition.Y
		local CanvasOffsetY = TabModule.Window.TabHolder.CanvasPosition.Y
		local TabHeight = TabModule.Tabs[TabModule.SelectedTab].Frame.AbsoluteSize.Y

		return (TabPos - TabHolderPos) + CanvasOffsetY + (TabHeight / 2)
	end

	function TabModule:New(Title, Icon, Parent)
		local Window = TabModule.Window
		local Elements = Library.Elements

		TabModule.TabCount = TabModule.TabCount + 1
		local TabIndex = TabModule.TabCount

		local Tab = {
			Selected = false,
			Name = Title,
			Type = "Tab",
		}

		local validIcon = type(Icon) == "string" and Icon ~= "" and (Icon:find("rbxassetid://") or Icon:match("^%d+$")) and Icon or nil

		Tab.Frame = New("TextButton", {
			Size = UDim2.new(1, 0, 0, 34),
			BackgroundTransparency = 1,
			Parent = Parent,
			ZIndex = 10,
			ThemeTag = {
				BackgroundColor3 = "Tab",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 6),
			}),
			New("TextLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				Position = validIcon and UDim2.new(0, 30, 0.5, 0) or UDim2.new(0, 12, 0.5, 0),
				Text = Title,
				RichText = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextTransparency = 0,
				FontFace = Font.new(
					"rbxasset://fonts/families/GothamSSm.json",
					Enum.FontWeight.Medium,
					Enum.FontStyle.Normal
				),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				Size = UDim2.new(1, -12, 1, 0),
				BackgroundTransparency = 1,
				ZIndex = 11,
				ThemeTag = {
					TextColor3 = "Text",
				},
			}),
			validIcon and New("ImageLabel", {
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(0, 8, 0.5, 0),
				BackgroundTransparency = 1,
				Image = validIcon,
				ZIndex = 11,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			}) or nil,
		})

		local ContainerLayout = New("UIListLayout", {
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		})

		Tab.ContainerAnim = New("CanvasGroup", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			GroupTransparency = 0,
			Parent = Window.ContainerHolder,
			Visible = false,
			Position = UDim2.fromOffset(0, 0),
			ClipsDescendants = true,
		})

		Tab.ContainerFrame = New("ScrollingFrame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Parent = Tab.ContainerAnim,
			Visible = true,
			BottomImage = "",
			MidImage = "",
			TopImage = "",
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.95,
			ScrollBarThickness = 3,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollingEnabled = true,
		}, {
			ContainerLayout,
			New("UIPadding", {
				PaddingRight = UDim.new(0, 10),
				PaddingLeft = UDim.new(0, 1),
				PaddingTop = UDim.new(0, 1),
				PaddingBottom = UDim.new(0, 1),
			}),
		})

		Tab.ContainerXMotor = Flipper.SingleMotor.new(0)
		Tab.ContainerTransparencyMotor = Flipper.SingleMotor.new(0)

		Tab.ContainerXMotor:onStep(function(Value)
			if Tab.ContainerAnim and Tab.ContainerAnim.Parent then
				Tab.ContainerAnim.Position = UDim2.fromOffset(Value, 0)
			end
		end)

		Tab.ContainerTransparencyMotor:onStep(function(Value)
			if Tab.ContainerAnim and Tab.ContainerAnim.Parent then
				local alpha = math.clamp(Value, 0, 1)
				Tab.ContainerAnim.GroupTransparency = alpha
				Tab.ContainerFrame.ScrollBarImageTransparency = alpha > 0.5 and 1 or 0.95
			end
		end)

		Creator.AddSignal(ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Tab.ContainerFrame.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 2)
		end)

		Tab.Motor, Tab.SetTransparency = Creator.SpringMotor(1, Tab.Frame, "BackgroundTransparency")

		Creator.AddSignal(Tab.Frame.MouseEnter, function()
			Tab.SetTransparency(Tab.Selected and 0.85 or 0.87)
		end)
		Creator.AddSignal(Tab.Frame.MouseLeave, function()
			Tab.SetTransparency(Tab.Selected and 0.89 or 1)
		end)
		Creator.AddSignal(Tab.Frame.MouseButton1Down, function()
			Tab.SetTransparency(0.92)
		end)
		Creator.AddSignal(Tab.Frame.MouseButton1Up, function()
			Tab.SetTransparency(Tab.Selected and 0.85 or 0.89)
		end)
		Creator.AddSignal(Tab.Frame.MouseButton1Click, function()
			TabModule:SelectTab(TabIndex)
		end)

		TabModule.Containers[TabIndex] = Tab.ContainerAnim
		TabModule.Tabs[TabIndex] = Tab

		Tab.Container = Tab.ContainerFrame
		Tab.ScrollFrame = Tab.Container

		Tab.SubTabs = {}
		Tab.SubTabContainers = {}
		Tab.SelectedSubTab = 0
		Tab.SubTabCount = 0
		Tab.SubTabHolder = nil

		function Tab:AddSubTab(Title, Icon)
			self.SubTabCount = self.SubTabCount + 1
			local SubTabIndex = self.SubTabCount

			if not self.SubTabHolder then
				local SubTabListLayout = New("UIListLayout", {
					Padding = UDim.new(0, 6),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
				})

				self.SubTabHolder = New("ScrollingFrame", {
					Size = UDim2.new(1, 0, 0, 40),
					Position = UDim2.fromOffset(0, 8),
					BackgroundTransparency = 1,
					Parent = self.ContainerFrame,
					ScrollingDirection = Enum.ScrollingDirection.X,
					ScrollBarThickness = 0,
					ScrollBarImageTransparency = 1,
					ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
					CanvasSize = UDim2.fromScale(0, 1),
					BorderSizePixel = 0,
				}, {
					SubTabListLayout,
					New("UIPadding", {
						PaddingLeft = UDim.new(0, 0),
						PaddingRight = UDim.new(0, 0),
						PaddingTop = UDim.new(0, 0),
						PaddingBottom = UDim.new(0, 0),
					}),
				})

				Creator.AddSignal(SubTabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					self.SubTabHolder.CanvasSize = UDim2.new(0, SubTabListLayout.AbsoluteContentSize.X, 0, 40)
				end)

				local SubTabContainerHolder = New("Frame", {
					Size = UDim2.new(1, 0, 1, -56),
					Position = UDim2.fromOffset(0, 48),
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Parent = self.ContainerFrame,
				})

				self.SubTabContainerHolder = SubTabContainerHolder
			end

			local SubTabIcon = Icon

			local SubTabButton = New("TextButton", {
				Size = UDim2.new(0, 0, 0, 32),
				AutomaticSize = Enum.AutomaticSize.X,
				BackgroundTransparency = 1,
				Parent = self.SubTabHolder,
				Text = "",
				ThemeTag = {
					BackgroundColor3 = "Tab",
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 6),
				}),
				New("UIStroke", {
					Transparency = 1,
					Thickness = 1,
					ThemeTag = {
						Color = "Accent",
					},
				}),
				New("UIListLayout", {
					Padding = UDim.new(0, 6),
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalAlignment = Enum.VerticalAlignment.Center,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
				}),
				New("UIPadding", {
					PaddingLeft = UDim.new(0, 12),
					PaddingRight = UDim.new(0, 12),
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
				}),
				SubTabIcon and New("ImageLabel", {
					Size = UDim2.fromOffset(16, 16),
					BackgroundTransparency = 1,
					Image = SubTabIcon,
					LayoutOrder = 1,
					ThemeTag = {
						ImageColor3 = "Text",
					},
				}) or nil,
				New("TextLabel", {
					Text = Title,
					RichText = true,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextTransparency = 0,
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
					TextSize = 13,
					TextScaled = false,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					Size = UDim2.new(0, 0, 1, 0),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					LayoutOrder = 2,
					ThemeTag = {
						TextColor3 = "Text",
					},
				}),
			})

			local SubTabContainerAnim = New("CanvasGroup", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				GroupTransparency = 0,
				Parent = self.SubTabContainerHolder,
				Visible = false,
				Position = UDim2.fromOffset(0, 0),
				ClipsDescendants = true,
			})

			local SubTabContainer = New("ScrollingFrame", {
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Parent = SubTabContainerAnim,
				Visible = true,
				BottomImage = "",
				MidImage = "",
				TopImage = "",
				ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
				ScrollBarImageTransparency = 0.95,
				ScrollBarThickness = 3,
				BorderSizePixel = 0,
				CanvasSize = UDim2.fromScale(0, 0),
				ScrollingDirection = Enum.ScrollingDirection.Y,
				ScrollingEnabled = true,
			}, {
				New("UIListLayout", {
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				New("UIPadding", {
					PaddingRight = UDim.new(0, 0),
					PaddingLeft = UDim.new(0, 10),
					PaddingTop = UDim.new(0, 1),
					PaddingBottom = UDim.new(0, 1),
				}),
			})

			local SubTabLayout = SubTabContainer:FindFirstChild("UIListLayout")
			Creator.AddSignal(SubTabLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				SubTabContainer.CanvasSize = UDim2.new(0, 0, 0, SubTabLayout.AbsoluteContentSize.Y + 2)
			end)

			local SubTabXMotor = Flipper.SingleMotor.new(0)
			local SubTabTransparencyMotor = Flipper.SingleMotor.new(0)

			SubTabXMotor:onStep(function(Value)
				if SubTabContainerAnim and SubTabContainerAnim.Parent then
					SubTabContainerAnim.Position = UDim2.fromOffset(Value, 0)
				end
			end)

			SubTabTransparencyMotor:onStep(function(Value)
				if SubTabContainerAnim and SubTabContainerAnim.Parent then
					local alpha = math.clamp(Value, 0, 1)
					SubTabContainerAnim.GroupTransparency = alpha
				end
			end)

			local SubTabMotor, SubTabSetTransparency = Creator.SpringMotor(1, SubTabButton, "BackgroundTransparency")
			local SubTabStroke = SubTabButton:FindFirstChild("UIStroke")

			local function UpdateSubTabAppearance()
				if self.SelectedSubTab == SubTabIndex then
					SubTabSetTransparency(0.75)
					if SubTabStroke then
						SubTabStroke.Transparency = 0
					end
				else
					SubTabSetTransparency(1)
					if SubTabStroke then
						SubTabStroke.Transparency = 1
					end
				end
			end

			Creator.AddSignal(SubTabButton.MouseEnter, function()
				if self.SelectedSubTab ~= SubTabIndex then
					SubTabSetTransparency(0.87)
				end
			end)

			Creator.AddSignal(SubTabButton.MouseLeave, function()
				UpdateSubTabAppearance()
			end)

			Creator.AddSignal(SubTabButton.MouseButton1Down, function()
				SubTabSetTransparency(0.85)
			end)

			Creator.AddSignal(SubTabButton.MouseButton1Up, function()
				UpdateSubTabAppearance()
			end)

			UpdateSubTabAppearance()

			Creator.AddSignal(SubTabButton.MouseButton1Click, function()
				self:SelectSubTab(SubTabIndex)
			end)

			local SubTab = {
				Type = "SubTab",
				Name = Tab.Name,
				TabName = Tab.Name,
				Button = SubTabButton,
				Container = SubTabContainer,
				ContainerAnim = SubTabContainerAnim,
				XMotor = SubTabXMotor,
				TransparencyMotor = SubTabTransparencyMotor,
				SetTransparency = SubTabSetTransparency,
				Selected = false,
			}

			self.SubTabs[SubTabIndex] = SubTab
			self.SubTabContainers[SubTabIndex] = SubTabContainerAnim

			if self.SubTabCount == 1 then
				self:SelectSubTab(SubTabIndex)
			end

			function SubTab:AddSection(SectionTitle, SectionIcon)
				local Section = { Type = "Section", Name = Tab.Name, TabName = Tab.Name }

				local Icon = SectionIcon

				local SectionFrame = Components.Section(SectionTitle, SubTab.Container, Icon)
				Section.Container = SectionFrame.Container
				Section.ScrollFrame = SubTab.Container

				setmetatable(Section, Elements)
				return Section
			end

			setmetatable(SubTab, Elements)
			return SubTab
		end

		function Tab:SelectSubTab(SubTabIndex)
			if self.SelectedSubTab == SubTabIndex then
				return
			end

			local PreviousSubTab = self.SelectedSubTab
			local Direction = (PreviousSubTab > 0 and SubTabIndex > PreviousSubTab) and 1 or -1
			if PreviousSubTab == 0 then
				Direction = 0
			end

			local ContainerSize = self.SubTabContainerHolder and self.SubTabContainerHolder.AbsoluteSize.X or 500
			local SlideDistance = math.min(ContainerSize * 0.15, 60)

			self.SelectedSubTab = SubTabIndex

			for idx, SubTabObj in next, self.SubTabs do
				SubTabObj.Selected = (idx == SubTabIndex)
				local SubTabStroke = SubTabObj.Button:FindFirstChild("UIStroke")
				if idx == SubTabIndex then
					SubTabObj.SetTransparency(0.75)
					if SubTabStroke then
						SubTabStroke.Transparency = 0
					end
				else
					SubTabObj.SetTransparency(0.92)
					if SubTabStroke then
						SubTabStroke.Transparency = 1
					end
				end
			end

			if PreviousSubTab > 0 and PreviousSubTab ~= SubTabIndex and self.SubTabs[PreviousSubTab] and self.SubTabs[SubTabIndex] then
				local OldContainer = self.SubTabs[PreviousSubTab].ContainerAnim
				local NewContainer = self.SubTabs[SubTabIndex].ContainerAnim
				local OldSubTab = self.SubTabs[PreviousSubTab]
				local NewSubTab = self.SubTabs[SubTabIndex]

				for idx, Container in next, self.SubTabContainers do
					if Container and idx ~= PreviousSubTab and idx ~= SubTabIndex then
						Container.Visible = false
						Container.Position = UDim2.fromOffset(0, 0)
						if self.SubTabs[idx] then
							pcall(function()
								self.SubTabs[idx].XMotor:setGoal(Instant(0))
								self.SubTabs[idx].TransparencyMotor:setGoal(Instant(0))
							end)
						end
					end
				end

				OldContainer.Visible = false
				OldContainer.Position = UDim2.fromOffset(0, 0)
				pcall(function()
					OldSubTab.XMotor:setGoal(Instant(0))
					OldSubTab.TransparencyMotor:setGoal(Instant(0))
				end)

				NewContainer.Visible = true
				NewContainer.GroupTransparency = 0
				NewContainer.Position = UDim2.fromOffset(Direction * SlideDistance, 0)
				pcall(function()
					NewSubTab.XMotor:setGoal(Instant(Direction * SlideDistance))
					NewSubTab.TransparencyMotor:setGoal(Instant(0))
				end)

				task.wait()

				pcall(function()
					NewSubTab.XMotor:setGoal(Spring(0, { frequency = 10, dampingRatio = 0.85 }))
				end)

				task.spawn(function()
					task.wait(0.5)
				end)
			else
				for idx, Container in next, self.SubTabContainers do
					if Container then
						Container.Visible = (idx == SubTabIndex)
						Container.Position = UDim2.fromOffset(0, 0)
						if self.SubTabs[idx] then
							pcall(function()
								self.SubTabs[idx].XMotor:setGoal(Instant(0))
								self.SubTabs[idx].TransparencyMotor:setGoal(Instant(0))
							end)
						end
					end
				end
			end
		end

		function Tab:AddSection(SectionTitle, SectionIcon)
			if self.SelectedSubTab > 0 and self.SubTabs[self.SelectedSubTab] then
				return self.SubTabs[self.SelectedSubTab]:AddSection(SectionTitle, SectionIcon)
			end

			local Section = { Type = "Section", Name = Tab.Name, TabName = Tab.Name }

			local Icon = SectionIcon

			local SectionFrame = Components.Section(SectionTitle, Tab.Container, Icon)
			Section.Container = SectionFrame.Container
			Section.ScrollFrame = Tab.Container

			setmetatable(Section, Elements)
			return Section
		end

		setmetatable(Tab, Elements)
		return Tab
	end

	function TabModule:SelectTab(Tab)
		if TabModule.SelectedTab == Tab then
			return
		end

		if Library.OpenFrames then
			for _, frame in ipairs(Library.OpenFrames) do
				if frame.Visible then
					frame.Visible = false
					local dd = Library._OpenDropdowns and Library._OpenDropdowns[frame]
					if dd then
						dd.Opened = false
					end
				end
			end
		end

		local function hideContainer(container, tabObj)
			if container then
				container.Visible = false
				container.Position = UDim2.fromOffset(0, 0)
				container.GroupTransparency = 0
			end
			if tabObj and tabObj.ContainerXMotor and tabObj.ContainerTransparencyMotor then
				pcall(function()
					tabObj.ContainerXMotor:setGoal(Instant(0))
					tabObj.ContainerTransparencyMotor:setGoal(Instant(0))
				end)
			end
		end

		if TabModule.AnimationTask then
			task.cancel(TabModule.AnimationTask)
			TabModule.AnimationTask = nil
			if TabModule.CurrentAnimationTab and TabModule.CurrentAnimationTab ~= Tab then
				local prevAnimTab = TabModule.CurrentAnimationTab
				hideContainer(
					TabModule.Tabs[prevAnimTab] and TabModule.Tabs[prevAnimTab].ContainerAnim,
					TabModule.Tabs[prevAnimTab]
				)
			end
		end

		local Window = TabModule.Window
		local PreviousTab = TabModule.SelectedTab

		for idx, Container in next, TabModule.Containers do
			if Container and idx ~= PreviousTab and idx ~= Tab then
				hideContainer(Container, TabModule.Tabs[idx])
			end
		end

		local Direction = (PreviousTab > 0 and Tab > PreviousTab) and 1 or -1
		if PreviousTab == 0 then
			Direction = 0
		end

		local ContainerSize = Window.ContainerHolder and Window.ContainerHolder.AbsoluteSize.X or (Window.ContainerCanvas and Window.ContainerCanvas.AbsoluteSize.X or 500)
		local SlideDistance = math.min(ContainerSize * 0.15, 60)

		TabModule.SelectedTab = Tab
		TabModule.CurrentAnimationTab = Tab

		for _, TabObject in next, TabModule.Tabs do
			TabObject.SetTransparency(1)
			TabObject.Selected = false
		end
		TabModule.Tabs[Tab].SetTransparency(0.89)
		TabModule.Tabs[Tab].Selected = true

		Window.TabDisplay.Text = TabModule.Tabs[Tab].Name

		Window.SelectorSizeMotor:setGoal(Spring(32, { frequency = 6, dampingRatio = 0.7 }))
		task.defer(function()
			Window.SelectorSizeMotor:setGoal(Spring(16, { frequency = 6, dampingRatio = 0.8 }))
		end)
		local Selector = Window.Selector
		if Selector then
			Selector.Parent = TabModule.Tabs[Tab].Frame
			Selector.Position = UDim2.new(0, 0, 0.5, 0)
		end

		if PreviousTab > 0 and PreviousTab ~= Tab and TabModule.Tabs[PreviousTab] and TabModule.Tabs[Tab] then
			local OldContainer = TabModule.Tabs[PreviousTab].ContainerAnim
			local NewContainer = TabModule.Tabs[Tab].ContainerAnim
			local OldTab = TabModule.Tabs[PreviousTab]
			local NewTab = TabModule.Tabs[Tab]

			if not OldContainer or not NewContainer or not OldTab.ContainerXMotor or not OldTab.ContainerTransparencyMotor or not NewTab.ContainerXMotor or not NewTab.ContainerTransparencyMotor then
				for idx, Container in next, TabModule.Containers do
					if Container then
						Container.Visible = (idx == Tab)
						Container.Position = UDim2.fromOffset(0, 0)
					end
				end
				return
			end

			OldContainer.Visible = false
			OldContainer.Position = UDim2.fromOffset(0, 0)
			OldContainer.GroupTransparency = 0
			pcall(function()
				OldTab.ContainerXMotor:setGoal(Instant(0))
				OldTab.ContainerTransparencyMotor:setGoal(Instant(0))
			end)

			NewContainer.Visible = true
			NewContainer.GroupTransparency = 0
			NewContainer.Position = UDim2.fromOffset(Direction * SlideDistance, 0)
			pcall(function()
				NewTab.ContainerXMotor:setGoal(Instant(Direction * SlideDistance))
				NewTab.ContainerTransparencyMotor:setGoal(Instant(0))
			end)

			task.wait()

			pcall(function()
				NewTab.ContainerXMotor:setGoal(Spring(0, { frequency = 10, dampingRatio = 0.85 }))
			end)

			TabModule.AnimationTask = task.spawn(function()
				task.wait(0.5)
				if TabModule.CurrentAnimationTab == Tab then
					TabModule.AnimationTask = nil
				end
			end)
		else
			for idx, Container in next, TabModule.Containers do
				if Container then
					Container.Visible = (idx == Tab)
					Container.Position = UDim2.fromOffset(0, 0)
					Container.GroupTransparency = 0
					if TabModule.Tabs[idx] and TabModule.Tabs[idx].ContainerXMotor and TabModule.Tabs[idx].ContainerTransparencyMotor then
						pcall(function()
							TabModule.Tabs[idx].ContainerXMotor:setGoal(Instant(0))
							TabModule.Tabs[idx].ContainerTransparencyMotor:setGoal(Instant(0))
						end)
					end
				end
			end
		end
	end

	return TabModule
end)()
Components.Button = (function()
	local New = Creator.New

	local Spring = Flipper.Spring.new

	return function(Theme, Parent, DialogCheck)
		DialogCheck = DialogCheck or false
		local Button = {}

		Button.Title = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Button.HoverFrame = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ThemeTag = {
				BackgroundColor3 = "Hover",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		Button.Frame = New("TextButton", {
			Size = UDim2.new(0, 0, 0, 32),
			Parent = Parent,
			ThemeTag = {
				BackgroundColor3 = "DialogButton",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = 0.65,
				ThemeTag = {
					Color = "DialogButtonBorder",
				},
			}),
			Button.HoverFrame,
			Button.Title,
		})
		local Motor, SetTransparency = Creator.SpringMotor(1, Button.HoverFrame, "BackgroundTransparency", DialogCheck)
		Creator.AddSignal(Button.Frame.MouseEnter, function()
			SetTransparency(0.97)
		end)
		Creator.AddSignal(Button.Frame.MouseLeave, function()
			SetTransparency(1)
		end)
		Creator.AddSignal(Button.Frame.MouseButton1Down, function()
			SetTransparency(1)
		end)
		Creator.AddSignal(Button.Frame.MouseButton1Up, function()
			SetTransparency(0.97)
		end)

		return Button
	end
end)()
Components.Dialog = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Dialog = {
		Window = nil,
	}

	function Dialog:Init(Window)
		Dialog.Window = Window
		return Dialog
	end

	function Dialog:Create()
		local NewDialog = {
			Buttons = 0,
		}

		NewDialog.TintFrame = New("TextButton", {
			Text = "",
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			ZIndex = 50,
			Parent = Dialog.Window.Root,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, WINDOW_CORNER),
			}),
		})

		local TintMotor, TintTransparency = Creator.SpringMotor(1, NewDialog.TintFrame, "BackgroundTransparency", true)

		NewDialog.ButtonHolder = New("Frame", {
			Size = UDim2.new(1, -40, 1, -40),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 10),
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		NewDialog.ButtonHolderFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 70),
			Position = UDim2.new(0, 0, 1, -70),
			ThemeTag = {
				BackgroundColor3 = "DialogHolder",
			},
		}, {
			New("Frame", {
				Size = UDim2.new(1, 0, 0, 1),
				ThemeTag = {
					BackgroundColor3 = "DialogHolderLine",
				},
			}),
			NewDialog.ButtonHolder,
		})

		NewDialog.Title = New("TextLabel", {
			FontFace = Font.new(
				"rbxasset://fonts/families/GothamSSm.json",
				Enum.FontWeight.SemiBold,
				Enum.FontStyle.Normal
			),
			Text = "Dialog",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 22,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, 0, 0, 22),
			Position = UDim2.fromOffset(20, 25),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewDialog.Scale = New("UIScale", {
			Scale = 1,
		})

		local ScaleMotor, Scale = Creator.SpringMotor(1.1, NewDialog.Scale, "Scale")

		NewDialog.Root = New("CanvasGroup", {
			Size = UDim2.fromOffset(300, 165),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			GroupTransparency = 1,
			Parent = NewDialog.TintFrame,
			ThemeTag = {
				BackgroundColor3 = "Dialog",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ThemeTag = {
					Color = "DialogBorder",
				},
			}),
			NewDialog.Scale,
			NewDialog.Title,
			NewDialog.ButtonHolderFrame,
		})

		local RootMotor, RootTransparency = Creator.SpringMotor(1, NewDialog.Root, "GroupTransparency")

		function NewDialog:Open()
			Library.DialogOpen = true
			NewDialog.Scale.Scale = 1.1
			TintTransparency(0.75)
			RootTransparency(0)
			Scale(1)
		end

		function NewDialog:Close()
			Library.DialogOpen = false
			TintTransparency(1)
			RootTransparency(1)
			Scale(1.1)
			NewDialog.Root.UIStroke:Destroy()
			task.wait(0.15)
			NewDialog.TintFrame:Destroy()
		end

		function NewDialog:Button(Title, Callback)
			NewDialog.Buttons = NewDialog.Buttons + 1
			Title = Title or "Button"
			Callback = Callback or function() end

			local Button = Components.Button("", NewDialog.ButtonHolder, true)
			Button.Title.Text = Title

			for _, Btn in next, NewDialog.ButtonHolder:GetChildren() do
				if Btn:IsA("TextButton") then
					Btn.Size =
						UDim2.new(1 / NewDialog.Buttons, -(((NewDialog.Buttons - 1) * 10) / NewDialog.Buttons), 0, 32)
				end
			end

			Creator.AddSignal(Button.Frame.MouseButton1Click, function()
				Library:SafeCallback(Callback)
				pcall(function()
					NewDialog:Close()
				end)
			end)

			return Button
		end

		return NewDialog
	end

	return Dialog
end)()
Components.Notification = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	local Notification = {}

	function Notification:Init(GUI)
		Library.ActiveNotifications = Library.ActiveNotifications or {}

		Notification.Holder = New("Frame", {
			Position = UDim2.new(1, -30, 1, -30),
			Size = UDim2.new(0, 310, 1, -30),
			AnchorPoint = Vector2.new(1, 1),
			BackgroundTransparency = 1,
			Parent = GUI,
		}, {
			New("UIListLayout", {
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Bottom,
				Padding = UDim.new(0, 8),
			}),
		})
	end

	function Notification:New(Config)
		Config.Title = Config.Title or "Title"
		Config.Content = Config.Content or "Content"
		Config.SubContent = Config.SubContent or ""
		Config.Duration = Config.Duration or nil
		local NewNotification = {
			Closed = false,
		}

		NewNotification.AcrylicPaint = Acrylic.AcrylicPaint()

		NewNotification.Title = New("TextLabel", {
			Position = UDim2.new(0, 14, 0, 17),
			Text = Config.Title,
			RichText = true,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			Size = UDim2.new(1, -12, 0, 12),
			TextWrapped = true,
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.ContentLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = Config.Content,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		NewNotification.SubContentLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = Config.SubContent,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,
			Size = UDim2.new(1, 0, 0, 14),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			TextWrapped = true,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		NewNotification.LabelHolder = New("Frame", {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(14, 40),
			Size = UDim2.new(1, -28, 0, 0),
		}, {
			New("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				Padding = UDim.new(0, 3),
			}),
			NewNotification.ContentLabel,
			NewNotification.SubContentLabel,
		})

		NewNotification.CloseButton = New("TextButton", {
			Text = "",
			Position = UDim2.new(1, -14, 0, 13),
			Size = UDim2.fromOffset(20, 20),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
		}, {
			New("ImageLabel", {
				Image = Components.Assets.Close,
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ThemeTag = {
					ImageColor3 = "Text",
				},
			}),
		})

		NewNotification.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.fromScale(1, 0),
		}, {
			NewNotification.AcrylicPaint.Frame,
			NewNotification.Title,
			NewNotification.CloseButton,
			NewNotification.LabelHolder,
		})

		if Config.Content == "" then
			NewNotification.ContentLabel.Visible = false
		end

		if Config.SubContent == "" then
			NewNotification.SubContentLabel.Visible = false
		end

		NewNotification.Holder = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 200),
			Parent = Notification.Holder,
		}, {
			NewNotification.Root,
		})

		local RootMotor = Flipper.GroupMotor.new({
			Scale = 1,
			Offset = 60,
		})

		RootMotor:onStep(function(Values)
			NewNotification.Root.Position = UDim2.new(Values.Scale, Values.Offset, 0, 0)
		end)

		Creator.AddSignal(NewNotification.CloseButton.MouseButton1Click, function()
			NewNotification:Close()
		end)
		function NewNotification:ApplyTransparency()
			if Library.Theme == "Glass" and Library.UseAcrylic then
				local Value = Library.NotificationTransparency or 1

				local notifTransparency = 0.85 + (Value * 0.08)
				if Value > 1 then
					notifTransparency = 0.93 + ((Value - 1) * 0.04)
				end

				local notifBackgroundTransparency = 0.8 + (Value * 0.1)
				if Value > 1 then
					notifBackgroundTransparency = 0.9 + ((Value - 1) * 0.05)
				end

				if NewNotification.AcrylicPaint and NewNotification.AcrylicPaint.Model then
					NewNotification.AcrylicPaint.Model.Transparency = math.min(notifTransparency, 0.97)
				end
				if NewNotification.AcrylicPaint and NewNotification.AcrylicPaint.Frame and NewNotification.AcrylicPaint.Frame.Background then
					NewNotification.AcrylicPaint.Frame.Background.BackgroundTransparency = math.min(notifBackgroundTransparency, 0.95)
				end
			end
		end

		function NewNotification:Open()
			local ContentSize = NewNotification.LabelHolder.AbsoluteSize.Y
			NewNotification.Holder.Size = UDim2.new(1, 0, 0, 58 + ContentSize)

			RootMotor:setGoal({
				Scale = Spring(0, { frequency = 5 }),
				Offset = Spring(0, { frequency = 5 }),
			})

			task.defer(function()
				task.wait(0.1)
				NewNotification:ApplyTransparency()
			end)
		end

		function NewNotification:Close()
			if not NewNotification.Closed then
				NewNotification.Closed = true

				for i, notif in pairs(Library.ActiveNotifications or {}) do
					if notif == NewNotification then
						table.remove(Library.ActiveNotifications, i)
						break
					end
				end

				task.spawn(function()
					RootMotor:setGoal({
						Scale = Spring(1, { frequency = 5 }),
						Offset = Spring(60, { frequency = 5 }),
					})
					task.wait(0.4)
					if Library.UseAcrylic then
						NewNotification.AcrylicPaint.Model:Destroy()
					end
					NewNotification.Holder:Destroy()
				end)
			end
		end

		table.insert(Library.ActiveNotifications, NewNotification)

		NewNotification:Open()
		if Config.Duration then
			task.delay(Config.Duration, function()
				NewNotification:Close()
			end)
		end
		return NewNotification
	end

	return Notification
end)()
Components.Textbox = (function()
	local New = Creator.New

	return function(Parent, Acrylic)
		Acrylic = Acrylic or false
		local Textbox = {}

		Textbox.Input = New("TextBox", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Size = UDim2.fromScale(1, 1),
			Position = UDim2.fromOffset(10, 0),
			ThemeTag = {
				TextColor3 = "Text",
				PlaceholderColor3 = "SubText",
			},
		})

		Textbox.Container = New("Frame", {
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			Position = UDim2.new(0, 6, 0, 0),
			Size = UDim2.new(1, -12, 1, 0),
		}, {
			Textbox.Input,
		})

		Textbox.Indicator = New("Frame", {
			Size = UDim2.new(1, -4, 0, 1),
			Position = UDim2.new(0, 2, 1, 0),
			AnchorPoint = Vector2.new(0, 1),
			BackgroundTransparency = Acrylic and 0.5 or 0,
			ThemeTag = {
				BackgroundColor3 = Acrylic and "InputIndicator" or "DialogInputLine",
			},
		})

		Textbox.Frame = New("Frame", {
			Size = UDim2.new(0, 0, 0, 30),
			BackgroundTransparency = Acrylic and 0.9 or 0,
			Parent = Parent,
			ThemeTag = {
				BackgroundColor3 = Acrylic and "Input" or "DialogInput",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = Acrylic and 0.5 or 0.65,
				ThemeTag = {
					Color = Acrylic and "InElementBorder" or "DialogButtonBorder",
				},
			}),
			Textbox.Indicator,
			Textbox.Container,
		})

		local function Update()
			local PADDING = 2
			local Reveal = Textbox.Container.AbsoluteSize.X

			if not Textbox.Input:IsFocused() or Textbox.Input.TextBounds.X <= Reveal - 2 * PADDING then
				Textbox.Input.Position = UDim2.new(0, PADDING, 0, 0)
			else
				local Cursor = Textbox.Input.CursorPosition
				if Cursor ~= -1 then
					local subtext = string.sub(Textbox.Input.Text, 1, Cursor - 1)
					local width = TextService:GetTextSize(
						subtext,
						Textbox.Input.TextSize,
						Textbox.Input.Font,
						Vector2.new(math.huge, math.huge)
					).X

					local CurrentCursorPos = Textbox.Input.Position.X.Offset + width
					if CurrentCursorPos < PADDING then
						Textbox.Input.Position = UDim2.fromOffset(PADDING - width, 0)
					elseif CurrentCursorPos > Reveal - PADDING - 1 then
						Textbox.Input.Position = UDim2.fromOffset(Reveal - width - PADDING - 1, 0)
					end
				end
			end
		end

		task.spawn(Update)

		Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("Text"), Update)
		Creator.AddSignal(Textbox.Input:GetPropertyChangedSignal("CursorPosition"), Update)

		Creator.AddSignal(Textbox.Input.Focused, function()
			Update()
			Textbox.Indicator.Size = UDim2.new(1, -2, 0, 2)
			Textbox.Indicator.Position = UDim2.new(0, 1, 1, 0)
			Textbox.Indicator.BackgroundTransparency = 0
			Creator.OverrideTag(Textbox.Frame, { BackgroundColor3 = Acrylic and "InputFocused" or "DialogHolder" })
			Creator.OverrideTag(Textbox.Indicator, { BackgroundColor3 = "InputIndicatorFocus" })
		end)

		Creator.AddSignal(Textbox.Input.FocusLost, function()
			Update()
			Textbox.Indicator.Size = UDim2.new(1, -4, 0, 1)
			Textbox.Indicator.Position = UDim2.new(0, 2, 1, 0)
			Textbox.Indicator.BackgroundTransparency = 0.5
			Creator.OverrideTag(Textbox.Frame, { BackgroundColor3 = Acrylic and "Input" or "DialogInput" })
			Creator.OverrideTag(Textbox.Indicator, { BackgroundColor3 = Acrylic and "InputIndicator" or "DialogInputLine" })
		end)

		return Textbox
	end
end)()
Components.TitleBar = (function()
	local New = Creator.New
	local AddSignal = Creator.AddSignal
	local Spring = Flipper.Spring.new

	local BAR_H = TITLEBAR_HEIGHT
	local INNER_H = BAR_H - 12
	local BTN = Mobile and 34 or 28
	local PITCH = BTN + (Mobile and 6 or 4)
	local GlyphTween = TweenInfo.new(0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

	local CLOSE_RED = Color3.fromRGB(232, 72, 72)

	local function hashString(str)
		local h = 5381
		for i = 1, #str do
			h = (h * 33 + string.byte(str, i)) % 4294967296
		end
		return h
	end

	-- Accepts: "rbxassetid://123" | 123 | "123" | "avatar"/"player" | "rbxthumb://..." | "https://...png"
	-- Apply(image) is optional and is called later for sources that must be downloaded.
	local function ResolveIcon(value, Apply)
		if value == nil then
			return nil
		end
		if type(value) == "number" then
			return "rbxassetid://" .. string.format("%d", value)
		end
		if type(value) ~= "string" or value == "" then
			return nil
		end

		local lower = string.lower(value)

		if lower == "avatar" or lower == "player" or lower == "headshot" or lower == "me" then
			return "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=150&h=150"
		end

		if string.match(value, "^%d+$") then
			return "rbxassetid://" .. value
		end

		if string.match(lower, "^https?://") then
			-- game:HttpGet YIELDS, and this runs while the window is being built, so
			-- never download inline. A cached copy resolves instantly; anything else
			-- is fetched on another thread and applied through Apply() when it lands.
			if RunService:IsStudio() or not (writefile and isfile and getcustomasset) then
				return nil
			end
			local ext = string.match(lower, "%.(%a%a%a%a?)$") or "png"
			local file = "FluentTopBar_" .. tostring(hashString(value)) .. "." .. ext

			local cached = nil
			pcall(function()
				if isfile(file) then
					cached = getcustomasset(file)
				end
			end)
			if type(cached) == "string" and cached ~= "" then
				return cached
			end

			if Apply then
				task.spawn(function()
					local ok, asset = pcall(function()
						writefile(file, game:HttpGet(value))
						return getcustomasset(file)
					end)
					if ok and type(asset) == "string" and asset ~= "" then
						Apply(asset)
					else
						warn("[Fluent] could not load the top bar photo from " .. value)
					end
				end)
			end
			return nil
		end

		return value
	end

	return function(Config)
		local TitleBar = {}
		local Buttons = {}
		local BarInside = false

		local function AnyButtonHovered()
			for _, b in ipairs(Buttons) do
				if b.Hovered then
					return true
				end
			end
			return false
		end
		local BarHoverIn, BarHoverOut -- forward declared, assigned once the bar exists

		----------------------------------------------------------------
		--  Tooltip
		----------------------------------------------------------------
		local TipLabel = New("TextLabel", {
			Name = "Label",
			Text = "",
			RichText = false,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			TextSize = 12,
			TextTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.new(0, 0, 1, 0),
			BackgroundTransparency = 1,
			ZIndex = 42,
			ThemeTag = { TextColor3 = "Text" },
		})

		local TipStroke = New("UIStroke", {
			Thickness = 1,
			Transparency = 1,
			ThemeTag = { Color = "DialogBorder" },
		})

		local Tip = New("Frame", {
			Name = "Tooltip",
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.fromOffset(0, 22),
			AnchorPoint = Vector2.new(0.5, 0),
			Position = UDim2.fromOffset(0, BAR_H - 4),
			BackgroundTransparency = 1,
			Visible = false,
			ZIndex = 41,
			ThemeTag = { BackgroundColor3 = "DialogHolder" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 6) }),
			TipStroke,
			New("UIPadding", {
				PaddingLeft = UDim.new(0, 9),
				PaddingRight = UDim.new(0, 9),
			}),
			TipLabel,
		})

		local TipBgMotor, SetTipBg = Creator.SpringMotor(1, Tip, "BackgroundTransparency", true)
		local TipTextMotor, SetTipText = Creator.SpringMotor(1, TipLabel, "TextTransparency", true)
		local TipStrokeMotor, SetTipStroke = Creator.SpringMotor(1, TipStroke, "Transparency", true)

		local TipToken = 0
		local function HideTip()
			TipToken = TipToken + 1
			SetTipBg(1)
			SetTipText(1)
			SetTipStroke(1)
			local myToken = TipToken
			task.delay(0.2, function()
				if myToken == TipToken then
					Tip.Visible = false
				end
			end)
		end

		local function ShowTip(text, anchorButton)
			TipToken = TipToken + 1
			local myToken = TipToken
			task.delay(0.35, function()
				if myToken ~= TipToken then
					return
				end
				TipLabel.Text = text
				Tip.Visible = true
				local barX = TitleBar.Frame and TitleBar.Frame.AbsolutePosition.X or 0
				local btnX = anchorButton.AbsolutePosition.X
				Tip.Position = UDim2.fromOffset(math.floor(btnX - barX + BTN / 2), BAR_H - 4)
				SetTipBg(0.08)
				SetTipText(0)
				SetTipStroke(0.45)
			end)
		end

		----------------------------------------------------------------
		--  Glyphs drawn with frames (crisp + themeable + animatable)
		----------------------------------------------------------------
		local function GlyphBar(name, w, h, xOff, yOff, rot)
			return New("Frame", {
				Name = name,
				Size = UDim2.fromOffset(w, h),
				Position = UDim2.new(0.5, xOff, 0.5, yOff),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Rotation = rot or 0,
				BackgroundTransparency = 0.1,
				ZIndex = 8,
				ThemeTag = { BackgroundColor3 = "Text" },
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
			})
		end

		local function BarButton(Kind, Index, TipText, Callback)
			local Button = {
				Kind = Kind,
				Callback = Callback or function() end,
			}

			local Glyph = New("Frame", {
				Name = "Icon",
				Size = UDim2.fromOffset(14, 14),
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				ZIndex = 7,
			}, {})

			Button.Glyph = Glyph
			Button.Bars = {}

			if Kind == "min" then
				Button.Bars.A = GlyphBar("A", 7, 2, -3, 0, 0)
				Button.Bars.B = GlyphBar("B", 7, 2, 3, 0, 0)
				Button.Bars.A.Parent = Glyph
				Button.Bars.B.Parent = Glyph
			elseif Kind == "max" then
				Button.BackStroke = New("UIStroke", {
					Thickness = 1.6,
					Transparency = 1,
					ThemeTag = { Color = "Text" },
				})
				Button.FrontStroke = New("UIStroke", {
					Thickness = 1.6,
					Transparency = 0.1,
					ThemeTag = { Color = "Text" },
				})
				Button.Back = New("Frame", {
					Name = "Back",
					Size = UDim2.fromOffset(9, 9),
					Position = UDim2.new(0.5, 2, 0.5, -2),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					ZIndex = 7,
				}, {
					New("UICorner", { CornerRadius = UDim.new(0, 3) }),
					Button.BackStroke,
				})
				Button.Front = New("Frame", {
					Name = "Front",
					Size = UDim2.fromOffset(11, 11),
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					BackgroundTransparency = 1,
					ZIndex = 8,
				}, {
					New("UICorner", { CornerRadius = UDim.new(0, 3) }),
					Button.FrontStroke,
				})
				Button.Back.Parent = Glyph
				Button.Front.Parent = Glyph
			else
				Button.Bars.A = GlyphBar("A", 13, 2, 0, 0, 45)
				Button.Bars.B = GlyphBar("B", 13, 2, 0, 0, -45)
				Button.Bars.A.Parent = Glyph
				Button.Bars.B.Parent = Glyph
			end

			local props = {
				Name = "TitleBarButton_" .. Kind,
				Size = UDim2.fromOffset(BTN, BTN),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -6 - (Index - 1) * PITCH, 0.5, 0),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Text = "",
				ZIndex = 6,
			}
			if Kind == "close" then
				props.BackgroundColor3 = CLOSE_RED
			else
				props.ThemeTag = { BackgroundColor3 = "Tab" }
			end

			Button.Frame = New("TextButton", props, {
				New("UICorner", { CornerRadius = UDim.new(0, 8) }),
				Glyph,
			})

			local BgMotor, SetBg = Creator.SpringMotor(1, Button.Frame, "BackgroundTransparency", true)
			local ScaleObj = New("UIScale", { Scale = 1, Parent = Button.Frame })
			local ScaleMotor, SetScale = Creator.SpringMotor(1, ScaleObj, "Scale", true)

			local function TintGlyph(color)
				for _, bar in pairs(Button.Bars) do
					TweenService:Create(bar, GlyphTween, { BackgroundColor3 = color }):Play()
				end
			end

			AddSignal(Button.Frame.MouseEnter, function()
				Button.Hovered = true
				if BarHoverIn then
					BarHoverIn()
				end
				SetBg(Kind == "close" and 0.12 or 0.8)
				SetScale(1.08)
				if Kind == "close" then
					TintGlyph(Color3.fromRGB(255, 255, 255))
				end
				ShowTip(TipText, Button.Frame)
			end)
			AddSignal(Button.Frame.MouseLeave, function()
				Button.Hovered = false
				if BarHoverOut then
					BarHoverOut()
				end
				SetBg(1, true)
				SetScale(1)
				if Kind == "close" then
					TintGlyph(Creator.GetThemeProperty("Text") or Color3.fromRGB(240, 240, 240))
				end
				HideTip()
			end)
			AddSignal(Button.Frame.MouseButton1Down, function()
				SetBg(Kind == "close" and 0 or 0.68)
				SetScale(0.9)
			end)
			AddSignal(Button.Frame.MouseButton1Up, function()
				SetBg(Kind == "close" and 0.12 or 0.8)
				SetScale(1.08)
			end)
			AddSignal(Button.Frame.MouseButton1Click, function()
				HideTip()
				Button.Callback()
			end)

			-- GUI input bubbles up to the bar, which owns the window drag and the
			-- double-click-to-maximize. The child fires first, so stamping here lets
			-- the bar's own handler bail out of a press that landed on a button.
			AddSignal(Button.Frame.InputBegan, function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					TitleBar.ButtonPress = os.clock()
				end
			end)

			Button.SetCallback = function(Func)
				Button.Callback = Func or function() end
			end

			table.insert(Buttons, Button)
			return Button
		end

		----------------------------------------------------------------
		--  Left cluster : photo + hub name + subtitle
		----------------------------------------------------------------
		local ApplyIcon -- forward declared, defined once IconImage exists
		local resolvedIcon = ResolveIcon(Config.Icon, function(image)
			if ApplyIcon then
				ApplyIcon(image)
			end
		end)
		local iconRadius = (Config.IconCorner == "square" and UDim.new(0, 2))
			or (Config.IconCorner == "rounded" and UDim.new(0, 8))
			or UDim.new(1, 0)

		local IconImage = New("ImageLabel", {
			Name = "Photo",
			Image = resolvedIcon or "",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Crop,
			ResampleMode = Enum.ResamplerMode.Default,
			ZIndex = 6,
		}, {
			New("UICorner", { CornerRadius = iconRadius }),
		})

		local IconHolder = New("Frame", {
			Name = "PhotoHolder",
			Size = UDim2.fromOffset(26, 26),
			BackgroundTransparency = resolvedIcon and 1 or 0.6,
			Visible = resolvedIcon ~= nil,
			LayoutOrder = 1,
			ZIndex = 6,
			ThemeTag = { BackgroundColor3 = "Element" },
		}, {
			New("UICorner", { CornerRadius = iconRadius }),
			IconImage,
			New("UIStroke", {
				Thickness = 1,
				Transparency = 0.55,
				ThemeTag = { Color = "InElementBorder" },
			}),
		})

		local TitleLabel = New("TextLabel", {
			Name = "HubName",
			RichText = true,
			Text = Config.Title or "Hub",
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
			TextSize = 14,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			Size = UDim2.fromScale(0, 1),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			ZIndex = 6,
			ThemeTag = { TextColor3 = "Text" },
		}, {
			New("UISizeConstraint", { MaxSize = Vector2.new(230, math.huge) }),
		})

		local Divider = New("Frame", {
			Name = "Divider",
			Size = UDim2.fromOffset(1, 14),
			BackgroundTransparency = 0.55,
			Visible = (Config.SubTitle ~= nil and Config.SubTitle ~= ""),
			LayoutOrder = 3,
			ZIndex = 6,
			ThemeTag = { BackgroundColor3 = "InElementBorder" },
		}, {})

		local SubTitleLabel = New("TextLabel", {
			Name = "SubTitle",
			RichText = true,
			Text = Config.SubTitle or "",
			TextTransparency = 0.25,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			Size = UDim2.fromScale(0, 1),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			Visible = (Config.SubTitle ~= nil and Config.SubTitle ~= ""),
			LayoutOrder = 4,
			ZIndex = 6,
			ThemeTag = { TextColor3 = "SubText" },
		}, {
			New("UISizeConstraint", { MaxSize = Vector2.new(260, math.huge) }),
		})

		local LeftCluster = New("Frame", {
			Name = "Left",
			Size = UDim2.new(1, -(18 + 3 * PITCH), 1, 0),
			Position = UDim2.fromOffset(10, 0),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
			ZIndex = 6,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 9),
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			}),
			IconHolder,
			TitleLabel,
			Divider,
			SubTitleLabel,
		})

		----------------------------------------------------------------
		--  The bar itself : rounded, elevated, animated
		----------------------------------------------------------------
		local BarStroke = New("UIStroke", {
			Thickness = 1,
			Transparency = 0.6,
			ThemeTag = { Color = "InElementBorder" },
		})

		local Bar = New("Frame", {
			Name = "Bar",
			Size = UDim2.new(1, -20, 0, INNER_H),
			Position = UDim2.new(0, 10, 0, 6),
			BackgroundTransparency = 0.55,
			ZIndex = 5,
			ThemeTag = { BackgroundColor3 = "Element" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(0, 10) }),
			New("UIGradient", {
				Rotation = 90,
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(1, 0.45),
				}),
			}),
			BarStroke,
			LeftCluster,
		})

		local AccentLine = New("Frame", {
			Name = "AccentLine",
			Size = UDim2.new(0, 0, 0, 2),
			Position = UDim2.new(0.5, 0, 1, -1),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 0.25,
			ZIndex = 9,
			ThemeTag = { BackgroundColor3 = "Accent" },
		}, {
			New("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})
		AccentLine.Parent = Bar

		TitleBar.Frame = New("Frame", {
			Name = "TitleBar",
			Size = UDim2.new(1, 0, 0, BAR_H),
			Position = UDim2.fromOffset(0, 0),
			BackgroundTransparency = 1,
			ZIndex = 4,
			Parent = Config.Parent,
		}, {
			Bar,
			Tip,
		})

		TitleBar.Bar = Bar
		TitleBar.Height = BAR_H
		TitleBar.TitleLabel = TitleLabel
		TitleBar.SubTitleLabel = SubTitleLabel
		TitleBar.IconImage = IconImage
		TitleBar.IconHolder = IconHolder

		-- hover lift on the whole bar
		local BarBgMotor, SetBarBg = Creator.SpringMotor(0.55, Bar, "BackgroundTransparency", true)
		local BarStrokeMotor, SetBarStroke = Creator.SpringMotor(0.6, BarStroke, "Transparency", true)

		BarHoverIn = function()
			SetBarBg(0.4)
			SetBarStroke(0.35)
			TweenService:Create(AccentLine, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, -24, 0, 2),
			}):Play()
		end

		-- a child TextButton steals the pointer and fires Bar.MouseLeave, so settle a
		-- couple of frames later and only retract when nothing in the bar is hovered
		BarHoverOut = function()
			task.delay(0.06, function()
				if BarInside or AnyButtonHovered() then
					return
				end
				SetBarBg(0.55, true)
				SetBarStroke(0.6, true)
				TweenService:Create(AccentLine, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, 0, 0, 2),
				}):Play()
			end)
		end

		AddSignal(Bar.MouseEnter, function()
			BarInside = true
			BarHoverIn()
		end)
		AddSignal(Bar.MouseLeave, function()
			BarInside = false
			BarHoverOut()
		end)

		----------------------------------------------------------------
		--  Buttons  (right to left : close, maximize, minimize)
		----------------------------------------------------------------
		TitleBar.CloseButton = BarButton("close", 1, "Unload", function()
			Library.Window:Dialog({
				Title = "Close",
				Content = "Are you sure you want to unload the interface?",
				Buttons = {
					{
						Title = "Yes",
						Callback = function()
							Library:Destroy()
						end,
					},
					{
						Title = "No",
					},
				},
			})
		end)

		TitleBar.MaxButton = BarButton("max", 2, "Maximize", function()
			Config.Window.Maximize(not Config.Window.Maximized)
		end)

		TitleBar.MinButton = BarButton("min", 3, "Minimize", function()
			if Config.Window.ToggleCollapse then
				Config.Window.ToggleCollapse()
			else
				Library.Window:Minimize()
			end
		end)

		TitleBar.CloseButton.Frame.Parent = Bar
		TitleBar.MaxButton.Frame.Parent = Bar
		TitleBar.MinButton.Frame.Parent = Bar

		TitleBar.Buttons = Buttons
		TitleBar.IsButtonHovered = AnyButtonHovered

		----------------------------------------------------------------
		--  State setters
		----------------------------------------------------------------
		function TitleBar.SetCollapsed(Value)
			local btn = TitleBar.MinButton
			local rot = Value and 26 or 0
			local yOff = Value and -1 or 0
			TweenService:Create(btn.Bars.A, GlyphTween, {
				Rotation = rot,
				Position = UDim2.new(0.5, -3, 0.5, yOff),
			}):Play()
			TweenService:Create(btn.Bars.B, GlyphTween, {
				Rotation = -rot,
				Position = UDim2.new(0.5, 3, 0.5, yOff),
			}):Play()
		end

		function TitleBar.SetMaximized(Value)
			local btn = TitleBar.MaxButton
			TweenService:Create(btn.Front, GlyphTween, {
				Size = UDim2.fromOffset(Value and 9 or 11, Value and 9 or 11),
				Position = Value and UDim2.new(0.5, -2, 0.5, 2) or UDim2.fromScale(0.5, 0.5),
			}):Play()
			TweenService:Create(btn.BackStroke, GlyphTween, {
				Transparency = Value and 0.45 or 1,
			}):Play()
		end

		function TitleBar.SetTitle(Text)
			TitleLabel.Text = tostring(Text or "")
		end

		function TitleBar.SetSubTitle(Text)
			Text = tostring(Text or "")
			SubTitleLabel.Text = Text
			SubTitleLabel.Visible = Text ~= ""
			Divider.Visible = Text ~= ""
		end

		ApplyIcon = function(image)
			IconImage.Image = image or ""
			IconHolder.Visible = image ~= nil and image ~= ""
			IconHolder.BackgroundTransparency = (image and image ~= "") and 1 or 0.6
		end

		function TitleBar.SetIcon(Value)
			ApplyIcon(ResolveIcon(Value, ApplyIcon))
		end

		return TitleBar
	end
end)()
Components.Window = (function()
	local Spring = Flipper.Spring.new
	local Instant = Flipper.Instant.new
	local New = Creator.New

	return function(Config)
		local Window = {
			Minimized = false,
			Maximized = false,
			Size = Config.Size,
			CurrentPos = 0,
			TabWidth = 0,
			Position = UDim2.fromOffset(0, 0),
			DropdownsOutsideWindow = Config.DropdownsOutsideWindow == true,
		}

		Library.Window = Window

		local Resizing, ResizePos = false
		local MinimizeNotif = false

		Window.AcrylicPaint = Acrylic.AcrylicPaint()

		local function CenterWindow()
			local vp = Camera.ViewportSize
			local x = math.max(0, (vp.X - Window.Size.X.Offset) / 2)
			local liveH = Window.Collapsed and (TITLEBAR_HEIGHT + 2) or Window.Size.Y.Offset
			local y = math.max(0, (vp.Y - liveH) / 2)
			Window.Position = UDim2.fromOffset(math.floor(x), math.floor(y))
			if Window.Root then
				Window.Root.Position = Window.Position
			end
			if Window.PosMotor then
				Window.PosMotor:setGoal({
					X = Flipper.Instant.new(Window.Position.X.Offset),
					Y = Flipper.Instant.new(Window.Position.Y.Offset),
				})
			end
		end
		Window.TabWidth = Config.TabWidth or 150

		local Selector = New("Frame", {
			Size = UDim2.fromOffset(4, 0),
			BackgroundColor3 = Color3.fromRGB(76, 194, 255),
			Position = UDim2.fromOffset(0, 17),
			AnchorPoint = Vector2.new(0, 0.5),
			ZIndex = 20,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 9),
			}),
		})

		local ResizeStartFrame = New("Frame", {
			Size = UDim2.fromOffset(20, 20),
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -20, 1, -2),
		})

		local SearchElements = {}
		local AllElements = {}

		local function UpdateElementVisibility(searchTerm)
			if not searchTerm then searchTerm = "" end

			local function normalizeText(text)
				if not text then return "" end
				text = tostring(text)
				text = string.gsub(text, "^%s+", "")
				text = string.gsub(text, "%s+$", "")
				text = string.gsub(text, "%s+", " ")
				return string.lower(text)
			end

			local function getElementValues(elementFrame)
				local values = {}

				local function addText(text)
					if text and text ~= "" then
						table.insert(values, tostring(text))
					end
				end

				local function findTextInDescendants(obj)
					if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
						addText(obj.Text)
					end
					for _, child in pairs(obj:GetChildren()) do
						findTextInDescendants(child)
					end
				end

				findTextInDescendants(elementFrame)

				return values
			end

			local function checkMatch(text, query)
				if query == "" then
					return true
				end

				local normalizedText = normalizeText(text)
				if normalizedText == "" then
					return false
				end

				local queryLower = normalizeText(query)
				if queryLower == "" then
					return true
				end

				if string.find(queryLower, "%s", 1) then
					local words = {}
					for word in string.gmatch(queryLower, "%S+") do
						if #word > 0 then
							table.insert(words, word)
						end
					end

					if #words == 0 then
						return true
					end

					for _, word in ipairs(words) do
						if not string.find(normalizedText, word, 1, true) then
							return false
						end
					end
					return true
				else
					return string.find(normalizedText, queryLower, 1, true) ~= nil
				end
			end

			local normalizedQuery = normalizeText(searchTerm)

			local matchedSectionFrames = {}
			local elementsInMatchedSections = {}

			for element, data in pairs(AllElements) do
				if element and element.Parent then
					if data.type == "Section" then
						local title = tostring(data.title or "")
						if normalizedQuery ~= "" and checkMatch(title, normalizedQuery) then
							matchedSectionFrames[element] = true
							if element:FindFirstChild("Container") then
								local container = element:FindFirstChild("Container")
								for _, child in pairs(container:GetChildren()) do
									if not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
										elementsInMatchedSections[child] = true
									end
								end
							end
						end
					end
				end
			end

			for element, data in pairs(AllElements) do
				if element and element.Parent then
					if normalizedQuery == "" then
						element.Visible = true
					else
						local title = tostring(data.title or "")
						local desc = tostring(data.description or "")
						local matchesTitle = checkMatch(title, normalizedQuery)
						local matchesDesc = checkMatch(desc, normalizedQuery)
						local matchesValues = false

						local elementValues = getElementValues(element)
						for _, value in ipairs(elementValues) do
							if checkMatch(value, normalizedQuery) then
								matchesValues = true
								break
							end
						end

						local matchesSection = elementsInMatchedSections[element] == true

						if not matchesSection and data.section then
							for sectionFrame, _ in pairs(matchedSectionFrames) do
								if data.section == sectionFrame then
									matchesSection = true
									break
								end
							end
						end

						element.Visible = matchesTitle or matchesDesc or matchesValues or matchesSection
					end
				end
			end

			local searchTermForClosure = searchTerm
			task.spawn(function()
				task.wait(0.05)

				if not Window or not Window.ContainerHolder then return end

				local firstMatchTabIdx = nil

				for _, tabContainer in pairs(Window.ContainerHolder:GetChildren()) do
					if tabContainer:IsA("Frame") then
						local tabIdx = nil
						if Window._TabModule then
							for idx, container in pairs(Window._TabModule.Containers) do
								if container == tabContainer then
									tabIdx = idx
									break
								end
							end
						end

						local scrollFrame = tabContainer:FindFirstChildOfClass("ScrollingFrame")
						if scrollFrame then
							local containerLayout = scrollFrame:FindFirstChild("UIListLayout")
							if containerLayout then
								local containerPadding = scrollFrame:FindFirstChild("UIPadding")
								local paddingTop = containerPadding and containerPadding.PaddingTop.Offset or 1
								local paddingBottom = containerPadding and containerPadding.PaddingBottom.Offset or 1
								local contentSize = containerLayout.AbsoluteContentSize.Y + paddingTop + paddingBottom
								scrollFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(0, contentSize))
							end

							for _, section in pairs(scrollFrame:GetChildren()) do
								if section:IsA("Frame") and section.Name ~= "UIPadding" then
									local sectionContainer = section:FindFirstChild("Container")

									if sectionContainer and sectionContainer:IsA("Frame") then
										local containerLayout = sectionContainer:FindFirstChild("UIListLayout")
										if containerLayout then
											local hasVisibleChild = false
											for _, element in pairs(sectionContainer:GetChildren()) do
												if not element:IsA("UIListLayout") and element.Visible then
													hasVisibleChild = true
													break
												end
											end

											if searchTermForClosure == "" or hasVisibleChild then
												section.Visible = true
												if firstMatchTabIdx == nil and searchTermForClosure ~= "" and tabIdx then
													firstMatchTabIdx = tabIdx
												end
												local containerPadding = sectionContainer:FindFirstChild("UIPadding")
												local containerPaddingTop = containerPadding and containerPadding.PaddingTop.Offset or 0
												local containerPaddingBottom = containerPadding and containerPadding.PaddingBottom.Offset or 0
												local containerContentSize = containerLayout.AbsoluteContentSize.Y + containerPaddingTop + containerPaddingBottom
												sectionContainer.Size = UDim2.new(1, 0, 0, math.max(0, containerContentSize))
											else
												section.Visible = false
												sectionContainer.Size = UDim2.new(1, 0, 0, 0)
											end
										end
									end

									local sectionLayout = section:FindFirstChild("UIListLayout")
									if sectionLayout then
										local sectionPadding = section:FindFirstChild("UIPadding")
										local sectionPaddingTop = sectionPadding and sectionPadding.PaddingTop.Offset or 0
										local sectionPaddingBottom = sectionPadding and sectionPadding.PaddingBottom.Offset or 0
										local sectionContentSize = sectionLayout.AbsoluteContentSize.Y + sectionPaddingTop + sectionPaddingBottom
										section.Size = UDim2.new(1, 0, 0, math.max(0, sectionContentSize + 25))
									end
								end
							end
						end
					end
				end

				if searchTermForClosure ~= "" and firstMatchTabIdx and Window._TabModule then
					if Window._TabModule.SelectedTab ~= firstMatchTabIdx then
						Window._TabModule:SelectTab(firstMatchTabIdx)
					end
				end
			end)
		end

		local function RegisterElement(elementFrame, title, elementType, description)
			if elementFrame then
				local sectionFrame = nil
				local parent = elementFrame.Parent

				while parent do
					if parent:FindFirstChild("Container") then
						local sectionRoot = parent
						local sectionContainer = parent:FindFirstChild("Container")
						if sectionContainer and elementFrame.Parent == sectionContainer then
							sectionFrame = sectionRoot
							break
						end
					end
					parent = parent.Parent
				end

				AllElements[elementFrame] = {
					title = tostring(title or ""),
					type = elementType or "Element",
					description = tostring(description or ""),
					section = sectionFrame
				}
			end
		end

		Window.ShowSearch = (Config.Search == nil) and true or (Config.Search and true or false)

		local ImageAsset = Config.Image
		local hasImage = ImageAsset and type(ImageAsset) == "string" and ImageAsset ~= ""
		local imageSize = Window.TabWidth - 24
		local topOffset = 0

		local ImageFrame = hasImage and New("ImageLabel", {
			Size = UDim2.new(0, imageSize, 0, imageSize),
			Position = UDim2.new(0.5, 0, 0, topOffset),
			AnchorPoint = Vector2.new(0.5, 0),
			BackgroundTransparency = 1,
			Image = ImageAsset,
			ZIndex = 5,
			Visible = true,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 6),
			}),
		}) or nil

		Window.HasImage = hasImage
		Window.ImageFrame = ImageFrame
		Window.ImageSize = imageSize
		Window.TopOffset = topOffset

		local searchOffset = hasImage and (imageSize + 10 + topOffset) or topOffset
		local searchHeight = 28

		local tabHolderTop
		if hasImage then
			if Window.ShowSearch then
				tabHolderTop = imageSize + 10 + topOffset + searchHeight + 6
			else
				tabHolderTop = imageSize + 10 + topOffset
			end
		else
			if Window.ShowSearch then
				tabHolderTop = topOffset + searchHeight + 6
			else
				tabHolderTop = 10
			end
		end
		Window.TabHolderTop = tabHolderTop

		Window.TabHolder = New("ScrollingFrame", {
			Size = UDim2.new(1, 0, 1, -(tabHolderTop + 6)),
			Position = UDim2.new(0, 0, 0, tabHolderTop),
			BackgroundTransparency = 1,
			ScrollBarImageTransparency = 1,
			ScrollBarThickness = 0,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			New("UIListLayout", {
				Padding = UDim.new(0, 4),
			}),
		})

		local SearchFrame = New("Frame", {
			Size = UDim2.new(1, 0, 0, 28),
			Position = UDim2.new(0, 0, 0, searchOffset),
			BackgroundTransparency = 0.7,
			ZIndex = 10,
			Visible = Window.ShowSearch,
			BackgroundColor3 = Color3.fromRGB(20, 20, 20),
			ThemeTag = {
				BackgroundColor3 = "Element",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		local SearchInput = New("TextBox", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			TextColor3 = Color3.fromRGB(200, 200, 200),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -36, 1, 0),
			Position = UDim2.new(0, 8, 0, 0),
			PlaceholderText = "Search...",
			PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
			ClearTextOnFocus = false,
			Text = "",
			Parent = SearchFrame,
			ThemeTag = {
				TextColor3 = "Text",
				PlaceholderColor3 = "SubText",
			},
		})

		local SearchIcon = New("ImageLabel", {
			Size = UDim2.fromOffset(16, 16),
			Position = UDim2.new(1, -13, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = "rbxassetid://10734943674",
			Parent = SearchFrame,
			ImageTransparency = 0.3,
			ThemeTag = {
				ImageColor3 = "SubText",
			},
		})

		local SearchTextbox = {
			Input = SearchInput,
			Frame = SearchFrame,
		}

		Creator.AddSignal(SearchTextbox.Input:GetPropertyChangedSignal("Text"), function()
			local searchText = SearchTextbox.Input.Text or ""
			UpdateElementVisibility(searchText)
		end)

		Creator.AddSignal(SearchTextbox.Input.FocusLost, function(enterPressed)
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(input, gameProcessed)
			if gameProcessed then return end
			if input.KeyCode == Enum.KeyCode.Escape and SearchTextbox.Input:IsFocused() then
				SearchTextbox.Input.Text = ""
				SearchTextbox.Input:ReleaseFocus()
			end
		end)

		Window.SearchElements = SearchElements
		Window.AllElements = AllElements
		Window.RegisterElement = RegisterElement
		Window.UpdateElementVisibility = UpdateElementVisibility

		local imageSize = Window.TabWidth - 24
		local topOffset = Window.TopOffset or 25
		local imageOffset = hasImage and (imageSize + 10 + topOffset) or topOffset
		local searchHeight = 28
		local totalOffset = (Window.ShowSearch and searchHeight or 0) + imageOffset

		local TabFrame = New("Frame", {
			Size = UDim2.new(0, Window.TabWidth, 1, -(TITLEBAR_HEIGHT + 21)),
			Position = UDim2.new(0, 12, 0, TITLEBAR_HEIGHT + 12),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		}, {
			ImageFrame,
			SearchFrame,
			Window.TabHolder,
		})

		Selector.Parent = Window.TabHolder
		Window.Selector = Selector

		Window.TabFrame = TabFrame

		Window.TabDisplay = New("TextLabel", {
			RichText = true,
			Text = "Tab",
			TextTransparency = 0,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
			TextSize = 22,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			Size = UDim2.new(1, -16, 0, 28),
			Position = UDim2.fromOffset(Window.TabWidth + 26, TITLEBAR_HEIGHT + 14),
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		Window.ContainerHolder = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		})

		Window.ContainerAnim = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
		})

		Window.ContainerCanvas = New("Frame", {
			Size = UDim2.new(1, -Window.TabWidth - 32, 1, -(TITLEBAR_HEIGHT + 60)),
			Position = UDim2.fromOffset(Window.TabWidth + 26, TITLEBAR_HEIGHT + 48),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		}, {
			Window.ContainerAnim,
			Window.ContainerHolder
		})

		local backgroundTransparency = Config.BackgroundTransparency
		if backgroundTransparency == nil then
			backgroundTransparency = 0.5
		end
		Window.BackgroundTransparency = backgroundTransparency

		local backgroundImageTransparency = Config.BackgroundImageTransparency
		if backgroundImageTransparency == nil then
			backgroundImageTransparency = backgroundTransparency
		end
		Window.BackgroundImageTransparency = backgroundImageTransparency

		local rootChildren = {}

		if Config.BackgroundImage then
			local BackgroundImageFrame = New("ImageLabel", {
				Name = "BackgroundImage",
				Size = UDim2.fromScale(1, 1),
				Position = UDim2.fromOffset(0, 0),
				BackgroundTransparency = 1,
				Image = Config.BackgroundImage,
				ImageTransparency = math.max(0, math.min(1, backgroundImageTransparency)),
				ZIndex = 0,
				ScaleType = Enum.ScaleType.Stretch,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, WINDOW_CORNER),
				}),
			})
			Window.BackgroundImage = BackgroundImageFrame
			table.insert(rootChildren, BackgroundImageFrame)

			if Window.AcrylicPaint and Window.AcrylicPaint.Frame then
				if backgroundImageTransparency <= 0.1 then
					Window.AcrylicPaint.Frame.BackgroundTransparency = 1
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 1
					end
					local function makeTransparent(obj)
						if obj:IsA("Frame") then
							obj.BackgroundTransparency = 1
						elseif obj:IsA("ImageLabel") then
							obj.ImageTransparency = 1
						end
						for _, child in ipairs(obj:GetChildren()) do
							if not child:IsA("UICorner") and not child:IsA("UIGradient") and not child:IsA("UIStroke") and not child:IsA("UIListLayout") and not child:IsA("UIPadding") then
								makeTransparent(child)
							end
						end
					end
					makeTransparent(Window.AcrylicPaint.Frame)
				elseif backgroundImageTransparency < 0.3 then
					Window.AcrylicPaint.Frame.BackgroundTransparency = 0.99
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 0.99
					end
				else
					Window.AcrylicPaint.Frame.BackgroundTransparency = 0.98
					if Window.AcrylicPaint.Model then
						Window.AcrylicPaint.Model.Transparency = 0.98
					end
				end
			end
		end

		-- Everything below the top bar lives in a clipped Body frame. Shrinking the
		-- window down to the bar then rolls the content up instead of overflowing.
		-- Root itself must NOT clip: the resize grip and the acrylic border hang
		-- outside its rectangle on purpose.
		Window.Body = New("Frame", {
			Name = "Body",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ClipsDescendants = true,
		}, {
			Window.TabDisplay,
			Window.ContainerCanvas,
			TabFrame,
		})

		table.insert(rootChildren, Window.AcrylicPaint.Frame)
		table.insert(rootChildren, Window.Body)
		table.insert(rootChildren, ResizeStartFrame)

		Window.Root = New("Frame", {
			BackgroundTransparency = 1,
			Size = Window.Size,
			Position = Window.Position,
			Parent = Config.Parent,
		}, rootChildren)

		CenterWindow()
		Creator.AddSignal(Camera:GetPropertyChangedSignal("ViewportSize"), function()
			CenterWindow()
		end)

		Window.Title = Config.Title
		Window.DisplayTitle = Config.Title
		Window.SubTitle = Config.SubTitle
		Window.Icon = Config.Icon

		Window.TitleBar = Components.TitleBar({
			Title = Config.Title,
			SubTitle = Config.SubTitle,
			Icon = Config.Icon,
			IconCorner = Config.IconCorner,
			Parent = Window.Root,
			Window = Window,
			UserInfoTitle = Config.UserInfoTitle,
			UserInfo = Config.UserInfo,
			UserInfoSubtitle = Config.UserInfoSubtitle,
			UserInfoSubtitleColor = Config.UserInfoSubtitleColor,
		})

		if Config.UserInfo then
			local function parseColor(value)
				if typeof(value) == "Color3" then return value end
				return Themes[Library.Theme].SubText or Color3.fromRGB(170,170,170)
			end

			local userInfoHeight = 56
			Window.UserInfoHeight = userInfoHeight
			Window.UserInfoTop = Config.UserInfoTop
			local UserInfoSection
			UserInfoSection = New("Frame", {
				Name = "UserInfoSection",
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, userInfoHeight),
				Position = Config.UserInfoTop and UDim2.fromOffset(0, 0) or UDim2.new(0, 0, 1, -(userInfoHeight + 2)),
				ZIndex = 15,
				Parent = TabFrame,
			})
			Window.UserInfoSection = UserInfoSection

			Window.UserInfoSeparator = New("Frame", {
				Name = "UserInfoSeparator",
				BackgroundTransparency = 0.5,
				Size = UDim2.new(1, 0, 0, 1),
				Position = Config.UserInfoTop and UDim2.fromOffset(0, userInfoHeight + 4) or UDim2.new(0, 0, 1, -(userInfoHeight + 4)),
				ZIndex = 15,
				Parent = TabFrame,
				ThemeTag = {
					BackgroundColor3 = "TitleBarLine",
				},
			})

			local avatarSize = 28
			local Avatar = New("ImageLabel", {
				Name = "Avatar",
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(avatarSize, avatarSize),
				Position = UDim2.new(0, 0, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Image = "",
				Parent = UserInfoSection,
			}, {
				New("UICorner", { CornerRadius = UDim.new(1, 0) }),
				New("UIStroke", { Transparency = 0.7, Thickness = 1, ThemeTag = { Color = "ElementBorder" } }),
			})

			pcall(function()
				local Players = game:GetService("Players")
				local content, isReady = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
				if isReady and content then
					Avatar.Image = content
				end
			end)

			local titleText = tostring((Config.UserInfoTitle ~= nil and Config.UserInfoTitle) or (LocalPlayer.Name or "User"))
			local subtitleText = (Config.UserInfoSubtitle ~= nil) and tostring(Config.UserInfoSubtitle) or ""

			New("TextLabel", {
				Name = "UserName",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Bottom,
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
				TextSize = 13,
				Text = titleText,
				Size = UDim2.new(1, -avatarSize - 12, 0.5, 0),
				Position = UDim2.new(0, avatarSize + 12, 0, -2),
				Parent = UserInfoSection,
				ThemeTag = { TextColor3 = "Text" },
			})

			New("TextLabel", {
				Name = "UserSubtitle",
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
				TextSize = 12,
				TextTransparency = 0.2,
				Text = subtitleText,
				TextColor3 = parseColor(Config.UserInfoSubtitleColor),
				Size = UDim2.new(1, -avatarSize - 12, 0.5, 0),
				Position = UDim2.new(0, avatarSize + 12, 0.5, 2),
				Parent = UserInfoSection,
			})

			if Config.UserInfoTop then
				local topOffset = Window.TopOffset or 0
				local imageOffset = hasImage and (imageSize + 10 + topOffset) or topOffset
				TabFrame.Position = UDim2.new(0, 12, 0, TITLEBAR_HEIGHT - 3)
				TabFrame.Size = UDim2.new(0, Window.TabWidth, 1, -(TITLEBAR_HEIGHT + 6))
				local searchOffset = hasImage and (imageSize + 10 + topOffset) or topOffset
				SearchFrame.Position = UDim2.new(0, 0, 0, userInfoHeight + 6 + searchOffset)
				if ImageFrame then
					ImageFrame.Position = UDim2.new(0.5, 0, 0, userInfoHeight + 6 + topOffset)
				end
				local newTabHolderTop = userInfoHeight + 6 + (hasImage and (imageSize + 10 + topOffset) or topOffset) + (Window.ShowSearch and (searchHeight + 6) or 0)
				Window.TabHolderTop = newTabHolderTop
				Window.TabHolder.Position = UDim2.new(0, 0, 0, newTabHolderTop)
				Window.TabHolder.Size = UDim2.new(1, 0, 1, -(newTabHolderTop + 6))
				if Window.UpdateTabHolderLayout then
					Window:UpdateTabHolderLayout(newTabHolderTop)
				end
			else
				Window.TabHolder.Size = UDim2.new(1, 0, 1, -(tabHolderTop + 6 + userInfoHeight))
				if Window.UpdateTabHolderLayout then
					Window:UpdateTabHolderLayout(tabHolderTop)
				end
			end
		end

		if Library.UseAcrylic then
			Window.AcrylicPaint.AddParent(Window.Root)
		end

		local SizeMotor = Flipper.GroupMotor.new({
			X = Window.Size.X.Offset,
			Y = Window.Size.Y.Offset,
		})

		local PosMotor = Flipper.GroupMotor.new({
			X = Window.Position.X.Offset,
			Y = Window.Position.Y.Offset,
		})

		Window.SizeMotor = SizeMotor
		Window.PosMotor = PosMotor

		Window.SelectorPosMotor = Flipper.SingleMotor.new(0)
		Window.SelectorSizeMotor = Flipper.SingleMotor.new(0)
		Window.ContainerBackMotor = Flipper.SingleMotor.new(0)
		Window.ContainerPosMotor = Flipper.SingleMotor.new(94)
		Window.ContainerXMotor = Flipper.SingleMotor.new(0)

		SizeMotor:onStep(function(values)
			Window.Root.Size = UDim2.new(0, values.X, 0, values.Y)
			task.spawn(function()
				task.wait(0.01)
				if Window.UpdateTabHolderLayout then
					Window:UpdateTabHolderLayout()
				end
			end)
		end)

		PosMotor:onStep(function(values)
			Window.Root.Position = UDim2.new(0, values.X, 0, values.Y)
		end)

		local LastValue = 0
		local LastTime = 0
		Window.SelectorPosMotor:onStep(function(Value)
			Selector.Visible = true
		end)

		Window.SelectorSizeMotor:onStep(function(Value)
			Selector.Size = UDim2.new(0, 4, 0, Value)
		end)

		Window.ContainerBackMotor:onStep(function(Value)
		end)

		local ContainerXValue = 0
		local ContainerYValue = 94

		local function UpdateContainerPosition()
			if Window.ContainerAnim then
				Window.ContainerAnim.Position = UDim2.fromOffset(ContainerXValue, ContainerYValue)
			end
		end

		Window.ContainerPosMotor:onStep(function(Value)
			ContainerYValue = Value
			UpdateContainerPosition()
		end)

		Window.ContainerXMotor:onStep(function(Value)
			ContainerXValue = Value
			UpdateContainerPosition()
		end)

		local OldSizeX
		local OldSizeY
		local OldPosX
		local OldPosY
		local EntranceCancelled = false

		Window.Corners = {}
		if Window.AcrylicPaint and Window.AcrylicPaint.Frame then
			for _, v in ipairs(Window.AcrylicPaint.Frame:GetDescendants()) do
				if v:IsA("UICorner") then
					table.insert(Window.Corners, v)
				end
			end
		end
		if Window.BackgroundImage then
			local c = Window.BackgroundImage:FindFirstChildOfClass("UICorner")
			if c then
				table.insert(Window.Corners, c)
			end
		end

		Window.SetCornerRadius = function(Radius, Animate)
			Window.CornerRadius = Radius
			for _, corner in ipairs(Window.Corners) do
				if Animate then
					TweenService:Create(corner, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
						CornerRadius = UDim.new(0, Radius),
					}):Play()
				else
					corner.CornerRadius = UDim.new(0, Radius)
				end
			end
		end

		Window.Maximize = function(Value, NoPos, Instant)
			Value = Value and true or false

			-- maximizing out of a rolled-up window has to un-roll it first
			if Window.Collapsed then
				Window.Collapsed = false
				ResizeStartFrame.Visible = true
				if Window.Body then
					Window.Body.Visible = true
				end
				if ImageFrame then
					ImageFrame.Visible = true
				end
				if Window.UserInfoSection then
					Window.UserInfoSection.Visible = true
				end
				if Window.UserInfoSeparator then
					Window.UserInfoSeparator.Visible = true
				end
				if Window.TitleBar and Window.TitleBar.SetCollapsed then
					Window.TitleBar.SetCollapsed(false)
				end
			end

			EntranceCancelled = true
			Window.Maximized = Value
			if Window.TitleBar and Window.TitleBar.SetMaximized then
				Window.TitleBar.SetMaximized(Value)
			end

			if Value then
				OldSizeX = Window.Size.X.Offset
				OldSizeY = Window.Size.Y.Offset
				OldPosX = Window.Position.X.Offset
				OldPosY = Window.Position.Y.Offset
			end

			local SizeX = Value and Camera.ViewportSize.X or (OldSizeX or Window.Size.X.Offset)
			local SizeY = Value and Camera.ViewportSize.Y or (OldSizeY or Window.Size.Y.Offset)

			SizeMotor:setGoal({
				X = Flipper[Instant and "Instant" or "Spring"].new(SizeX, { frequency = 6 }),
				Y = Flipper[Instant and "Instant" or "Spring"].new(SizeY, { frequency = 6 }),
			})
			Window.Size = UDim2.fromOffset(SizeX, SizeY)
			Window.SetCornerRadius(Value and 0 or WINDOW_CORNER, not Instant)

			if not NoPos then
				local PosX = Value and 0 or (OldPosX or Window.Position.X.Offset)
				local PosY = Value and 0 or (OldPosY or Window.Position.Y.Offset)
				PosMotor:setGoal({
					X = Flipper[Instant and "Instant" or "Spring"].new(PosX, { frequency = 6 }),
					Y = Flipper[Instant and "Instant" or "Spring"].new(PosY, { frequency = 6 }),
				})
				if not Value then
					Window.Position = UDim2.fromOffset(PosX, PosY)
				end
			end
		end

		----------------------------------------------------------------
		--  Collapse: roll the window up into its own top bar.
		--  This is what the top bar's minimize button does, so no floating
		--  button is needed to bring the interface back.
		----------------------------------------------------------------
		Window.Collapsed = false
		local CollapseToken = 0

		Window.Collapse = function(Value, NoAnim)
			Value = Value and true or false
			if Window.Collapsed == Value then
				return
			end
			if Value and Window.Maximized then
				Window.Maximize(false, false, false)
			end

			EntranceCancelled = true
			Window.Collapsed = Value
			CollapseToken = CollapseToken + 1
			local Token = CollapseToken

			for _, Option in next, Library.Options do
				if Option and Option.Type == "Dropdown" and Option.Opened then
					pcall(function()
						Option:Close()
					end)
				end
			end

			ResizeStartFrame.Visible = not Value
			if ImageFrame then
				ImageFrame.Visible = not Value
			end
			if Window.UserInfoSection then
				Window.UserInfoSection.Visible = not Value
			end
			if Window.UserInfoSeparator then
				Window.UserInfoSeparator.Visible = not Value
			end
			if Window.TitleBar and Window.TitleBar.SetCollapsed then
				Window.TitleBar.SetCollapsed(Value)
			end
			if not Value and Window.Body then
				Window.Body.Visible = true
			end

			-- NOTE: never write Window.Size here, Maximize snapshots its restore
			-- size from it and would otherwise restore to the collapsed height.
			local TargetY = Value and (TITLEBAR_HEIGHT + 2) or Window.Size.Y.Offset
			SizeMotor:setGoal({
				X = Flipper[NoAnim and "Instant" or "Spring"].new(Window.Size.X.Offset, { frequency = 6 }),
				Y = Flipper[NoAnim and "Instant" or "Spring"].new(TargetY, { frequency = 5, dampingRatio = 1 }),
			})

			if Value and Window.Body then
				task.delay(NoAnim and 0 or 0.6, function()
					if Token == CollapseToken and Window.Collapsed then
						Window.Body.Visible = false
					end
				end)
			end
		end

		Window.ToggleCollapse = function()
			Window.Collapse(not Window.Collapsed)
		end

		function Window:SetCollapsed(Value)
			Window.Collapse(Value)
		end

		function Window:SetTitle(Text)
			Window.DisplayTitle = Text
			if Window.TitleBar and Window.TitleBar.SetTitle then
				Window.TitleBar.SetTitle(Text)
			end
		end

		function Window:SetSubTitle(Text)
			Window.SubTitle = Text
			if Window.TitleBar and Window.TitleBar.SetSubTitle then
				Window.TitleBar.SetSubTitle(Text)
			end
		end

		function Window:SetIcon(Value)
			Window.Icon = Value
			if Window.TitleBar and Window.TitleBar.SetIcon then
				Window.TitleBar.SetIcon(Value)
			end
		end

		----------------------------------------------------------------
		--  Drag by the top bar (Frame.Draggable dragged from anywhere and
		--  never wrote the new position back into Window.Position)
		----------------------------------------------------------------
		local Dragging, DragStart, DragOrigin = false, nil, nil
		local LastBarPress = 0
		local DragHandle = Window.TitleBar.Bar or Window.TitleBar.Frame

		Creator.AddSignal(DragHandle.InputBegan, function(Input)
			if
				Input.UserInputType ~= Enum.UserInputType.MouseButton1
				and Input.UserInputType ~= Enum.UserInputType.Touch
			then
				return
			end

			-- GUI input bubbles from the window buttons up to the bar. The button
			-- stamps ButtonPress first (same frame), so ignore that press here,
			-- otherwise clicking minimize would also arm the drag and count
			-- towards the double-click-to-maximize.
			local TB = Window.TitleBar
			if TB.ButtonPress and (os.clock() - TB.ButtonPress) < 0.05 then
				LastBarPress = 0
				return
			end
			-- touch never produces a hover, so only trust the counter for mouse input
			if
				Input.UserInputType ~= Enum.UserInputType.Touch
				and TB.IsButtonHovered
				and TB.IsButtonHovered()
			then
				LastBarPress = 0
				return
			end

			local Now = os.clock()
			if Now - LastBarPress < 0.3 then
				LastBarPress = 0
				Dragging = false
				Window.Maximize(not Window.Maximized)
				return
			end
			LastBarPress = Now

			if Window.Maximized then
				return
			end

			-- cancel any position spring still running, or it would fight the drag
			EntranceCancelled = true
			PosMotor:setGoal({
				X = Flipper.Instant.new(Window.Root.Position.X.Offset),
				Y = Flipper.Instant.new(Window.Root.Position.Y.Offset),
			})

			Dragging = true
			DragStart = Input.Position
			DragOrigin = Window.Root.Position
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if not Dragging then
				return
			end
			if
				Input.UserInputType ~= Enum.UserInputType.MouseMovement
				and Input.UserInputType ~= Enum.UserInputType.Touch
			then
				return
			end
			local Delta = Input.Position - DragStart
			local Viewport = Camera.ViewportSize
			local Width = Window.Root.AbsoluteSize.X
			local NewX = math.clamp(DragOrigin.X.Offset + Delta.X, -Width + 120, math.max(0, Viewport.X - 120))
			local NewY = math.clamp(DragOrigin.Y.Offset + Delta.Y, 0, math.max(0, Viewport.Y - TITLEBAR_HEIGHT))
			Window.Root.Position = UDim2.fromOffset(NewX, NewY)
		end)

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if not Dragging then
				return
			end
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Dragging = false
				Window.Position = Window.Root.Position
				PosMotor:setGoal({
					X = Flipper.Instant.new(Window.Root.Position.X.Offset),
					Y = Flipper.Instant.new(Window.Root.Position.Y.Offset),
				})
			end
		end)

		----------------------------------------------------------------
		--  Entrance animation: spring up from 94% around the centre
		----------------------------------------------------------------
		do
			local TargetW = Window.Size.X.Offset
			local TargetH = Window.Size.Y.Offset
			local StartW = math.floor(TargetW * 0.94)
			local StartH = math.floor(TargetH * 0.94)
			local StartX = Window.Position.X.Offset + math.floor((TargetW - StartW) / 2)
			local StartY = Window.Position.Y.Offset + math.floor((TargetH - StartH) / 2)

			Window.Root.Size = UDim2.fromOffset(StartW, StartH)
			Window.Root.Position = UDim2.fromOffset(StartX, StartY)
			SizeMotor:setGoal({ X = Flipper.Instant.new(StartW), Y = Flipper.Instant.new(StartH) })
			PosMotor:setGoal({ X = Flipper.Instant.new(StartX), Y = Flipper.Instant.new(StartY) })
			-- The motors were built holding the FINAL values, and setGoal alone does not
			-- move their internal state. Step them once so the Instant goals actually land,
			-- otherwise the spring below starts from the target and nothing animates.
			SizeMotor:step(0)
			PosMotor:step(0)

			task.defer(function()
				-- the hub may have collapsed / maximized in the meantime
				if EntranceCancelled or Window.Collapsed or Window.Maximized then
					return
				end
				SizeMotor:setGoal({
					X = Spring(TargetW, { frequency = 4.5, dampingRatio = 0.85 }),
					Y = Spring(TargetH, { frequency = 4.5, dampingRatio = 0.85 }),
				})
				PosMotor:setGoal({
					X = Spring(Window.Position.X.Offset, { frequency = 4.5, dampingRatio = 0.85 }),
					Y = Spring(Window.Position.Y.Offset, { frequency = 4.5, dampingRatio = 0.85 }),
				})
			end)
		end

		Window.Root.Active = true
		Window.Root.Draggable = false -- replaced by the top bar drag handle

		Creator.AddSignal(ResizeStartFrame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Resizing = true
				ResizePos = Input.Position
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if
				(Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch)
				and Resizing
			then
				local Delta = Input.Position - ResizePos
				local StartSize = Window.Size

				local TargetSize = Vector3.new(StartSize.X.Offset, StartSize.Y.Offset, 0) + Vector3.new(1, 1, 0) * Delta
				local TargetSizeClamped =
					Vector2.new(math.clamp(TargetSize.X, 470, 2048), math.clamp(TargetSize.Y, TITLEBAR_HEIGHT + 338, 2048))

				SizeMotor:setGoal({
					X = Flipper.Instant.new(TargetSizeClamped.X),
					Y = Flipper.Instant.new(TargetSizeClamped.Y),
				})
			end
		end)

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			-- Only the press that started the drag ends it. Without the type filter any
			-- key release (walking with WASD during a resize) committed a half-dragged size.
			if
				Resizing == true
				and (
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				)
			then
				Resizing = false
				if not Window.Collapsed then
					Window.Size = UDim2.fromOffset(SizeMotor:getValue().X, SizeMotor:getValue().Y)
				end
			end
		end)

		Creator.AddSignal(Window.TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			if Window.TabHolder and Window.TabHolder.UIListLayout then
				local padding = Window.TabHolder:FindFirstChild("UIPadding")
				local paddingTop = padding and padding.PaddingTop.Offset or 6
				local paddingBottom = padding and padding.PaddingBottom.Offset or 6
				local contentSize = Window.TabHolder.UIListLayout.AbsoluteContentSize.Y + paddingTop + paddingBottom
				if contentSize > 0 then
					Window.TabHolder.CanvasSize = UDim2.new(0, 0, 0, contentSize)
				end
			end
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if
				type(Library.MinimizeKeybind) == "table"
				and Library.MinimizeKeybind.Type == "Keybind"
				and not UserInputService:GetFocusedTextBox()
			then
				if Input.KeyCode.Name == Library.MinimizeKeybind.Value then
					Window:Minimize()
				end
			elseif Input.KeyCode == Library.MinimizeKey and not UserInputService:GetFocusedTextBox() then
				Window:Minimize()
			end
		end)

		-- Rewritten: the original only resized TabFrame and left SearchFrame and
		-- TabHolder where they were, so toggling search desynced the tab column --
		-- and it ignored the UserInfo layouts entirely. These branches mirror the
		-- creation-time formulas exactly.
		function Window:ToggleSearch()
			Window.ShowSearch = not Window.ShowSearch
			SearchFrame.Visible = Window.ShowSearch

			local topOffset = Window.TopOffset or 0
			local searchHeight = 28
			local imageOffset = Window.HasImage and (Window.ImageSize + 10 + topOffset) or topOffset
			local userInfoHeight = Config.UserInfo and (Window.UserInfoHeight or 56) or 0
			local userInfoTop = (Config.UserInfo and Config.UserInfoTop) and (userInfoHeight + 6) or 0

			SearchFrame.Position = UDim2.new(0, 0, 0, userInfoTop + imageOffset)

			if Config.UserInfo and Config.UserInfoTop then
				TabFrame.Position = UDim2.new(0, 12, 0, TITLEBAR_HEIGHT - 3)
				TabFrame.Size = UDim2.new(0, Window.TabWidth, 1, -(TITLEBAR_HEIGHT + 6))
			else
				TabFrame.Position = UDim2.new(0, 12, 0, TITLEBAR_HEIGHT + 12)
				TabFrame.Size = UDim2.new(0, Window.TabWidth, 1, -(TITLEBAR_HEIGHT + 21))
			end

			local newTabHolderTop
			if Config.UserInfo and Config.UserInfoTop then
				newTabHolderTop = userInfoHeight + 6 + imageOffset + (Window.ShowSearch and (searchHeight + 6) or 0)
			elseif Window.HasImage then
				newTabHolderTop = imageOffset + (Window.ShowSearch and (searchHeight + 6) or 0)
			else
				newTabHolderTop = Window.ShowSearch and (topOffset + searchHeight + 6) or 10
			end

			-- with UserInfoTop the user block sits at the TOP, inside newTabHolderTop
			-- already; only the bottom-anchored variant has to reserve room for it
			local bottomReserve = (Config.UserInfo and not Config.UserInfoTop) and userInfoHeight or 0

			Window.TabHolderTop = newTabHolderTop
			Window.TabHolder.Position = UDim2.new(0, 0, 0, newTabHolderTop)
			Window.TabHolder.Size = UDim2.new(1, 0, 1, -(newTabHolderTop + 6 + bottomReserve))

			if Window.UpdateTabHolderLayout then
				Window:UpdateTabHolderLayout()
			end
		end

		function Window:Minimize()
			Window.Minimized = not Window.Minimized
			Window.Root.Visible = not Window.Minimized

			for _, Option in next, Library.Options do
				if Option and Option.Type == "Dropdown" and Option.Opened then
					pcall(function()
						Option:Close()
					end)
				end
			end
			if not MinimizeNotif then
				MinimizeNotif = true
				local Key = Library.MinimizeKeybind and Library.MinimizeKeybind.Value or Library.MinimizeKey.Name
				if not Mobile then Library:Notify({
					Title = "Interface",
					Content = "Press " .. Key .. " to toggle the interface.",
					Duration = 6
					})
				else
					Library:Notify({
						Title = "Interface",
						Content = "Tap to the button to toggle the interface.",
						Duration = 6
					})
				end
			end

			if not RunService:IsStudio() and Library.Minimizer then
				pcall(function()
					local btn = Library.Minimizer:FindFirstChild("TextButton")
						if btn then
							local iconLbl = btn:FindFirstChild("Icon")
							if iconLbl and iconLbl:IsA("TextLabel") then
								iconLbl.Text = Window.Minimized and utf8.char(9633) or utf8.char(8211)
							end
						end
				end)
			end
		end

		function Window:Destroy()
			if Library.UseAcrylic then
				Window.AcrylicPaint.Model:Destroy()
			end
			Window.Root:Destroy()
		end

		function Window:SetBackgroundImage(imageUrl, imageTransparency)
			if not Window.BackgroundImage then
				local imgTransparency = imageTransparency or Window.BackgroundImageTransparency or Window.BackgroundTransparency or 0.5
				local BackgroundImageFrame = New("ImageLabel", {
					Name = "BackgroundImage",
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromOffset(0, 0),
					BackgroundTransparency = 1,
					Image = imageUrl,
					ImageTransparency = math.max(0, math.min(1, imgTransparency)),
					ZIndex = 0,
					ScaleType = Enum.ScaleType.Stretch,
					Parent = Window.Root,
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(0, WINDOW_CORNER),
					}),
				})
				Window.BackgroundImage = BackgroundImageFrame
				if Window.Corners then
					local c = BackgroundImageFrame:FindFirstChildOfClass("UICorner")
					if c then
						table.insert(Window.Corners, c)
						if Window.CornerRadius then
							c.CornerRadius = UDim.new(0, Window.CornerRadius)
						end
					end
				end
				if imageTransparency ~= nil then
					Window.BackgroundImageTransparency = imageTransparency
				end
			else
				Window.BackgroundImage.Image = imageUrl
				Window.BackgroundImage.ScaleType = Enum.ScaleType.Stretch
				if imageTransparency ~= nil then
					Window.BackgroundImageTransparency = imageTransparency
					Window.BackgroundImage.ImageTransparency = math.max(0, math.min(1, imageTransparency))
				end
			end
		end

		local DialogModule = Components.Dialog:Init(Window)
		function Window:Dialog(Config)
			-- the tint and the dialog are sized against Window.Root, so never open one
			-- while the window is rolled up into its bar
			if Window.Collapsed then
				Window.Collapse(false, true)
			end
			local Dialog = DialogModule:Create()
			Dialog.Title.Text = Config.Title

			local ContentHolder = New("ScrollingFrame", {
				BackgroundTransparency = 1,
				ScrollBarImageTransparency = 0.7,
				ScrollBarThickness = 4,
				BottomImage = "",
				MidImage = "",
				TopImage = "",
				Position = UDim2.fromOffset(20, 60),
				Size = UDim2.new(1, -40, 1, -110),
				CanvasSize = UDim2.fromOffset(0, 0),
				AutomaticCanvasSize = Enum.AutomaticSize.Y,
				Parent = Dialog.Root,
			})

			local Content = New("TextLabel", {
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				Text = Config.Content,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextWrapped = true,
				Size = UDim2.new(1, -8, 0, 0),
				BackgroundTransparency = 1,
				Parent = ContentHolder,
				ThemeTag = { TextColor3 = "Text" },
			})

			New("UISizeConstraint", {
				MinSize = Vector2.new(300, 165),
				MaxSize = Vector2.new(620, math.huge),
				Parent = Dialog.Root,
			})

			local maxWidth = math.min(620, Window.Size.X.Offset - 120)
			local baseWidth = math.max(300, math.min(maxWidth, Content.TextBounds.X + 40))
			Dialog.Root.Size = UDim2.fromOffset(baseWidth, 165)
			ContentHolder.Size = UDim2.new(1, -40, 1, -110)
			task.defer(function()
				local contentHeight = Content.TextBounds.Y
				local desired = math.clamp(contentHeight + 110, 165, 420)
				Dialog.Root.Size = UDim2.fromOffset(baseWidth, desired)
				ContentHolder.CanvasSize = UDim2.fromOffset(0, contentHeight)
			end)

			for _, Button in next, Config.Buttons do
				Dialog:Button(Button.Title, Button.Callback)
			end

			Dialog:Open()
		end

		local TabModule = Components.Tab:Init(Window)
		Window._TabModule = TabModule
function Window:AddTab(TabConfig)
			local tab = TabModule:New(TabConfig.Title, TabConfig.Icon, Window.TabHolder)
			if TabModule.TabCount == 1 then
				TabModule:SelectTab(1)
			end
			return tab
		end

		function Window:SelectTab(Tab)
			TabModule:SelectTab(Tab)
		end

		function Window:SetTab(TabNameOrIndex)
			if type(TabNameOrIndex) == "number" then
				TabModule:SelectTab(TabNameOrIndex)
			elseif type(TabNameOrIndex) == "string" then
				for idx, tab in pairs(TabModule.Tabs) do
					if tab.Name == TabNameOrIndex then
						TabModule:SelectTab(idx)
						return
					end
				end
			end
		end

		Creator.AddSignal(Window.TabHolder:GetPropertyChangedSignal("CanvasPosition"), function()
		end)

		return Window
	end
end)()
local ElementsTable = {}
local AddSignal = Creator.AddSignal

ElementsTable.Button = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Button"

	function Element:New(Config)
		Config.Title = Config.Title or "Button"
		Config.Callback = Config.Callback or function() end

		local ButtonFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)

		local ButtonIco = New("ImageLabel", {
			Image = "",
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			BackgroundTransparency = 1,
			Parent = ButtonFrame.Frame,
			ThemeTag = {
				ImageColor3 = "Text",
			},
		})

		Creator.AddSignal(ButtonFrame.Frame.MouseButton1Click, function()
			Library:SafeCallback(Config.Callback)
		end)

		return ButtonFrame
	end

	return Element
end)()
ElementsTable.Toggle = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Toggle"

	function Element:New(Idx, Config)
		Config.Title = Config.Title or "Toggle"

		local Toggle = {
			Value = Config.Default or false,
			Callback = Config.Callback or function(Value) end,
			Type = "Toggle",
		}

		local ToggleFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)
		ToggleFrame.DescLabel.Size = UDim2.new(1, -54, 0, 0)

		Toggle.SetTitle = ToggleFrame.SetTitle
		Toggle.SetDesc = ToggleFrame.SetDesc
		Toggle.Visible = ToggleFrame.Visible
		Toggle.Elements = ToggleFrame

		local ToggleCircle = New("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.fromOffset(14, 14),
			Position = UDim2.new(0, 2, 0.5, 0),
			Image = "http://www.roblox.com/asset/?id=12266946128",
			ImageTransparency = 0.5,
			ThemeTag = {
				ImageColor3 = "ToggleSlider",
			},
		})

		local ToggleBorder = New("UIStroke", {
			Transparency = 0.5,
			ThemeTag = {
				Color = "ToggleSlider",
			},
		})

		local ToggleSlider = New("Frame", {
			Size = UDim2.fromOffset(36, 18),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -10, 0.5, 0),
			Parent = ToggleFrame.Frame,
			BackgroundTransparency = 1,
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 9),
			}),
			ToggleBorder,
			ToggleCircle,
		})

		function Toggle:OnChanged(Func)
			Toggle.Changed = Func
			Func(Toggle.Value)
		end

		function Toggle:SetValue(Value)
			Value = not not Value
			Toggle.Value = Value

			Creator.OverrideTag(ToggleBorder, { Color = Toggle.Value and "Accent" or "ToggleSlider" })
			Creator.OverrideTag(ToggleCircle, { ImageColor3 = Toggle.Value and "ToggleToggled" or "ToggleSlider" })
			TweenService:Create(
				ToggleCircle,
				TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ Position = UDim2.new(0, Toggle.Value and 19 or 2, 0.5, 0) }
			):Play()
			TweenService:Create(
				ToggleSlider,
				TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ BackgroundTransparency = Toggle.Value and 0.45 or 1 }
			):Play()
			ToggleCircle.ImageTransparency = Toggle.Value and 0 or 0.5

			Library:SafeCallback(Toggle.Callback, Toggle.Value)
			Library:SafeCallback(Toggle.Changed, Toggle.Value)
		end

		function Toggle:Destroy()
			ToggleFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ToggleFrame.Frame.MouseButton1Click, function()
			Toggle:SetValue(not Toggle.Value)
		end)

		Toggle:SetValue(Toggle.Value)

		Toggle.TabName = Element.TabName or "Unknown"
		Library.Options[Idx] = Toggle
		return Toggle
	end

	return Element
end)()
ElementsTable.Dropdown = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Dropdown"
	local New = Creator.New

	function Element:New(Idx, Config)

		local windowDropdownsOutside = false
		if Library.Window and Library.Window.DropdownsOutsideWindow ~= nil then
			windowDropdownsOutside = Library.Window.DropdownsOutsideWindow
		elseif Library.Windows and #Library.Windows > 0 then
			for i = #Library.Windows, 1, -1 do
				local window = Library.Windows[i]
				if window and window.DropdownsOutsideWindow ~= nil then
					windowDropdownsOutside = window.DropdownsOutsideWindow
					break
				end
			end
		end

		local Dropdown = {
			Values = Config.Values,
			Value = Config.Default,
			Multi = Config.Multi,
			Buttons = {},
			Opened = false,
			Type = "Dropdown",
			Callback = Config.Callback or function() end,
			Search = (Config.Search == nil) and true or Config.Search,
			KeepSearch = Config.KeepSearch == true,
			OpenToRight = windowDropdownsOutside
		}

		if Dropdown.Multi and Config.AllowNull then
			Dropdown.Value = {}
		end

		local DropdownFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config)
		DropdownFrame.DescLabel.Size = UDim2.new(1, -170, 0, 0)

		Dropdown.SetTitle = DropdownFrame.SetTitle
		Dropdown.SetDesc = DropdownFrame.SetDesc
		Dropdown.Visible = DropdownFrame.Visible
		Dropdown.Elements = DropdownFrame

		local container = self.Container

		local DropdownDisplay = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = "",
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 14,
			AutomaticSize = Enum.AutomaticSize.Y,
			TextYAlignment = Enum.TextYAlignment.Center,
			TextXAlignment = Enum.TextXAlignment.Left,
			Size = UDim2.new(1, -40, 0.5, 0),
			Position = UDim2.new(0, 8, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local DropdownIco = New("TextLabel", {
			Text = utf8.char(9660),
			TextSize = 10,
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Size = UDim2.fromOffset(16, 16),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -6, 0.5, 0),
			BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Center,
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		local DropdownInner = New("TextButton", {
			Size = UDim2.fromOffset(160, 30),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent = DropdownFrame.Frame,
			ThemeTag = {
				BackgroundColor3 = "DropdownFrame",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 5),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			DropdownIco,
			DropdownDisplay,
		})

		local DropdownListLayout = New("UIListLayout", {
			Padding = UDim.new(0, 3),
		})

		local DropdownScrollFrame = New("ScrollingFrame", {
			Size = UDim2.new(1, -5, 1, -10),
			Position = UDim2.fromOffset(5, 5),
			BackgroundTransparency = 1,
			BottomImage = "",
			MidImage = "",
			TopImage = "",
			ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255),
			ScrollBarImageTransparency = 0.75,
			ScrollBarThickness = 5,
			BorderSizePixel = 0,
			CanvasSize = UDim2.fromScale(0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
		}, {
			DropdownListLayout,
		})

		local SearchBar
		local SearchBox
		if Dropdown.Search then
			SearchBar = New("Frame", {
				Size = UDim2.new(1, -10, 0, 28),
				Position = UDim2.fromOffset(5, 5),
				BackgroundTransparency = 0.7,
				BackgroundColor3 = Color3.fromRGB(20, 20, 20),
				ThemeTag = { BackgroundColor3 = "Element" },
				ZIndex = 24,
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, 4) }),
			})

			SearchBox = New("TextBox", {
				FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Center,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -36, 1, 0),
				Position = UDim2.new(0, 8, 0, 0),
				PlaceholderText = "Search...",
				PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
				ClearTextOnFocus = false,
				Text = "",
				Parent = SearchBar,
				ThemeTag = {
					TextColor3 = "Text",
					PlaceholderColor3 = "SubText",
				},
				ZIndex = 24,
			})

			local SearchIcon = New("ImageLabel", {
				Size = UDim2.fromOffset(16, 16),
				Position = UDim2.new(1, -13, 0.5, 0),
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "rbxassetid://10734943674",
				Parent = SearchBar,
				ImageTransparency = 0.3,
				ZIndex = 25,
				ThemeTag = {
					ImageColor3 = "SubText",
				},
			})

			DropdownScrollFrame.Position = UDim2.fromOffset(5, 38)
			DropdownScrollFrame.Size = UDim2.new(1, -5, 1, -43)

			local filterToken = 0
			local function ApplyFilter()
				filterToken = filterToken + 1
				local myToken = filterToken
				task.spawn(function()
					task.wait(0.01)
					if myToken ~= filterToken then return end
					local text = (SearchBox.Text or ""):lower()
					for _, element in next, DropdownScrollFrame:GetChildren() do
						if not element:IsA("UIListLayout") then
							local value = element:FindFirstChild("ButtonLabel") and element.ButtonLabel.Text or ""
							element.Visible = text == "" or value:lower():find(text, 1, true) ~= nil
						end
					end
					task.wait()
					RecalculateCanvasSize()
					task.wait()
					RecalculateListSize()
					task.wait()
					RecalculateListPosition()
				end)
			end

			Creator.AddSignal(SearchBox:GetPropertyChangedSignal("Text"), ApplyFilter)
		end

		local DropdownHolderFrame = New("Frame", {
			Size = UDim2.fromScale(1, 0.6),
			ThemeTag = {
				BackgroundColor3 = "DropdownHolder",
			},
		}, {
			SearchBar,
			DropdownScrollFrame,
			New("UICorner", {
				CornerRadius = UDim.new(0, 7),
			}),
			New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "DropdownBorder",
				},
			}),
			New("ImageLabel", {
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=5554236805",
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(23, 23, 277, 277),
				Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30),
				Position = UDim2.fromOffset(-15, -15),
				ImageColor3 = Color3.fromRGB(0, 0, 0),
				ImageTransparency = 1,
			}),
		})

		local DropdownHolderCanvas = New("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(170, 300),
			Parent = Library.GUI,
			Visible = false,
		}, {
			DropdownHolderFrame,
			New("UISizeConstraint", {
				MinSize = Vector2.new(170, 0),
			}),
		})
		table.insert(Library.OpenFrames, DropdownHolderCanvas)
		Library._OpenDropdowns = Library._OpenDropdowns or {}
		Library._OpenDropdowns[DropdownHolderCanvas] = Dropdown

		local windowRoot = nil
		if Library.Window and Library.Window.Root then
			windowRoot = Library.Window.Root
		elseif Library.Windows and #Library.Windows > 0 then
			for i = #Library.Windows, 1, -1 do
				local window = Library.Windows[i]
				if window and window.Root then
					windowRoot = window.Root
					break
				end
			end
		end

		if not windowRoot and container then
			local parent = container.Parent
			while parent do
				if parent:IsA("Frame") then
					if parent:FindFirstChild("ContainerCanvas") or (parent.Name and parent:FindFirstChild("TitleBar")) then
						windowRoot = parent
						break
					end
				end
				if parent:IsA("ScreenGui") then
					break
				end
				parent = parent.Parent
			end
		end

		local function RecalculateListPosition()
			if not DropdownHolderCanvas or not DropdownInner then return end

			local dropdownX = DropdownInner.AbsolutePosition.X
			local dropdownY = DropdownInner.AbsolutePosition.Y
			local dropdownWidth = DropdownInner.AbsoluteSize.X
			local dropdownHeight = DropdownInner.AbsoluteSize.Y
			local canvasWidth = DropdownHolderCanvas.AbsoluteSize.X
			local canvasHeight = DropdownHolderCanvas.AbsoluteSize.Y
			local viewportHeight = Camera.ViewportSize.Y
			local viewportWidth = Camera.ViewportSize.X

			if not windowRoot then
				if Library.Window and Library.Window.Root then
					windowRoot = Library.Window.Root
				elseif Library.Windows and #Library.Windows > 0 then
					for i = #Library.Windows, 1, -1 do
						local window = Library.Windows[i]
						if window and window.Root then
							windowRoot = window.Root
							break
						end
					end
				end

				if not windowRoot and container then
					local parent = container.Parent
					while parent do
						if parent:IsA("Frame") then
							if parent:FindFirstChild("ContainerCanvas") or (parent.Name and parent:FindFirstChild("TitleBar")) then
								windowRoot = parent
								break
							end
						end
						if parent:IsA("ScreenGui") then
							break
						end
						parent = parent.Parent
					end
				end
			end

			local targetX = dropdownX - 1
			local useFixedY = false

			if windowRoot then
				local windowX = windowRoot.AbsolutePosition.X
				local windowWidth = windowRoot.AbsoluteSize.X
				local windowRight = windowX + windowWidth

				if Dropdown.OpenToRight then
					targetX = windowRight + 5
					if Dropdown.SavedY == nil then
						Dropdown.SavedY = dropdownY
					end
					useFixedY = true
				else
					local canvasRight = dropdownX + canvasWidth - 1
					if canvasRight > windowRight then
						targetX = math.max(windowX + 5, windowRight - canvasWidth - 5)
					end
					Dropdown.SavedY = nil
				end
			else
				local canvasRight = dropdownX + canvasWidth - 1
				if canvasRight > viewportWidth then
					if Dropdown.OpenToRight then
						targetX = viewportWidth + 5
						if Dropdown.SavedY == nil then
							Dropdown.SavedY = dropdownY
						end
						useFixedY = true
					else
						targetX = math.max(5, viewportWidth - canvasWidth - 5)
					end
					Dropdown.SavedY = nil
				end
			end

			local targetY
			if useFixedY and windowRoot then
				local windowY = windowRoot.AbsolutePosition.Y
				local windowHeight = windowRoot.AbsoluteSize.Y
				local windowCenterY = windowY + windowHeight / 2
				targetY = windowCenterY - canvasHeight / 2

				local windowTop = windowY
				local windowBottom = windowY + windowHeight
				local viewportTop = 0
				local viewportBottom = viewportHeight

				if targetY + canvasHeight > viewportBottom then
					targetY = viewportBottom - canvasHeight - 5
				end
				if targetY < viewportTop then
					targetY = viewportTop + 5
				end

				if targetY + canvasHeight > windowBottom then
					targetY = windowBottom - canvasHeight - 5
				end
				if targetY < windowTop then
					targetY = windowTop + 5
				end
			elseif useFixedY and Dropdown.SavedY then
				targetY = Dropdown.SavedY

				local spaceBelow = viewportHeight - (Dropdown.SavedY + dropdownHeight)
				local spaceAbove = Dropdown.SavedY

				if canvasHeight > spaceBelow and canvasHeight <= spaceAbove then
					targetY = Dropdown.SavedY - canvasHeight - 5
				elseif canvasHeight > spaceBelow and canvasHeight > spaceAbove then
					if spaceBelow > spaceAbove then
						targetY = Dropdown.SavedY + dropdownHeight + 5
					else
						targetY = math.max(5, Dropdown.SavedY - canvasHeight - 5)
					end
				else
					targetY = Dropdown.SavedY + dropdownHeight + 5
				end
			else
				local spaceBelow = viewportHeight - (dropdownY + dropdownHeight)
				local spaceAbove = dropdownY

				if canvasHeight <= spaceBelow then
					targetY = dropdownY + dropdownHeight + 5
				elseif canvasHeight <= spaceAbove then
					targetY = dropdownY - canvasHeight - 5
				else
					if spaceBelow > spaceAbove then
						targetY = dropdownY + dropdownHeight + 5
					else
						targetY = math.max(5, dropdownY - canvasHeight - 5)
					end
				end
			end

			DropdownHolderCanvas.Position = UDim2.fromOffset(targetX, targetY)
		end

		local ListSizeX = 0
		local function RecalculateListSize()
			if not DropdownHolderCanvas or not DropdownHolderFrame then return end

			local visibleCount = 0
			for _, element in next, DropdownScrollFrame:GetChildren() do
				if not element:IsA("UIListLayout") and element.Visible then
					visibleCount = visibleCount + 1
				end
			end

			local itemHeight = 32
			local padding = 3
			local searchHeight = Dropdown.Search and 38 or 0
			local innerMargins = 10
			local estimatedContent = (visibleCount > 0) and (visibleCount * itemHeight + (visibleCount - 1) * padding + innerMargins + searchHeight) or (innerMargins + searchHeight)
			local maxHeight = 392
			local targetHeight = math.min(estimatedContent, maxHeight)

			local canvasWidth = math.max(170, ListSizeX > 0 and (ListSizeX + 20) or 170)
			DropdownHolderCanvas.Size = UDim2.fromOffset(canvasWidth, targetHeight)

			local many = visibleCount > 10
			DropdownHolderFrame.Size = UDim2.fromScale(1, many and (targetHeight / math.max(targetHeight, 1)) or 1)
		end

		local function RecalculateCanvasSize()
			DropdownScrollFrame.CanvasSize = UDim2.fromOffset(0, DropdownListLayout.AbsoluteContentSize.Y)
		end

		RecalculateListPosition()
		RecalculateListSize()
		RecalculateCanvasSize()

		if Dropdown.OpenToRight then
			if windowRoot then
				Creator.AddSignal(windowRoot:GetPropertyChangedSignal("AbsolutePosition"), function()
					if Dropdown.Opened then
						Dropdown.SavedY = nil
						RecalculateListPosition()
					end
				end)
				Creator.AddSignal(windowRoot:GetPropertyChangedSignal("AbsoluteSize"), function()
					if Dropdown.Opened then
						RecalculateListPosition()
					end
				end)
			end
		else
			Creator.AddSignal(DropdownInner:GetPropertyChangedSignal("AbsolutePosition"), function()
				if Dropdown.Opened then
					RecalculateListPosition()
				end
			end)
			if windowRoot then
				Creator.AddSignal(windowRoot:GetPropertyChangedSignal("AbsolutePosition"), function()
					if Dropdown.Opened then
						RecalculateListPosition()
					end
				end)
				Creator.AddSignal(windowRoot:GetPropertyChangedSignal("AbsoluteSize"), function()
					if Dropdown.Opened then
						RecalculateListPosition()
					end
				end)
			end
		end
		Creator.AddSignal(DropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			RecalculateCanvasSize()
			task.wait()
			RecalculateListSize()
			task.wait()
		RecalculateListPosition()
		end)

		local _justOpened = false

		Creator.AddSignal(DropdownInner.MouseButton1Click, function()
			if Mobile then return end
			if Dropdown.Opened then
				Dropdown:Close()
			else
				Dropdown:Open()
			end
		end)

		Creator.AddSignal(DropdownInner.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.Touch then
				if Dropdown.Opened then
					Dropdown:Close()
				else
					_justOpened = true
					task.delay(0.3, function() _justOpened = false end)
					Dropdown:Open()
				end
			end
		end)

		Creator.AddSignal(DropdownDisplay:GetPropertyChangedSignal("Text"), function()
			for _, Element in next, DropdownScrollFrame:GetChildren() do
				if not Element:IsA("UIListLayout") then
					Element.Visible = true
				end
			end
			RecalculateListPosition()
			RecalculateListSize()
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if not Dropdown.Opened then return end
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				local mousePos = Input.UserInputType == Enum.UserInputType.MouseButton1 and Vector2.new(Mouse.X, Mouse.Y) or Input.Position
				local AbsPos, AbsSize = DropdownHolderFrame.AbsolutePosition, DropdownHolderFrame.AbsoluteSize
				local innerAbsPos, innerAbsSize = DropdownInner.AbsolutePosition, DropdownInner.AbsoluteSize

				local clickedInsideDropdown = mousePos.X >= AbsPos.X and mousePos.X <= AbsPos.X + AbsSize.X and mousePos.Y >= AbsPos.Y and mousePos.Y <= AbsPos.Y + AbsSize.Y
				local clickedInsideInner = mousePos.X >= innerAbsPos.X and mousePos.X <= innerAbsPos.X + innerAbsSize.X and mousePos.Y >= innerAbsPos.Y and mousePos.Y <= innerAbsPos.Y + innerAbsSize.Y

				if not clickedInsideDropdown and not clickedInsideInner and not _justOpened then
					Dropdown:Close()
				end
			end
		end)

		local ScrollFrame = self.ScrollFrame
		function Dropdown:Open()
			if Dropdown.Opened then
				return
			end
			Dropdown.Opened = true
			_justOpened = true
			task.delay(0.25, function() _justOpened = false end)
			if Dropdown.OpenToRight then
				Dropdown.SavedY = nil
			end
			for _, frame in ipairs(Library.OpenFrames) do
				if frame ~= DropdownHolderCanvas and frame.Visible then
					frame.Visible = false
					local dd = Library._OpenDropdowns and Library._OpenDropdowns[frame]
					if dd then
						dd.Opened = false
					end
				end
			end
			if SearchBox and not Dropdown.KeepSearch then
				SearchBox.Text = ""
			end
			DropdownHolderCanvas.Visible = true
			RecalculateListPosition()
			RecalculateListSize()
			RecalculateCanvasSize()
			TweenService:Create(
				DropdownHolderFrame,
				TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
				{ Size = UDim2.fromScale(1, 1) }
			):Play()
		end

		function Dropdown:Close()
			Dropdown.Opened = false
			if Dropdown.OpenToRight then
				Dropdown.SavedY = nil
			end
			DropdownHolderFrame.Size = UDim2.fromScale(1, 1)
			DropdownHolderCanvas.Visible = false

			Dropdown:Display()
			for _, element in next, DropdownScrollFrame:GetChildren() do
				if not element:IsA("UIListLayout") then
					element.Visible = true
				end
			end
		end

		function Dropdown:Display()
			local Values = Dropdown.Values
			local Str = ""

			if Config.Multi then
				for Idx, Value in next, Values do
					if Dropdown.Value[Value] then
						Str = Str .. Value .. ", "
					end
				end
				Str = Str:sub(1, #Str - 2)
			else
				Str = Dropdown.Value or ""
			end

			DropdownDisplay.Text = (Str == "" and "--" or Str)
		end

		function Dropdown:GetActiveValues()
			if Config.Multi then
				local T = {}

				for Value, Bool in next, Dropdown.Value do
					table.insert(T, Value)
				end

				return T
			else
				return Dropdown.Value and 1 or 0
			end
		end

		function Dropdown:SetActiveValues(Value)
			Dropdown.Value = Value

			Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
			Library:SafeCallback(Dropdown.Changed, Dropdown.Value)

			Dropdown:BuildDropdownList()
		end

		function Dropdown:BuildDropdownList()
			local Values = Dropdown.Values
			local Buttons = {}

			for _, Element in next, DropdownScrollFrame:GetChildren() do
				if not Element:IsA("UIListLayout") then
					Element:Destroy()
				end
			end

			local Count = 0

			for Idx, Value in next, Values do
				local Table = {}

				Count = Count + 1

				local ButtonSelector = New("Frame", {
					Size = UDim2.fromOffset(4, 14),
					BackgroundColor3 = Color3.fromRGB(76, 194, 255),
					Position = UDim2.fromOffset(-1, 16),
					AnchorPoint = Vector2.new(0, 0.5),
					ThemeTag = {
						BackgroundColor3 = "Accent",
					},
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(0, 2),
					}),
				})

				local ButtonLabel = New("TextLabel", {
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
					Text = Value,
					TextColor3 = Color3.fromRGB(200, 200, 200),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromOffset(10, 0),
					Name = "ButtonLabel",
					ThemeTag = {
						TextColor3 = "Text",
					},
				})

				local Button = New("TextButton", {
					Size = UDim2.new(1, -5, 0, 32),
					BackgroundTransparency = 1,
					ZIndex = 23,
					Text = "",
					Parent = DropdownScrollFrame,
					ThemeTag = {
						BackgroundColor3 = "DropdownOption",
					},
				}, {
					ButtonSelector,
					ButtonLabel,
					New("UICorner", {
						CornerRadius = UDim.new(0, 6),
					}),
				})

				local Selected

				if Config.Multi then
					Selected = Dropdown.Value[Value]
				else
					Selected = Dropdown.Value == Value
				end

				local BackMotor, SetBackTransparency = Creator.SpringMotor(1, Button, "BackgroundTransparency")
				local SelMotor, SetSelTransparency = Creator.SpringMotor(1, ButtonSelector, "BackgroundTransparency")
				local SelectorSizeMotor = Flipper.SingleMotor.new(6)

				SelectorSizeMotor:onStep(function(value)
					ButtonSelector.Size = UDim2.new(0, 4, 0, value)
				end)

				Creator.AddSignal(Button.MouseEnter, function()
					SetBackTransparency(Selected and 0.85 or 0.89)
				end)
				Creator.AddSignal(Button.MouseLeave, function()
					SetBackTransparency(Selected and 0.89 or 1)
				end)
				Creator.AddSignal(Button.MouseButton1Down, function()
					SetBackTransparency(0.92)
				end)
				Creator.AddSignal(Button.MouseButton1Up, function()
					SetBackTransparency(Selected and 0.85 or 0.89)
				end)

				function Table:UpdateButton()
					if Config.Multi then
						Selected = Dropdown.Value[Value]
						if Selected then
							SetBackTransparency(0.89)
						end
					else
						Selected = Dropdown.Value == Value
						SetBackTransparency(Selected and 0.89 or 1)
					end

					SelectorSizeMotor:setGoal(Flipper.Spring.new(Selected and 14 or 6, { frequency = 6 }))
					SetSelTransparency(Selected and 0 or 1)
				end
				AddSignal(Button.Activated, function()
					local Try = not Selected

					if Dropdown:GetActiveValues() == 1 and not Try and not Config.AllowNull then
					else
						if Config.Multi then
							Selected = Try
							Dropdown.Value[Value] = Selected and true or nil
						else
							Selected = Try
							Dropdown.Value = Selected and Value or nil

							for _, OtherButton in next, Buttons do
								OtherButton:UpdateButton()
							end
						end

						Table:UpdateButton()

						Dropdown:Display()

						Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
						Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
					end
				end)

				Table:UpdateButton()
				Dropdown:Display()

				Buttons[Button] = Table
			end

			ListSizeX = 0
			for Button, Table in next, Buttons do
				if Button.ButtonLabel then
					local textSize = Button.ButtonLabel.TextBounds.X
					if textSize > ListSizeX then
						ListSizeX = textSize
					end
				end
			end
			ListSizeX = math.max(150, ListSizeX + 40)

			RecalculateCanvasSize()
			RecalculateListSize()
		end

		function Dropdown:SetValues(NewValues)
			if NewValues then
				Dropdown.Values = NewValues
			end

			Dropdown:BuildDropdownList()
		end

		function Dropdown:OnChanged(Func)
			Dropdown.Changed = Func
			Func(Dropdown.Value)
		end

		function Dropdown:SetValue(Val)
			if Dropdown.Multi then
				local nTable = {}

				for Value, Bool in next, Val do
					if table.find(Dropdown.Values, Value) then
						nTable[Value] = true
					end
				end

				Dropdown.Value = nTable
			else
				if not Val then
					Dropdown.Value = nil
				elseif table.find(Dropdown.Values, Val) then
					Dropdown.Value = Val
				end
			end

			Dropdown:BuildDropdownList()

			Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
			Library:SafeCallback(Dropdown.Changed, Dropdown.Value)
		end

		function Dropdown:Destroy()
			DropdownFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Dropdown:BuildDropdownList()
		Dropdown:Display()

		local Defaults = {}

		if type(Config.Default) == "string" then
			local Idx = table.find(Dropdown.Values, Config.Default)
			if Idx then
				table.insert(Defaults, Idx)
			end
		elseif type(Config.Default) == "table" then
			for _, Value in next, Config.Default do
				local Idx = table.find(Dropdown.Values, Value)
				if Idx then
					table.insert(Defaults, Idx)
				end
			end
		elseif type(Config.Default) == "number" and Dropdown.Values[Config.Default] ~= nil then
			table.insert(Defaults, Config.Default)
		end

		if next(Defaults) then
			for i = 1, #Defaults do
				local Index = Defaults[i]
				if Config.Multi then
					Dropdown.Value[Dropdown.Values[Index]] = true
				else
					Dropdown.Value = Dropdown.Values[Index]
				end

				if not Config.Multi then
					break
				end
			end

			Dropdown:BuildDropdownList()
			Dropdown:Display()
		end

		Dropdown.TabName = Element.TabName or "Unknown"
		Library.Options[Idx] = Dropdown
		return Dropdown
	end

	return Element
end)()
ElementsTable.Paragraph = (function()
	local Paragraph = {}
	Paragraph.__index = Paragraph
	Paragraph.__type = "Paragraph"

	function Paragraph:New(Config)
		Config.Content = Config.Content or ""

		local Paragraph = Components.Element(Config.Title, Config.Content, Paragraph.Container, false, Config)
		Paragraph.Frame.BackgroundTransparency = 0.92
		Paragraph.Border.Transparency = 0.6

		Paragraph.SetTitle = Paragraph.SetTitle
		Paragraph.SetDesc = Paragraph.SetDesc
		Paragraph.Visible = Paragraph.Visible
		Paragraph.Elements = Paragraph

		return Paragraph
	end

	return Paragraph
end)()
ElementsTable.Slider = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Slider"

	function Element:New(Idx, Config)
		Config.Title = Config.Title or "Slider"
		Config.Default = Config.Default or Config.Min or 0
		Config.Min = Config.Min or 0
		Config.Max = Config.Max or 100
		Config.Rounding = Config.Rounding or 0

		local Slider = {
			Value = nil,
			Min = Config.Min,
			Max = Config.Max,
			Rounding = Config.Rounding,
			Callback = Config.Callback or function(Value) end,
			Type = "Slider",
			Format = type(Config.Format) == "function" and Config.Format or nil,
		}

		local Dragging = false

		local SliderFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config)
		SliderFrame.DescLabel.Size = UDim2.new(1, -170, 0, 0)

		Slider.Elements = SliderFrame
		Slider.SetTitle = SliderFrame.SetTitle
		Slider.SetDesc = SliderFrame.SetDesc
		Slider.Visible = SliderFrame.Visible

		local SliderDot = New("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, -8, 0.5, 0),
			Size = UDim2.fromOffset(16, 16),
			Image = "http://www.roblox.com/asset/?id=12266946128",
			ThemeTag = {
				ImageColor3 = "Accent",
			},
		})

		local SliderRail = New("Frame", {
			BackgroundTransparency = 1,
			Position = UDim2.fromOffset(8, 0),
			Size = UDim2.new(1, -16, 1, 0),
		}, {
			SliderDot,
		})

		local SliderFill = New("Frame", {
			Size = UDim2.new(0, 0, 1, 0),
			ThemeTag = {
				BackgroundColor3 = "Accent",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(1, 0),
			}),
		})

		local SliderDisplay = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
			Text = "Value",
			TextSize = 12,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Right,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 100, 0, 14),
			Position = UDim2.new(0, -9, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			ThemeTag = {
				TextColor3 = "SubText",
			},
		})

		local SliderInner = New("Frame", {
			Size = UDim2.new(1, 0, 0, 8),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -15, 0.5, 0),
			BackgroundTransparency = 0.4,
			Parent = SliderFrame.Frame,
			ThemeTag = {
				BackgroundColor3 = "SliderRail",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(1, 0),
			}),
			New("UISizeConstraint", {
				MaxSize = Vector2.new(145, math.huge),
			}),
			SliderDisplay,
			SliderFill,
			SliderRail,
			New("Frame", {
				Size = UDim2.new(1, 24, 0, 44),
				Position = UDim2.new(0, -12, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				BackgroundTransparency = 1,
				ZIndex = 10,
			}),
		})

		local function SliderUpdate(posX)
			local SizeScale = math.clamp((posX - SliderRail.AbsolutePosition.X) / SliderRail.AbsoluteSize.X, 0, 1)
			Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * SizeScale))
		end

		local SliderHitbox = SliderInner:FindFirstChildOfClass("Frame")

		local function OnSliderInputBegan(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				SliderUpdate(Input.Position.X)
			end
		end

		local function OnSliderInputEnded(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = false
			end
		end

		Creator.AddSignal(SliderInner.InputBegan, OnSliderInputBegan)
		Creator.AddSignal(SliderInner.InputEnded, OnSliderInputEnded)

		if SliderHitbox then
			Creator.AddSignal(SliderHitbox.InputBegan, OnSliderInputBegan)
			Creator.AddSignal(SliderHitbox.InputEnded, OnSliderInputEnded)
		end

		Creator.AddSignal(UserInputService.InputEnded, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = false
			end
		end)

		Creator.AddSignal(UserInputService.InputChanged, function(Input)
			if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
				SliderUpdate(Input.Position.X)
			end
		end)

		function Slider:OnChanged(Func)
			Slider.Changed = Func
			Func(Slider.Value)
		end

		function Slider:SetValue(Value)
			self.Value = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Rounding)
			SliderDot.Position = UDim2.new((self.Value - Slider.Min) / (Slider.Max - Slider.Min), -8, 0.5, 0)
			SliderFill.Size = UDim2.fromScale((self.Value - Slider.Min) / (Slider.Max - Slider.Min), 1)

			local DisplayText = tostring(self.Value)
			if Slider.Format then
				local ok, result = pcall(Slider.Format, self.Value)
				if ok and type(result) == "string" and result ~= "" then
					DisplayText = result
				end
			end
			SliderDisplay.Text = DisplayText

			Library:SafeCallback(Slider.Callback, self.Value)
			Library:SafeCallback(Slider.Changed, self.Value)
		end

		function Slider:Destroy()
			SliderFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Slider:SetValue(Config.Default)

		Slider.TabName = Element.TabName or "Unknown"
		Library.Options[Idx] = Slider
		return Slider
	end

	return Element
end)()
ElementsTable.Keybind = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Keybind"

	function Element:New(Idx, Config)
		Config.Title = Config.Title or "Keybind"
		Config.Default = Config.Default or "None"

		local Keybind = {
			Value = Config.Default,
			Toggled = false,
			Mode = Config.Mode or "Toggle",
			Type = "Keybind",
			Callback = Config.Callback or function(Value) end,
			ChangedCallback = Config.ChangedCallback or function(New) end,
		}

		local Picking = false

		local KeybindFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)

		Keybind.SetTitle = KeybindFrame.SetTitle
		Keybind.SetDesc = KeybindFrame.SetDesc
		Keybind.Visible = KeybindFrame.Visible
		Keybind.Elements = KeybindFrame

		local KeybindDisplayLabel = New("TextLabel", {
			FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
			Text = Config.Default,
			TextColor3 = Color3.fromRGB(240, 240, 240),
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Center,
			Size = UDim2.new(0, 0, 0, 14),
			Position = UDim2.new(0, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			AutomaticSize = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			ThemeTag = {
				TextColor3 = "Text",
			},
		})

		local KeybindDisplayFrame = New("TextButton", {
			Size = UDim2.fromOffset(0, 30),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundTransparency = 0.9,
			Parent = KeybindFrame.Frame,
			AutomaticSize = Enum.AutomaticSize.X,
			ThemeTag = {
				BackgroundColor3 = "Keybind",
			},
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 5),
			}),
			New("UIPadding", {
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
			}),
			New("UIStroke", {
				Transparency = 0.5,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				ThemeTag = {
					Color = "InElementBorder",
				},
			}),
			KeybindDisplayLabel,
		})

		function Keybind:GetState()
			if UserInputService:GetFocusedTextBox() and Keybind.Mode ~= "Always" then
				return false
			end

			if Keybind.Mode == "Always" then
				return true
			elseif Keybind.Mode == "Hold" then
				if Keybind.Value == "None" then
					return false
				end

				local Key = Keybind.Value

				if Key == "MouseLeft" or Key == "MouseRight" then
					return Key == "MouseLeft" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
						or Key == "MouseRight"
						and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
				else
					return UserInputService:IsKeyDown(Enum.KeyCode[Keybind.Value])
				end
			else
				return Keybind.Toggled
			end
		end

		function Keybind:SetValue(Key, Mode)
			Key = Key or Keybind.Key
			Mode = Mode or Keybind.Mode

			KeybindDisplayLabel.Text = Key
			Keybind.Value = Key
			Keybind.Mode = Mode
		end

		function Keybind:OnClick(Callback)
			Keybind.Clicked = Callback
		end

		function Keybind:OnChanged(Callback)
			Keybind.Changed = Callback
			Callback(Keybind.Value)
		end

		function Keybind:DoClick()
			Library:SafeCallback(Keybind.Callback, Keybind.Toggled)
			Library:SafeCallback(Keybind.Clicked, Keybind.Toggled)
		end

		function Keybind:Destroy()
			KeybindFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(KeybindDisplayFrame.InputBegan, function(Input)
			if
				Input.UserInputType == Enum.UserInputType.MouseButton1
				or Input.UserInputType == Enum.UserInputType.Touch
			then
				Picking = true
				KeybindDisplayLabel.Text = "..."

				task.wait(0.2)

				local Event
				Event = UserInputService.InputBegan:Connect(function(Input)
					local Key

					if Input.UserInputType == Enum.UserInputType.Keyboard then
						Key = Input.KeyCode.Name
					elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
						Key = "MouseLeft"
					elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
						Key = "MouseRight"
					end

					local EndedEvent
					EndedEvent = UserInputService.InputEnded:Connect(function(Input)
						if
							Input.KeyCode.Name == Key
							or Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1
							or Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2
						then
							Picking = false

							KeybindDisplayLabel.Text = Key
							Keybind.Value = Key

							Library:SafeCallback(Keybind.ChangedCallback, Input.KeyCode or Input.UserInputType)
							Library:SafeCallback(Keybind.Changed, Input.KeyCode or Input.UserInputType)

							Event:Disconnect()
							EndedEvent:Disconnect()
						end
					end)
				end)
			end
		end)

		Creator.AddSignal(UserInputService.InputBegan, function(Input)
			if not Picking and not UserInputService:GetFocusedTextBox() then
				if Keybind.Mode == "Toggle" then
					local Key = Keybind.Value

					if Key == "MouseLeft" or Key == "MouseRight" then
						if
							Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1
							or Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2
						then
							Keybind.Toggled = not Keybind.Toggled
							Keybind:DoClick()
						end
					elseif Input.UserInputType == Enum.UserInputType.Keyboard then
						if Input.KeyCode.Name == Key then
							Keybind.Toggled = not Keybind.Toggled
							Keybind:DoClick()
						end
					end
				end
			end
		end)

		Keybind.TabName = Element.TabName or "Unknown"
		Library.Options[Idx] = Keybind
		return Keybind
	end

	return Element
end)()
ElementsTable.Colorpicker = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Colorpicker"

	function Element:New(Idx, Config)
		Config.Title = Config.Title or "Color"
		Config.Default = Config.Default or Color3.fromRGB(255,255,255)

		local Colorpicker = {
			Value = Config.Default,
			Transparency = (type(Config.Transparency) == "number" and Config.Transparency) or 0,
			Type = "Colorpicker",
			Title = type(Config.Title) == "string" and Config.Title or "Colorpicker",
			Callback = Config.Callback or function(Color) end,
		}

		function Colorpicker:SetHSVFromRGB(Color)
			local H, S, V = Color3.toHSV(Color)
			Colorpicker.Hue = H
			Colorpicker.Sat = S
			Colorpicker.Vib = V
		end

		Colorpicker:SetHSVFromRGB(Colorpicker.Value)

		local ColorpickerFrame = Components.Element(Config.Title, Config.Description, self.Container, true, Config)

		Colorpicker.SetTitle = ColorpickerFrame.SetTitle
		Colorpicker.SetDesc = ColorpickerFrame.SetDesc
		Colorpicker.Visible = ColorpickerFrame.Visible
		Colorpicker.Elements = ColorpickerFrame

		local DisplayFrameColor = New("Frame", {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Colorpicker.Value,
			Parent = ColorpickerFrame.Frame,
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
		})

		local DisplayFrame = New("ImageLabel", {
			Size = UDim2.fromOffset(26, 26),
			Position = UDim2.new(1, -10, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			Parent = ColorpickerFrame.Frame,
			Image = "http://www.roblox.com/asset/?id=14204231522",
			ImageTransparency = 0.45,
			ScaleType = Enum.ScaleType.Tile,
			TileSize = UDim2.fromOffset(40, 40),
		}, {
			New("UICorner", {
				CornerRadius = UDim.new(0, 4),
			}),
			DisplayFrameColor,
		})

		local function CreateColorDialog()
			local Dialog = Components.Dialog:Create()
			Dialog.Title.Text = Colorpicker.Title
			Dialog.Root.Size = UDim2.fromOffset(430, 330)

			local Hue, Sat, Vib = Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib
			local Transparency = Colorpicker.Transparency

			local function CreateInput()
				local Box = Components.Textbox()
				Box.Frame.Parent = Dialog.Root
				Box.Frame.Size = UDim2.new(0, 90, 0, 32)

				return Box
			end

			local function CreateInputLabel(Text, Pos)
				return New("TextLabel", {
					FontFace = Font.new(
						"rbxasset://fonts/families/GothamSSm.json",
						Enum.FontWeight.Medium,
						Enum.FontStyle.Normal
					),
					Text = Text,
					TextColor3 = Color3.fromRGB(240, 240, 240),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					Size = UDim2.new(1, 0, 0, 32),
					Position = Pos,
					BackgroundTransparency = 1,
					Parent = Dialog.Root,
					ThemeTag = {
						TextColor3 = "Text",
					},
				})
			end

			local function GetRGB()
				local Value = Color3.fromHSV(Hue, Sat, Vib)
				return { R = math.floor(Value.r * 255), G = math.floor(Value.g * 255), B = math.floor(Value.b * 255) }
			end

			local SatCursor = New("ImageLabel", {
				Size = UDim2.new(0, 18, 0, 18),
				ScaleType = Enum.ScaleType.Fit,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Image = "http://www.roblox.com/asset/?id=4805639000",
			})

			local SatVibMap = New("ImageLabel", {
				Size = UDim2.fromOffset(180, 160),
				Position = UDim2.fromOffset(20, 55),
				Image = "",
				BackgroundColor3 = Colorpicker.Value,
				BackgroundTransparency = 0,
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				SatCursor,
			})

			local OldColorFrame = New("Frame", {
				BackgroundColor3 = Colorpicker.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = Colorpicker.Transparency,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})
			local OldColorFrameChecker = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(112, 220),
				Size = UDim2.fromOffset(88, 24),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				OldColorFrame,
			})

			local DialogDisplayFrame = New("Frame", {
				BackgroundColor3 = Colorpicker.Value,
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 0,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			})

			local DialogDisplayFrameChecker = New("ImageLabel", {
				Image = "http://www.roblox.com/asset/?id=14204231522",
				ImageTransparency = 0.45,
				ScaleType = Enum.ScaleType.Tile,
				TileSize = UDim2.fromOffset(40, 40),
				BackgroundTransparency = 1,
				Position = UDim2.fromOffset(20, 220),
				Size = UDim2.fromOffset(88, 24),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
				New("UIStroke", {
					Thickness = 2,
					Transparency = 0.75,
				}),
				DialogDisplayFrame,
			})

			local SequenceTable = {}

			for Color = 0, 1, 0.1 do
				table.insert(SequenceTable, ColorSequenceKeypoint.new(Color, Color3.fromHSV(Color, 1, 1)))
			end

			local HueSliderGradient = New("UIGradient", {
				Color = ColorSequence.new(SequenceTable),
				Rotation = 90,
			})

			local HueDragHolder = New("Frame", {
				Size = UDim2.new(1, 0, 1, -10),
				Position = UDim2.fromOffset(0, 5),
				BackgroundTransparency = 1,
			})

			local HueDrag = New("ImageLabel", {
				Size = UDim2.fromOffset(14, 14),
				Image = "http://www.roblox.com/asset/?id=12266946128",
				Parent = HueDragHolder,
				ThemeTag = {
					ImageColor3 = "DialogInput",
				},
			})

			local HueSlider = New("Frame", {
				Size = UDim2.fromOffset(12, 190),
				Position = UDim2.fromOffset(210, 55),
				Parent = Dialog.Root,
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(1, 0),
				}),
				HueSliderGradient,
				HueDragHolder,
			})

			local HexInput = CreateInput()
			HexInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 55)
			CreateInputLabel("Hex", UDim2.fromOffset(Config.Transparency and 360 or 340, 55))

			local RedInput = CreateInput()
			RedInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 95)
			CreateInputLabel("Red", UDim2.fromOffset(Config.Transparency and 360 or 340, 95))

			local GreenInput = CreateInput()
			GreenInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 135)
			CreateInputLabel("Green", UDim2.fromOffset(Config.Transparency and 360 or 340, 135))

			local BlueInput = CreateInput()
			BlueInput.Frame.Position = UDim2.fromOffset(Config.Transparency and 260 or 240, 175)
			CreateInputLabel("Blue", UDim2.fromOffset(Config.Transparency and 360 or 340, 175))

			local AlphaInput
			if Config.Transparency then
				AlphaInput = CreateInput()
				AlphaInput.Frame.Position = UDim2.fromOffset(260, 215)
				CreateInputLabel("Alpha", UDim2.fromOffset(360, 215))
			end

			local TransparencySlider, TransparencyDrag, TransparencyColor
			if Config.Transparency then
				local TransparencyDragHolder = New("Frame", {
					Size = UDim2.new(1, 0, 1, -10),
					Position = UDim2.fromOffset(0, 5),
					BackgroundTransparency = 1,
				})

				TransparencyDrag = New("ImageLabel", {
					Size = UDim2.fromOffset(14, 14),
					Image = "http://www.roblox.com/asset/?id=12266946128",
					Parent = TransparencyDragHolder,
					ThemeTag = {
						ImageColor3 = "DialogInput",
					},
				})

				TransparencyColor = New("Frame", {
					Size = UDim2.fromScale(1, 1),
				}, {
					New("UIGradient", {
						Transparency = NumberSequence.new({
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(1, 1),
						}),
						Rotation = 270,
					}),
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
				})

				TransparencySlider = New("Frame", {
					Size = UDim2.fromOffset(12, 190),
					Position = UDim2.fromOffset(230, 55),
					Parent = Dialog.Root,
					BackgroundTransparency = 1,
				}, {
					New("UICorner", {
						CornerRadius = UDim.new(1, 0),
					}),
					New("ImageLabel", {
						Image = "http://www.roblox.com/asset/?id=14204231522",
						ImageTransparency = 0.45,
						ScaleType = Enum.ScaleType.Tile,
						TileSize = UDim2.fromOffset(40, 40),
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Parent = Dialog.Root,
					}, {
						New("UICorner", {
							CornerRadius = UDim.new(1, 0),
						}),
					}),
					TransparencyColor,
					TransparencyDragHolder,
				})
			end

			local function Display()
				SatVibMap.BackgroundColor3 = Color3.fromHSV(Hue, 1, 1)
				HueDrag.Position = UDim2.new(0, -1, Hue, -6)
				SatCursor.Position = UDim2.new(Sat, 0, 1 - Vib, 0)
				DialogDisplayFrame.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)

				HexInput.Input.Text = "#" .. Color3.fromHSV(Hue, Sat, Vib):ToHex()
				RedInput.Input.Text = GetRGB()["R"]
				GreenInput.Input.Text = GetRGB()["G"]
				BlueInput.Input.Text = GetRGB()["B"]

				if Config.Transparency then
					TransparencyColor.BackgroundColor3 = Color3.fromHSV(Hue, Sat, Vib)
					DialogDisplayFrame.BackgroundTransparency = Transparency
					TransparencyDrag.Position = UDim2.new(0, -1, 1 - Transparency, -6)
					AlphaInput.Input.Text = Library:Round((1 - Transparency) * 100, 0) .. "%"
				end
			end

			Creator.AddSignal(HexInput.Input.FocusLost, function(Enter)
				if Enter then
					local Success, Result = pcall(Color3.fromHex, HexInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						Hue, Sat, Vib = Color3.toHSV(Result)
					end
				end
				Display()
			end)

			Creator.AddSignal(RedInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result = pcall(Color3.fromRGB, RedInput.Input.Text, CurrentColor["G"], CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(RedInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(GreenInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result =
						pcall(Color3.fromRGB, CurrentColor["R"], GreenInput.Input.Text, CurrentColor["B"])
					if Success and typeof(Result) == "Color3" then
						if tonumber(GreenInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			Creator.AddSignal(BlueInput.Input.FocusLost, function(Enter)
				if Enter then
					local CurrentColor = GetRGB()
					local Success, Result =
						pcall(Color3.fromRGB, CurrentColor["R"], CurrentColor["G"], BlueInput.Input.Text)
					if Success and typeof(Result) == "Color3" then
						if tonumber(BlueInput.Input.Text) <= 255 then
							Hue, Sat, Vib = Color3.toHSV(Result)
						end
					end
				end
				Display()
			end)

			if Config.Transparency then
				Creator.AddSignal(AlphaInput.Input.FocusLost, function(Enter)
					if Enter then
						pcall(function()
							local Value = tonumber(AlphaInput.Input.Text)
							if Value >= 0 and Value <= 100 then
								Transparency = 1 - Value * 0.01
							end
						end)
					end
					Display()
				end)
			end

			Creator.AddSignal(SatVibMap.InputBegan, function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinX = SatVibMap.AbsolutePosition.X
						local MaxX = MinX + SatVibMap.AbsoluteSize.X
						local MouseX = math.clamp(Mouse.X, MinX, MaxX)

						local MinY = SatVibMap.AbsolutePosition.Y
						local MaxY = MinY + SatVibMap.AbsoluteSize.Y
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

						Sat = (MouseX - MinX) / (MaxX - MinX)
						Vib = 1 - ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end)

			Creator.AddSignal(HueSlider.InputBegan, function(Input)
				if
					Input.UserInputType == Enum.UserInputType.MouseButton1
					or Input.UserInputType == Enum.UserInputType.Touch
				then
					while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
						local MinY = HueSlider.AbsolutePosition.Y
						local MaxY = MinY + HueSlider.AbsoluteSize.Y
						local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

						Hue = ((MouseY - MinY) / (MaxY - MinY))
						Display()

						RenderStepped:Wait()
					end
				end
			end)

			if Config.Transparency then
				Creator.AddSignal(TransparencySlider.InputBegan, function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then
						while UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
							local MinY = TransparencySlider.AbsolutePosition.Y
							local MaxY = MinY + TransparencySlider.AbsoluteSize.Y
							local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

							Transparency = 1 - ((MouseY - MinY) / (MaxY - MinY))
							Display()

							RenderStepped:Wait()
						end
					end
				end)
			end

			Display()

			Dialog:Button("Done", function()
				Colorpicker:SetValue({ Hue, Sat, Vib }, Transparency)
			end)
			Dialog:Button("Cancel")
			Dialog:Open()
		end

		function Colorpicker:Display()
			Colorpicker.Value = Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib)

			DisplayFrameColor.BackgroundColor3 = Colorpicker.Value
			DisplayFrameColor.BackgroundTransparency = Colorpicker.Transparency

			Element.Library:SafeCallback(Colorpicker.Callback, Colorpicker.Value)
			Element.Library:SafeCallback(Colorpicker.Changed, Colorpicker.Value)
		end

		function Colorpicker:SetValue(HSV, Transparency)
			local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3])

			Colorpicker.Transparency = Transparency or 0
			Colorpicker:SetHSVFromRGB(Color)
			Colorpicker:Display()
		end

		function Colorpicker:SetValueRGB(Color, Transparency)
			Colorpicker.Transparency = Transparency or 0
			Colorpicker:SetHSVFromRGB(Color)
			Colorpicker:Display()
		end

		function Colorpicker:OnChanged(Func)
			Colorpicker.Changed = Func
			Func(Colorpicker.Value)
		end

		function Colorpicker:Destroy()
			ColorpickerFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Creator.AddSignal(ColorpickerFrame.Frame.MouseButton1Click, function()
			CreateColorDialog()
		end)

		Creator.AddSignal(ColorpickerFrame.Frame.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.Touch then
				CreateColorDialog()
			end
		end)

		Colorpicker:Display()

		Colorpicker.TabName = Element.TabName or "Unknown"
		Library.Options[Idx] = Colorpicker
		return Colorpicker
	end

	return Element
end)()
ElementsTable.Input = (function()
	local Element = {}
	Element.__index = Element
	Element.__type = "Input"

	function Element:New(Idx, Config)
		Config.Title = Config.Title or "Input"
		Config.Callback = Config.Callback or function() end

		local Input = {
			Value = Config.Default or "",
			Numeric = Config.Numeric or false,
			Finished = Config.Finished or false,
			Callback = Config.Callback or function(Value) end,
			Type = "Input",
			Format = (Config.Numeric and type(Config.Format) == "function") and Config.Format or nil,
		}

		local InputFrame = Components.Element(Config.Title, Config.Description, self.Container, false, Config)

		Input.SetTitle = InputFrame.SetTitle
		Input.SetDesc = InputFrame.SetDesc
		Input.Visible = InputFrame.Visible
		Input.Elements = InputFrame

		InputFrame.LabelHolder.Size = UDim2.new(1, -175, 0, 0)

		local Textbox = Components.Textbox(InputFrame.Frame, true)
		Textbox.Frame.Position = UDim2.new(1, -10, 0.5, 0)
		Textbox.Frame.AnchorPoint = Vector2.new(1, 0.5)
		Textbox.Frame.Size = UDim2.fromOffset(160, 30)
		Textbox.Input.Text = Config.Default or ""
		Textbox.Input.PlaceholderText = Config.Placeholder or ""

		local Box = Textbox.Input
		local _isFormatDisplaying = false

		local function ApplyFormat()
			if Input.Format and Input.Numeric and Input.Value ~= "" then
				local n = tonumber(Input.Value)
				if not n then return end
				local ok, result = pcall(Input.Format, n)
				if ok and type(result) == "string" and result ~= "" then
					_isFormatDisplaying = true
					Box.Text = result
				end
			end
		end

		local function RestoreRaw()
			if _isFormatDisplaying then
				_isFormatDisplaying = false
				Box.Text = tostring(Input.Value)
			end
		end

		function Input:SetValue(Text)
			if Config.MaxLength and #Text > Config.MaxLength then
				Text = Text:sub(1, Config.MaxLength)
			end

			if Input.Numeric then
				if (not tonumber(Text)) and Text:len() > 0 then
					Text = Input.Value
				end
			end

			Input.Value = Text

			_isFormatDisplaying = false
			Box.Text = Text

			Library:SafeCallback(Input.Callback, Input.Value)
			Library:SafeCallback(Input.Changed, Input.Value)

			if not Box:IsFocused() then
				task.defer(ApplyFormat)
			end
		end

		AddSignal(Box.Focused, function()
			RestoreRaw()
		end)

		if Input.Finished then
			AddSignal(Box.FocusLost, function(enter)

				local rawText = Box.Text
				if Input.Numeric then
					if (not tonumber(rawText)) and rawText:len() > 0 then
						rawText = Input.Value
					end
				end
				if Config.MaxLength and #rawText > Config.MaxLength then
					rawText = rawText:sub(1, Config.MaxLength)
				end
				Input.Value = rawText
				_isFormatDisplaying = false
				Box.Text = rawText

				if enter then
					Library:SafeCallback(Input.Callback, Input.Value)
					Library:SafeCallback(Input.Changed, Input.Value)
				end

				ApplyFormat()
			end)
		else
			AddSignal(Box:GetPropertyChangedSignal("Text"), function()
				if _isFormatDisplaying then return end
				Input:SetValue(Box.Text)
			end)
			AddSignal(Box.FocusLost, function()

				ApplyFormat()
			end)
		end

		if Config.Default and Config.Default ~= "" then
			task.defer(ApplyFormat)
		end

		function Input:OnChanged(Func)
			Input.Changed = Func
			Func(Input.Value)
		end

		function Input:Destroy()
			InputFrame:Destroy()
			Library.Options[Idx] = nil
		end

		Input.TabName = Element.TabName or "Unknown"
		Library.Options[Idx] = Input
		return Input
	end

	return Element
end)()

local NotificationModule = Components.Notification
NotificationModule:Init(GUI)

local New = Creator.New

local Elements = {}
Elements.__index = Elements
Elements.__namecall = function(Table, Key, ...)
	return Elements[Key](...)
end

local SaveManager

for _, ElementComponent in pairs(ElementsTable) do
	Elements["Add" .. ElementComponent.__type] = function(self, Idx, Config)
		if type(Idx) == "table" then
			Config = Idx
			IdxStr = Config.Id or Config.Title or tostring(math.random(100000, 999999))
		else
			IdxStr = Idx
			Config = Config or {}
		end
		local tabName = self.Name or self.TabName or "Unknown"
		local baseIdx = tabName .. "_" .. IdxStr

		local uniqueIdx = baseIdx
		local counter = 2
		while Library.Options[uniqueIdx] do
			uniqueIdx = baseIdx .. "_" .. counter
			counter = counter + 1
		end

		ElementComponent.Container = self.Container
		ElementComponent.Type = self.Type
		ElementComponent.ScrollFrame = self.ScrollFrame
		ElementComponent.Library = Library
		ElementComponent.TabName = tabName

		local eType = ElementComponent.__type
		if eType == "Button" or eType == "Paragraph" then
			return ElementComponent:New(Config)
		else
			local result = ElementComponent:New(uniqueIdx, Config)
			if result then
				result.Default = result.Value
				if eType == "Colorpicker" then
					result.DefaultTransparency = result.Transparency
				elseif eType == "Keybind" then
					result.DefaultMode = result.Mode
				end
				if SaveManager then
					SaveManager:HookOption(result)
				end
			end
			return result
		end
	end
end

SaveManager = {
	Folder = "FluentSettings",
	Ignore = {},
	_saveDebounce = false,
	Parser = {
		Toggle = {
			Save = function(idx, object)
				return { type = "Toggle", value = object.Value }
			end,
			Load = function(idx, data)
				if Library.Options[idx] then Library.Options[idx]:SetValue(data.value) end
			end,
		},
		Slider = {
			Save = function(idx, object)
				return { type = "Slider", value = tostring(object.Value) }
			end,
			Load = function(idx, data)
				if Library.Options[idx] then Library.Options[idx]:SetValue(tonumber(data.value) or data.value) end
			end,
		},
		Dropdown = {
			Save = function(idx, object)
				return { type = "Dropdown", value = object.Value, multi = object.Multi }
			end,
			Load = function(idx, data)
				if Library.Options[idx] then Library.Options[idx]:SetValue(data.value) end
			end,
		},
		Colorpicker = {
			Save = function(idx, object)
				return { type = "Colorpicker", value = object.Value:ToHex(), transparency = object.Transparency }
			end,
			Load = function(idx, data)
				if Library.Options[idx] then Library.Options[idx]:SetValueRGB(Color3.fromHex(data.value), data.transparency) end
			end,
		},
		Keybind = {
			Save = function(idx, object)
				return { type = "Keybind", mode = object.Mode, key = object.Value }
			end,
			Load = function(idx, data)
				if Library.Options[idx] then Library.Options[idx]:SetValue(data.key, data.mode) end
			end,
		},
		Input = {
			Save = function(idx, object)
				return { type = "Input", text = object.Value }
			end,
			Load = function(idx, data)
				if Library.Options[idx] and type(data.text) == "string" then Library.Options[idx]:SetValue(data.text) end
			end,
		},
	},
}

function SaveManager:BuildFolderTree()
	if RunService:IsStudio() then return end
	pcall(function() if not isfolder(self.Folder) then makefolder(self.Folder) end end)
end

function SaveManager:GetSaveTitle()
	if Library.Window and Library.Window.SaveFile and Library.Window.SaveFile ~= "" then
		return Library.Window.SaveFile
	end
	local title = nil
	if Library.Window then
		if Library.Window.Title then
			title = Library.Window.Title
		else
			local tb = Library.Window.TitleBar and Library.Window.TitleBar.Frame
			if tb then
				for _, v in ipairs(tb:GetDescendants()) do
					if v:IsA("TextLabel") and v.Text ~= "" then title = v.Text break end
				end
			end
		end
	end
	return title or "Config"
end

function SaveManager:BuildData()
	local data = { __theme = Library.Theme }
	for idx, option in next, Library.Options do
		if not self.Ignore[idx] and self.Parser[option.Type] then
			local tabName = option.TabName or "Unknown"
			if not data[tabName] then
				data[tabName] = {}
			end
			local prefix = tabName .. "_"
			local cleanIdx = idx:sub(1, #prefix) == prefix and idx:sub(#prefix + 1) or idx
			data[tabName][cleanIdx] = self.Parser[option.Type].Save(idx, option)
		end
	end
	return data
end

function SaveManager:Save()
	if RunService:IsStudio() then return true end
	local title = self:GetSaveTitle()
	local path = self.Folder .. "/" .. title .. ".json"
	local data = self:BuildData()
	local success, encoded = pcall(httpService.JSONEncode, httpService, data)
	if not success then return false, encoded end
	local ok, err = pcall(writefile, path, encoded)
	if not ok then return false, err end
	return true
end

function SaveManager:Load()
	if RunService:IsStudio() then return true end
	local title = self:GetSaveTitle()
	local path = self.Folder .. "/" .. title .. ".json"
	if not (pcall(isfile, path) and isfile(path)) then return false, "File not found" end
	local ok, result = pcall(readfile, path)
	if not ok then return false, result end
	local success, decoded = pcall(httpService.JSONDecode, httpService, result)
	if not success then return false, decoded end
	if type(decoded) ~= "table" then return false, "Invalid data" end
	if decoded.__theme and type(decoded.__theme) == "string" then
		Library:SetTheme(decoded.__theme)
	end
	for tabName, tabData in pairs(decoded) do
		if tabName ~= "__theme" and type(tabData) == "table" then
			for idx, optData in pairs(tabData) do
				if type(optData) == "table" and optData.type and self.Parser[optData.type] then
					local internalIdx = tabName .. "_" .. idx
					if Library.Options[internalIdx] then
						pcall(function() self.Parser[optData.type].Load(internalIdx, optData) end)
					elseif Library.Options[idx] then
						pcall(function() self.Parser[optData.type].Load(idx, optData) end)
					end
				end
			end
		end
	end
	return true
end

function SaveManager:HookOption(option)
	if not option or not option.Callback then return end
	if not self.Parser[option.Type] then return end
	if option._autoSaveHooked then return end
	option._autoSaveHooked = true

	local orig = option.Callback
	option.Callback = function(...)
		if orig then pcall(orig, ...) end
		if not SaveManager._saveDebounce then
			SaveManager._saveDebounce = true
			task.defer(function()
				task.wait(0.35)
				SaveManager._saveDebounce = false
				pcall(function() SaveManager:Save() end)
			end)
		end
	end
end

function SaveManager:ResetOption(idx, option)
	if self.Ignore[idx] or not self.Parser[option.Type] then return end

	if option.Type == "Keybind" then
		option.Toggled = false
		pcall(function() option:SetValue(option.Default, option.DefaultMode) end)
		pcall(function() Library:SafeCallback(option.Callback, false) end)
	elseif option.Type == "Colorpicker" then
		pcall(function() option:SetValueRGB(option.Default, option.DefaultTransparency) end)
	else
		pcall(function() option:SetValue(option.Default) end)
	end
end

function SaveManager:ClearSave()
	local ok, err = pcall(function()
		if not RunService:IsStudio() and isfolder(self.Folder) then
			if delfolder then
				delfolder(self.Folder)
			else
				local files = listfiles(self.Folder)
				for _, file in next, files do
					pcall(delfile, file)
				end
			end
		end
	end)

	for idx, option in next, Library.Options do
		self:ResetOption(idx, option)
	end

	pcall(function() Library:SetTheme(self.DefaultTheme or "Dark") end)

	self:BuildFolderTree()

	if not ok then return false, err end
	return true
end

SaveManager:BuildFolderTree()

for idx, option in next, Library.Options do
	SaveManager:HookOption(option)
end

Library.SaveManager = SaveManager
Library.Elements = Elements

if RunService:IsStudio() then
	makefolder = function(...) return ... end;
	makefile = function(...) return ... end;
	isfile = function(...) return ... end;
	isfolder = function(...) return ... end;
	readfile = function(...) return ... end;
	writefile = function(...) return ... end;
	listfiles = function (...) return {...} end;
end

Library.CreateWindow = function(self, Config)
	assert(Config.Title, "Window - Missing Title")
	if Library.Window then
		print("You cannot create more than one window.")
		return
	end
	Library.MinimizeKey = Config.MinimizeKey or Enum.KeyCode.LeftControl
	Library.UseAcrylic = Config.Acrylic or false
	Library.Acrylic = Config.Acrylic or false
	Library.Theme = Config.Theme or "Dark"
	SaveManager.DefaultTheme = Library.Theme
	if Config.Size == nil then
		Config.Size = UDim2.fromOffset(580, 460)
	end
	if Config.BackgroundImage == nil then
		Config.BackgroundImage = ""
	end
	if Config.BackgroundTransparency == nil then
		Config.BackgroundTransparency = 0.5
	end
	if Config.Acrylic then
		Acrylic.init()
	end
	local Icon = Config.Icon
	local Window = Components.Window({
		Parent = GUI,
		Size = Config.Size,
		Title = Config.Title,
		Icon = Icon,
		IconCorner = Config.IconCorner,
		Image = Config.Image,
		BackgroundImage = Config.BackgroundImage,
		BackgroundTransparency = Config.BackgroundTransparency,
		BackgroundImageTransparency = Config.BackgroundImageTransparency,
		SubTitle = Config.SubTitle,
		TabWidth = Config.TabWidth or 150,
		DropdownsOutsideWindow = Config.DropdownsOutsideWindow,
		Search = Config.Search,
		UserInfoTitle = Config.UserInfoTitle,
		UserInfo = Config.UserInfo,
		UserInfoTop = Config.UserInfoTop,
		UserInfoSubtitle = Config.UserInfoSubtitle,
		UserInfoSubtitleColor = Config.UserInfoSubtitleColor,
	})
	Library.Window = Window
	table.insert(Library.Windows, Window)

	if Config.SaveFile and Config.SaveFile ~= "" then
		Window.SaveFile = Config.SaveFile
	end

	Window.AcrylicBlur = function(self, Value)
		Library:SetAcrylic(Value)
	end

	Window.SaveManager = SaveManager

	function Window:Save(...)
		return SaveManager:Save(...)
	end

	function Window:Load(...)
		return SaveManager:Load(...)
	end

	function Window:ClearSave(...)
		return SaveManager:ClearSave(...)
	end

	Library:SetTheme(Config.Theme)

	task.defer(function()
		task.defer(function()
			pcall(function() SaveManager:Load() end)
		end)
	end)

	return Window
end
function Library:CreateMinimizer(Config)
	Config = Config or {}
	if self.Minimizer and self.Minimizer.Parent then
		return self.Minimizer
	end
	local parentGui = Library.GUI or GUI
	if parentGui then parentGui.DisplayOrder = 1000 end
	local isMobile = Mobile and true or false
	local iconAsset = ""
	if type(Config.Icon) == "string" and Config.Icon ~= "" then
		iconAsset = Config.Icon
	end
	local useAcrylic = (Config.Acrylic == true)
	local cornerRadius = tonumber(Config.Corner)
	local backgroundTransparency = (typeof(Config.Transparency) == "number") and math.clamp(Config.Transparency, 0, 1) or 0
	local draggableWhole = (Config.Draggable == true)
	local holder
	local function createButton(isDesktop)
		local hasIcon = iconAsset ~= ""
		local btnProps = {
			Name = "MinimizeButton",
			Size = UDim2.new(1, 0, 1, 0),
			BorderSizePixel = 0,
			AutoButtonColor = true,
		}
		if hasIcon then
			btnProps.BackgroundTransparency = 1
		else
			btnProps.BackgroundTransparency = backgroundTransparency or 0
			btnProps.ThemeTag = { BackgroundColor3 = "Element" }
		end
		local children = {
			New("UICorner", { CornerRadius = UDim.new(0, cornerRadius or (isDesktop and 14 or 12)) }),
		}
		if not hasIcon then
			table.insert(children, New("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Transparency = isDesktop and 0.6 or 0.7,
				Thickness = isDesktop and 2 or 1.5,
				ThemeTag = {
					Color = "ElementBorder",
				},
			}))
		end
		if hasIcon then
			table.insert(children, New("ImageLabel", {
				Name = "Icon",
				Image = iconAsset,
				Size = UDim2.new(1, 0, 1, 0),
				Position = UDim2.new(0, 0, 0, 0),
				AnchorPoint = Vector2.new(0, 0),
				BackgroundTransparency = 1,
				ImageColor3 = Color3.fromRGB(255, 255, 255),
				ScaleType = Enum.ScaleType.Stretch,
			}, {
				New("UICorner", { CornerRadius = UDim.new(0, cornerRadius or (isDesktop and 14 or 12)) })
			}))
		end
		return New("TextButton", btnProps, children)
	end
	if isMobile then
		holder = New("Frame", {
			Name = "FluentMinimizer",
			Parent = parentGui,
			Size = Config.Size or UDim2.fromOffset(36, 36),
			Position = Config.Position or UDim2.new(0.45, 0, 0.025, 0),
			BackgroundTransparency = 1,
			ZIndex = 999999999,
			Visible = (Config.Visible ~= false),
		})
	else
		holder = New("Frame", {
			Name = "FluentMinimizer",
			Parent = parentGui,
			Size = Config.Size or UDim2.fromOffset(36, 36),
			Position = Config.Position or UDim2.new(0, 300, 0, 20),
			BackgroundTransparency = 1,
			ZIndex = 999999999,
			Visible = (Config.Visible ~= false),
		})
	end
	if useAcrylic then
		local miniAcrylic = Acrylic.AcrylicPaint()
		miniAcrylic.Frame.Parent = holder
		miniAcrylic.Frame.Size = UDim2.fromScale(1, 1)
		pcall(function() miniAcrylic.AddParent(holder) end)
		local desiredCorner = UDim.new(0, cornerRadius or 0)
		pcall(function()
			for _, descendant in ipairs(miniAcrylic.Frame:GetDescendants()) do
				if descendant.ClassName == "UICorner" then
					descendant.CornerRadius = desiredCorner
				elseif descendant.ClassName == "ImageLabel" then
					descendant.Size = UDim2.fromScale(1, 1)
					descendant.Position = UDim2.new(0.5, 0, 0.5, 0)
					descendant.AnchorPoint = Vector2.new(0.5, 0.5)
				end
			end
		end)
		self.MinimizerAcrylic = miniAcrylic
	end
	local btnInstance = createButton(not isMobile)
	btnInstance.Parent = holder
	btnInstance.ZIndex = (holder.ZIndex or 0) + 1
	local button = holder:FindFirstChildOfClass("TextButton")
	if button then
		local isDragging = false
		if draggableWhole then
			local dragOffsetX, dragOffsetY = 0, 0
			Creator.AddSignal(button.InputBegan, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					isDragging = true
					dragOffsetX = Input.Position.X - holder.AbsolutePosition.X
					dragOffsetY = Input.Position.Y - holder.AbsolutePosition.Y
					local conn
					conn = Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							isDragging = false
							conn:Disconnect()
						end
					end)
				end
			end)
			Creator.AddSignal(UserInputService.InputChanged, function(Input)
				if isDragging and holder and holder.Parent and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
					local viewport = workspace.Camera.ViewportSize
					local size = holder.AbsoluteSize
					local newX = math.clamp(Input.Position.X - dragOffsetX, 0, viewport.X - size.X)
					local newY = math.clamp(Input.Position.Y - dragOffsetY, 0, viewport.Y - size.Y)
					holder.Position = UDim2.fromOffset(newX, newY)
				end
			end)
			Creator.AddSignal(UserInputService.InputEnded, function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					isDragging = false
				end
			end)
		end
		AddSignal(button.MouseButton1Click, function()
			task.wait(0.1)
			if not isDragging and Library.Window then
				Library.Window:Minimize()
			end
		end)
	end
	self.Minimizer = holder
	return holder
end
function Library:SetTheme(Value)
	if Library.Window and table.find(Library.Themes, Value) then
		Library.Theme = Value
		Creator.UpdateTheme()
	end
end
function Library:Destroy()
	if Library.Window then
		Library.Unloaded = true
		if Library.UseAcrylic then
			Library.Window.AcrylicPaint.Model:Destroy()
		end
		Creator.Disconnect()
		Library.GUI:Destroy()
	end
end
function Library:SetAcrylic(Value)
	if not Library.Window then return end
	Library.Acrylic = Value
	Library._blurEnabled = Value

	if Value and not Acrylic.Enable then
		Acrylic.init()
	end

	local paint = Library.Window.AcrylicPaint
	if not paint or not paint.Frame then return end

	if Value then
		if not paint.Model then
			local Blur = Acrylic.AcrylicBlur()
			Blur.Frame.Parent = paint.Frame
			paint.Model = Blur.Model
			paint.AddParent = Blur.AddParent
			paint.SetVisibility = Blur.SetVisibility
			paint.AddParent(Library.Window.Root)
		end
		if Acrylic.Enable then Acrylic.Enable() end
		local bg = paint.Frame:FindFirstChild("Background")
		for _, child in ipairs(paint.Frame:GetChildren()) do
			if child:IsA("Frame") or child:IsA("ImageLabel") then
				if child.Name ~= "Background" then
					child.Visible = true
				end
			end
		end
		if bg then
			bg.BackgroundTransparency = 0.45
		end
		if paint.Model then
			paint.Model.Transparency = 0.98
		end
	else
		if Acrylic.Disable then Acrylic.Disable() end
		local bg = paint.Frame:FindFirstChild("Background")
		for _, child in ipairs(paint.Frame:GetChildren()) do
			if child:IsA("ImageLabel") then
				if child.Name ~= "Background" then
					child.Visible = false
				end
			end
		end
		if bg then
			bg.BackgroundTransparency = 0
		end
		if paint.Model then
			paint.Model.Transparency = 1
		end
	end
end
function Library:SetTransparency(Value)
	if Library.Window then
		Library._transparencyEnabled = Value
		local paint = Library.Window.AcrylicPaint
		if not paint or not paint.Frame then return end
		local bg = paint.Frame:FindFirstChild("Background")
		if bg then
			if Value then
				bg.BackgroundTransparency = 0.35
			else
				bg.BackgroundTransparency = Library._blurEnabled and 0.45 or 0
			end
		end
	end
end
function Library:Notify(Config)
	return NotificationModule:New(Config)
end
if getgenv then
	getgenv().Fluent = Library
else
	Fluent = Library
end

return Library
