# -*- coding: utf-8 -*-
{
    'name': 'Modern Backend Theme',
    'summary': 'A modern, clean UI redesign for Odoo 17 Community backend',
    'description': """
Modern Backend Theme for Odoo 17 CE
=====================================
Transforms the entire Odoo backend appearance:
- Modern navbar with refined colors and spacing
- Clean form views with better typography
- Improved list and kanban views
- Modern buttons, inputs, and dropdowns
- Better control panel and breadcrumbs
- Refined sidebar, modals, and notifications
- Google Fonts (Inter) for clean typography
- Dark mode (automatic via prefers-color-scheme)
- Login page styling
- Accessibility improvements (focus-visible, reduced motion)
- Print-optimized styles

Only changes CSS - zero functional changes. Uninstall to revert.
    """,
    'author': 'Custom Modern Theme Team',
    'category': 'Themes/Backend',
    'version': '17.0.1.1.0',
    'license': 'LGPL-3',

    'depends': ['web'],

    'data': [],

    'assets': {
        'web.assets_backend': [
            '/custom_modern_theme/static/src/scss/backend_theme.scss',
            '/custom_modern_theme/static/src/scss/backend_theme_rtl.scss',
        ],
    },

    'demo': [],
    'installable': True,
    'auto_install': False,
    'application': False,
}
