-- Main.lua
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
    Name = "Moon Hub v1.0",
    Icon = "moon",
    LoadingTitle = "Moon Hub",
    LoadingSubtitle = "Loading scripts...",
    Theme = "Amethyst",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MoonHub",
        FileName = "MoonConfig"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local PlayerTab = Window:CreateTab("Player", "user")
local CombatTab = Window:CreateTab("Combat", "swords")
local VisualTab = Window:CreateTab("Visual", "eye")
local WorldTab = Window:CreateTab("World", "globe")
local UtilityTab = Window:CreateTab("Utility", "settings")

local BASE_URL = "https://raw.githubusercontent.com/MoonRobloxx/MoonHub/main/Scripts/"
local searchRegistry = {}

local function registerScript(name, displayName, tabName, elements)
    table.insert(searchRegistry, {
        name = name,
        displayName = displayName,
        tabName = tabName,
        elements = elements,
        visible = true
    })
end

local searchInput = Window:CreateInput({
    Name = "Search Scripts",
    CurrentValue = "",
    PlaceholderText = "Type to search...",
    RemoveTextAfterFocusLost = false,
    Flag = "search_input",
    Callback = function(text)
        local q = text:lower()
        local matchedTabs = {}
        for _, script in ipairs(searchRegistry) do
            local searchText = (script.name .. " " .. script.displayName):lower()
            local match = (q == "") or searchText:find(q)
            script.visible = match
            if match then
                matchedTabs[script.tabName] = true
            end
            for _, element in pairs(script.elements) do
                if element and element.Visible ~= nil then
                    element.Visible = match
                elseif element and element.SetVisible then
                    element:SetVisible(match)
                end
            end
        end
        local matchCount = 0
        local lastMatch = nil
        for tabName, _ in pairs(matchedTabs) do
            matchCount = matchCount + 1
            lastMatch = tabName
        end
        if matchCount == 1 then
            -- auto switch to tab (not implemented, just note)
        end
    end,
})

local scripts = {
    Player = {
        "Player/WalkSpeed.lua",
        "Player/JumpPower.lua",
        "Player/Fly.lua",
        "Player/NoClip.lua",
        "Player/InfiniteJump.lua",
        "Player/GodMode.lua",
        "Player/Gravity.lua",
        "Player/SpinBot.lua",
        "Player/Freecam.lua",
        "Player/AntiAFK.lua",
        "Player/ClickTP.lua",
        "Player/AutoRespawn.lua",
        "Player/Invisible.lua",
        "Player/Freeze.lua",
        "Player/Fling.lua",
        "Player/LoopTP.lua",
        "Player/Sit.lua",
        "Player/VehicleFly.lua",
        "Player/AntiVoid.lua",
        "Player/BypassWalkSpeed.lua",
        "Player/RespawnOnDeath.lua",
        "Player/GlowCharacter.lua",
        "Player/Headless.lua",
        "Player/TinyArms.lua",
        "Player/RainbowCharacter.lua",
        "Player/Swim.lua",
        "Player/AutoRespawnOnSpot.lua",
        "Player/TeleportToNearest.lua",
        "Player/ResetCharacter.lua",
        "Player/CloneCharacter.lua",
    },
    Combat = {
        "Combat/Aimbot.lua",
        "Combat/SilentAim.lua",
        "Combat/HitboxExpander.lua",
        "Combat/KillAll.lua",
        "Combat/AutoAttack.lua",
        "Combat/TriggerBot.lua",
        "Combat/AutoBlock.lua",
        "Combat/OneShot.lua",
        "Combat/BackTrack.lua",
        "Combat/DodgeBot.lua",
        "Combat/ComboSpammer.lua",
        "Combat/KillAura.lua",
        "Combat/Reach.lua",
        "Combat/AntiStun.lua",
        "Combat/RapidFire.lua",
        "Combat/NoRecoil.lua",
        "Combat/NoSpread.lua",
        "Combat/BulletTP.lua",
        "Combat/AutoReload.lua",
        "Combat/InfiniteAmmo.lua",
        "Combat/WeaponMods.lua",
    },
    Visual = {
        "Visual/ESP.lua",
        "Visual/Tracers.lua",
        "Visual/Chams.lua",
        "Visual/Crosshair.lua",
        "Visual/FullBright.lua",
        "Visual/ThirdPerson.lua",
        "Visual/Zoom.lua",
        "Visual/NoFog.lua",
        "Visual/SkyboxChanger.lua",
        "Visual/NightMode.lua",
        "Visual/TimeChanger.lua",
        "Visual/BoxESP.lua",
        "Visual/NameESP.lua",
        "Visual/HealthESP.lua",
        "Visual/DistanceESP.lua",
        "Visual/WeaponESP.lua",
        "Visual/TeamESP.lua",
        "Visual/ColorChams.lua",
        "Visual/MaterialChams.lua",
        "Visual/OutlineESP.lua",
        "Visual/SkeletonESP.lua",
        "Visual/DrawFOV.lua",
        "Visual/Lighting.lua",
        "Visual/PlayerChams.lua",
        "Visual/NameTags.lua",
        "Visual/AmbientChanger.lua",
        "Visual/ShadowRemover.lua",
        "Visual/SunRays.lua",
        "Visual/BloomEffect.lua",
        "Visual/BlurEffect.lua",
        "Visual/ColorCorrection.lua",
        "Visual/DestroyVisuals.lua",
    },
    World = {
        "World/Teleports.lua",
        "World/CoordinateSaver.lua",
        "World/ServerHop.lua",
        "World/Rejoin.lua",
        "World/LowServerHop.lua",
        "World/AntiLag.lua",
        "World/FPSBooster.lua",
        "World/RemoveTerrain.lua",
        "World/RemoveWater.lua",
        "World/RemoveTrees.lua",
        "World/RemoveShadows.lua",
        "World/WeatherChanger.lua",
        "World/RemoveMapDecoration.lua",
        "World/DestroyMap.lua",
        "World/LowGraphics.lua",
        "World/StreamDistance.lua",
        "World/RemoveFog.lua",
        "World/RemoveSkybox.lua",
        "World/ClearWorkspace.lua",
        "World/RemoveBuildings.lua",
    },
    Utility = {
        "Utility/ConfigManager.lua",
        "Utility/AutoExecute.lua",
        "Utility/AutoReconnect.lua",
        "Utility/KeybindManager.lua",
        "Utility/ScriptExecutor.lua",
        "Utility/NotificationManager.lua",
        "Utility/FPSUnlocker.lua",
        "Utility/DiscordRPC.lua",
        "Utility/SpeedrunTimer.lua",
        "Utility/PlayerInfo.lua",
        "Utility/ScreenShotter.lua",
        "Utility/AutoScreenshot.lua",
        "Utility/MacroRecorder.lua",
        "Utility/ChatSpammer.lua",
        "Utility/AutoTypist.lua",
        "Utility/ClipboardManager.lua",
        "Utility/MemoryCleaner.lua",
        "Utility/QuickActions.lua",
        "Utility/FavoriteScripts.lua",
        "Utility/ScriptHistory.lua",
        "Utility/InfoPanel.lua",
    },
}

local function getDisplayName(path)
    local name = path:match("/([^/]+)%.lua$")
    if not name then return path end
    name = name:gsub("([A-Z])", " %1"):gsub("^ ", "")
    return name
end

for tabName, scriptList in pairs(scripts) do
    local tab
    if tabName == "Player" then tab = PlayerTab
    elseif tabName == "Combat" then tab = CombatTab
    elseif tabName == "Visual" then tab = VisualTab
    elseif tabName == "World" then tab = WorldTab
    elseif tabName == "Utility" then tab = UtilityTab
    end
    for _, scriptPath in ipairs(scriptList) do
        local url = BASE_URL .. scriptPath
        local success, module = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if success and type(module) == "function" then
            local elements = module(tab, Window)
            registerScript(scriptPath, getDisplayName(scriptPath), tabName, elements)
        else
            Rayfield:Notify({
                Title = "Error",
                Content = "Failed to load " .. scriptPath,
                Duration = 3
            })
        end
    end
end
