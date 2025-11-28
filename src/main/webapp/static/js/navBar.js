/**
 * 
 */


  const btn = document.getElementById("avatarBtn");
  const menu = document.getElementById("avatarDropdown");

  btn.addEventListener("click", () => {
    menu.classList.toggle("hidden");
  });

  // clicar fora fecha
  document.addEventListener("click", (e) => {
    if (!btn.contains(e.target) && !menu.contains(e.target)) {
      menu.classList.add("hidden");
    }
  });