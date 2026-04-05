# Contributing to Modern Backend Theme

Thank you for your interest in contributing! Here are some guidelines.

## How to Contribute

1. **Fork** the repo and create your branch from `main`
2. **Test** your changes with Odoo 17.0 CE
3. **Ensure** no SCSS compilation errors
4. **Submit** a pull request

## Guidelines

- Only CSS/SCSS changes — no Python or JS modifications
- Use hardcoded color values (no cross-file SCSS variable references)
- Test in both Chrome and Firefox
- Verify the backend still functions correctly after your changes
- Keep selectors scoped to `.o_web_client` where possible

## Reporting Issues

- Include your Odoo version
- Include browser and OS
- Attach screenshots if possible
- Describe expected vs actual behavior

## Code Style

- Use 4-space indentation in SCSS
- Comment each section clearly
- Use `!important` only when absolutely necessary
- Prefer class selectors over element selectors
