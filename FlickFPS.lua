-- WIND UI BASE
local WindUI
do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
    
    if ok then
        WindUI = result
    else 
        WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua"))()
    end
end

WindUI:Popup({
    Title = "LuisCheats",
    Icon = "bird",
    Content = "Carregado com sucesso!",
    Buttons = {
        { Title = "OK", Icon = "bird" }
    }
})



local Window = WindUI:CreateWindow({
    Title = "LuisCheats | FpsFlick  [BETA]",
    Author = "by LuisCheats",
    Folder = "LuisCheats",

    Icon = "rbxassetid://125600615912955",
    IconSize = 50,

    HideSearchBar = true,

    OpenButton = {
        Title = "Open LuisCheats",
        CornerRadius = UDim.new(1,0),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true
    }
})

-----------------------------------------------------
-- //////////////////// TAB COMBAT ////////////////////
-----------------------------------------------------

local CombatTab = Window:Tab({
    Title = "Combat",
    Icon = "sword"
})

-- AIMBOT SUAVE
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local AimbotEnabled = false
local AimConnection

-- fuerza del aimbot (MENOR = más suave)
local AimStrength = 0.08 -- recomendado entre 0.05 y 0.12

-- obtener jugador más cercano al cursor
local function GetClosestTarget()
    local closestPart = nil
    local shortestDistance = math.huge
    local mousePos = UserInputService:GetMouseLocation()

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)

            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPart = head
                end
            end
        end
    end

    return closestPart
end

-- TOGGLE AIMBOT
CombatTab:Toggle({
    Title = "Aimbot (Soft)",
    Callback = function(state)
        AimbotEnabled = state

        if state then
            AimConnection = RunService.RenderStepped:Connect(function()
                local target = GetClosestTarget()
                if target then
                    local currentCF = Camera.CFrame
                    local targetCF = CFrame.new(currentCF.Position, target.Position)

                    -- suavizado
                    Camera.CFrame = currentCF:Lerp(targetCF, AimStrength)
                end
            end)
        else
            if AimConnection then
                AimConnection:Disconnect()
                AimConnection = nil
            end
        end
    end
})


CombatTab:Button({
    Title = "Coming soon...",
    Locked = true
})

-----------------------------------------------------
-- //////////////////// TAB FPS //////////////////////
-----------------------------------------------------

local FPSTab = Window:Tab({
    Title = "FPS",
    Icon = "gauge"
})

FPSTab:Button({
    Title = "FPS Boost",
    Color = Color3.fromHex("#00ff00"),
    Callback = function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("BasePart") then v.Material = Enum.Material.SmoothPlastic end
            if v:IsA("Decal") or v:IsA("Texture") then v.Transparency = 1 end
        end
        setfpscap(240)
    end
})

FPSTab:Button({ Title = "Coming soon...", Locked = true })
FPSTab:Button({ Title = "Coming soon...", Locked = true })

-----------------------------------------------------
-- //////////////////// TAB MISC /////////////////////
-----------------------------------------------------

local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "boxes"
})

MiscTab:Button({
    Title = "Infinite Yield",
    Color = Color3.fromHex("#305dff"),
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

-----------------------------------------------------
-- //////////////////// TAB UPDATE ///////////////////
-----------------------------------------------------

local UpdateTab = Window:Tab({
    Title = "Update",
    Icon = "Update"
})

UpdateTab:Button({
    Title = "shows update ",
    Icon = "doc.text",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuisCheats/LuisCheats/refs/heads/main/info.lua"))()
    end
   
})


-----------------------------------------------------
-- ////////////////// TAB CREDITS ///////////////////
-----------------------------------------------------

local CreditsTab = Window:Tab({
    Title = "Credits",
    Icon = "star"
})

CreditsTab:Button({
    Title = "Copy Discord Invite",
    Icon = "clipboard",
    Callback = function()
        setclipboard("https://discord.gg/TU_INVITE")
    end
})
