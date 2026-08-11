import os
print("Current working directory:", os.getcwd())

import tkinter as tk
from tkinter import messagebox
from PIL import Image, ImageTk
import random

# -----------------------------
# Configuration
# -----------------------------
WORK_INTERVAL = 20 * 60      # 20 minutes
SNOOZE_INTERVAL = 10 * 60    # 10 minutes

# Base folder of this script (fixes System32 issue)
BASE = os.path.dirname(os.path.abspath(__file__))

STRETCH_IMAGES = [
    os.path.join(BASE, "pelvic_tilt.png"),
    os.path.join(BASE, "thoracic_rotation.png"),
    os.path.join(BASE, "hip_flexor_stretch.png"),
    os.path.join(BASE, "hamstring_stretch.png"),
    os.path.join(BASE, "gentle_extension.png")
]

EXERCISE_DESCRIPTIONS = {
    os.path.join(BASE, "pelvic_tilt.png"): "Gently rock your pelvis forward and backward to mobilize the lower back.",
    os.path.join(BASE, "thoracic_rotation.png"): "Rotate your upper body left and right to loosen the mid‑back.",
    os.path.join(BASE, "hip_flexor_stretch.png"): "Step one foot back and shift weight forward to stretch the front of the hip.",
    os.path.join(BASE, "hamstring_stretch.png"): "Extend one leg forward and hinge at the hips to stretch the hamstring.",
    os.path.join(BASE, "gentle_extension.png"): "Place hands on hips and lean slightly backward to extend the spine."
}

# -----------------------------
# GUI Application
# -----------------------------
class BreakReminderApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Posture & Break Reminder")

        self.remaining = WORK_INTERVAL
        self.snoozed = False
        self.timer_job = None

        # Timer label
        self.timer_label = tk.Label(root, text="", font=("Arial", 24))
        self.timer_label.pack(pady=10)

        # Image label
        self.image_label = tk.Label(root)
        self.image_label.pack(pady=10)

        # Description label
        self.description_label = tk.Label(
            root,
            text="",
            font=("Arial", 12),
            wraplength=400,
            justify="center"
        )
        self.description_label.pack(pady=5)

        # Buttons frame
        buttons_frame = tk.Frame(root)
        buttons_frame.pack(pady=10)

        self.snooze_button = tk.Button(buttons_frame, text="Snooze 10 min", command=self.snooze)
        self.snooze_button.pack(side="left", padx=20)

        self.done_button = tk.Button(buttons_frame, text="Done", command=self.reset_timer)
        self.done_button.pack(side="right", padx=20)

        # Start timer
        self.update_timer()

    def update_timer(self):
        # Cancel previous timer job if exists
        if self.timer_job is not None:
            self.root.after_cancel(self.timer_job)

        mins = self.remaining // 60
        secs = self.remaining % 60
        self.timer_label.config(text=f"{mins:02d}:{secs:02d}")

        if self.remaining > 0:
            self.remaining -= 1
            self.timer_job = self.root.after(1000, self.update_timer)
        else:
            self.show_break_window()

    def show_break_window(self):
        img_path = random.choice(STRETCH_IMAGES)

        # Load image
        try:
            img = Image.open(img_path)
            img = img.resize((300, 300))
            img = ImageTk.PhotoImage(img)
            self.image_label.config(image=img, text="")
            self.image_label.image = img
        except Exception:
            self.image_label.config(text="(Image not found)", image="")

        # Update description
        description = EXERCISE_DESCRIPTIONS.get(img_path, "")
        self.description_label.config(text=description)

        messagebox.showinfo("Break Time", "Time to sit up, move, and stretch!")

    def snooze(self):
        if not self.snoozed:
            self.snoozed = True
            self.remaining = SNOOZE_INTERVAL
            self.update_timer()
        else:
            messagebox.showinfo("Snooze limit", "You already used your snooze.")

    def reset_timer(self):
        self.remaining = WORK_INTERVAL
        self.snoozed = False
        self.update_timer()


# -----------------------------
# Run the app
# -----------------------------
if __name__ == "__main__":
    root = tk.Tk()
    app = BreakReminderApp(root)
    root.mainloop()