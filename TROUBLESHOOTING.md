# Troubleshooting

Common issues and solutions for Modern Backend Theme.

## Theme not applying after installation

1. **Clear browser cache**: Press `Ctrl+Shift+R` (hard refresh)
2. **Clear Odoo asset cache**:
   ```bash
   # From Odoo shell
   env['ir.attachment'].search([('url', 'like', '/web/assets/')]).unlink()
   ```
3. **Restart Odoo server** and try again

## SCSS compilation errors

- Ensure you're running **Odoo 17.0** (not 16.0 or 18.0)
- Check that no other theme module conflicts with `web.assets_backend`
- Verify the SCSS file has no syntax errors: `sass --check static/src/scss/backend_theme.scss`

## Dark mode not working

- Dark mode uses `prefers-color-scheme: dark` — it follows your **OS/browser** setting
- It does **not** have a manual toggle (yet)
- Check your system: Windows Settings > Personalization > Colors > Dark

## Theme conflicts with other modules

- This theme only modifies `web.assets_backend` CSS
- If another module also overrides the same CSS classes, the last-loaded module wins
- Try adjusting module load order in `__manifest__.py` by adding the conflicting module to `depends`

## Fonts not loading

- The theme uses the **Inter** font with `font-display: swap`
- It loads via `@font-face` with `src: local('Inter')` — the font must be installed on the user's system
- Fallback fonts: `system-ui, -apple-system, Segoe UI, Roboto, sans-serif`

## Print layout issues

- The theme includes print styles that hide navigation elements
- If you need custom print behavior, override the `@media print` section in the SCSS file

## Docker-specific issues

```bash
# Verify the module is in the addons path
docker exec odoo_container ls /mnt/extra-addons/custom_modern_theme/

# Check Odoo logs for errors
docker logs odoo_container --tail 50

# Force module update
docker exec odoo_container odoo -u custom_modern_theme --stop-after-init
```

## Still need help?

- [Open an issue](https://github.com/JavierASU/custom_modern_theme_Odoo-17/issues/new/choose) with details
- Include your Odoo version, browser, and screenshots
