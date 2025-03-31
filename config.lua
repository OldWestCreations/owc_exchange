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
    PromptGroupLabel = "Currency Exchange",
    InputDollarToGold = "How many Dollars do you want to exchange?",
    InputGoldToDollar = "How much Gold do you want to exchange?",
    InvalidAmount = "Please enter a valid number.",
    SuccessExchange = "Exchange successful!",
    NotEnoughCurrency = "You don’t have enough currency for this."
}

Config.Webhook = {
    Enabled = true,
    Url = "https://discord.com/api/webhooks/1355078316889083904/CbjknDyv4Fy0ArGDLmxSrszufdsPXN5M7JpDhAr2U2MH-DL7K6R4s_4QpuN0JEXwtMN3",
    Title = "Currency Exchange", -- name of webhook
    Color = 16753920, -- ex. yellow-orange
    Name = "OWC Currency Exchange",
    Logo = "https://files.catbox.moe/bvrehi.png",         -- optional: big logo
    FooterLogo = "https://files.catbox.moe/bvrehi.png",   -- optional: small logo in footer
    Avatar = "https://files.catbox.moe/bvrehi.png"        -- optional: bot-avatar
}