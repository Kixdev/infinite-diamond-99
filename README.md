# 💎 Visual Diamond System (Client-Only Simulation)

> **Educational Purposes Only – Open Source UI & Animation Reference**

---

## 📌 Overview

**Visual Diamond System** is a **client-side UI simulation system** that visually represents diamond changes **without modifying any server-side data**.

This project is intended for:
- UI / UX prototyping
- Reward preview & showcase
- Monetisation mockups
- Game advertisements & trailers
- Educational Roblox scripting references

❗ This script **does NOT** change real diamonds  
❗ No RemoteEvents are used  
❗ 100% client-only and safe  

---

## 🎯 Purpose

The main goals of this project are to:

- Demonstrate **professional UI simulation patterns**
- Teach **delta-based UI synchronisation**
- Prevent common UI bugs such as:
  - UI value resets
  - Desynchronisation
  - Sudden value jumps
- Provide **realistic visual feedback** similar to production-level games

---

## ✨ Features

### 🔹 Visual Add & Reduce
- Positive input → diamonds increase with smooth animation
- Negative input → diamonds decrease with smooth animation

```lua
_G.VisualAddDiamond(100)   -- Visual +100
_G.VisualAddDiamond(-50)   -- Visual -50
