#!/usr/bin/env python
from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import urllib.error
import urllib.request
import zipfile


def download_repo(repo: str, ref: str, workspace: Path) -> Path:
    url = f"https://codeload.github.com/{repo}/zip/refs/heads/{ref}"
    archive_path = workspace / "repo.zip"
    try:
        with urllib.request.urlopen(url) as response, archive_path.open("wb") as out:
            out.write(response.read())
    except urllib.error.HTTPError as exc:
        raise RuntimeError(
            f"Falha ao baixar {repo}@{ref}. Verifique se o repositorio esta publico e se a branch existe."
        ) from exc

    with zipfile.ZipFile(archive_path) as zf:
        zf.extractall(workspace)

    extracted = workspace / f"{repo.split('/')[-1]}-{ref}"
    if extracted.exists():
        return extracted

    children = [p for p in workspace.iterdir() if p.is_dir()]
    if len(children) != 1:
        raise RuntimeError("Nao foi possivel localizar a pasta extraida do repositorio.")
    return children[0]


def copy_file(source: Path, destination: Path, overwrite: bool) -> str:
    destination.parent.mkdir(parents=True, exist_ok=True)
    if not destination.exists():
        shutil.copy2(source, destination)
        return "created"
    if overwrite:
        shutil.copy2(source, destination)
        return "updated"
    return "skipped"


def copy_tree(source_dir: Path, target_dir: Path, overwrite: bool) -> dict[str, int]:
    stats = {"created": 0, "updated": 0, "skipped": 0}
    for file in source_dir.rglob("*"):
        if not file.is_file():
            continue
        relative = file.relative_to(source_dir)
        result = copy_file(file, target_dir / relative, overwrite)
        stats[result] += 1
    return stats


def merge_stats(total: dict[str, int], delta: dict[str, int]) -> None:
    for key in total:
        total[key] += delta[key]


def install(repo_root: Path, target: Path, mode: str, overwrite: bool, init_git: bool, remote_url: str) -> dict[str, dict[str, int]]:
    manifest = json.loads((repo_root / "manifest" / "template-manifest.json").read_text(encoding="utf-8"))

    if mode == "new":
        visible = [p for p in target.iterdir() if p.name != ".git"] if target.exists() else []
        if visible and not overwrite:
            raise RuntimeError("A pasta de destino nao esta vazia. Use existing ou force.")

    target.mkdir(parents=True, exist_ok=True)

    root_stats = {"created": 0, "updated": 0, "skipped": 0}
    dir_stats = {"created": 0, "updated": 0, "skipped": 0}

    for rel in manifest["installRootFiles"]:
        result = copy_file(repo_root / rel, target / rel, overwrite)
        root_stats[result] += 1

    for rel in manifest["installDirectories"]:
        merge_stats(dir_stats, copy_tree(repo_root / rel, target / rel, overwrite))

    if init_git and not (target / ".git").exists():
        subprocess.run(["git", "-C", str(target), "init", "-b", "main"], check=False, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        if remote_url:
            subprocess.run(["git", "-C", str(target), "remote", "add", "origin", remote_url], check=False, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    return {"root": root_stats, "dirs": dir_stats}


def sync(repo_root: Path, target: Path, include_guides: bool, overwrite: bool) -> dict[str, dict[str, int]]:
    manifest = json.loads((repo_root / "manifest" / "template-manifest.json").read_text(encoding="utf-8"))
    target.mkdir(parents=True, exist_ok=True)

    skills_stats = copy_tree(repo_root / manifest["syncDirectories"][0], target / manifest["syncDirectories"][0], overwrite)
    guide_stats = {"created": 0, "updated": 0, "skipped": 0}

    if include_guides:
        for rel in manifest["syncOptionalRootFiles"]:
            result = copy_file(repo_root / rel, target / rel, overwrite)
            guide_stats[result] += 1

    return {"skills": skills_stats, "guides": guide_stats}


def infer_mode(target: Path) -> str:
    if not target.exists():
        return "new"
    visible = [p for p in target.iterdir() if p.name != ".git"]
    if not visible:
        return "new"
    if (target / "FLOW.md").exists() or (target / "skills").exists():
        return "sync"
    return "existing"


def main() -> int:
    parser = argparse.ArgumentParser(description="Instala ou sincroniza o software-factory-template a partir do GitHub.")
    parser.add_argument("--target", default=".", help="Pasta de destino")
    parser.add_argument("--mode", choices=["new", "existing", "sync", "auto"], default="auto")
    parser.add_argument("--repo", default="josielaguiar/software-factory-template")
    parser.add_argument("--ref", default="main")
    parser.add_argument("--source-path", default="")
    parser.add_argument("--force", action="store_true")
    parser.add_argument("--include-guides", action="store_true")
    parser.add_argument("--init-git", action="store_true")
    parser.add_argument("--remote-url", default="")
    args = parser.parse_args()

    target = Path(args.target).expanduser().resolve()
    mode = infer_mode(target) if args.mode == "auto" else args.mode

    with tempfile.TemporaryDirectory(prefix="software-factory-template-") as tmp:
        repo_root = Path(args.source_path).expanduser().resolve() if args.source_path else download_repo(args.repo, args.ref, Path(tmp))
        if mode == "sync":
            result = sync(repo_root, target, args.include_guides, args.force)
            print(f"modo={mode}")
            print(f"destino={target}")
            print(f"skills_criadas={result['skills']['created']}")
            print(f"skills_atualizadas={result['skills']['updated']}")
            print(f"skills_ignoradas={result['skills']['skipped']}")
            if args.include_guides:
                print(f"guias_criados={result['guides']['created']}")
                print(f"guias_atualizados={result['guides']['updated']}")
                print(f"guias_ignorados={result['guides']['skipped']}")
            print("proximo_passo=seguir com o fluxo normal do projeto; FLOW.md e docs factuais foram preservados")
        else:
            result = install(repo_root, target, mode, args.force, args.init_git, args.remote_url)
            print(f"modo={mode}")
            print(f"destino={target}")
            print(f"raiz_criados={result['root']['created']}")
            print(f"raiz_atualizados={result['root']['updated']}")
            print(f"raiz_ignorados={result['root']['skipped']}")
            print(f"dirs_criados={result['dirs']['created']}")
            print(f"dirs_atualizados={result['dirs']['updated']}")
            print(f"dirs_ignorados={result['dirs']['skipped']}")
            if mode == "new":
                print("proximo_passo=seguir por FLOW.md -> docs/00_Contexto_Mestre.md -> skills/factory")
            else:
                print("proximo_passo=preencher docs/20, docs/21 e docs/22 com o estado real do produto")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
