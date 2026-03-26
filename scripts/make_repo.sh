#!/bin/bash
set -e

TEMPLATE_URL="https://github.com/FelipeWoo/newpy.git"

if [ -z "$1" ]; then
  echo "Usage: newpy <project_name>"
  exit 1
fi

PROJECT_NAME=$1

git clone --depth 1 "$TEMPLATE_URL" "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit 1

rm -rf .git .venv logs htmlcov .pytest_cache
find . -type d -name "__pycache__" -exec rm -rf {} +
find . -type f -name "*.pyc" -delete

git init

# Create .private directory and notes.md
mkdir -p .private
cat <<EOF > .private/notes.md
---
created_at: $(date +%Y-%m-%d)
tags: [tag_1, tag_2]
---

# Title

## Context
This file contains personal notes related to the project.

## Observations
- Write anything relevant here.

## To Do
- [ ] Define initial steps
- [ ] Document decisions

EOF

# Create .env
cat <<EOF > .env
APP_NAME=$PROJECT_NAME
APP_ENV=development
LOG_LEVEL=DEBUG
EOF

# Ensure .private is ignored
grep -qxF ".private/" .gitignore || echo ".private/" >> .gitignore
grep -qxF ".env" .gitignore || echo ".env" >> .gitignore


echo "Project '$PROJECT_NAME' created successfully."
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  make init"
echo "  uv sync --extra dev --extra api --extra tools"
echo "  git add ."
echo "  git commit -m 'Initial project files $PROJECT_NAME'"
