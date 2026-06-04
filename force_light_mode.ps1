$files = Get-ChildItem -Path '.' -Filter '*.html' -Recurse | Where-Object { $_.FullName -notmatch 'node_modules' }
foreach ($f in $files) {
    $text = [System.IO.File]::ReadAllText($f.FullName)
    $changed = $false
    
    $newText = $text.Replace("return prefersDark() ? 'dark' : 'light';", "return 'light';")
    if ($newText -cne $text) { $text = $newText; $changed = $true }
    
    $newText = $text.Replace("const resolved = theme === 'auto' ? (prefersDark() ? 'dark' : 'light') : theme;", "const resolved = theme === 'auto' ? 'light' : theme;")
    if ($newText -cne $text) { $text = $newText; $changed = $true }
    
    if ($changed) {
        [System.IO.File]::WriteAllText($f.FullName, $text, (New-Object System.Text.UTF8Encoding $False))
        Write-Host "Updated $($f.FullName)"
    }
}
