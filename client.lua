local Core = exports.vorp_core:GetCore()

local function SetupPromptGroup()
    local GroupsClass = {}
    GroupsClass.PromptGroup = GetRandomIntInRange(0, 0xffffff)

    function GroupsClass:ShowGroup(text)
        PromptSetActiveGroupThisFrame(self.PromptGroup, CreateVarString(10, 'LITERAL_STRING', text or "Interaction"))
    end

    function GroupsClass:RegisterPrompt(title, button, enabled, visible, pulsing, mode, options)
        local PromptClass = {}
        PromptClass.Prompt = PromptRegisterBegin()
        PromptClass.Mode = mode

        PromptSetControlAction(PromptClass.Prompt, button or 0x4CC0E2FE)
        PromptSetText(PromptClass.Prompt, CreateVarString(10, 'LITERAL_STRING', title or "Prompt"))
        PromptSetEnabled(PromptClass.Prompt, enabled ~= false)
        PromptSetVisible(PromptClass.Prompt, visible ~= false)

        if mode == "click" then
            PromptSetStandardMode(PromptClass.Prompt, 1)
        elseif mode == "hold" then
            Citizen.InvokeNative(0x74C7D7B72ED0D3CF, PromptClass.Prompt, options and options.timedeventhash or 'MEDIUM_TIMED_EVENT')
        elseif mode == "customhold" then
            Citizen.InvokeNative(0x94073D5CA3F16B7B, PromptClass.Prompt, options and options.holdtime or 3000)
        end

        PromptSetGroup(PromptClass.Prompt, self.PromptGroup)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C, PromptClass.Prompt, pulsing ~= false)
        PromptRegisterEnd(PromptClass.Prompt)

        function PromptClass:HasCompleted()
            if self.Mode == "click" then
                return Citizen.InvokeNative(0xC92AC953F0A982AE, self.Prompt)
            elseif self.Mode == "hold" or self.Mode == "customhold" then
                local result = Citizen.InvokeNative(0xE0F65F0640EF0617, self.Prompt)
                if result then Wait(500) end
                return result
            end
            return false
        end

        return PromptClass
    end

    return GroupsClass
end

local PromptGroup_D2G = SetupPromptGroup()
local PromptGroup_G2D = SetupPromptGroup()

local promptKey = Config.Key or 0x760A9C6F -- G

local promptD2G = PromptGroup_D2G:RegisterPrompt(Config.Text.DollarToGoldPrompt, promptKey, true, true, true, "click")
local promptG2D = PromptGroup_G2D:RegisterPrompt(Config.Text.GoldToDollarPrompt, promptKey, true, true, true, "click")

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(PlayerPedId())

        local foundPrompt = false

        for _, loc in pairs(Config.DollarToGoldLocations) do
            if #(coords - loc) < 2.0 then
                PromptGroup_D2G:ShowGroup(Config.Text.PromptGroupLabel or "Currency Exchange")
                if promptD2G:HasCompleted() then
                    OpenExchangeMenu("d_to_g")
                    Wait(1000)
                end
                foundPrompt = true
                break
            end
        end

        if not foundPrompt then
            for _, loc in pairs(Config.GoldToDollarLocations) do
                if #(coords - loc) < 2.0 then
                    PromptGroup_G2D:ShowGroup(Config.Text.PromptGroupLabel or "Currency Exchange")
                    if promptG2D:HasCompleted() then
                        OpenExchangeMenu("g_to_d")
                        Wait(1000)
                    end
                    break
                end
            end
        end
    end
end)

function OpenExchangeMenu(mode)
    local label = (mode == "d_to_g") and Config.Text.InputDollarToGold or Config.Text.InputGoldToDollar

    local inputData = {
        type = "enableinput",
        inputType = "input",
        button = "Confirm",
        placeholder = "Enter amount",
        style = "block",
        attributes = {
            inputHeader = label,
            type = "text",
            pattern = "[0-9]+",
            title = Config.Text.InvalidAmount,
            style = "border-radius: 10px;"
        }
    }

    Citizen.CreateThread(function()
        local result = exports.vorp_inputs:advancedInput(inputData)
        local amount = tonumber(result)
        if amount and amount > 0 then
            TriggerServerEvent("owc_exchange:convert", mode, amount)
        else
            TriggerEvent("vorp:TipBottom", Config.Text.InvalidAmount, 3000)
        end
    end)
end
