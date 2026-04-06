# Security Policy

## Supported Versions

| Version    | Supported          |
| ---------- | ------------------ |
| 17.0.1.x.x | :white_check_mark: |
| < 17.0     | :x:                |

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability in this project,
please report it responsibly.

### How to Report

1. **Do NOT** open a public GitHub issue for security vulnerabilities
2. **Email** us at: **s_javier_11@hotmail.com**
3. Include the following in your report:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### What to Expect

- **Acknowledgment**: We will acknowledge your report within 48 hours
- **Assessment**: We will assess the vulnerability within 7 days
- **Fix**: Critical vulnerabilities will be patched as soon as possible
- **Disclosure**: We will coordinate with you on public disclosure timing

### Scope

This module is a **pure CSS/SCSS theme** with no backend logic, API endpoints,
or data processing. The primary security concerns are:

- CSS injection through customization
- Supply chain integrity of the module files
- Compatibility issues that could expose underlying Odoo UI elements

### Best Practices for Users

- Always download this module from the official GitHub repository
- Verify the integrity of files after download
- Keep your Odoo instance updated to the latest security patches
- Review any CSS customizations before deploying to production

## Security Updates

Security updates will be released as patch versions and announced through:
- GitHub Releases
- Repository README notifications
