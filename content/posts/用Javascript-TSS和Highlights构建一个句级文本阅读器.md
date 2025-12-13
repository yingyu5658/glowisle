---
abbrlink: 1126783921
categories:
- 往昔
date: "2025-07-04 10:46:53"
tags:
- 翻译
- JavaScript
title: 使用Javascript TSS和Highlights构建一个文本阅读器
---

> 原文：https://jsdev.space/tts-sentence-reader/
>
> 翻译：Verdant<i@glowisle.me>

![](https://jsdev.space/.netlify/images?url=_astro%2Ftts-sentence-reader.hV9whx3I.png&w=800&h=800)

在这篇文章中，我们将构建一个简单的Web工具来探究**Text-toSpeech(TTS)**在JavaScript中是如何工作的。我们也将深入研究**句子级高亮**的工作逻辑。这两项功能经常结合在一起使用，以走到浏览器中打造无障碍的动态阅读体验。

步骤:

1. 学习在浏览器中,TTS是如何工作的
2. 探究动态高亮句子的实现方法
3. 用HTML, CSS, JavaScript构建一个小工具([Demo & Code](https://codepen.io/jsdevspace/pen/YPXRRjO)) 

## 📢 浏览器中的TTS概述

JavaScript提供一个内置的API：[`SpeechSynthesis`](https://developer.mozilla.org/en-US/docs/Web/API/SpeechSynthesis)，它允许我们使用系统中的可用嗓音去大声朗读问文字。

### 核心对象:

-  `speechSynthesis` — 控制播放、暂停、恢复、停止 
-  `SpeechSynthesisUtterance` — 作为TTS引擎的待播报文本 

### ✨示例:

```js
const msg = new SpeechSynthesisUtterance("Hello, world!");
window.speechSynthesis.speak(msg);
```

### ⚙️ 添加嗓音和配置

```js
const utter = new SpeechSynthesisUtterance("This is a test");
const voices = window.speechSynthesis.getVoices();
utter.voice = voices.find(v => v.lang === 'en-US');
utter.rate = 1.2;
utter.pitch = 1;
window.speechSynthesis.speak(utter);
```

你也可以追踪朗读的开始和结束：

```js
utter.onstart = () => console.log('Started speaking');
utter.onend = () => console.log('Finished speaking');
```

## ✍️ 句子高亮

展示给用户哪一个句子正在阅读，我们需要用CSS和JavaScript来高亮文本。

### 示例 HTML:

```html
<p>
  <span class="sentence">First sentence.</span>
  <span class="sentence">Second sentence.</span>
</p>
```

### 处理高亮的CSS:

```css
.sentence.active {
  background-color: yellow;
  font-weight: bold;
}
```

### JavaScript高亮逻辑：

```js
function highlight(index) {
  document.querySelectorAll('.sentence').forEach((el, i) => {
    el.classList.toggle('active', i === index);
  });
}
```

# 🚀项目: 使用TSS和高亮的阅读器

我们的程序将要：

- 逐句朗读文本
- 高亮朗读中的文本
- 提供播放、暂停、恢复、停止
- 让用户能选择嗓音

## 📄 HTML结构

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="description" content="Build an interactive sentence-level text-to-speech reader with highlight, playback controls, and local progress tracking using HTML and JavaScript." />
  <title>Interactive TTS Article Reader</title>
</head>
<body>
  <h1>Read Along TTS Demo</h1>
  <div class="toolbar">
    <button id="start">Play</button>
    <button id="pause" disabled>Pause</button>
    <button id="resume" disabled>Resume</button>
    <button id="stop" disabled>Stop</button>
    <button id="reset">Reset</button>
    <select id="voices"></select>
  </div>
  <div class="text-block" id="reader">
    <span class="line">Learning to code is a never-ending journey.</span>
    <span class="line">Technologies evolve rapidly, requiring constant adaptation.</span>
    <span class="line">JavaScript, HTML, and CSS are essential tools for web development.</span>
    <span class="line">Frameworks like React and Vue enhance front-end capabilities.</span>
    <span class="line">Back-end skills with Node.js extend JavaScript to the server.</span>
  </div>
  <div class="progress">
    <span id="progressText">0/0</span>
    <div class="bar"><div class="bar-fill" id="bar"></div></div>
  </div>
</body>
</html>
```

## 🎨 CSS 样式

```css
body {
  font-family: sans-serif;
  margin: 0;
  padding: 2rem;
  background: #f0f4f8;
  color: #333;
}
h1 {
  text-align: center;
  margin-bottom: 2rem;
}
.toolbar {
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 1rem;
  margin-bottom: 2rem;
}
.toolbar button,
.toolbar select {
  padding: 0.6rem 1.2rem;
  border-radius: 4px;
  border: none;
  font-size: 1rem;
}
.toolbar button {
  background: #0077cc;
  color: white;
  cursor: pointer;
}
.toolbar button:disabled {
  background: #ccc;
  cursor: not-allowed;
}
.text-block {
  background: white;
  padding: 1.5rem;
  border-radius: 6px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}
.line {
  display: block;
  margin-bottom: 1rem;
  cursor: pointer;
  transition: background 0.3s;
}
.line:hover {
  background: #f9f9f9;
}
.line.active {
  background: #fff3cd;
  font-weight: bold;
}
.progress {
  text-align: center;
  margin-top: 1rem;
}
.bar {
  height: 8px;
  width: 100%;
  background: #eee;
  border-radius: 4px;
  overflow: hidden;
}
.bar-fill {
  height: 100%;
  width: 0;
  background: linear-gradient(to right, #0077cc, #005fa3);
  transition: width 0.3s;
}
```

## 💡 JavaScript逻辑

```js
const lines = document.querySelectorAll('.line');
const playBtn = document.getElementById('start');
const pauseBtn = document.getElementById('pause');
const resumeBtn = document.getElementById('resume');
const stopBtn = document.getElementById('stop');
const resetBtn = document.getElementById('reset');
const voiceSelect = document.getElementById('voices');
const progressText = document.getElementById('progressText');
const progressBar = document.getElementById('bar');

const synth = window.speechSynthesis;
let voices = [];
let currentIndex = 0;
let currentUtterance = null;
let isPaused = false;

function populateVoices() {
  voices = synth.getVoices();
  voiceSelect.innerHTML = '';
  voices.forEach((voice, index) => {
    const opt = document.createElement('option');
    opt.value = index;
    opt.textContent = `${voice.name} (${voice.lang})`;
    voiceSelect.appendChild(opt);
  });
}

synth.onvoiceschanged = populateVoices;
populateVoices();

function updateUI() {
  progressText.textContent = `${currentIndex + 1}/${lines.length}`;
  progressBar.style.width = `${((currentIndex + 1) / lines.length) * 100}%`;
}

function highlightLine(index) {
  lines.forEach((line, i) => {
    line.classList.toggle('active', i === index);
  });
  lines[index]?.scrollIntoView({ behavior: 'smooth', block: 'center' });
}

function speakLine(index) {
  if (index >= lines.length) return;
  const text = lines[index].textContent;
  const utter = new SpeechSynthesisUtterance(text);
  const selected = voiceSelect.value;
  if (voices[selected]) utter.voice = voices[selected];
  utter.rate = 1;

  utter.onstart = () => {
    highlightLine(index);
    playBtn.disabled = true;
    pauseBtn.disabled = false;
    resumeBtn.disabled = true;
    stopBtn.disabled = false;
  };

  utter.onend = () => {
    if (!isPaused) {
      currentIndex++;
      if (currentIndex < lines.length) {
        speakLine(currentIndex);
      } else {
        resetControls();
      }
    }
  };

  currentUtterance = utter;
  synth.speak(utter);
  updateUI();
}

function resetControls() {
  playBtn.disabled = false;
  pauseBtn.disabled = true;
  resumeBtn.disabled = true;
  stopBtn.disabled = true;
}

playBtn.onclick = () => {
  currentIndex = 0;
  speakLine(currentIndex);
};
pauseBtn.onclick = () => {
  synth.pause();
  isPaused = true;
  pauseBtn.disabled = true;
  resumeBtn.disabled = false;
};
resumeBtn.onclick = () => {
  synth.resume();
  isPaused = false;
  pauseBtn.disabled = false;
  resumeBtn.disabled = true;
};
stopBtn.onclick = () => {
  synth.cancel();
  resetControls();
};
resetBtn.onclick = () => {
  synth.cancel();
  currentIndex = 0;
  highlightLine(currentIndex);
  updateUI();
};

lines.forEach((line, index) => {
  line.addEventListener('click', () => {
    synth.cancel();
    currentIndex = index;
    speakLine(currentIndex);
  });
});

updateUI();
```

## ✅ 它们如何工作

- 每一个句子都是`<span class="sentence">`
- 我们迭代句子并使用`SpeechSynthesisUtterance`大声朗读
- 在朗读过程中，高亮正确的文本并滚动
- 一个句子结束后，自动朗读下一个句子

## 🔚 尾声

阅读了本文，你理解了：

- 浏览器TTS的运行原理
- 如何实现动态高亮文本
- 如何从零构建一个功能齐全的阅读界面

你可以扩展项目功能：

- 在`localStorage`保存阅读进度
- 添加进度条
- 加载外部文章或用户输入
