# Linus AI Public GUI Shell

This directory standardizes `linus-ai-public` with:

- A static web GUI entrypoint in [index.html](./index.html)
- A Tauri 2 desktop shell in [src-tauri](./src-tauri)
- Generated project metadata in [product.config.json](./product.config.json)

## Web

Open `gui/index.html` directly, or serve this directory with a simple static server:

```bash
cd gui
python3 -m http.server 8080
```

## Tauri

The desktop shell is intentionally minimal and points at the static GUI in this directory:

```bash
cargo check --manifest-path gui/src-tauri/Cargo.toml
```

## Purpose

The goal is to give every product repo in `prod-targets` a consistent, non-invasive GUI baseline without rewriting each project's existing implementation.
