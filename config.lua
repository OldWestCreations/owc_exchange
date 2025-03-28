Config = {}

Config.DollarToGoldLocations = {
    vector3(-3664.110, -2626.564, -13.588), -- armadillo
}

Config.GoldToDollarLocations = {
    vector3(-3668.456, -2626.604, -13.588), -- armadillo
}

Config.Key = 0x760A9C6F -- G

Config.ExchangeRate = {
    DollarToGold = 10.00,     -- 1 Dollar = 10 Gold
    GoldToDollar = 0.10       -- 1 Gold = 0.10 Dollar
}

Config.Text = {
    DollarToGoldPrompt = "Exchange Dollar to Gold",
    GoldToDollarPrompt = "Exchange Gold to Dollar",
    InputTitle = "Currency Exchange",
    InputDollarToGold = "How many Dollars would you like to exchange?",
    InputGoldToDollar = "How many Gold would you like to exchange?",
    NotEnoughCurrency = "You don't have enough money for this.",
    SuccessExchange = "Exchange successful!",
    InvalidAmount = "Invalid amount.",    
}

Config.Webhook = {
    Enabled = true,
    Url = "YOUR_DISCORD_WEBHOOK",
    Title = "Currency Exchange", -- name of webhook
    Color = 16753920, -- ex. yellow-orange
    Name = "OWC Currency Exchange",
    Logo = "https://files.catbox.moe/bvrehi.png",         -- optional: big logo
    FooterLogo = "https://files.catbox.moe/bvrehi.png",   -- optional: small logo in footer
    Avatar = "https://files.catbox.moe/bvrehi.png"        -- optional: bot-avatar
}
