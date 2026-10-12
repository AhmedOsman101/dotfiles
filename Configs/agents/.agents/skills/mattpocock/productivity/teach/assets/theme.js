// Reusable theme switch. Dark is the default; persists to localStorage.
// Contract: html[data-theme] ∈ {"dark","light"}; button[data-theme-toggle] toggles it.
(function () {
  const KEY = "teach-theme";
  function current() {
    return document.documentElement.dataset.theme === "light" ? "light" : "dark";
  }
  function label(btn, theme) {
    btn.textContent = theme === "dark" ? "☀ light" : "☾ dark";
    btn.setAttribute("aria-label", theme === "dark" ? "Switch to light mode" : "Switch to dark mode");
  }
  function apply(theme) {
    document.documentElement.dataset.theme = theme;
    try {
      localStorage.setItem(KEY, theme);
    } catch (e) {}
    document.querySelectorAll("[data-theme-toggle]").forEach((b) => label(b, theme));
  }
  document.addEventListener("click", (e) => {
    const btn = e.target.closest("[data-theme-toggle]");
    if (!btn) return;
    apply(current() === "dark" ? "light" : "dark");
  });
  // Initial paint (inline head snippet sets it even earlier to avoid flash).
  try {
    apply(localStorage.getItem(KEY) || document.documentElement.dataset.theme || "dark");
  } catch (e) {
    apply("dark");
  }
})();
