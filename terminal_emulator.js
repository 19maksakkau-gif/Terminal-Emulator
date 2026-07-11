// terminal_emulator.js
const readline = require('readline');
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const RESET = '\x1b[0m';
const BOLD = '\x1b[1m';
const ITALIC = '\x1b[3m';
const UNDERLINE = '\x1b[4m';
const BLINK = '\x1b[5m';
const REVERSE = '\x1b[7m';
const STRIKE = '\x1b[9m';

function colorFg(code) { return `\x1b[38;5;${code}m`; }
function colorBg(code) { return `\x1b[48;5;${code}m`; }
function colorRgbFg(r,g,b) { return `\x1b[38;2;${r};${g};${b}m`; }
function colorRgbBg(r,g,b) { return `\x1b[48;2;${r};${g};${b}m`; }

function ask(question) {
    return new Promise(resolve => rl.question(question, resolve));
}

async function print16Colors() {
    console.log('=== 16 Foreground Colors ===');
    let line = '';
    for (let i = 0; i < 16; i++) {
        line += `${colorFg(i)}Color ${String(i).padStart(2)}${RESET}  `;
    }
    console.log(line);
    console.log('=== 16 Background Colors ===');
    line = '';
    for (let i = 0; i < 16; i++) {
        line += `${colorBg(i)}  BG ${String(i).padStart(2)}  ${RESET}`;
    }
    console.log(line);
}

async function print256Colors() {
    console.log('=== 256-Color Palette ===');
    let line = '';
    for (let i = 0; i < 256; i++) {
        line += `${colorFg(i)}█${RESET}`;
        if ((i+1) % 32 === 0) {
            console.log(line);
            line = '';
        }
    }
    if (line) console.log(line);
}

async function printTruecolorDemo() {
    console.log('=== Truecolor (RGB) Demo ===');
    let line = '';
    for (let r = 0; r < 256; r += 8) {
        line += `${colorRgbFg(r,0,0)}█${RESET}`;
    }
    console.log(line);
    line = '';
    for (let g = 0; g < 256; g += 8) {
        line += `${colorRgbFg(0,g,0)}█${RESET}`;
    }
    console.log(line);
    line = '';
    for (let b = 0; b < 256; b += 8) {
        line += `${colorRgbFg(0,0,b)}█${RESET}`;
    }
    console.log(line);
}

async function interactive() {
    console.log('=== Interactive Color Picker ===');
    const fg = parseInt(await ask('Foreground color (0-255): '), 10);
    const bg = parseInt(await ask('Background color (0-255): '), 10);
    const style = await ask('Style (bold, italic, underline, blink, reverse, strike, none): ');
    const msg = await ask('Message: ');
    const styleMap = { bold: BOLD, italic: ITALIC, underline: UNDERLINE, blink: BLINK, reverse: REVERSE, strike: STRIKE, none: '' };
    const styleCode = styleMap[style] || '';
    console.log(`${styleCode}${colorFg(fg)}${colorBg(bg)}${msg}${RESET}`);
}

async function customMessage() {
    console.log('=== Custom Message with Colors ===');
    const msg = await ask('Message: ');
    console.log('Foreground RGB (0-255): ');
    const r = parseInt(await ask('R: '), 10);
    const g = parseInt(await ask('G: '), 10);
    const b = parseInt(await ask('B: '), 10);
    console.log('Background RGB (0-255): ');
    const br = parseInt(await ask('R: '), 10);
    const bg = parseInt(await ask('G: '), 10);
    const bb = parseInt(await ask('B: '), 10);
    const style = await ask('Style (bold, italic, underline, none): ');
    const styleMap = { bold: BOLD, italic: ITALIC, underline: UNDERLINE, none: '' };
    const styleCode = styleMap[style] || '';
    console.log(`${styleCode}${colorRgbFg(r,g,b)}${colorRgbBg(br,bg,bb)}${msg}${RESET}`);
}

async function main() {
    console.log('=== Terminal Color Emulator ===');
    while (true) {
        console.log('\n1. Show 16 basic colors (foreground)');
        console.log('2. Show 16 basic colors (background)');
        console.log('3. Show 256-color palette');
        console.log('4. Show truecolor (RGB) demo');
        console.log('5. Interactive color picker');
        console.log('6. Custom message with colors');
        console.log('7. Exit');
        const choice = await ask('Choose: ');
        switch (choice.trim()) {
            case '1': case '2': await print16Colors(); break;
            case '3': await print256Colors(); break;
            case '4': await printTruecolorDemo(); break;
            case '5': await interactive(); break;
            case '6': await customMessage(); break;
            case '7': console.log('Goodbye!'); rl.close(); return;
            default: console.log('Invalid choice.');
        }
    }
}

main().catch(console.error);
