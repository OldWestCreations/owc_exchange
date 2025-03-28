local VorpCore = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()

Citizen.CreateThread(function()
    local PromptGroup_D2G = BccUtils.Prompts:SetupPromptGroup()
    local promptD2G = PromptGroup_D2G:RegisterPrompt(Config.Text.DollarToGoldPrompt, Config.Key, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})

    local PromptGroup_G2D = BccUtils.Prompts:SetupPromptGroup()
    local promptG2D = PromptGroup_G2D:RegisterPrompt(Config.Text.GoldToDollarPrompt, Config.Key, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})

    while true do
        Wait(1)
        local coords = GetEntityCoords(PlayerPedId())

        for _, loc in pairs(Config.DollarToGoldLocations) do
            if #(coords - loc) < 2.0 then
                PromptGroup_D2G:ShowGroup(Config.Text.DollarToGoldPrompt)
                if promptD2G:HasCompleted() then
                    OpenExchangeMenu("d_to_g")
                    Wait(2000)
                end
            end
        end

        for _, loc in pairs(Config.GoldToDollarLocations) do
            if #(coords - loc) < 2.0 then
                PromptGroup_G2D:ShowGroup(Config.Text.GoldToDollarPrompt)
                if promptG2D:HasCompleted() then
                    OpenExchangeMenu("g_to_d")
                    Wait(2000)
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
        button = "Bestätigen",
        placeholder = "Zahl eingeben",
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


