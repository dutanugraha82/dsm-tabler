$files = Get-ChildItem -Path '.' -Filter '*.html' -Recurse | Where-Object { $_.FullName -notmatch 'node_modules' }
foreach ($f in $files) {
    $text = [System.IO.File]::ReadAllText($f.FullName)
    # Match <html lang="en"> or <html> and add data-bs-theme="light"
    $newText = $text -replace '(?i)<html(?: lang="[^"]*")?>', '<html lang="en" data-bs-theme="light">'
    
    if ($newText -cne $text) {
        [System.IO.File]::WriteAllText($f.FullName, $newText, (New-Object System.Text.UTF8Encoding $False))
        Write-Host "Updated $($f.FullName)"
    }
}
