param(
    [ValidateSet('project','user','claude-project','codex-project','claude-user','codex-user')]
    [string]$Mode = 'project',
    [string]$Root = (Get-Location).Path
)

$Here = Split-Path -Parent $MyInvocation.MyCommand.Path
$Source = Join-Path $Here 'breachpilot-mindset'

function Install-Skill([string]$Base) {
    $Dest = Join-Path $Base 'breachpilot-mindset'
    New-Item -ItemType Directory -Force -Path $Base | Out-Null
    if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
    Copy-Item -Recurse -Force $Source $Dest
    Write-Host "Installed: $Dest"
}

switch ($Mode) {
    'project' {
        Install-Skill (Join-Path $Root '.claude/skills')
        Install-Skill (Join-Path $Root '.agents/skills')
    }
    'user' {
        Install-Skill (Join-Path $HOME '.claude/skills')
        Install-Skill (Join-Path $HOME '.agents/skills')
    }
    'claude-project' { Install-Skill (Join-Path $Root '.claude/skills') }
    'codex-project'  { Install-Skill (Join-Path $Root '.agents/skills') }
    'claude-user'    { Install-Skill (Join-Path $HOME '.claude/skills') }
    'codex-user'     { Install-Skill (Join-Path $HOME '.agents/skills') }
}
