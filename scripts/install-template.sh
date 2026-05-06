#!/usr/bin/env bash
set -euo pipefail

TARGET_PATH="${1:-.}"
MODE="${2:-new}"
FORCE="${FORCE:-0}"
INIT_GIT="${INIT_GIT:-0}"
REMOTE_URL="${REMOTE_URL:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
mkdir -p "$TARGET_PATH"
TARGET_PATH="$(cd "$TARGET_PATH" && pwd)"

if [[ "$MODE" != "new" && "$MODE" != "existing" ]]; then
  echo "Modo invalido. Use: new ou existing"
  exit 1
fi

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

if [[ "$MODE" == "new" && "$FORCE" != "1" ]]; then
  if find "$TARGET_PATH" -mindepth 1 -maxdepth 1 ! -name ".git" | read -r _; then
    echo "A pasta de destino nao esta vazia. Use modo existing ou FORCE=1."
    exit 1
  fi
fi

root_created=0
root_updated=0
root_skipped=0
dir_created=0
dir_updated=0
dir_skipped=0

for file in .gitignore AGENTS.md CLAUDE.md FLOW.md README.md; do
  result="$(copy_file "$REPO_ROOT/$file" "$TARGET_PATH/$file")"
  case "$result" in
    created) root_created=$((root_created + 1)) ;;
    updated) root_updated=$((root_updated + 1)) ;;
    skipped) root_skipped=$((root_skipped + 1)) ;;
  esac
done

for directory in docs skills; do
  IFS=';' read -r created updated skipped <<< "$(copy_tree "$REPO_ROOT/$directory" "$TARGET_PATH/$directory")"
  dir_created=$((dir_created + created))
  dir_updated=$((dir_updated + updated))
  dir_skipped=$((dir_skipped + skipped))
done

if [[ "$INIT_GIT" == "1" && ! -d "$TARGET_PATH/.git" ]]; then
  (
    cd "$TARGET_PATH"
    git init -b main >/dev/null
    if [[ -n "$REMOTE_URL" ]]; then
      git remote add origin "$REMOTE_URL"
    fi
  )
fi

echo
echo "Software Factory Template - instalacao concluida"
echo "Destino: $TARGET_PATH"
echo "Modo: $MODE"
echo
echo "Arquivos raiz -> criados: $root_created | atualizados: $root_updated | ignorados: $root_skipped"
echo "Diretorios/docs/skills -> criados: $dir_created | atualizados: $dir_updated | ignorados: $dir_skipped"
echo
if [[ "$MODE" == "new" ]]; then
  echo "Proximo passo: abrir o projeto e seguir FLOW.md -> docs/00_Contexto_Mestre.md -> skills/factory"
else
  echo "Proximo passo: preencher docs/20, docs/21 e docs/22 com o estado real antes de implementar"
fi
