# terminal_emulator.py
import os
import sys
import platform

# Enable ANSI support on Windows
if platform.system() == "Windows":
    try:
        import ctypes
        kernel32 = ctypes.windll.kernel32
        kernel32.SetConsoleMode(kernel32.GetStdHandle(-11), 7)
    except:
        pass

RESET = "\033[0m"
BOLD = "\033[1m"
ITALIC = "\033[3m"
UNDERLINE = "\033[4m"
BLINK = "\033[5m"
REVERSE = "\033[7m"
STRIKE = "\033[9m"

def color_fg(code): return f"\033[38;5;{code}m"
def color_bg(code): return f"\033[48;5;{code}m"
def color_rgb_fg(r,g,b): return f"\033[38;2;{r};{g};{b}m"
def color_rgb_bg(r,g,b): return f"\033[48;2;{r};{g};{b}m"

def print_16_colors():
    print("=== 16 Foreground Colors ===")
    for i in range(16):
        print(f"{color_fg(i)}Color {i:2d}{RESET}", end="  ")
    print("\n")
    print("=== 16 Background Colors ===")
    for i in range(16):
        print(f"{color_bg(i)}  BG {i:2d}  {RESET}", end="")
    print("\n")

def print_256_colors():
    print("=== 256-Color Palette ===")
    for i in range(256):
        print(f"{color_fg(i)}█{RESET}", end="")
        if (i+1) % 32 == 0:
            print()
    print()

def print_truecolor_demo():
    print("=== Truecolor (RGB) Demo ===")
    # Gradient red to blue
    for r in range(0, 256, 8):
        g, b = 0, 0
        print(f"{color_rgb_fg(r,g,b)}█{RESET}", end="")
    print()
    for g in range(0, 256, 8):
        r, b = 0, 0
        print(f"{color_rgb_fg(r,g,b)}█{RESET}", end="")
    print()
    for b in range(0, 256, 8):
        r, g = 0, 0
        print(f"{color_rgb_fg(r,g,b)}█{RESET}", end="")
    print()

def interactive():
    print("=== Interactive Color Picker ===")
    try:
        fg = int(input("Foreground color (0-255): "))
        bg = int(input("Background color (0-255): "))
        style = input("Style (bold, italic, underline, blink, reverse, strike, none): ").lower()
        msg = input("Message: ")
        style_codes = {
            "bold": BOLD, "italic": ITALIC, "underline": UNDERLINE,
            "blink": BLINK, "reverse": REVERSE, "strike": STRIKE, "none": ""
        }
        style_code = style_codes.get(style, "")
        colored = f"{style_code}{color_fg(fg)}{color_bg(bg)}{msg}{RESET}"
        print(colored)
    except ValueError:
        print("Invalid input.")

def custom_message():
    print("=== Custom Message with Colors ===")
    msg = input("Message: ")
    print("Foreground RGB (0-255): ")
    r = int(input("R: "))
    g = int(input("G: "))
    b = int(input("B: "))
    print("Background RGB (0-255): ")
    br = int(input("R: "))
    bg = int(input("G: "))
    bb = int(input("B: "))
    style = input("Style (bold, italic, underline, none): ").lower()
    style_map = {"bold": BOLD, "italic": ITALIC, "underline": UNDERLINE, "none": ""}
    style_code = style_map.get(style, "")
    colored = f"{style_code}{color_rgb_fg(r,g,b)}{color_rgb_bg(br,bg,bb)}{msg}{RESET}"
    print(colored)

def main():
    print("=== Terminal Color Emulator ===")
    while True:
        print("\n1. Show 16 basic colors (foreground)")
        print("2. Show 16 basic colors (background)")
        print("3. Show 256-color palette")
        print("4. Show truecolor (RGB) demo")
        print("5. Interactive color picker")
        print("6. Custom message with colors")
        print("7. Exit")
        choice = input("Choose: ").strip()
        if choice == "1":
            print_16_colors()
        elif choice == "2":
            print_16_colors()  # includes both
        elif choice == "3":
            print_256_colors()
        elif choice == "4":
            print_truecolor_demo()
        elif choice == "5":
            interactive()
        elif choice == "6":
            custom_message()
        elif choice == "7":
            print("Goodbye!")
            break
        else:
            print("Invalid choice.")

if __name__ == "__main__":
    main()
