🎨 Terminal Emulator – Color Output

A cross‑platform **terminal color demonstration tool** that displays ANSI escape sequences for text and background colors, styles (bold, italic, underline), and even truecolor (24‑bit) gradients.  
Perfect for learning ANSI codes, testing terminal capabilities, or adding color to your own projects.  
Built in **7 programming languages** – each with an interactive mode.

## ✨ Features
- **16 standard colors** – foreground and background.
- **256‑color palette** – show all 256 indexed colors.
- **Truecolor (24‑bit)** – display RGB colors with gradient or custom values.
- **Text styles** – bold, italic, underline, blink, reverse, strikethrough.
- **Interactive mode** – choose colors and styles interactively.
- **Custom messages** – type your own text and preview with chosen settings.
- **Cross‑platform** – works on Linux, macOS, and Windows (with virtual terminal support).

## 🗂 Languages & Files
| Language          | File                        |
|-------------------|-----------------------------|
| Python            | `terminal_emulator.py`      |
| Go                | `terminal_emulator.go`      |
| JavaScript (Node) | `terminal_emulator.js`      |
| C#                | `TerminalEmulator.cs`       |
| Java              | `TerminalEmulator.java`     |
| Ruby              | `terminal_emulator.rb`      |
| Swift             | `terminal_emulator.swift`   |

## 🚀 How to Run
Each file is standalone – run it with the appropriate interpreter/compiler.

| Language | Command |
|----------|---------|
| Python   | `python terminal_emulator.py` |
| Go       | `go run terminal_emulator.go` |
| JavaScript | `node terminal_emulator.js` |
| C#       | `dotnet run` (or `csc TerminalEmulator.cs && TerminalEmulator.exe`) |
| Java     | `javac TerminalEmulator.java && java TerminalEmulator` |
| Ruby     | `ruby terminal_emulator.rb` |
| Swift    | `swift terminal_emulator.swift` |

**Note:** On Windows, the terminal must support ANSI escape sequences (Windows 10+ with console VT support). The programs will try to enable it automatically.

## 📊 Example Session
=== Terminal Color Emulator ===

Show 16 basic colors (foreground)

Show 16 basic colors (background)

Show 256-color palette

Show truecolor (RGB) demo

Interactive color picker

Custom message with colors

Exit
Choose: 5

Foreground color (0-255): 31
Background color (0-255): 47
Style (bold, italic, underline, none): bold
Message: Hello, World!
Your colored text: Hello, World!

text

## 🔧 ANSI Codes Reference
- `\033[0m` – reset all styles
- `\033[1m` – bold
- `\033[3m` – italic
- `\033[4m` – underline
- `\033[5m` – blink
- `\033[7m` – reverse
- `\033[9m` – strikethrough
- `\033[38;5;N m` – foreground 256‑color (N = 0‑255)
- `\033[48;5;N m` – background 256‑color
- `\033[38;2;R;G;B m` – truecolor foreground (R,G,B = 0‑255)
- `\033[48;2;R;G;B m` – truecolor background

## 🤝 Contributing
Add more features (gradient text, animations, SVG export) – PRs welcome!

## 📜 License
MIT – use freely.
