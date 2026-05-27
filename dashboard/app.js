(() => {
  const data = JSON.parse(document.getElementById("data").textContent);
  const customized = data.customized;
  const upstream = data.upstream;
  const categories = data.categories;

  const searchEl = document.getElementById("search");
  const filtersEl = document.getElementById("filters");
  const gridCust = document.getElementById("grid-customized");
  const gridUp = document.getElementById("grid-upstream");
  const custCount = document.getElementById("cust-count");
  const upCount = document.getElementById("up-count");
  const toast = document.getElementById("toast");

  let activeCategory = "all";
  let searchQuery = "";

  function makeCard(skill, isCustom) {
    const card = document.createElement("article");
    card.className = "card";
    card.dataset.name = skill.name;
    card.dataset.nameKo = skill.name_ko;
    card.dataset.category = skill.category;
    card.dataset.summary = skill.summary || "";

    const prompt = `/${skill.name}`;
    const naturalEx = (skill.examples && skill.examples[0]) || `${skill.name_ko} 스킬 쓰고 싶어`;
    const claudeUrl = `https://claude.ai/code?q=${encodeURIComponent(naturalEx)}`;

    card.innerHTML = `
      <div class="card-head">
        <div class="card-name-ko">${escapeHtml(skill.name_ko)}</div>
        <div class="card-name-en">${escapeHtml(skill.name)}</div>
      </div>
      <span class="card-cat">${escapeHtml(skill.category)}</span>
      <p class="card-summary">${escapeHtml(skill.summary || skill.description || "")}</p>
      ${(skill.examples && skill.examples.length) ? `
        <details class="examples">
          <summary>사용 예시 ${skill.examples.length}개</summary>
          <ul>${skill.examples.map(e => `<li>${escapeHtml(e)}</li>`).join("")}</ul>
        </details>` : ""}
      <div class="actions">
        <button class="btn copy-btn" data-prompt="${escapeHtml(prompt)}">📋 프롬프트 복사</button>
        <a class="btn btn-primary" href="${claudeUrl}" target="_blank" rel="noopener">🚀 Claude.ai 열기</a>
      </div>
    `;
    return card;
  }

  function escapeHtml(s) {
    return String(s).replace(/[&<>"']/g, c => ({
      "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;"
    }[c]));
  }

  function render() {
    [...customized].forEach(s => gridCust.appendChild(makeCard(s, true)));
    [...upstream].forEach(s => gridUp.appendChild(makeCard(s, false)));
    custCount.textContent = customized.length;
    upCount.textContent = upstream.length;
  }

  function renderFilters() {
    const cats = new Set([...customized, ...upstream].map(s => s.category));
    const buttons = ["all", ...[...cats].sort()];
    filtersEl.innerHTML = buttons.map(c => `
      <button class="filter-btn ${c === activeCategory ? 'active' : ''}" data-cat="${escapeHtml(c)}">
        ${c === "all" ? "전체" : escapeHtml(c)}
      </button>
    `).join("");
    filtersEl.querySelectorAll(".filter-btn").forEach(btn => {
      btn.addEventListener("click", () => {
        activeCategory = btn.dataset.cat;
        renderFilters();
        applyFilter();
      });
    });
  }

  function applyFilter() {
    const q = searchQuery.trim().toLowerCase();
    document.querySelectorAll(".card").forEach(card => {
      const matchCat = activeCategory === "all" || card.dataset.category === activeCategory;
      const haystack = (card.dataset.name + " " + card.dataset.nameKo + " " + card.dataset.summary).toLowerCase();
      const matchSearch = !q || haystack.includes(q);
      card.hidden = !(matchCat && matchSearch);
    });
  }

  function showToast(msg) {
    toast.textContent = msg;
    toast.classList.add("show");
    clearTimeout(showToast._t);
    showToast._t = setTimeout(() => toast.classList.remove("show"), 1800);
  }

  // event delegation — 복사 버튼
  document.body.addEventListener("click", e => {
    const btn = e.target.closest(".copy-btn");
    if (!btn) return;
    const text = btn.dataset.prompt;
    if (navigator.clipboard && navigator.clipboard.writeText) {
      navigator.clipboard.writeText(text).then(
        () => showToast(`'${text}' 복사됨`),
        () => showToast("복사 실패 — 수동으세요")
      );
    } else {
      const ta = document.createElement("textarea");
      ta.value = text; document.body.appendChild(ta);
      ta.select(); document.execCommand("copy"); ta.remove();
      showToast(`'${text}' 복사됨`);
    }
  });

  searchEl.addEventListener("input", e => {
    searchQuery = e.target.value;
    applyFilter();
  });

  renderFilters();
  render();
})();
