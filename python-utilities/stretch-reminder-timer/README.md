# Break Reminder (Python)
A lightweight Python desktop utility that helps reduce back stiffness during long coding or desk‑work sessions. The app runs a work timer, reminds you to stand up and stretch, and displays a random posture with an image and short description.

This project is part of my Python learning journey and was inspired by experiencing back pain after extended coding sessions. Building a small ergonomic assistant felt like a practical way to apply new skills while improving daily habits.

---

## Features

- Customizable work interval  
- Pop‑up reminder using Tkinter  
- Random stretch image displayed in the GUI  
- Short description of each posture  
- 30‑minute snooze option  
- Lightweight and easy to run locally  

---

## How It Works

- The script starts a countdown timer when launched.  
- When the timer reaches zero, a Tkinter pop‑up appears.  
- A random stretch image is shown along with a short explanation.  
- You can snooze the reminder for 30 minutes or reset the timer.  

---

## Assets

All stretch images used in this project were AI‑generated specifically for this application.

Place the images in the same folder as `break\_reminder.py`.

---

## Requirements

- Python 3.x  
- Pillow (`pip install pillow`)  

Tkinter is included with most standard Python installations.

---

## Future Improvements

- Configurable timer duration  
- System tray integration  
- Logging daily sitting/standing time  
- A simple GUI for configuration
