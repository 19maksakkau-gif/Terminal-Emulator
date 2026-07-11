// TerminalEmulator.cs
using System;

class TerminalEmulator
{
    const string RESET = "\x1b[0m";
    const string BOLD = "\x1b[1m";
    const string ITALIC = "\x1b[3m";
    const string UNDERLINE = "\x1b[4m";
    const string BLINK = "\x1b[5m";
    const string REVERSE = "\x1b[7m";
    const string STRIKE = "\x1b[9m";

    static string ColorFg(int code) => $"\x1b[38;5;{code}m";
    static string ColorBg(int code) => $"\x1b[48;5;{code}m";
    static string ColorRgbFg(int r, int g, int b) => $"\x1b[38;2;{r};{g};{b}m";
    static string ColorRgbBg(int r, int g, int b) => $"\x1b[48;2;{r};{g};{b}m";

    static void Print16Colors()
    {
        Console.WriteLine("=== 16 Foreground Colors ===");
        for (int i = 0; i < 16; i++)
            Console.Write($"{ColorFg(i)}Color {i,2}{RESET}  ");
        Console.WriteLine();
        Console.WriteLine("=== 16 Background Colors ===");
        for (int i = 0; i < 16; i++)
            Console.Write($"{ColorBg(i)}  BG {i,2}  {RESET}");
        Console.WriteLine();
    }

    static void Print256Colors()
    {
        Console.WriteLine("=== 256-Color Palette ===");
        for (int i = 0; i < 256; i++)
        {
            Console.Write($"{ColorFg(i)}█{RESET}");
            if ((i+1) % 32 == 0)
                Console.WriteLine();
        }
        Console.WriteLine();
    }

    static void PrintTruecolorDemo()
    {
        Console.WriteLine("=== Truecolor (RGB) Demo ===");
        for (int r = 0; r < 256; r += 8)
            Console.Write($"{ColorRgbFg(r,0,0)}█{RESET}");
        Console.WriteLine();
        for (int g = 0; g < 256; g += 8)
            Console.Write($"{ColorRgbFg(0,g,0)}█{RESET}");
        Console.WriteLine();
        for (int b = 0; b < 256; b += 8)
            Console.Write($"{ColorRgbFg(0,0,b)}█{RESET}");
        Console.WriteLine();
    }

    static void Interactive()
    {
        Console.WriteLine("=== Interactive Color Picker ===");
        Console.Write("Foreground color (0-255): ");
        int fg = int.Parse(Console.ReadLine());
        Console.Write("Background color (0-255): ");
        int bg = int.Parse(Console.ReadLine());
        Console.Write("Style (bold, italic, underline, blink, reverse, strike, none): ");
        string style = Console.ReadLine().ToLower();
        Console.Write("Message: ");
        string msg = Console.ReadLine();
        var styleMap = new Dictionary<string, string> {
            {"bold", BOLD}, {"italic", ITALIC}, {"underline", UNDERLINE},
            {"blink", BLINK}, {"reverse", REVERSE}, {"strike", STRIKE}, {"none", ""}
        };
        string styleCode = styleMap.ContainsKey(style) ? styleMap[style] : "";
        Console.WriteLine($"{styleCode}{ColorFg(fg)}{ColorBg(bg)}{msg}{RESET}");
    }

    static void CustomMessage()
    {
        Console.WriteLine("=== Custom Message with Colors ===");
        Console.Write("Message: ");
        string msg = Console.ReadLine();
        Console.WriteLine("Foreground RGB (0-255): ");
        Console.Write("R: "); int r = int.Parse(Console.ReadLine());
        Console.Write("G: "); int g = int.Parse(Console.ReadLine());
        Console.Write("B: "); int b = int.Parse(Console.ReadLine());
        Console.WriteLine("Background RGB (0-255): ");
        Console.Write("R: "); int br = int.Parse(Console.ReadLine());
        Console.Write("G: "); int bg = int.Parse(Console.ReadLine());
        Console.Write("B: "); int bb = int.Parse(Console.ReadLine());
        Console.Write("Style (bold, italic, underline, none): ");
        string style = Console.ReadLine().ToLower();
        var styleMap = new Dictionary<string, string> { {"bold", BOLD}, {"italic", ITALIC}, {"underline", UNDERLINE}, {"none", ""} };
        string styleCode = styleMap.ContainsKey(style) ? styleMap[style] : "";
        Console.WriteLine($"{styleCode}{ColorRgbFg(r,g,b)}{ColorRgbBg(br,bg,bb)}{msg}{RESET}");
    }

    static void Main()
    {
        Console.WriteLine("=== Terminal Color Emulator ===");
        while (true)
        {
            Console.WriteLine("\n1. Show 16 basic colors (foreground)");
            Console.WriteLine("2. Show 16 basic colors (background)");
            Console.WriteLine("3. Show 256-color palette");
            Console.WriteLine("4. Show truecolor (RGB) demo");
            Console.WriteLine("5. Interactive color picker");
            Console.WriteLine("6. Custom message with colors");
            Console.WriteLine("7. Exit");
            Console.Write("Choose: ");
            string choice = Console.ReadLine();
            switch (choice)
            {
                case "1": case "2": Print16Colors(); break;
                case "3": Print256Colors(); break;
                case "4": PrintTruecolorDemo(); break;
                case "5": Interactive(); break;
                case "6": CustomMessage(); break;
                case "7": Console.WriteLine("Goodbye!"); return;
                default: Console.WriteLine("Invalid choice."); break;
            }
        }
    }
}
