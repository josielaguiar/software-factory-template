param(
    [string]$TargetPath = ".",
    [ValidateSet("new", "existing")]
    [string]$Mode = "new",
    [switch]$Force,
    [switch]$InitGit,
    [string]$RemoteUrl = ""
)

$ErrorActionPreference = "Stop"

function Copy-TreeSmart {
    param(
        [string]$SourceDir,
        [string]$TargetDir,
        [bool]$Overwrite
    )

    $created = 0
    $updated = 0
    $skipped = 0

    Get-ChildItem -Path $SourceDir -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($SourceDir.Length).TrimStart('\', '/')
        $destination = Join-Path $TargetDir $relative
        $destinationParent = Split-Path $destination -Parent

        if (-not (Test-Path $destinationParent)) {
            New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
        }

        if (-not (Test-Path $destination)) {
            Copy-Item $_.FullName $destination
            $created++
        }
        elseif ($Overwrite) {
            Copy-Item $_.FullName $destination -Force
            $updated++
        }
        else {
            $skipped++
        }
    }

    return @{
        created = $created
        updated = $updated
        skipped = $skipped
    }
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$manifestPath = Join-Path $repoRoot "manifest\\template-manifest.json"
$manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json
if (-not (Test-Path $TargetPath)) {
    New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
}
$target = (Resolve-Path $TargetPath).Path

if ($Mode -eq "new") {
    $visibleItems = Get-ChildItem -Path $target -Force | Where-Object { $_.Name -notin @(".git", ".", "..") }
    if ($visibleItems.Count -gt 0 -and -not $Force) {
        throw "A pasta de destino nao esta vazia. Use -Mode existing ou rode novamente com -Force."
    }
}

$rootCreated = 0
$rootUpdated = 0
$rootSkipped = 0
$dirCreated = 0
$dirUpdated = 0
$dirSkipped = 0

foreach ($file in $manifest.installRootFiles) {
    $sourceFile = Join-Path $repoRoot $file
    $targetFile = Join-Path $target $file
    $targetParent = Split-Path $targetFile -Parent

    if (-not (Test-Path $targetParent)) {
        New-Item -ItemType Directory -Path $targetParent -Force | Out-Null
    }

    if (-not (Test-Path $targetFile)) {
        Copy-Item $sourceFile $targetFile
        $rootCreated++
    }
    elseif ($Force) {
        Copy-Item $sourceFile $targetFile -Force
        $rootUpdated++
    }
    else {
        $rootSkipped++
    }
}

foreach ($directory in $manifest.installDirectories) {
    $sourceDir = Join-Path $repoRoot $directory
    $targetDir = Join-Path $target $directory
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }
    $result = Copy-TreeSmart -SourceDir $sourceDir -TargetDir $targetDir -Overwrite:$Force
    $dirCreated += $result.created
    $dirUpdated += $result.updated
    $dirSkipped += $result.skipped
}

if ($InitGit -and -not (Test-Path (Join-Path $target ".git"))) {
    Push-Location $target
    try {
        git init -b main | Out-Null
        if ($RemoteUrl) {
            git remote add origin $RemoteUrl
        }
    }
    finally {
        Pop-Location
    }
}

Write-Host ""
Write-Host "Software Factory Template - instalacao concluida" -ForegroundColor Green
Write-Host "Destino: $target"
Write-Host "Modo: $Mode"
Write-Host ""
Write-Host "Arquivos raiz -> criados: $rootCreated | atualizados: $rootUpdated | ignorados: $rootSkipped"
Write-Host "Diretorios/docs/skills -> criados: $dirCreated | atualizados: $dirUpdated | ignorados: $dirSkipped"
if ($InitGit) {
    Write-Host "Git inicializado quando necessario."
}
Write-Host ""
Write-Host "Proximo passo sugerido:"
if ($Mode -eq "new") {
    Write-Host "- abrir o projeto e seguir por FLOW.md -> docs/00_Contexto_Mestre.md -> skills/factory"
}
else {
    Write-Host "- mapear o estado real em docs/20, docs/21 e docs/22 antes de implementar"
}
