# terminal_emulator.rb
RESET = "\033[0m"
BOLD = "\033[1m"
ITALIC = "\033[3m"
UNDERLINE = "\033[4m"
BLINK = "\033[5m"
REVERSE = "\033[7m"
STRIKE = "\033[9m"

def color_fg(code) = "\033[38;5;#{code}m"
def color_bg(code) = "\033[48;5;#{code}m"
def color_rgb_fg(r,g,b) = "\033[38;2;#{r};#{g};#{b}m"
def color_rgb_bg(r,g,b) = "\033[48;2;#{r};#{g};#{b}m"

def print_16_colors
  puts "=== 16 Foreground Colors ==="
  print (0...16).map { |i| "#{color_fg(i)}Color #{i.to_s.rjust(2)}#{RESET}  " }.join
  puts
  puts "=== 16 Background Colors ==="
  print (0...16).map { |i| "#{color_bg(i)}  BG #{i.to_s.rjust(2)}  #{RESET}" }.join
  puts
end

def print_256_colors
  puts "=== 256-Color Palette ==="
  (0...256).each do |i|
    print "#{color_fg(i)}█#{RESET}"
    puts if (i+1) % 32 == 0
  end
  puts
end

def print_truecolor_demo
  puts "=== Truecolor (RGB) Demo ==="
  (0...256).step(8) { |r| print "#{color_rgb_fg(r,0,0)}█#{RESET}" }
  puts
  (0...256).step(8) { |g| print "#{color_rgb_fg(0,g,0)}█#{RESET}" }
  puts
  (0...256).step(8) { |b| print "#{color_rgb_fg(0,0,b)}█#{RESET}" }
  puts
end

def interactive
  puts "=== Interactive Color Picker ==="
  print "Foreground color (0-255): "
  fg = gets.to_i
  print "Background color (0-255): "
  bg = gets.to_i
  print "Style (bold, italic, underline, blink, reverse, strike, none): "
  style = gets.chomp.downcase
  print "Message: "
  msg = gets.chomp
  style_map = {
    "bold" => BOLD, "italic" => ITALIC, "underline" => UNDERLINE,
    "blink" => BLINK, "reverse" => REVERSE, "strike" => STRIKE, "none" => ""
  }
  style_code = style_map[style] || ""
  puts "#{style_code}#{color_fg(fg)}#{color_bg(bg)}#{msg}#{RESET}"
end

def custom_message
  puts "=== Custom Message with Colors ==="
  print "Message: "
  msg = gets.chomp
  puts "Foreground RGB (0-255): "
  print "R: "; r = gets.to_i
  print "G: "; g = gets.to_i
  print "B: "; b = gets.to_i
  puts "Background RGB (0-255): "
  print "R: "; br = gets.to_i
  print "G: "; bg = gets.to_i
  print "B: "; bb = gets.to_i
  print "Style (bold, italic, underline, none): "
  style = gets.chomp.downcase
  style_map = {"bold" => BOLD, "italic" => ITALIC, "underline" => UNDERLINE, "none" => ""}
  style_code = style_map[style] || ""
  puts "#{style_code}#{color_rgb_fg(r,g,b)}#{color_rgb_bg(br,bg,bb)}#{msg}#{RESET}"
end

def main
  puts "=== Terminal Color Emulator ==="
  loop do
    puts "\n1. Show 16 basic colors (foreground)"
    puts "2. Show 16 basic colors (background)"
    puts "3. Show 256-color palette"
    puts "4. Show truecolor (RGB) demo"
    puts "5. Interactive color picker"
    puts "6. Custom message with colors"
    puts "7. Exit"
    print "Choose: "
    choice = gets.chomp
    case choice
    when "1", "2" then print_16_colors
    when "3" then print_256_colors
    when "4" then print_truecolor_demo
    when "5" then interactive
    when "6" then custom_message
    when "7" then puts "Goodbye!"; break
    else puts "Invalid choice."
    end
  end
end

main if __FILE__ == $0
