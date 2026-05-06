param(
    [string]$TargetPath = ".",
    [switch]$IncludeGuides,
    [switch]$Force
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
$target = (Resolve-Path $TargetPath).Path

$skillsSource = Join-Path $repoRoot ($manifest.syncDirectories[0])
$skillsTarget = Join-Path $target ($manifest.syncDirectories[0])
if (-not (Test-Path $skillsTarget)) {
    New-Item -ItemType Directory -Path $skillsTarget -Force | Out-Null
}
$skillsResult = Copy-TreeSmart -SourceDir $skillsSource -TargetDir $skillsTarget -Overwrite:$Force

$guideCreated = 0
$guideUpdated = 0
$guideSkipped = 0

if ($IncludeGuides) {
    foreach ($file in $manifest.syncOptionalRootFiles) {
        $sourceFile = Join-Path $repoRoot $file
        $targetFile = Join-Path $target $file
        if (-not (Test-Path $targetFile)) {
            Copy-Item $sourceFile $targetFile
            $guideCreated++
        }
        elseif ($Force) {
            Copy-Item $sourceFile $targetFile -Force
            $guideUpdated++
        }
        else {
            $guideSkipped++
        }
    }
}

Write-Host ""
Write-Host "Software Factory Template - sincronizacao concluida" -ForegroundColor Green
Write-Host "Destino: $target"
Write-Host ""
Write-Host "Skills -> criadas: $($skillsResult.created) | atualizadas: $($skillsResult.updated) | ignoradas: $($skillsResult.skipped)"
if ($IncludeGuides) {
    Write-Host "Guias raiz -> criados: $guideCreated | atualizados: $guideUpdated | ignorados: $guideSkipped"
}
Write-Host ""
Write-Host "Observacao: FLOW.md e docs factuais do projeto nao sao sobrescritos pelo sync."
