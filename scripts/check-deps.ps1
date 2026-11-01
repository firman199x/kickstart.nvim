$required = @("git", "nvim", "rg", "fd")
$optional = @("clangd", "lua-language-server", "stylua")

Write-Host "Required dependencies:"
foreach ($exe in $required) {
    $cmd = Get-Command $exe -ErrorAction SilentlyContinue
    if ($cmd) { Write-Host "  [ok] $exe ($($cmd.Source))" }
    else { Write-Host "  [missing] $exe" }
}

Write-Host ""
Write-Host "Optional language tools:"
foreach ($exe in $optional) {
    $cmd = Get-Command $exe -ErrorAction SilentlyContinue
    if ($cmd) { Write-Host "  [ok] $exe ($($cmd.Source))" }
    else { Write-Host "  [missing] $exe" }
}