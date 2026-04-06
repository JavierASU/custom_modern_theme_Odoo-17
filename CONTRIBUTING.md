# Contributing to Modern Backend Theme

Thank you for your interest in contributing! This guide will help you get started.

## Development Setup

1. **Clone** the repo:
   ```bash
   git clone https://github.com/JavierASU/custom_modern_theme_Odoo-17.git custom_modern_theme
   cd custom_modern_theme
   ```

2. **Set up Odoo 17** with the module in your addons path

3. **Install** the sass CLI for SCSS validation:
   ```bash
   npm install -g sass
   ```

4. **Validate** your SCSS before committing:
   ```bash
   sass static/src/scss/backend_theme.scss /dev/null --no-source-map
   ```

## How to Contribute

1. **Fork** the repo and create your branch from `main`
2. **Make** your changes (CSS/SCSS only)
3. **Test** your changes with Odoo 17.0 CE
4. **Validate** SCSS compiles without errors
5. **Submit** a pull request

## Branching Convention

| Prefix | Use |
|--------|-----|
| `feat/` | New feature or UI improvement |
| `fix/` | Bug fix |
| `docs/` | Documentation only |
| `chore/` | Maintenance (CI, config, cleanup) |
| `refactor/` | Code restructuring without new features |

Example: `feat/dark-mode-calendar` or `fix/navbar-dropdown-alignment`

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add hover effect for kanban cards
fix: correct navbar alignment on mobile
docs: update installation instructions
chore: update CI workflow
```

## Code Guidelines

### SCSS Rules
- Use **4-space** indentation
- Comment each section clearly with `// ===` headers
- Use `!important` only when absolutely necessary
- Prefer **class selectors** over element selectors
- Scope selectors to `.o_web_client` where possible
- Use **SCSS variables** (`$cmt-*`) for colors — never hardcode new colors

### What NOT to do
- No Python or JavaScript modifications
- No cross-file SCSS variable references to Odoo core
- No inline styles or `<style>` tags in templates
- No removing existing functionality

### Testing Checklist
- [ ] Tested in **Chrome** (latest)
- [ ] Tested in **Firefox** (latest)
- [ ] Tested with **Odoo 17.0 CE**
- [ ] Dark mode still works
- [ ] Print layout not broken
- [ ] No SCSS compilation errors
- [ ] `prefers-reduced-motion` respected for animations

## Reporting Issues

When opening an issue, include:
- Odoo version and edition (CE/Enterprise)
- Browser and OS
- Screenshots (before/after if possible)
- Steps to reproduce
- Expected vs actual behavior

## Code Review Process

1. All PRs are reviewed for CSS quality and Odoo compatibility
2. CI must pass (SCSS compilation + Python lint)
3. Screenshots in the PR are highly appreciated
4. Merges are done via merge commit to preserve history

## Need Help?

- Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common issues
- Open a [Discussion](https://github.com/JavierASU/custom_modern_theme_Odoo-17/discussions) for questions
- See [COLOR_PRESETS.md](docs/COLOR_PRESETS.md) for theming guide
