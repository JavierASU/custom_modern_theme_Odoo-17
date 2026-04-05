# -*- coding: utf-8 -*-
# from odoo import http


# class CustomModernTheme(http.Controller):
#     @http.route('/custom_modern_theme/custom_modern_theme', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/custom_modern_theme/custom_modern_theme/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('custom_modern_theme.listing', {
#             'root': '/custom_modern_theme/custom_modern_theme',
#             'objects': http.request.env['custom_modern_theme.custom_modern_theme'].search([]),
#         })

#     @http.route('/custom_modern_theme/custom_modern_theme/objects/<model("custom_modern_theme.custom_modern_theme"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('custom_modern_theme.object', {
#             'object': obj
#         })

