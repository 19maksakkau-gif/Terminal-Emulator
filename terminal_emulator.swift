// terminal_emulator.swift
import Foundation

let RESET = "\u{001B}[0m"
let BOLD = "\u{001B}[1m"
let ITALIC = "\u{001B}[3m"
let UNDERLINE = "\u{001B}[4m"
let BLINK = "\u{001B}[5m"
let REVERSE = "\u{001B}[7m"
let STRIKE = "\u{001B}[9m"

func colorFg(_ code: Int) -> String { return "\u{001B}[38;5;\(code)m" }
func colorBg(_ code: Int) -> String { return "\u{001B}[48;5;\(code)m" }
func colorRgbFg(_ r: Int, _ g: Int, _ b: Int) -> String { return "\u{001B}[38;2;\(r);\(g);\(b)m" }
func colorRgbBg(_ r: Int, _ g: Int, _ b: Int) -> String { return "\u{001B}[48;2;\(r);\(g);\(b)m" }

func print16Colors() {
    print("=== 16 Foreground Colors ===")
    for i in 0..<16 {
        print("\(colorFg(i))Color \(String(format: "%2d", i))\(RESET)  ", terminator: "")
    }
    print()
    print("=== 16 Background Colors ===")
    for i in 0..<16 {
        print("\(colorBg(i))  BG \(String(format: "%2d", i))  \(RESET)", terminator: "")
    }
    print()
}

func print256Colors() {
    print("=== 256-Color Palette ===")
    for i in 0..<256 {
        print("\(colorFg(i))█\(RESET)", terminator: "")
        if (i+1) % 32 == 0 { print() }
    }
    print()
}

func printTruecolorDemo() {
    print("=== Truecolor (RGB) Demo ===")
    for r in stride(from: 0, to: 256, by: 8) {
        print("\(colorRgbFg(r,0,0))█\(RESET)", terminator: "")
    }
    print()
    for g in stride(from: 0, to: 256, by: 8) {
        print("\(colorRgbFg(0,g,0))█\(RESET)", terminator: "")
    }
    print()
    for b in stride(from: 0, to: 256, by: 8) {
        print("\(colorRgbFg(0,0,b))█\(RESET)", terminator: "")
    }
    print()
}

func interactive() {
    print("=== Interactive Color Picker ===")
    print("Foreground color (0-255): ", terminator: "")
    guard let fg = Int(readLine() ?? "") else { return }
    print("Background color (0-255): ", terminator: "")
    guard let bg = Int(readLine() ?? "") else { return }
    print("Style (bold, italic, underline, blink, reverse, strike, none): ", terminator: "")
    let style = readLine()?.lowercased() ?? ""
    print("Message: ", terminator: "")
    let msg = readLine() ?? ""
    let styleMap: [String: String] = [
        "bold": BOLD, "italic": ITALIC, "underline": UNDERLINE,
        "blink": BLINK, "reverse": REVERSE, "strike": STRIKE, "none": ""
    ]
    let styleCode = styleMap[style] ?? ""
    print("\(styleCode)\(colorFg(fg))\(colorBg(bg))\(msg)\(RESET)")
}

func customMessage() {
    print("=== Custom Message with Colors ===")
    print("Message: ", terminator: "")
    let msg = readLine() ?? ""
    print("Foreground RGB (0-255): ")
    print("R: ", terminator: ""); let r = Int(readLine() ?? "") ?? 0
    print("G: ", terminator: ""); let g = Int(readLine() ?? "") ?? 0
    print("B: ", terminator: ""); let b = Int(readLine() ?? "") ?? 0
    print("Background RGB (0-255): ")
    print("R: ", terminator: ""); let br = Int(readLine() ?? "") ?? 0
    print("G: ", terminator: ""); let bg = Int(readLine() ?? "") ?? 0
    print("B: ", terminator: ""); let bb = Int(readLine() ?? "") ?? 0
    print("Style (bold, italic, underline, none): ", terminator: "")
    let style = readLine()?.lowercased() ?? ""
    let styleMap: [String: String] = ["bold": BOLD, "italic": ITALIC, "underline": UNDERLINE, "none": ""]
    let styleCode = styleMap[style] ?? ""
    print("\(styleCode)\(colorRgbFg(r,g,b))\(colorRgbBg(br,bg,bb))\(msg)\(RESET)")
}

func main() {
    print("=== Terminal Color Emulator ===")
    while true {
        print("\n1. Show 16 basic colors (foreground)")
        print("2. Show 16 basic colors (background)")
        print("3. Show 256-color palette")
        print("4. Show truecolor (RGB) demo")
        print("5. Interactive color picker")
        print("6. Custom message with colors")
        print("7. Exit")
        print("Choose: ", terminator: "")
        guard let choice = readLine() else { break }
        switch choice {
        case "1", "2": print16Colors()
        case "3": print256Colors()
        case "4": printTruecolorDemo()
        case "5": interactive()
        case "6": customMessage()
        case "7": print("Goodbye!"); return
        default: print("Invalid choice.")
        }
    }
}

main()
