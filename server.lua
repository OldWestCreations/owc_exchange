local Core = exports.vorp_core:GetCore()

RegisterServerEvent("owc_exchange:convert")
AddEventHandler("owc_exchange:convert", function(direction, amount)
    local src = source
    local User = Core.getUser(src)
    if not User then return end

    local Character = User.getUsedCharacter
    if not Character then return end

    amount = tonumber(amount)
    if not amount or amount <= 0 then return end

    local money = Character.money or 0
    local gold = Character.gold or 0

    print("[WÄHRUNGSTAUSCH] Spieler: "..src.." | Richtung: "..direction.." | Betrag: "..amount)
    print("[Kontostand] Dollar: "..money.." | Gold: "..gold)

    local directionText, exchangeRate, success = "", 0, false

    if direction == "d_to_g" then
        local cost = amount
        local gain = amount * Config.ExchangeRate.DollarToGold
        directionText = "Dollar → Gold"
        exchangeRate = Config.ExchangeRate.DollarToGold

        if money >= cost then
            TriggerEvent("vorp:removeMoney", src, 0, cost)
            TriggerEvent("vorp:addMoney", src, 1, gain)
            TriggerClientEvent("vorp:TipBottom", src, Config.Text.SuccessExchange, 3000)
            success = true
        else
            TriggerClientEvent("vorp:TipBottom", src, Config.Text.NotEnoughCurrency, 3000)
        end

    elseif direction == "g_to_d" then
        local cost = amount
        local gain = amount * Config.ExchangeRate.GoldToDollar
        directionText = "Gold → Dollar"
        exchangeRate = Config.ExchangeRate.GoldToDollar

        if gold >= cost then
            TriggerEvent("vorp:removeMoney", src, 1, cost)
            TriggerEvent("vorp:addMoney", src, 0, gain)
            TriggerClientEvent("vorp:TipBottom", src, Config.Text.SuccessExchange, 3000)
            success = true
        else
            TriggerClientEvent("vorp:TipBottom", src, Config.Text.NotEnoughCurrency, 3000)
        end
    end

    if success and Config.Webhook and Config.Webhook.Enabled and Core.AddWebhook then
        local playerName = GetPlayerName(src) or "Unknown"
        local identifiers = GetPlayerIdentifiers(src)
        local steamIdentifier = "Not found"

        for _, id in ipairs(identifiers) do
            if string.sub(id, 1, 6) == "steam:" then
                steamIdentifier = id
                break
            end
        end

        local moneyAfter = Character.money or 0
        local goldAfter = Character.gold or 0

        local description = string.format([[
**Player:** %s  
**Steam ID:** %s  
**Exchange Type:** %s  
**Amount Exchanged:** %s  
**Exchange Rate:** %s  
**Dollar Balance After:** %.2f  
**Gold Balance After:** %.2f
]],
            playerName,
            steamIdentifier,
            directionText,
            amount,
            exchangeRate,
            moneyAfter,
            goldAfter
        )

        Core.AddWebhook(
            Config.Webhook.Title or "Currency Exchange",
            Config.Webhook.Url or "",
            description,
            Config.Webhook.Color or 16753920,
            Config.Webhook.Name or "owc_exchange",
            Config.Webhook.Logo or "",
            Config.Webhook.FooterLogo or "",
            Config.Webhook.Avatar or ""
        )
    end
end)
