// Reusable quiz widget: tight feedback loop, no dependencies.
// Usage:
// <div class="quiz" data-answer="b">
//   <fieldset><legend>...</legend>
//   <label><input type="radio" name="q1" value="a"> ...</label>
//   ...
//   <button type="button" data-check>Check</button>
//   <div class="feedback" aria-live="polite"></div>
// </div>
document.addEventListener("click", (e) => {
  const btn = e.target.closest("[data-check]");
  if (!btn) return;
  const box = btn.closest(".quiz");
  const key = box.dataset.answer;
  const picked = box.querySelector("input[type=radio]:checked");
  const fb = box.querySelector(".feedback");
  if (!picked) {
    fb.textContent = "Pick one first — retrieval is the point.";
    fb.className = "feedback no";
    return;
  }
  if (picked.value === key) {
    fb.textContent = "Correct. Say why in one sentence before moving on.";
    fb.className = "feedback ok";
  } else {
    fb.textContent = "Not quite — re-read the WHY box, then try again.";
    fb.className = "feedback no";
  }
});
document.addEventListener("click", (e) => {
  const btn = e.target.closest("[data-reset]");
  if (!btn) return;
  const box = btn.closest(".quiz");
  box.querySelectorAll("input[type=radio]").forEach((r) => (r.checked = false));
  const fb = box.querySelector(".feedback");
  fb.textContent = "";
  fb.className = "feedback";
});
