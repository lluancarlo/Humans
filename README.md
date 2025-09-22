# Humans! Prototype – Godot 4.5

This project is a **small prototype of life simulation game**, built with the [Godot Engine 4.5](https://godotengine.org/).  
It demonstrates the **basic core mechanics of life simulation games**:

- **Move camera** with **W**-**A**-**S**-**D** 
- **Rotate camera** with **Q** and **E** Hold **SCROLL MOUSE BUTTON**
- **Zoom camera** with **SCROLL MOUSE BUTTON**
- **Select human** with **LEFT CLICK** and do a command with **RIGHT CLICK**

---

## 🎮 Features
- Simple unit selection system  
- Simple navigation system 
- Click-to-move mechanics on a 3D grid
- Minimal and modular design, intended for learning and prototyping  

---

## 🛠️ Requirements
- [Godot Engine 4.5](https://godotengine.org/download)  
- Any OS supported by Godot (Windows, Linux, macOS)  

---

## 🚀 Getting Started
1. Clone or download this repository:
   ```bash
   git clone https://github.com/lluancarlo/humans.git
   ```
2. Open **Godot 4.5**  
3. Click **Import Project** and select the `project.godot` file  
4. Run the project (F5)  

---

## 🎮 Controls
| Action        | Key / Mouse             |
|---------------|-------------------------|
| Move Camera   | **W**-**A**-**S**-**D** |
| Rotate Camera | **Q** and **E** / Hold **Scroll Mouse Button**  |
| Zoom Camera   | **Scroll Mouse Button** |
| Select Human  | **Left Mouse Button**   |
| Command Human | **Right Mouse Button**  |

---

## 📂 Project Structure
```
res://
│── project.godot       # Godot project file
│── main.tscn           # Main scene
│── Assets/             # Placeholder art, icons, etc.
│── Character/          # Characters and npcs
│── Components/         # Components that works alone, blocks of behaviour
│── Controllers/        # Core features, suck as mouse or camera controller
│── Globals/         	# Scripts that are static
└── Materials/          # Materials for MeshInstance3Ds
```

---

## 📌 Notes
- This is a **learning prototype**, not a full game  
- The project is intended as a **foundation for expanding** into a proper game  

---

## 📜 License
This project is released under the **MIT License**.  
You are free to use, modify, and distribute it.
