import fs from 'fs';

const cssPath = 'd:/BaiduSyncdisk/study/2602Hersolidity/WWW6.5/Tenlossiby/GUI/src/styles/main.css';
let css = fs.readFileSync(cssPath, 'utf8');

const colorMap = {
    '#fdf6e3': 'var(--bg-base)',
    '#eee8d5': 'var(--bg-surface-1)',
    '#657b83': 'var(--text-main)',
    '#93a1a1': 'var(--text-muted)',
    '#839496': 'var(--code-text)',
    '#d3cbb8': 'var(--border-main)',
    '#b58900': 'var(--accent-yellow)',
    '#2aa198': 'var(--accent-cyan)',
    '#218079': 'var(--accent-cyan-hover)',
    '#859900': 'var(--accent-green)',
    '#9ea91b': 'var(--accent-green-hover)',
    '#dc322f': 'var(--accent-red)',
    '#e63935': 'var(--accent-red-hover)',
    '#cb4b16': 'var(--accent-orange)',
    '#268bd2': 'var(--accent-blue)',
    '#3c92d8': 'var(--accent-blue-hover)',
    '#d33682': 'var(--accent-magenta)',
    '#073642': 'var(--code-bg)',
    '#586e75': 'var(--code-border)',

    // Shadows
    'rgba(0, 0, 0, 0.1)': 'var(--shadow-base-1)',
    'rgba(181, 137, 0, 0.3)': 'var(--shadow-yellow-3)',
    'rgba(181, 137, 0, 0.4)': 'var(--shadow-yellow-4)',
    'rgba(133, 153, 0, 0.4)': 'var(--shadow-green-4)',
    'rgba(133, 153, 0, 0.5)': 'var(--shadow-green-5)',
    'rgba(220, 50, 47, 0.4)': 'var(--shadow-red-4)',
    'rgba(42, 161, 152, 0.4)': 'var(--shadow-cyan-4)',
    'rgba(38, 139, 210, 0.4)': 'var(--shadow-blue-4)'
};

// Also let's fix the rgba(0,0,0,0.1) etc. which may have spaces.
// regex replace each key
for (let key in colorMap) {
    let escKey = key.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    // For hex keys, make case insensitive
    if (key.startsWith('#')) {
        css = css.replace(new RegExp(escKey, 'gi'), colorMap[key]);
    } else {
        // For rgba, space might vary slightly, but in main.css it's exactly as defined
        css = css.replace(new RegExp(escKey, 'g'), colorMap[key]);
    }
}

// Add the variables to the top
const vars = `
:root {
  --bg-base: #fdf6e3;
  --bg-surface-1: #eee8d5;
  --text-main: #657b83;
  --text-muted: #93a1a1;
  --border-main: #d3cbb8;
  --accent-yellow: #b58900;
  --accent-cyan: #2aa198;
  --accent-cyan-hover: #218079;
  --accent-green: #859900;
  --accent-green-hover: #9ea91b;
  --accent-red: #dc322f;
  --accent-red-hover: #e63935;
  --accent-orange: #cb4b16;
  --accent-blue: #268bd2;
  --accent-blue-hover: #3c92d8;
  --accent-magenta: #d33682;
  --code-bg: #073642;
  --code-border: #586e75;
  --code-text: #839496;
  
  --shadow-base-1: rgba(0, 0, 0, 0.1);
  --shadow-yellow-3: rgba(181, 137, 0, 0.3);
  --shadow-yellow-4: rgba(181, 137, 0, 0.4);
  --shadow-green-4: rgba(133, 153, 0, 0.4);
  --shadow-green-5: rgba(133, 153, 0, 0.5);
  --shadow-red-4: rgba(220, 50, 47, 0.4);
  --shadow-cyan-4: rgba(42, 161, 152, 0.4);
  --shadow-blue-4: rgba(38, 139, 210, 0.4);
}

[data-theme="dark"] {
  --bg-base: #002b36;
  --bg-surface-1: #073642;
  --text-main: #839496;
  --text-muted: #586e75; 
  --border-main: #002b36; /* Darker border in dark mode */
  --accent-yellow: #b58900;
  --accent-cyan: #2aa198;
  --accent-cyan-hover: #218079;
  --accent-green: #859900;
  --accent-green-hover: #9ea91b;
  --accent-red: #dc322f;
  --accent-red-hover: #e63935;
  --accent-orange: #cb4b16;
  --accent-blue: #268bd2;
  --accent-blue-hover: #3c92d8;
  --accent-magenta: #d33682;
  --code-bg: #002b36; 
  --code-border: #002b36;
  --code-text: #93a1a1;
  
  --shadow-base-1: transparent;
  --shadow-yellow-3: transparent;
  --shadow-yellow-4: transparent;
  --shadow-green-4: transparent;
  --shadow-green-5: transparent;
  --shadow-red-4: transparent;
  --shadow-cyan-4: transparent;
  --shadow-blue-4: transparent;
}
`;

css = vars + '\n' + css;

fs.writeFileSync(cssPath, css, 'utf8');
console.log('Replaced successfully.');
