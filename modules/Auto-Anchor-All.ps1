# Define ritual folders
$rituals = @("private", "public", "group", "onboarding", "legal", "emotional")
$logDate = Get-Date -Format "yyyyMMdd"

foreach ($ritual in $rituals) {
    $logPath = "E:\Nexara\email\changelog\email-log-$logDate-$ritual.txt"
    $metaPath = "E:\Nexara\email\rituals\$ritual\nexmeta.json"
    $gitbookPath = "E:\Nexara\email\docs\email-rituals.md"

    # Simulate log entry
    "[$(Get-Date)] Email sent for $ritual ritual." | Out-File $logPath -Encoding UTF8

    # Anchor to IPFS
    $ipfsOutput = ipfs add $logPath
    $cid = ($ipfsOutput -split " ")[1]

    # Update metadata
    $meta = @{
        ritual        = "$ritual Email"
        guardian      = "MJ Ahmad"
        date          = (Get-Date -Format "yyyy-MM-dd")
        ipfsCID       = $cid
        anchoredFrom  = $logPath
        linkedTo      = @("GitBook", "Microsoft Graph", "PowerShell")
        notes         = "Automated anchoring for $ritual"
    }
    $meta | ConvertTo-Json -Depth 3 | Out-File $metaPath -Encoding UTF8

    # Update GitBook
    $markdownRow = "| $ritual Email | $($meta.date) | $cid | ${meta.notes} |"
    Add-Content $gitbookPath "`n$markdownRow"

    Write-Host "✅ Anchored: $ritual → $cid"
}
