/* Shared quiz component.
 * Markup contract (no build step, plain HTML):
 *
 *   <div class="quiz" data-quiz>
 *     <p class="quiz-q">Question text?</p>
 *     <div class="quiz-choices">
 *       <button data-correct>answer A</button>
 *       <button>answer B</button>
 *     </div>
 *     <p class="quiz-feedback" hidden data-why>Explanation shown after answering.</p>
 *   </div>
 *
 * Buttons show immediate feedback; an explanation is revealed after the
 * user answers. All choices should be the same length so formatting never
 * hints at the answer.
 */
(function () {
  function initQuiz(root) {
    var buttons = root.querySelectorAll(".quiz-choices button");
    var feedback = root.querySelector(".quiz-feedback");

    buttons.forEach(function (btn) {
      btn.style.cssText =
        "display:block;width:100%;max-width:34rem;margin:0.35rem 0;padding:0.55rem 0.9rem;" +
        "font:inherit;text-align:left;border:1.5px solid #34383f;border-radius:8px;" +
        "background:#1e2128;color:#e2e0dd;cursor:pointer";
      btn.addEventListener("click", function () {
        if (root.dataset.done) return;
        root.dataset.done = "1";
        var correct = btn.hasAttribute("data-correct");
        btn.style.borderColor = correct ? "#7fbf7f" : "#d97b6c";
        btn.style.background = correct ? "#1f2b1f" : "#2b2020";
        buttons.forEach(function (other) {
          if (other !== btn) {
            other.style.opacity = "0.55";
            other.style.cursor = "default";
            if (other.hasAttribute("data-correct")) other.style.borderColor = "#7fbf7f";
          }
        });
        if (feedback) {
          feedback.hidden = false;
          feedback.style.cssText =
            "margin-top:0.8rem;padding:0.7rem 1rem;border-radius:8px;font-size:0.95rem;" +
            (correct
              ? "background:#1f2b1f;border-left:4px solid #7fbf7f"
              : "background:#2b2020;border-left:4px solid #d97b6c");
        }
      });
    });
  }

  document.querySelectorAll("[data-quiz]").forEach(initQuiz);

  // Sanity check: every quiz must have exactly one correct answer.
  document.querySelectorAll("[data-quiz]").forEach(function (root) {
    var correct = root.querySelectorAll(".quiz-choices [data-correct]");
    if (correct.length !== 1) {
      console.error("Quiz markup error: expected exactly 1 [data-correct], found " + correct.length, root);
    }
  });
})();
