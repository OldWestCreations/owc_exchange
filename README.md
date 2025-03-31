# 💱 OWC Currency Exchange

A simple and configurable currency exchange script for **RedM (VorpCore)**.  
Convert Dollars to Gold and vice versa using prompts and UI inputs at multiple locations.

![Framework](https://img.shields.io/badge/Framework-VorpCore-blue?style=flat-square)
![UI](https://img.shields.io/badge/UI-vorp_inputs-orange?style=flat-square)
![Performance](https://img.shields.io/badge/Performance-Optimized-green?style=flat-square)
![Webhook](https://img.shields.io/badge/Webhook-Supported-purple?style=flat-square)

---

## ✨ Features

- 🔁 Two-way conversion: **Dollar ↔ Gold**
- 📍 Supports **multiple exchange locations**
- 🎮 `G` key prompt interaction via **vorp_utils**
- 🧾 Clean input interface using **vorp_inputs**
- 🌍 Fully translatable (`config.lua`)
- 📡 Optional **Discord webhook logging** with rich details
- 🔐 Only compatible with **VorpCore**

---

## ⚙️ Dependencies

- [vorp_core](https://github.com/VORPCORE/VORP-Core)
- [vorp_inputs](https://github.com/VORPCORE/vorp_inputs)
- [vorp_utils](https://github.com/VORPCORE/vorp_utils)

---

## 🛠️ Installation

1. Download or clone this repository:
   ```bash
   git clone https://github.com/OldWestCreations/owc_exchange.git
   ```

2. Add the resource to your `server.cfg` **in the correct order**:
   ```cfg
   ensure vorp_core
   ensure vorp_inputs
   ensure vorp_utils
   ensure owc_currencyexchange
   ```

3. Open `config.lua` and adjust exchange rates, locations, and webhook settings.

---

## 🔧 Configuration Example

```lua
Config.DollarToGoldLocations = {
    vector3(-3664.110, -2626.564, -13.588),
    vector3(250.0, 1000.0, 125.0)
}

Config.GoldToDollarLocations = {
    vector3(-3668.456, -2626.604, -13.588)
}

Config.ExchangeRate = {
    DollarToGold = 10.0, -- 1$ = 10 Gold
    GoldToDollar = 10.0  -- 1 Gold = 10$
}

Config.Key = 0x760A9C6F -- G
```

---

## 📡 Webhook Logging (Optional)

You can log each exchange to a Discord webhook for staff review or statistics.

```lua
Config.Webhook = {
    Enabled = true,
    Url = "https://discord.com/api/webhooks/...",
    Title = "Currency Exchange",
    Color = 16753920,
    Name = "ExchangeBot",
    Logo = "",
    FooterLogo = "",
    Avatar = ""
}
```

Logged data includes:
- Player name
- Steam ID
- Direction (Dollar → Gold or vice versa)
- Amount exchanged
- Exchange rate
- Balances after transaction

---

## 🧠 How It Works

- Walk up to a configured location
- Press `G` to trigger the exchange prompt
- Enter the amount you want to convert
- The system checks your balance, processes the exchange, and (optionally) sends a webhook log

---

## 📃 License

This resource is licensed for **personal or server use only** unless otherwise noted.  
Feel free to modify it to suit your needs — but do not resell.

---

## 🙌 Credits

- Script by [HerrScaletta]
- Special thanks to VORP and Outsider

---

## 💬 Support

Need help or want custom features?  
Open an issue or contact me on Discord: `herrscaletta`
