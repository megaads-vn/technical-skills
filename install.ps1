# install.ps1 [skill-name] [-Global]
# Usage:
#   .\install.ps1                       # install all skills to .\.claude\skills
#   .\install.ps1 skill-name            # install one skill locally
#   .\install.ps1 -Global               # install all skills to $HOME\.claude\skills
#   .\install.ps1 skill-name -Global    # install one skill globally
#
# Run via remote:
#   irm https://raw.githubusercontent.com/megaads-vn/technical-skills/master/install.ps1 | iex
#   (for arguments, download first then run)

[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$SkillName = "",

    [switch]$Global
)

$ErrorActionPreference = "Stop"

if ($Global) {
    $BaseTarget = Join-Path $HOME ".claude\skills"
} else {
    $BaseTarget = Join-Path (Get-Location) ".claude\skills"
}

$RepoUrl = "https://github.com/megaads-vn/technical-skills"
$TempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

try {
    Write-Host "📦 Cloning skills repo..."
    $RepoDir = Join-Path $TempDir "repo"
    & git clone --depth=1 -q $RepoUrl $RepoDir
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to clone repo" -ForegroundColor Red
        exit 1
    }

    function Install-Skill {
        param([string]$Name)

        $source = Join-Path $RepoDir "skills\$Name"
        $target = Join-Path $BaseTarget $Name

        if (-not (Test-Path $source -PathType Container)) {
            Write-Host "❌ Skill not found: $Name" -ForegroundColor Red
            return
        }

        if (-not (Test-Path $BaseTarget)) {
            New-Item -ItemType Directory -Path $BaseTarget -Force | Out-Null
        }

        if (Test-Path $target) {
            Remove-Item -Recurse -Force $target
        }

        Copy-Item -Recurse -Force $source $target
        Write-Host "✅ Installed: $Name → $target" -ForegroundColor Green
    }

    if ($SkillName -ne "") {
        Install-Skill -Name $SkillName
    } else {
        $skillsRoot = Join-Path $RepoDir "skills"
        $skills = @(Get-ChildItem -Path $skillsRoot -Directory -ErrorAction SilentlyContinue)

        if ($skills.Count -eq 0) {
            Write-Host "❌ No skills found in repo" -ForegroundColor Red
            exit 1
        }

        foreach ($skill in $skills) {
            Install-Skill -Name $skill.Name
        }
    }
}
finally {
    if (Test-Path $TempDir) {
        Remove-Item -Recurse -Force $TempDir -ErrorAction SilentlyContinue
    }
}
