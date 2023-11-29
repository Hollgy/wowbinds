local _, u = ...

-- https://wowpedia.fandom.com/wiki/BindingID
local myBinds = {
    -- Movement
    ["A"] = "STRAFELEFT",
    ["D"] = "STRAFERIGHT",

    -- Character and bag toggles, since c and b are used for strafing
    ["F1"] = "OPENALLBAGS",
    ["F2"] = "TOGGLECHARACTER0",

    -- Action Bar 1
    ["1"] = "ACTIONBUTTON1",
    ["2"] = "ACTIONBUTTON2",
    ["3"] = "ACTIONBUTTON3",
    ["4"] = "ACTIONBUTTON4",
    ["5"] = "ACTIONBUTTON5",
    ["6"] = "ACTIONBUTTON6",
    ["SHIFT-1"] = "ACTIONBUTTON7",
    ["SHIFT-2"] = "ACTIONBUTTON8",
    ["SHIFT-3"] = "ACTIONBUTTON9",
    ["SHIFT-4"] = "ACTIONBUTTON10",
    ["SHIFT-5"] = "ACTIONBUTTON11",
    ["SHIFT-6"] = "ACTIONBUTTON12",

    -- Action Bar 2
    ["BUTTON5"] = "MULTIACTIONBAR1BUTTON1",
    ["BUTTON4"] = "MULTIACTIONBAR1BUTTON2",
    ["SHIFT-BUTTON5"] = "MULTIACTIONBAR1BUTTON3",
    ["SHIFT-BUTTON4"] = "MULTIACTIONBAR1BUTTON4",
    ["CTRL-BUTTON5"] = "MULTIACTIONBAR1BUTTON5",
    ["CTRL-BUTTON4"] = "MULTIACTIONBAR1BUTTON6",
    ["BUTTON3"] = "MULTIACTIONBAR1BUTTON7",
    ["SHIFT-BUTTON3"] = "MULTIACTIONBAR1BUTTON8",
    ["CTRL-BUTTON3"] = "MULTIACTIONBAR1BUTTON9",
    ["§"] = "MULTIACTIONBAR1BUTTON10",
    ["SHIFT-§"] = "MULTIACTIONBAR1BUTTON11",
    ["CTRL-§"] = "MULTIACTIONBAR1BUTTON12",

    -- Action Bar 3
    ["Q"] = "MULTIACTIONBAR2BUTTON1",
    ["E"] = "MULTIACTIONBAR2BUTTON2",
    ["R"] = "MULTIACTIONBAR2BUTTON3",
    ["T"] = "MULTIACTIONBAR2BUTTON4",
    ["F"] = "MULTIACTIONBAR2BUTTON5",
    ["G"] = "MULTIACTIONBAR2BUTTON6",
    ["SHIFT-Q"] = "MULTIACTIONBAR2BUTTON7",
    ["SHIFT-E"] = "MULTIACTIONBAR2BUTTON8",
    ["SHIFT-R"] = "MULTIACTIONBAR2BUTTON9",
    ["SHIFT-T"] = "MULTIACTIONBAR2BUTTON10",
    ["SHIFT-F"] = "MULTIACTIONBAR2BUTTON11",
    ["SHIFT-G"] = "MULTIACTIONBAR2BUTTON12",

    -- Action Bar 4
    ["S"] = "MULTIACTIONBAR3BUTTON1",
    ["Z"] = "MULTIACTIONBAR3BUTTON2",
    ["X"] = "MULTIACTIONBAR3BUTTON3",
    ["C"] = "MULTIACTIONBAR3BUTTON4",
    ["V"] = "MULTIACTIONBAR3BUTTON5",
    ["B"] = "MULTIACTIONBAR3BUTTON6",
    ["SHIFT-S"] = "MULTIACTIONBAR3BUTTON7",
    ["SHIFT-Z"] = "MULTIACTIONBAR3BUTTON8",
    ["SHIFT-X"] = "MULTIACTIONBAR3BUTTON9",
    ["SHIFT-C"] = "MULTIACTIONBAR3BUTTON10",
    ["SHIFT-V"] = "MULTIACTIONBAR3BUTTON11",
    ["SHIFT-B"] = "MULTIACTIONBAR3BUTTON12",

    -- Action Bar 5
    ["CTRL-Q"] = "MULTIACTIONBAR4BUTTON1",
    ["CTRL-E"] = "MULTIACTIONBAR4BUTTON2",
    ["CTRL-R"] = "MULTIACTIONBAR4BUTTON3",
    ["CTRL-T"] = "MULTIACTIONBAR4BUTTON4",
    ["CTRL-F"] = "MULTIACTIONBAR4BUTTON5",
    ["CTRL-G"] = "MULTIACTIONBAR4BUTTON6",
    ["CTRL-1"] = "MULTIACTIONBAR4BUTTON7",
    ["CTRL-2"] = "MULTIACTIONBAR4BUTTON8",
    ["CTRL-3"] = "MULTIACTIONBAR4BUTTON9",
    ["CTRL-4"] = "MULTIACTIONBAR4BUTTON10",
    ["CTRL-5"] = "MULTIACTIONBAR4BUTTON11",
    ["CTRL-6"] = "MULTIACTIONBAR4BUTTON12",
}

local cameraBinds = {
    -- Remove zoom from mousewheel
    ["-"] = "CAMERAZOOMOUT",
    ["+"] = "CAMERAZOOMIN",

    ["MOUSEWHEELUP"] = "STARTAUTORUN",
    ["MOUSEWHEELDOWN"] = "FOLLOWTARGET",
}

-- Unsets a binding, if it exists
local function unsetBinding(action)
    local key1, key2 = GetBindingKey(action);
    if key1 then
        SetBinding(key1, nil);
    end
    if key2 then
        SetBinding(key2, nil);
    end
end

-- Same as SetBinding, but removes the old binding first
local function setBindingRM(key, action)
    unsetBinding(action);
    if SetBinding(key, action) then
        u.success(key .. " -> " .. action);
    else
        u.error("Failed to set binding " .. key .. " to " .. action);
    end
end

local function applyBindingSet(set)
    for key, action in pairs(set) do
        setBindingRM(key, action)
    end
    u.info("Bindings set!")
    u.warn("Dont forget to reload your UI.")
end

local function enableBars()
    SetActionBarToggles(1, 1, 1, 1);
    SHOW_MULTI_ACTIONBAR_1 = 1 --Bottom Left Bar
    SHOW_MULTI_ACTIONBAR_2 = 1 --Bottom Right Bar
    SHOW_MULTI_ACTIONBAR_3 = 1 --Right Bar
    SHOW_MULTI_ACTIONBAR_4 = 1 --Right Bar 2
    MultiActionBar_Update();
    SetCVar("alwaysShowActionBars", 1);
    SetCVar("lockActionBars", 1);
    SetCVar("countdownForCooldowns", 1);
    SetCVar("cameraDistanceMaxZoomFactor", 2);
    SetCVar("instantQuestText", 1);
    SetCVar("nameplateShowAll", 1);
    SetCVar("nameplateShowEnemies", 1);
    SetCVar("nameplateMaxDistance", 35);
    SetCVar("enableFloatingCombatText", 1);
end

local function BindsHandler(msg, editbox)
    u.guards()
    if msg == "" then
        applyBindingSet(myBinds)
        enableBars()
    end
    if msg == "camera" then
        applyBindingSet(cameraBinds)
    end
    SaveBindings(1)
    u.guards()
end

-- Register the /hello command
SLASH_BINDS1 = "/binds"
SlashCmdList["BINDS"] = BindsHandler
