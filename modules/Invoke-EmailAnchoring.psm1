function Invoke-EmailAnchoring {
    param (
        [Parameter(Mandatory)]
        [ValidateSet("private", "public", "group")]
        [string]$RitualType,

        [Parameter(Mandatory)]
        [string]$LogDate # Format: YYYYMMDD
    )

    $ritualMap = @{
        private = "Private Email"
        public  = "Public Announcement"
        group   = "Group Invocation"
    }

    $ritualName = $ritualMap[$RitualType]
    $logPath = "E:\Nexara\email\changelog\email-log-$LogDate.txt"
    $metaPath = "E:\Nexara\email\rituals\$RitualType\nexmeta.json"
    $gitbookPath = "E:\Nexara\email\docs\email-rituals.md"

    if (!(Test-Path $logPath)) {
        Write-Error "Log file not found: $logPath"
        return
    }

    # Anchor to IPFS
    $ipfsOutput = ipfs add $logPath
    $cid = ($ipfsOutput -split " ")[1]

    # Update metadata
    $meta = @{
        ritual        = $ritualName
        guardian      = "MJ Ahmad"
        date          = (Get-Date -Format "yyyy-MM-dd")
        ipfsCID       = $cid
        anchoredFrom  = $logPath
        linkedTo      = @("GitBook", "Microsoft Graph", "PowerShell")
        notes         = "Anchored message for $ritualName"
    }
    $meta | ConvertTo-Json -Depth 3 | Out-File $metaPath -Encoding UTF8

    # Append to GitBook
    $markdownRow = "| $ritualName | $($meta.date) | $cid | ${meta.notes} |"
    Add-Content $gitbookPath "`n$markdownRow"

    Write-Host "`n✅ Anchoring complete for $ritualName"
    Write-Host "📦 IPFS CID: $cid"
    Write-Host "📁 Metadata updated: $metaPath"
    Write-Host "📚 GitBook updated: $gitbookPath"
}
