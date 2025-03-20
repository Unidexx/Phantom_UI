-- Phantom UI Script for Roblox DOORS

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local flying = false
local noclip = false
local godMode = false
local dragging, dragInput, dragStart, startPos

-- Create UI Elements
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local FirstFrame = Instance.new("Frame", ScreenGui)
local SecondFrame = Instance.new("Frame", ScreenGui)

-- Frame Properties
FirstFrame.Size = UDim2.new(0, 400, 0, 300)
FirstFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
FirstFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FirstFrame.BorderSizePixel = 0
FirstFrame.Visible = true
FirstFrame.Active = true
FirstFrame.Draggable = true
FirstFrame.ClipsDescendants = true

SecondFrame.Size = UDim2.new(0, 400, 0, 300)
SecondFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
SecondFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SecondFrame.BorderSizePixel = 0
SecondFrame.Visible = false
SecondFrame.Active = true
SecondFrame.Draggable = true
SecondFrame.ClipsDescendants = true

-- Create Buttons
local ContinueButton = Instance.new("TextButton", FirstFrame)
ContinueButton.Size = UDim2.new(0, 200, 0, 50)
ContinueButton.Position = UDim2.new(0.5, -100, 0.8, 0)
ContinueButton.Text = "Continue"
ContinueButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local UsernameInput = Instance.new("TextBox", SecondFrame)
UsernameInput.Size = UDim2.new(0, 150, 0, 40)
UsernameInput.Position = UDim2.new(0.1, 0, 0.1, 0)
UsernameInput.PlaceholderText = "Enter username"
UsernameInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UsernameInput.TextColor3 = Color3.fromRGB(0, 0, 0)

local FlyButton = Instance.new("TextButton", SecondFrame)
FlyButton.Size = UDim2.new(0, 150, 0, 50)
FlyButton.Position = UDim2.new(0.1, 0, 0.2, 0)
FlyButton.Text = "Fly"
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.MouseButton1Click:Connect(function()
    toggleFly()
end)

local NoclipButton = Instance.new("TextButton", SecondFrame)
NoclipButton.Size = UDim2.new(0, 150, 0, 50)
NoclipButton.Position = UDim2.new(0.1, 0, 0.35, 0)
NoclipButton.Text = "Noclip"
NoclipButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.MouseButton1Click:Connect(function()
    toggleNoclip()
end)

local GodModeButton = Instance.new("TextButton", SecondFrame)
GodModeButton.Size = UDim2.new(0, 150, 0, 50)
GodModeButton.Position = UDim2.new(0.1, 0, 0.5, 0)
GodModeButton.Text = "God Mode"
GodModeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GodModeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GodModeButton.MouseButton1Click:Connect(function()
    toggleGodMode()
end)

local FlingButton = Instance.new("TextButton", SecondFrame)
FlingButton.Size = UDim2.new(0, 150, 0, 50)
FlingButton.Position = UDim2.new(0.1, 0, 0.65, 0)
FlingButton.Text = "Fling"
FlingButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FlingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingButton.MouseButton1Click:Connect(function()
    toggleFling(UsernameInput.Text)
end)

-- Function for Noclip
toggleNoclip = function()
    noclip = not noclip
    while noclip do
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
        RunService.Stepped:Wait()
    end
    for _, v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = true
        end
    end
end

-- Function for God Mode
toggleGodMode = function()
    godMode = not godMode
    local humanoid = Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    end
end

-- Fly Function
toggleFly = function()
    flying = not flying
    while flying do
        HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
        RunService.Heartbeat:Wait()
    end
end

-- Function for Fling
toggleFling = function(targetName)
    local targetPlayer = Players:FindFirstChild(targetName)
    if targetPlayer and targetPlayer.Character then
        local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
        if targetRoot then
            targetRoot.Velocity = Vector3.new(0, 500, 0)
        end
    else
        HumanoidRootPart.Velocity = Vector3.new(0, 500, 0)
    end
end

-- Toggle Screens on Continue
ContinueButton.MouseButton1Click:Connect(function()
    FirstFrame.Visible = false
    SecondFrame.Visible = true
end)

print("Psst! I just wanted to say... Thanks for using!")
