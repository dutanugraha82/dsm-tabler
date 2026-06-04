$files = Get-ChildItem -Path '.' -Filter '*.html' -Recurse | Where-Object { $_.FullName -notmatch 'node_modules' }
foreach ($f in $files) {
    $text = [System.IO.File]::ReadAllText($f.FullName)
    # Using regex replace for aside tag
    $newText = [regex]::Replace($text, '<aside([^>]+)data-bs-theme="dark"', '<aside$1data-bs-theme="light"')
    if ($newText -cne $text) {
        [System.IO.File]::WriteAllText($f.FullName, $newText, (New-Object System.Text.UTF8Encoding $False))
        Write-Host "Updated $($f.FullName)"
    }
}
