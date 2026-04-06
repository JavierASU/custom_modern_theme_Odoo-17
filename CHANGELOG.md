# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Odoo versioning](https://www.odoo.com/documentation/17.0/developer/reference/module.html).

## [17.0.1.1.0] - 2026-04-06

### Added
- **Dark Mode**: Automatic dark theme via `prefers-color-scheme: dark` for all 40+ UI areas
- **Login Page Styling**: Modern login page with gradient background and themed inputs
- **Accessibility**: Focus-visible indicators, reduced-motion support, keyboard navigation
- **Print Styles**: Clean print output hiding navigation, optimizing forms and lists
- **SCSS Variables**: All colors and design tokens extracted to variables for easy customization
- **GitHub Pages**: Documentation site with feature showcase and installation guide
- **CI/CD Pipeline**: GitHub Actions for SCSS validation, Python linting, and module structure checks
- **CodeQL Analysis**: Automated security scanning on every push and PR
- **Dependabot**: Automated dependency updates for GitHub Actions
- **Community Standards**: CODE_OF_CONDUCT, SECURITY policy, issue/PR templates, stale bot
- **FUNDING.yml**: GitHub Sponsors support

### Changed
- Improved CHANGELOG format to follow Keep a Changelog standard
- Cleaned up scaffold code in models.py and controllers.py
- Removed empty `demo/` and `views/` directories
- Updated README with CI badge

## [17.0.1.0.0] - 2026-04-05

### Added
- Initial release of Modern Backend Theme for Odoo 17 CE
- 40 UI sections redesigned:
  - Navbar with dark slate background and refined spacing
  - Home menu with gradient background and app icon animations
  - Control panel with modern search bar and breadcrumbs
  - Buttons with indigo primary color and hover lift effects
  - Form views with card-style sheets and rounded corners
  - List views with uppercase headers and subtle row hover
  - Kanban views with rounded cards and hover lift
  - Settings with hover effects and better typography
  - Modals with rounded corners and refined shadows
  - Notifications with colored left border and blur backdrop
  - Badges and tags with pill shapes and semantic colors
  - Tooltips with dark background and rounded corners
  - Switches and toggles with indigo checked state
  - Custom scrollbars (thin, minimal)
  - Pivot and graph views with clean typography
  - Calendar events with rounded corners
  - Chatter and discuss with refined sidebar
  - Many2One dropdowns with modern styling
  - Loading indicator with indigo color
  - Stat buttons with hover effects
  - Many2Many tags with pill shape
  - Progress bars with gradient fill
  - Priority stars with scale animation
  - Status selection dots with hover scale
  - Activity view with clean headers
  - Dashboard cards with hover elevation
  - Favorites toggle with animation
  - Search panel sidebar with rounded items
  - Wizard/dialog forms with clean styling
  - Empty state with improved typography
  - Checkboxes and radios with indigo state
  - File attachments with hover effects
  - Report/print action menus
  - Color palette with circular swatches
  - App switcher with rounded icons
  - Generic tables with hover backgrounds
  - Ribbon badges with uppercase text
  - Input groups with consistent styling
- Inter font family for clean, modern typography
- Indigo (#6366f1) as primary accent color
- Smooth transitions and hover effects (200-300ms)
- Single SCSS file architecture for maximum reliability
- Full compatibility with Odoo 17.0 Community Edition
