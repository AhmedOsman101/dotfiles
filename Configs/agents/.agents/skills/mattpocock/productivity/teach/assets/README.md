# Teach skill — bundled lesson components

Starter components for a teaching workspace's `./assets/`. Copy what you need into
the workspace and link from lessons; don't re-author per workspace.

- `style.css` — shared lesson stylesheet (promoted from the lua workspace). Dark-only,
  Georgia body / Helvetica headings / JetBrainsMono Nerd Font code, Tufte-style
  sidenotes, `.callout` / `.task` boxes, and a rounded frame for Prism code blocks.
  Ends with a `.quiz` block so the radio quiz stays styled. No light theme;
  `theme.js` is opt-in for workspaces that add their own light tokens.
- `prism.css` / `prism.js` — vendored PrismJS 1.30.0 (tomorrow theme, lua + common
  languages, line-numbers / toolbar / copy-button plugins), pre-tinted to this theme.
- `quiz.js` — radio quiz: `.quiz[data-answer="<key>"]` with radios, `button[data-check]`,
  optional `button[data-reset]`, `.feedback[aria-live]`. Retry allowed.
- `quiz-buttons.js` — button quiz: `[data-quiz]` with `.quiz-choices button`s, exactly
  one `[data-correct]`, optional `.quiz-feedback[data-why]` revealed after answering.
  Locks after one click; styles itself inline. Logs a console error if the
  exactly-one-correct invariant is broken.
- `theme.js` — `data-theme` switch (dark default, persists to
  `localStorage["teach-theme"]`). Only useful if the stylesheet defines a
  `html[data-theme="light"]` palette; the bundled `style.css` does not.

## Wiring a lesson page

```html
<link rel="stylesheet" href="../assets/style.css">
<link rel="stylesheet" href="../assets/prism.css">
<script src="../assets/prism.js" defer></script>
<script src="../assets/quiz.js" defer></script>       <!-- and/or quiz-buttons.js -->
```

Code blocks for highlighting:

```html
<pre class="language-lua"><code class="language-lua">print("hi")</code></pre>
```

## Quiz markups

Radio (`quiz.js`):

```html
<div class="quiz" data-answer="b">
  <fieldset><legend>Question…</legend>
    <label><input type="radio" name="r1" value="a"> Option A</label>
    <label><input type="radio" name="r1" value="b"> Option B</label>
    <button type="button" data-check>Check</button>
    <button type="button" class="ghost" data-reset>Reset</button>
    <div class="feedback" aria-live="polite"></div>
  </fieldset>
</div>
```

Buttons (`quiz-buttons.js`):

```html
<div class="quiz" data-quiz>
  <p class="quiz-q">Question?</p>
  <div class="quiz-choices">
    <button data-correct>answer A</button>
    <button>answer B</button>
  </div>
  <p class="quiz-feedback" hidden data-why>Explanation shown after answering.</p>
</div>
```

Keep answers equal-length (words and, if possible, characters) and vary the
correct position across questions.
