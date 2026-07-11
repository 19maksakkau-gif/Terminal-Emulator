// TerminalEmulator.java
import java.io.*;
import java.util.*;

public class TerminalEmulator {
    private static final String RESET = "\033[0m";
    private static final String BOLD = "\033[1m";
    private static final String ITALIC = "\033[3m";
    private static final String UNDERLINE = "\033[4m";
    private static final String BLINK = "\033[5m";
    private static final String REVERSE = "\033[7m";
    private static final String STRIKE = "\033[9m";

    private static String colorFg(int code) { return "\033[38;5;" + code + "m"; }
    private static String colorBg(int code) { return "\033[48;5;" + code + "m"; }
    private static String colorRgbFg(int r, int g, int b) { return "\033[38;2;" + r + ";" + g + ";" + b + "m"; }
    private static String colorRgbBg(int r, int g, int b) { return "\033[48;2;" + r + ";" + g + ";" + b + "m"; }

    private static void print16Colors() {
        System.out.println("=== 16 Foreground Colors ===");
        for (int i = 0; i < 16; i++) {
            System.out.print(colorFg(i) + "Color " + String.format("%2d", i) + RESET + "  ");
        }
        System.out.println();
        System.out.println("=== 16 Background Colors ===");
        for (int i = 0; i < 16; i++) {
            System.out.print(colorBg(i) + "  BG " + String.format("%2d", i) + "  " + RESET);
        }
        System.out.println();
    }

    private static void print256Colors() {
        System.out.println("=== 256-Color Palette ===");
        for (int i = 0; i < 256; i++) {
            System.out.print(colorFg(i) + "█" + RESET);
            if ((i+1) % 32 == 0) System.out.println();
        }
        System.out.println();
    }

    private static void printTruecolorDemo() {
        System.out.println("=== Truecolor (RGB) Demo ===");
        for (int r = 0; r < 256; r += 8) System.out.print(colorRgbFg(r,0,0) + "█" + RESET);
        System.out.println();
        for (int g = 0; g < 256; g += 8) System.out.print(colorRgbFg(0,g,0) + "█" + RESET);
        System.out.println();
        for (int b = 0; b < 256; b += 8) System.out.print(colorRgbFg(0,0,b) + "█" + RESET);
        System.out.println();
    }

    private static void interactive(Scanner sc) {
        System.out.println("=== Interactive Color Picker ===");
        System.out.print("Foreground color (0-255): ");
        int fg = sc.nextInt();
        System.out.print("Background color (0-255): ");
        int bg = sc.nextInt();
        sc.nextLine(); // consume newline
        System.out.print("Style (bold, italic, underline, blink, reverse, strike, none): ");
        String style = sc.nextLine().toLowerCase();
        System.out.print("Message: ");
        String msg = sc.nextLine();
        Map<String, String> styleMap = new HashMap<>();
        styleMap.put("bold", BOLD); styleMap.put("italic", ITALIC);
        styleMap.put("underline", UNDERLINE); styleMap.put("blink", BLINK);
        styleMap.put("reverse", REVERSE); styleMap.put("strike", STRIKE);
        styleMap.put("none", "");
        String styleCode = styleMap.getOrDefault(style, "");
        System.out.println(styleCode + colorFg(fg) + colorBg(bg) + msg + RESET);
    }

    private static void customMessage(Scanner sc) {
        System.out.println("=== Custom Message with Colors ===");
        sc.nextLine(); // clear buffer
        System.out.print("Message: ");
        String msg = sc.nextLine();
        System.out.println("Foreground RGB (0-255): ");
        System.out.print("R: "); int r = sc.nextInt();
        System.out.print("G: "); int g = sc.nextInt();
        System.out.print("B: "); int b = sc.nextInt();
        System.out.println("Background RGB (0-255): ");
        System.out.print("R: "); int br = sc.nextInt();
        System.out.print("G: "); int bg = sc.nextInt();
        System.out.print("B: "); int bb = sc.nextInt();
        sc.nextLine();
        System.out.print("Style (bold, italic, underline, none): ");
        String style = sc.nextLine().toLowerCase();
        Map<String, String> styleMap = new HashMap<>();
        styleMap.put("bold", BOLD); styleMap.put("italic", ITALIC);
        styleMap.put("underline", UNDERLINE); styleMap.put("none", "");
        String styleCode = styleMap.getOrDefault(style, "");
        System.out.println(styleCode + colorRgbFg(r,g,b) + colorRgbBg(br,bg,bb) + msg + RESET);
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("=== Terminal Color Emulator ===");
        while (true) {
            System.out.println("\n1. Show 16 basic colors (foreground)");
            System.out.println("2. Show 16 basic colors (background)");
            System.out.println("3. Show 256-color palette");
            System.out.println("4. Show truecolor (RGB) demo");
            System.out.println("5. Interactive color picker");
            System.out.println("6. Custom message with colors");
            System.out.println("7. Exit");
            System.out.print("Choose: ");
            String choice = sc.nextLine().trim();
            switch (choice) {
                case "1": case "2": print16Colors(); break;
                case "3": print256Colors(); break;
                case "4": printTruecolorDemo(); break;
                case "5": interactive(sc); break;
                case "6": customMessage(sc); break;
                case "7": System.out.println("Goodbye!"); sc.close(); return;
                default: System.out.println("Invalid choice.");
            }
        }
    }
}
