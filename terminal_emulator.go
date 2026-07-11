// terminal_emulator.go
package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

const RESET = "\033[0m"
const BOLD = "\033[1m"
const ITALIC = "\033[3m"
const UNDERLINE = "\033[4m"
const BLINK = "\033[5m"
const REVERSE = "\033[7m"
const STRIKE = "\033[9m"

func colorFg(code int) string { return fmt.Sprintf("\033[38;5;%dm", code) }
func colorBg(code int) string { return fmt.Sprintf("\033[48;5;%dm", code) }
func colorRgbFg(r, g, b int) string { return fmt.Sprintf("\033[38;2;%d;%d;%dm", r, g, b) }
func colorRgbBg(r, g, b int) string { return fmt.Sprintf("\033[48;2;%d;%d;%dm", r, g, b) }

func print16Colors() {
	fmt.Println("=== 16 Foreground Colors ===")
	for i := 0; i < 16; i++ {
		fmt.Printf("%sColor %2d%s  ", colorFg(i), i, RESET)
	}
	fmt.Println()
	fmt.Println("=== 16 Background Colors ===")
	for i := 0; i < 16; i++ {
		fmt.Printf("%s  BG %2d  %s", colorBg(i), i, RESET)
	}
	fmt.Println()
}

func print256Colors() {
	fmt.Println("=== 256-Color Palette ===")
	for i := 0; i < 256; i++ {
		fmt.Printf("%s█%s", colorFg(i), RESET)
		if (i+1)%32 == 0 {
			fmt.Println()
		}
	}
	fmt.Println()
}

func printTruecolorDemo() {
	fmt.Println("=== Truecolor (RGB) Demo ===")
	for r := 0; r < 256; r += 8 {
		g, b := 0, 0
		fmt.Printf("%s█%s", colorRgbFg(r, g, b), RESET)
	}
	fmt.Println()
	for g := 0; g < 256; g += 8 {
		r, b := 0, 0
		fmt.Printf("%s█%s", colorRgbFg(r, g, b), RESET)
	}
	fmt.Println()
	for b := 0; b < 256; b += 8 {
		r, g := 0, 0
		fmt.Printf("%s█%s", colorRgbFg(r, g, b), RESET)
	}
	fmt.Println()
}

func interactive() {
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("=== Interactive Color Picker ===")
	fmt.Print("Foreground color (0-255): ")
	fgStr, _ := reader.ReadString('\n')
	fg, _ := strconv.Atoi(strings.TrimSpace(fgStr))
	fmt.Print("Background color (0-255): ")
	bgStr, _ := reader.ReadString('\n')
	bg, _ := strconv.Atoi(strings.TrimSpace(bgStr))
	fmt.Print("Style (bold, italic, underline, blink, reverse, strike, none): ")
	styleStr, _ := reader.ReadString('\n')
	style := strings.TrimSpace(styleStr)
	fmt.Print("Message: ")
	msg, _ := reader.ReadString('\n')
	msg = strings.TrimSpace(msg)
	styleMap := map[string]string{
		"bold": BOLD, "italic": ITALIC, "underline": UNDERLINE,
		"blink": BLINK, "reverse": REVERSE, "strike": STRIKE, "none": "",
	}
	styleCode := styleMap[style]
	colored := fmt.Sprintf("%s%s%s%s%s", styleCode, colorFg(fg), colorBg(bg), msg, RESET)
	fmt.Println(colored)
}

func customMessage() {
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("=== Custom Message with Colors ===")
	fmt.Print("Message: ")
	msg, _ := reader.ReadString('\n')
	msg = strings.TrimSpace(msg)
	fmt.Println("Foreground RGB (0-255): ")
	fmt.Print("R: ")
	rStr, _ := reader.ReadString('\n')
	r, _ := strconv.Atoi(strings.TrimSpace(rStr))
	fmt.Print("G: ")
	gStr, _ := reader.ReadString('\n')
	g, _ := strconv.Atoi(strings.TrimSpace(gStr))
	fmt.Print("B: ")
	bStr, _ := reader.ReadString('\n')
	b, _ := strconv.Atoi(strings.TrimSpace(bStr))
	fmt.Println("Background RGB (0-255): ")
	fmt.Print("R: ")
	brStr, _ := reader.ReadString('\n')
	br, _ := strconv.Atoi(strings.TrimSpace(brStr))
	fmt.Print("G: ")
	bgStr, _ := reader.ReadString('\n')
	bg, _ := strconv.Atoi(strings.TrimSpace(bgStr))
	fmt.Print("B: ")
	bbStr, _ := reader.ReadString('\n')
	bb, _ := strconv.Atoi(strings.TrimSpace(bbStr))
	fmt.Print("Style (bold, italic, underline, none): ")
	styleStr, _ := reader.ReadString('\n')
	style := strings.TrimSpace(styleStr)
	styleMap := map[string]string{"bold": BOLD, "italic": ITALIC, "underline": UNDERLINE, "none": ""}
	styleCode := styleMap[style]
	colored := fmt.Sprintf("%s%s%s%s%s", styleCode, colorRgbFg(r, g, b), colorRgbBg(br, bg, bb), msg, RESET)
	fmt.Println(colored)
}

func main() {
	reader := bufio.NewReader(os.Stdin)
	fmt.Println("=== Terminal Color Emulator ===")
	for {
		fmt.Println("\n1. Show 16 basic colors (foreground)")
		fmt.Println("2. Show 16 basic colors (background)")
		fmt.Println("3. Show 256-color palette")
		fmt.Println("4. Show truecolor (RGB) demo")
		fmt.Println("5. Interactive color picker")
		fmt.Println("6. Custom message with colors")
		fmt.Println("7. Exit")
		fmt.Print("Choose: ")
		choiceStr, _ := reader.ReadString('\n')
		choice := strings.TrimSpace(choiceStr)
		switch choice {
		case "1", "2":
			print16Colors()
		case "3":
			print256Colors()
		case "4":
			printTruecolorDemo()
		case "5":
			interactive()
		case "6":
			customMessage()
		case "7":
			fmt.Println("Goodbye!")
			return
		default:
			fmt.Println("Invalid choice.")
		}
	}
}
