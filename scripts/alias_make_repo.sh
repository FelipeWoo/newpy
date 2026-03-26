#!/usr/bin/env bash


SCRIPT_URL="https://raw.githubusercontent.com/FelipeWoo/newpy/refs/heads/master/scripts/make_repo.sh"
SCRIPT_PATH="$HOME/make_repo.sh"
ALIASES_FILE="$HOME/.bash_aliases"

# Descargar script
curl -fsSL "$SCRIPT_URL" -o "$SCRIPT_PATH"
chmod +x "$SCRIPT_PATH"

# Crear aliases file si no existe
touch "$ALIASES_FILE"

# Agregar función solo si no existe
if ! grep -q "newpy()" "$ALIASES_FILE"; then
cat >> "$ALIASES_FILE" <<EOF

# newpy repo generator
newpy() {
    "$SCRIPT_PATH" "\$@"
}
EOF
fi

echo "Installed function: newpy"
echo "Run: source $ALIASES_FILE"