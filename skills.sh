#!/bin/bash
# ============================================================================
# CUSTOM MODERN THEME - Odoo 17 Development Skills
# ============================================================================
# Carga: source skills.sh
# Uso: Cada función es un comando disponible en tu terminal
# ============================================================================

# --- Colores ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# --- Configuración ---
ODOO_HOME="${ODOO_HOME:-/c/odoo-project}"
ODOO_BIN="${ODOO_HOME}/odoo-bin"
ODOO_CONF="${ODOO_HOME}/odoo.conf"
ADDONS_PATH="${ODOO_HOME}/addons"
THEME_PATH="${ADDONS_PATH}/custom_modern_theme"
DB_NAME="${ODOO_DB:-odoo17}"
PYTHON="${PYTHON_BIN:-python3}"
VENV_PATH="${ODOO_HOME}/venv"

# ============================================================================
# 1. GESTIÓN DEL SERVIDOR ODOO
# ============================================================================

odoo_start() {
    echo -e "${GREEN}▶ Iniciando Odoo 17...${NC}"
    if [ -f "$VENV_PATH/Scripts/activate" ]; then
        source "$VENV_PATH/Scripts/activate"
    elif [ -f "$VENV_PATH/bin/activate" ]; then
        source "$VENV_PATH/bin/activate"
    fi
    $PYTHON "$ODOO_BIN" -c "$ODOO_CONF" --addons-path="$ADDONS_PATH,${ODOO_HOME}/odoo/addons" -d "$DB_NAME" "$@"
}

odoo_start_dev() {
    echo -e "${CYAN}▶ Iniciando Odoo 17 en modo desarrollo (hot-reload)...${NC}"
    odoo_start --dev=reload,qweb,xml "$@"
}

odoo_start_debug() {
    echo -e "${YELLOW}▶ Iniciando Odoo 17 con debugger...${NC}"
    odoo_start --dev=reload,qweb,xml --log-level=debug "$@"
}

odoo_stop() {
    echo -e "${RED}■ Deteniendo Odoo...${NC}"
    pkill -f "odoo-bin" 2>/dev/null || taskkill //F //IM python.exe 2>/dev/null
    echo -e "${GREEN}✓ Odoo detenido${NC}"
}

odoo_restart() {
    odoo_stop
    sleep 2
    odoo_start_dev "$@"
}

# ============================================================================
# 2. GESTIÓN DE MÓDULOS
# ============================================================================

theme_install() {
    echo -e "${GREEN}📦 Instalando custom_modern_theme...${NC}"
    odoo_start -i custom_modern_theme --stop-after-init "$@"
    echo -e "${GREEN}✓ Theme instalado${NC}"
}

theme_upgrade() {
    echo -e "${YELLOW}🔄 Actualizando custom_modern_theme...${NC}"
    odoo_start -u custom_modern_theme --stop-after-init "$@"
    echo -e "${GREEN}✓ Theme actualizado${NC}"
}

theme_reinstall() {
    echo -e "${RED}🔄 Reinstalando custom_modern_theme (desinstalar + instalar)...${NC}"
    odoo_start --stop-after-init -c "$ODOO_CONF" \
        --shell-command="env['ir.module.module'].search([('name','=','custom_modern_theme')]).button_immediate_uninstall()" 2>/dev/null
    sleep 2
    theme_install "$@"
}

module_install() {
    local module_name="${1:?Uso: module_install <nombre_modulo>}"
    echo -e "${GREEN}📦 Instalando $module_name...${NC}"
    odoo_start -i "$module_name" --stop-after-init
}

module_upgrade() {
    local module_name="${1:?Uso: module_upgrade <nombre_modulo>}"
    echo -e "${YELLOW}🔄 Actualizando $module_name...${NC}"
    odoo_start -u "$module_name" --stop-after-init
}

# ============================================================================
# 3. GESTIÓN DE BASE DE DATOS
# ============================================================================

db_create() {
    local db="${1:-$DB_NAME}"
    echo -e "${GREEN}🗄️ Creando base de datos: $db${NC}"
    createdb "$db" 2>/dev/null || echo "DB ya existe o error"
    odoo_start -d "$db" -i base --stop-after-init --without-demo=all
    echo -e "${GREEN}✓ Base de datos $db creada${NC}"
}

db_drop() {
    local db="${1:-$DB_NAME}"
    echo -e "${RED}🗑️ Eliminando base de datos: $db${NC}"
    dropdb "$db" 2>/dev/null
    echo -e "${GREEN}✓ Base de datos $db eliminada${NC}"
}

db_backup() {
    local db="${1:-$DB_NAME}"
    local backup_file="backup_${db}_$(date +%Y%m%d_%H%M%S).sql"
    echo -e "${BLUE}💾 Respaldo de $db -> $backup_file${NC}"
    pg_dump "$db" > "$backup_file"
    echo -e "${GREEN}✓ Respaldo completado: $backup_file${NC}"
}

db_restore() {
    local backup_file="${1:?Uso: db_restore <archivo.sql> [nombre_db]}"
    local db="${2:-$DB_NAME}"
    echo -e "${YELLOW}📥 Restaurando $backup_file -> $db${NC}"
    psql "$db" < "$backup_file"
    echo -e "${GREEN}✓ Restauración completada${NC}"
}

db_reset() {
    local db="${1:-$DB_NAME}"
    echo -e "${RED}⚠️ Reset completo de $db (drop + create + install theme)${NC}"
    db_drop "$db"
    db_create "$db"
    theme_install
}

# ============================================================================
# 4. DESARROLLO Y ASSETS
# ============================================================================

assets_compile() {
    echo -e "${CYAN}🎨 Compilando assets (SCSS/JS)...${NC}"
    odoo_start --stop-after-init \
        --shell-command="env['ir.qweb'].sudo()._pregenerate_assets_bundles()" 2>/dev/null
    echo -e "${GREEN}✓ Assets compilados${NC}"
}

assets_clear() {
    echo -e "${YELLOW}🧹 Limpiando cache de assets...${NC}"
    odoo_start --stop-after-init \
        --shell-command="env['ir.attachment'].search([('url','like','/web/assets/')]).unlink()" 2>/dev/null
    echo -e "${GREEN}✓ Cache de assets limpiada${NC}"
}

scss_watch() {
    echo -e "${CYAN}👁️ Modo watch SCSS (requiere node-sass o sass)...${NC}"
    local scss_dir="${THEME_PATH}/static/src/scss"
    local css_dir="${THEME_PATH}/static/src/css"
    mkdir -p "$css_dir"
    if command -v sass &>/dev/null; then
        sass --watch "$scss_dir:$css_dir" --style=compressed
    elif command -v npx &>/dev/null; then
        npx sass --watch "$scss_dir:$css_dir" --style=compressed
    else
        echo -e "${RED}✗ Instala sass: npm install -g sass${NC}"
    fi
}

lint_scss() {
    echo -e "${CYAN}🔍 Linting SCSS...${NC}"
    if command -v npx &>/dev/null; then
        npx stylelint "${THEME_PATH}/static/src/scss/**/*.scss" --fix
    else
        echo -e "${YELLOW}Instala stylelint: npm install -g stylelint stylelint-config-standard-scss${NC}"
    fi
}

lint_js() {
    echo -e "${CYAN}🔍 Linting JavaScript...${NC}"
    if command -v npx &>/dev/null; then
        npx eslint "${THEME_PATH}/static/src/js/" --fix
    else
        echo -e "${YELLOW}Instala eslint: npm install -g eslint${NC}"
    fi
}

lint_py() {
    echo -e "${CYAN}🔍 Linting Python...${NC}"
    if command -v flake8 &>/dev/null; then
        flake8 "$THEME_PATH" --max-line-length=120 --exclude=__pycache__
    elif command -v pylint &>/dev/null; then
        pylint "$THEME_PATH" --rcfile="${ODOO_HOME}/.pylintrc" 2>/dev/null || pylint "$THEME_PATH"
    else
        echo -e "${YELLOW}Instala flake8: pip install flake8${NC}"
    fi
}

lint_xml() {
    echo -e "${CYAN}🔍 Validando XML...${NC}"
    find "$THEME_PATH" -name "*.xml" -exec xmllint --noout {} \; 2>&1 | grep -v "^$"
    echo -e "${GREEN}✓ Validación XML completada${NC}"
}

lint_all() {
    lint_py
    lint_js
    lint_scss
    lint_xml
}

# ============================================================================
# 5. TESTING
# ============================================================================

test_theme() {
    echo -e "${CYAN}🧪 Ejecutando tests del theme...${NC}"
    odoo_start --test-enable --test-tags=custom_modern_theme --stop-after-init --log-level=test "$@"
}

test_module() {
    local module="${1:?Uso: test_module <nombre_modulo>}"
    echo -e "${CYAN}🧪 Tests de $module...${NC}"
    odoo_start --test-enable --test-tags="$module" --stop-after-init --log-level=test
}

test_js() {
    echo -e "${CYAN}🧪 Tests JavaScript...${NC}"
    odoo_start --test-enable --test-tags=custom_modern_theme:js --stop-after-init
}

# ============================================================================
# 6. SCAFFOLDING Y GENERADORES
# ============================================================================

gen_snippet() {
    local name="${1:?Uso: gen_snippet <nombre_snippet>}"
    local snake_name=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
    local class_name=$(echo "$name" | sed 's/_/ /g' | sed 's/\b\(.\)/\u\1/g' | tr -d ' ')

    echo -e "${GREEN}🧩 Generando snippet: $name${NC}"

    # Template XML
    cat > "${THEME_PATH}/views/snippets/s_${snake_name}.xml" << XMLEOF
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <!-- Snippet: ${name} -->
    <template id="s_${snake_name}" name="${class_name}">
        <section class="s_${snake_name} pt48 pb48">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h2>${class_name} Section</h2>
                        <p class="lead">Edit this content in the website builder</p>
                    </div>
                </div>
            </div>
        </section>
    </template>

    <!-- Register in snippet list -->
    <template id="s_${snake_name}_snippet" inherit_id="website.snippets" name="${class_name} Snippet">
        <xpath expr="//snippets[@id='snippet_structure']" position="inside">
            <t t-snippet="custom_modern_theme.s_${snake_name}"
               t-thumbnail="/custom_modern_theme/static/src/img/snippets/s_${snake_name}.svg"/>
        </xpath>
    </template>

    <!-- Snippet Options -->
    <template id="s_${snake_name}_options" inherit_id="website.snippet_options">
        <xpath expr="." position="inside">
            <div data-selector=".s_${snake_name}" data-js="${class_name}Options">
                <we-select string="Layout">
                    <we-button data-select-class="">Default</we-button>
                    <we-button data-select-class="s_${snake_name}_alt">Alternative</we-button>
                </we-select>
            </div>
        </xpath>
    </template>
</odoo>
XMLEOF

    # SCSS
    cat > "${THEME_PATH}/static/src/scss/snippets/_s_${snake_name}.scss" << SCSSEOF
// Snippet: ${class_name}
.s_${snake_name} {
    position: relative;
    overflow: hidden;

    h2 {
        font-weight: 700;
        margin-bottom: 1rem;
    }

    .lead {
        color: var(--cmt-text-muted);
    }

    // Alternative layout
    &.s_${snake_name}_alt {
        background: var(--cmt-bg-secondary);
    }
}
SCSSEOF

    echo -e "${GREEN}✓ Snippet generado:${NC}"
    echo "  - views/snippets/s_${snake_name}.xml"
    echo "  - static/src/scss/snippets/_s_${snake_name}.scss"
    echo -e "${YELLOW}⚠ Recuerda agregar el XML al __manifest__.py${NC}"
}

gen_page() {
    local name="${1:?Uso: gen_page <nombre_pagina>}"
    local snake_name=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')

    echo -e "${GREEN}📄 Generando página: $name${NC}"

    cat > "${THEME_PATH}/data/page_${snake_name}.xml" << XMLEOF
<?xml version="1.0" encoding="utf-8"?>
<odoo>
    <record id="page_${snake_name}" model="website.page">
        <field name="name">${name}</field>
        <field name="url">/${snake_name}</field>
        <field name="type">qweb</field>
        <field name="key">custom_modern_theme.page_${snake_name}</field>
        <field name="arch" type="xml">
            <t t-name="custom_modern_theme.page_${snake_name}">
                <t t-call="website.layout">
                    <div id="wrap" class="oe_structure oe_empty">
                        <section class="pt48 pb48">
                            <div class="container">
                                <h1>${name}</h1>
                                <p>Page content here</p>
                            </div>
                        </section>
                    </div>
                </t>
            </t>
        </field>
    </record>
</odoo>
XMLEOF

    echo -e "${GREEN}✓ Página generada: data/page_${snake_name}.xml${NC}"
}

# ============================================================================
# 7. GIT Y VERSIONAMIENTO
# ============================================================================

theme_version() {
    local version=$(grep "'version'" "${THEME_PATH}/__manifest__.py" | grep -oP "'[\d.]+'")
    echo -e "${BLUE}📌 Versión actual: $version${NC}"
}

theme_bump() {
    local type="${1:-patch}"
    local current=$(grep "'version'" "${THEME_PATH}/__manifest__.py" | grep -oP "[\d.]+")
    local IFS='.'
    read -ra parts <<< "$current"

    case "$type" in
        major) parts[0]=$((parts[0]+1)); parts[1]=0; parts[2]=0 ;;
        minor) parts[1]=$((parts[1]+1)); parts[2]=0 ;;
        patch) parts[2]=$((parts[2]+1)) ;;
    esac

    local new_version="${parts[0]}.${parts[1]}.${parts[2]}"
    sed -i "s/'version': '${current}'/'version': '${new_version}'/" "${THEME_PATH}/__manifest__.py"
    echo -e "${GREEN}✓ Versión: $current → $new_version${NC}"
}

# ============================================================================
# 8. DEPLOYMENT Y EMPAQUETADO
# ============================================================================

theme_package() {
    local version=$(grep "'version'" "${THEME_PATH}/__manifest__.py" | grep -oP "[\d.]+")
    local pkg_name="custom_modern_theme_v${version}.zip"
    echo -e "${BLUE}📦 Empaquetando theme...${NC}"
    cd "$ADDONS_PATH"
    zip -r "$pkg_name" custom_modern_theme/ \
        -x "*.pyc" "*__pycache__*" "*.git*" "*.idea*" "*node_modules*" "*.vscode*"
    cd -
    echo -e "${GREEN}✓ Paquete: ${ADDONS_PATH}/${pkg_name}${NC}"
}

theme_check_manifest() {
    echo -e "${CYAN}🔍 Verificando __manifest__.py...${NC}"
    $PYTHON -c "
import ast, sys
try:
    with open('${THEME_PATH}/__manifest__.py') as f:
        manifest = ast.literal_eval(f.read())
    required = ['name', 'version', 'category', 'depends', 'data', 'license']
    missing = [k for k in required if k not in manifest]
    if missing:
        print(f'⚠ Campos faltantes: {missing}')
        sys.exit(1)
    if manifest.get('category') != 'Theme':
        print('⚠ category debería ser Theme')
    if 'website' not in manifest.get('depends', []):
        print('⚠ website debería estar en depends')
    print('✓ Manifest válido')
    for k, v in manifest.items():
        print(f'  {k}: {v}')
except Exception as e:
    print(f'✗ Error: {e}')
    sys.exit(1)
"
}

# ============================================================================
# 9. UTILIDADES
# ============================================================================

theme_tree() {
    echo -e "${BLUE}📂 Estructura del theme:${NC}"
    if command -v tree &>/dev/null; then
        tree "$THEME_PATH" -I "__pycache__|*.pyc|node_modules" --dirsfirst
    else
        find "$THEME_PATH" -not -path "*__pycache__*" -not -name "*.pyc" | sort | \
            sed "s|${THEME_PATH}||" | sed 's|/[^/]*$|  &|' | sed 's|^/||'
    fi
}

theme_loc() {
    echo -e "${BLUE}📊 Líneas de código:${NC}"
    echo -n "  Python: "; find "$THEME_PATH" -name "*.py" -exec cat {} + 2>/dev/null | wc -l
    echo -n "  XML:    "; find "$THEME_PATH" -name "*.xml" -exec cat {} + 2>/dev/null | wc -l
    echo -n "  SCSS:   "; find "$THEME_PATH" -name "*.scss" -exec cat {} + 2>/dev/null | wc -l
    echo -n "  JS:     "; find "$THEME_PATH" -name "*.js" -exec cat {} + 2>/dev/null | wc -l
    echo -n "  Total:  "; find "$THEME_PATH" \( -name "*.py" -o -name "*.xml" -o -name "*.scss" -o -name "*.js" \) -exec cat {} + 2>/dev/null | wc -l
}

odoo_shell() {
    echo -e "${CYAN}🐚 Abriendo Odoo Shell...${NC}"
    odoo_start shell "$@"
}

odoo_logs() {
    local log_file="${ODOO_HOME}/odoo.log"
    if [ -f "$log_file" ]; then
        tail -f "$log_file" | grep --color=auto -E "ERROR|WARNING|INFO|$"
    else
        echo -e "${YELLOW}No se encontró archivo de log. Inicia Odoo con: odoo_start 2>&1 | tee odoo.log${NC}"
    fi
}

theme_help() {
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║     Custom Modern Theme - Odoo 17 Dev Skills            ║${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC} ${GREEN}SERVIDOR${NC}                                               ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   odoo_start          Iniciar Odoo                      ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   odoo_start_dev      Iniciar con hot-reload            ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   odoo_start_debug    Iniciar con debug                 ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   odoo_stop           Detener Odoo                      ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   odoo_restart        Reiniciar Odoo                    ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                                                          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC} ${GREEN}MÓDULOS${NC}                                                 ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_install       Instalar theme                    ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_upgrade       Actualizar theme                  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_reinstall     Reinstalar theme                  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   module_install <m>  Instalar módulo                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   module_upgrade <m>  Actualizar módulo                 ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                                                          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC} ${GREEN}BASE DE DATOS${NC}                                           ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   db_create [db]      Crear BD                          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   db_drop [db]        Eliminar BD                       ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   db_backup [db]      Respaldar BD                      ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   db_restore <f> [d]  Restaurar BD                      ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   db_reset [db]       Reset completo                    ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                                                          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC} ${GREEN}DESARROLLO${NC}                                              ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   assets_compile      Compilar SCSS/JS                  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   assets_clear        Limpiar cache assets              ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   scss_watch          Watch SCSS changes                ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   lint_all            Lint todo (py/js/scss/xml)        ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                                                          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC} ${GREEN}TESTING${NC}                                                 ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   test_theme          Tests del theme                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   test_module <m>     Tests de módulo                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   test_js             Tests JavaScript                  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                                                          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC} ${GREEN}GENERADORES${NC}                                             ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   gen_snippet <name>  Generar snippet                   ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   gen_page <name>     Generar página                    ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}                                                          ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC} ${GREEN}UTILIDADES${NC}                                              ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_tree          Estructura de archivos            ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_loc           Líneas de código                  ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_version       Ver versión                       ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_bump [type]   Incrementar versión               ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_package       Empaquetar como ZIP              ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   theme_check_manifest Verificar manifest               ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   odoo_shell          Abrir shell interactivo           ${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}   odoo_logs           Ver logs en tiempo real           ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
}

# --- Auto-mensaje al cargar ---
echo -e "${GREEN}✓ Skills de desarrollo Odoo 17 cargadas${NC}"
echo -e "${CYAN}  Escribe 'theme_help' para ver todos los comandos disponibles${NC}"
