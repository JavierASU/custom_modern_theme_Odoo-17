# Frequently Asked Questions

## General

### What does this module do?
It replaces the default Odoo 17 Community Edition backend CSS with a modern, clean design. No functionality is changed — only visual appearance.

### Is it safe to install?
Yes. The module only adds CSS/SCSS overrides. It does not modify any Python logic, JavaScript behavior, or database structure. Uninstall at any time to revert.

### Does it work with Odoo Enterprise?
It is designed for **Odoo 17 Community Edition**. It may partially work with Enterprise, but Enterprise has its own theme that could conflict.

### Does it affect the website/frontend?
No. The theme only modifies `web.assets_backend` — the frontend/website is untouched.

---

## Installation

### The theme doesn't show after installing
1. Hard refresh your browser: `Ctrl+Shift+R`
2. Clear Odoo's asset cache (Settings > Technical > Attachments, delete assets)
3. Restart Odoo server

### Can I install it via pip?
No. This is an Odoo module, not a Python package. Clone it into your addons directory.

### Does it work with Docker?
Yes. Copy the module into your `extra-addons` volume and restart the container.

---

## Customization

### How do I change the primary color?
Edit the SCSS variables at the top of `static/src/scss/backend_theme.scss`. See [Color Presets](docs/COLOR_PRESETS.md) for ready-to-use options.

### Can I use only parts of the theme?
Yes. Each section in the SCSS file is clearly labeled (1-44). Comment out any section you don't want.

### How do I disable dark mode?
Remove or comment out section **44. DARK MODE** in `backend_theme.scss`.

### How do I disable animations?
Remove or comment out `backend_theme_animations.scss` from `__manifest__.py`, or rely on your OS "reduce motion" setting — the theme already respects `prefers-reduced-motion`.

---

## Dark Mode

### How do I enable dark mode?
Dark mode is automatic — it follows your operating system preference. There is no manual toggle in Odoo.

### How do I force dark/light mode?
Set your OS to dark/light mode:
- **Windows**: Settings > Personalization > Colors > Choose your mode
- **macOS**: System Preferences > Appearance
- **Linux**: Depends on your desktop environment

### Some elements look wrong in dark mode
Please [open an issue](https://github.com/JavierASU/custom_modern_theme_Odoo-17/issues/new?template=bug_report.md) with a screenshot and the affected view/module.

---

## Compatibility

### Does it work with other Odoo themes?
It may conflict if another theme also modifies `web.assets_backend`. Only use one backend theme at a time.

### Which browsers are supported?
Chrome, Firefox, and Edge (latest versions). Safari should work but is not actively tested.

### Does it support RTL languages?
Yes. Basic RTL support is included for Arabic, Hebrew, and other right-to-left languages.

---

## Contributing

### How do I contribute?
See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines, branching conventions, and code style rules.

### Can I add JavaScript features?
No. This module is CSS/SCSS-only by design. For JS features, consider creating a separate companion module.

### Where do I report bugs?
Use the [bug report template](https://github.com/JavierASU/custom_modern_theme_Odoo-17/issues/new?template=bug_report.md) on GitHub.
