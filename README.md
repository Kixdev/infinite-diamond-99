````md
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
````

---

### 🔹 Delta-Based Synchronisation (No Reset)

The system **never forces the UI to match the server value**.

Instead, it calculates the **difference (delta)**:

| Real Change     | Visual Result |
| --------------- | ------------- |
| Claim reward +5 | Visual +5     |
| Purchase −25    | Visual −25    |
| Respawn         | No reset      |

This avoids:

* UI snapping back to real values
* Animation glitches
* Desync issues

---

### 🔹 Anti-Spam & Animation Lock

The system uses a **global animation lock**:

* Only one animation can run at a time
* The RUN button cannot be spammed
* UI listeners do not stack

Result:

* No duplicate animations
* No sound overlap
* Stable visual behaviour

---

### 🔹 Client-Only Sound Feedback

* Diamond claim sound plays locally
* Uses `SoundService`
* No server interaction

Sound is played only for **manual visual additions**.

---

## 🧠 System Architecture

### Core State Variables

```lua
visualBalance     -- current simulated value
lastRealBalance   -- last observed real value
busy              -- animation lock
ignoreNextReal    -- prevents double triggers
```

### UI Listener

```lua
diamondLabel:GetPropertyChangedSignal("Text")
```

Used to:

* Detect real reward claims
* Detect real spending
* Apply delta-based visual updates only

---

## 🖥️ GUI

### GUI Features

* Floating tool window
* Minimal, clean design
* Numeric input (+ / −)
* RUN button for simulation

The GUI is **optional**.
The system can be used entirely via the API.

---

## 🚀 Usage

### Script Placement

Use as a **LocalScript** in one of the following:
* `StarterPlayerScripts`
* `PlayerGui`
* Executor (testing only)

---

### Using the GUI

1. Enter a number:

   * `1000` → add visually
   * `-250` → reduce visually
2. Click **RUN**
3. Observe the animation and effects

---

### Using the API

```lua
_G.VisualAddDiamond(500)
_G.VisualAddDiamond(-100)

---

## ⚠️ Disclaimer
**Educational Purposes Only**
This project is **not** a cheat, exploit, or bypass.

Do **NOT** use it to:
* Mislead players
* Fake rewards
* Manipulate live game economies

Use it only for:
* Learning
* Prototyping
* UI demonstrations
