#!/usr/bin/env bash
set -euo pipefail

TARGET_PATH="${1:-.}"
INCLUDE_GUIDES="${INCLUDE_GUIDES:-0}"
FORCE="${FORCE:-0}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_PATH="$(cd "$TARGET_PATH" && pwd)"

copy_file() {
  local source="$1"
  local destination="$2"
  mkdir -p "$(dirname "$destination")"
  if [[ ! -f "$destination" ]]; then
    cp "$source" "$destination"
    echo "created"
  elif [[ "$FORCE" == "1" ]]; then
    cp "$source" "$destination"
    echo "updated"
  else
    echo "skipped"
  fi
}

copy_tree() {
  local source_dir="$1"
  local target_dir="$2"

  local created=0
  local updated=0
  local skipped=0

  while IFS= read -r -d '' file; do
    local relative="${file#$source_dir/}"
    local destination="$target_dir/$relative"
    local result
    result="$(copy_file "$file" "$destination")"
    case "$result" in
      created) created=$((created + 1)) ;;
      updated) updated=$((updated + 1)) ;;
      skipped) skipped=$((skipped + 1)) ;;
    esac
  done < <(find "$source_dir" -type f -print0)

  echo "$created;$updated;$skipped"
}

IFS=';' read -r skills_created skills_updated skills_skipped <<< "$(copy_tree "$REPO_ROOT/skills" "$TARGET_PATH/skills")"

guide_created=0
guide_updated=0
guide_skipped=0
if [[ "$INCLUDE_GUIDES" == "1" ]]; then
  for file in AGENTS.md CLAUDE.md; do
    result="$(copy_file "$REPO_ROOT/$file" "$TARGET_PATH/$file")"
    case "$result" in
      created) guide_created=$((guide_created + 1)) ;;
      updated) guide_updated=$((guide_updated + 1)) ;;
      skipped) guide_skipped=$((guide_skipped + 1)) ;;
    esac
  done
fi

echo
echo "Software Factory Template - sincronizacao concluida"
echo "Destino: $TARGET_PATH"
echo
echo "Skills -> criadas: $skills_created | atualizadas: $skills_updated | ignoradas: $skills_skipped"
if [[ "$INCLUDE_GUIDES" == "1" ]]; then
  echo "Guias raiz -> criados: $guide_created | atualizados: $guide_updated | ignorados: $guide_skipped"
fi
echo
echo "Observacao: FLOW.md e docs factuais do projeto nao sao sobrescritos pelo sync."
