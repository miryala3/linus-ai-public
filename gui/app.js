const state = {
  product: null,
};

function renderBadges(metadata) {
  const badges = [
    metadata.category,
    metadata.slug,
    metadata.standardizedAt,
  ];
  return badges
    .map((badge) => '<span class="badge">' + badge + "</span>")
    .join("");
}

function renderStatusCards(cards) {
  return cards
    .map(
      (card) => `
        <article class="status-card">
          <h3>${card.label}</h3>
          <strong>${card.value}</strong>
          <p>${card.detail}</p>
        </article>
      `,
    )
    .join("");
}

function renderRunbook(runbook) {
  return runbook
    .map(
      (item) => `
        <article class="runbook-card">
          <h3>${item.title}</h3>
          <p>${item.description}</p>
          <div class="command-line">${item.command}</div>
        </article>
      `,
    )
    .join("");
}

function renderSurfaces(surfaces) {
  if (!surfaces.length) {
    return '<article class="surface-card"><h3>No existing surfaces detected</h3><p>This project did not expose a root HTML or desktop entrypoint during the scan, so the standardized shell becomes the primary GUI baseline.</p></article>';
  }

  return surfaces
    .map(
      (surface) => `
        <article class="surface-card" role="listitem">
          <div class="surface-chip">${surface.kind}</div>
          <h3>${surface.label}</h3>
          <p>${surface.description}</p>
          <div class="surface-meta">${surface.path}</div>
        </article>
      `,
    )
    .join("");
}

function renderCommands(commands) {
  if (!commands.length) {
    return '<article class="command-card"><h3>No package scripts detected</h3><p>This standardized shell keeps the repository browsable even when the original project is static, backend-first, or only partially scaffolded.</p></article>';
  }

  return commands
    .map(
      (command) => `
        <article class="command-card">
          <h3>${command.name}</h3>
          <p>Existing command discovered in the original project metadata.</p>
          <div class="command-line">${command.command}</div>
        </article>
      `,
    )
    .join("");
}

function renderNotes(notes) {
  return notes.map((note) => '<li>' + note + "</li>").join("");
}

async function loadProduct() {
  const response = await fetch("./product.config.json");
  if (!response.ok) {
    throw new Error("Unable to load product configuration.");
  }
  state.product = await response.json();
}

function paint() {
  const { product } = state;
  document.title = product.title + " Standardized GUI";
  document.getElementById("product-title").textContent = product.title;
  document.getElementById("product-summary").textContent = product.summary;
  document.getElementById("hero-badges").innerHTML = renderBadges(product);
  document.getElementById("status-cards").innerHTML = renderStatusCards(product.statusCards);
  document.getElementById("runbook").innerHTML = renderRunbook(product.runbook);
  document.getElementById("surfaces").innerHTML = renderSurfaces(product.surfaces);
  document.getElementById("commands").innerHTML = renderCommands(product.commands);
  document.getElementById("notes").innerHTML = renderNotes(product.notes);
}

loadProduct()
  .then(paint)
  .catch((error) => {
    document.getElementById("product-title").textContent = "Standardized GUI unavailable";
    document.getElementById("product-summary").textContent = error.message;
  });
