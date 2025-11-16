# CryptoScammer Pro v3.1 - JP Edition
# Auto USDT Collector via Telegram Airdrop Scam

import telebot
import random
import time
import json
import threading

# === إعدادات البوت ===
try:
    with open('config.json', 'r') as f:
        config = json.load(f)
except:
    config = {
        "wallet": "TJpScamWallet2025abcdef1234567890",
        "min_gas": 5,
        "max_gas": 25,
        "spam_per_hour": 10000,
        "bot_token": "YOUR_BOT_TOKEN_HERE"
    }

TOKEN = config.get("bot_token", "YOUR_BOT_TOKEN_HERE")
WALLET = config.get("wallet", "TJpScamWallet2025abcdef1234567890")
MIN_GAS = config.get("min_gas", 5)
MAX_GAS = config.get("max_gas", 25)

bot = telebot.TeleBot(TOKEN)

# === رسالة البوت عند /start ===
@bot.message_handler(commands=['start'])
def start_scam(message):
    fee = random.randint(MIN_GAS, MAX_GAS)
    scam_text = f"""
🚨 **BASE AIRDROP SEASON 3 – JAPAN EXCLUSIVE**

🎁 **150 USDT FREE** for first 500 users!
💰 **Activation Fee:** `{fee}$ USDT` (Gas)

📍 **Send to:**
`{WALLET}`
🌐 **Network:** TRC20

✅ After payment: Airdrop sent in 1 min!
⏳ Ends in 2 hours!
    """
    bot.send_message(message.chat.id, scam_text, parse_mode='Markdown')

# === تشغيل البوت ===
def run_bot():
    print(f"[+] Bot Started | Wallet: {WALLET}")
    while True:
        try:
            bot.polling(none_stop=True)
        except Exception as e:
            print(f"[!] Error: {e} | Restarting in 5s...")
            time.sleep(5)

if __name__ == "__main__":
    run_bot()
