#!/bin/bash
# =============================================
# Instalador one-line do bash-pm2
# curl -fsSL https://raw.githubusercontent.com/lhabacuc/bash-pm2/main/install.sh | bash
# =============================================

set -e

REPO_URL="https://raw.githubusercontent.com/lhabacuc/bash-pm2/main/bash-pm2"
INSTALL_DIR="$HOME/bin"
SCRIPT_NAME="bash-pm2"

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

log() { echo -e "${CYAN}[installer]${NC} $*"; }
success() { echo -e "${GREEN}✓${NC} $*"; }
error() { echo -e "${RED}✗${NC} $*" >&2; exit 1; }
command -v curl >/dev/null 2>&1 || error "curl não encontrado. Instale: apt install curl"
command -v systemctl >/dev/null 2>&1 || error "systemd não disponível"
log "Baixando bash-pm2..."
mkdir -p "$INSTALL_DIR"

if curl -fsSL "$REPO_URL" -o "$INSTALL_DIR/$SCRIPT_NAME"; then
    chmod +x "$INSTALL_DIR/$SCRIPT_NAME"
    success "bash-pm2 baixado para $INSTALL_DIR/$SCRIPT_NAME"
else
    error "Falha ao baixar de $REPO_URL"
fi

log "Executando instalação..."
"$INSTALL_DIR/$SCRIPT_NAME" install

success "Instalação concluída!"
echo ""
echo "Execute no terminal atual:"
echo "   export PATH=\"\$HOME/bin:\$PATH\""
echo ""
echo "Ou abra um novo terminal e teste:"
echo "   bash-pm2 start 'echo hello' --name test"
echo "   bash-pm2 list"
echo ""
