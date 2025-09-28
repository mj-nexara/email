<# 
.SYNOPSIS
Interactive launcher for constitutional email rituals.
.DESCRIPTION
Allows MJ to select and send private, public, or group emails with trauma-informed prompts.
#>

Write-Host "`n🧘 Welcome, MJ. Choose your email ritual:`n" -ForegroundColor Cyan
Write-Host "1. 🔒 Private Email" -ForegroundColor Yellow
Write-Host "2. 🌐 Public Announcement" -ForegroundColor Green
Write-Host "3. 👥 Group Invocation" -ForegroundColor Magenta

$choice = Read-Host "`nEnter your choice (1/2/3)"

switch ($choice) {
  '1' { & "E:\Nexara\email\rituals\send-private-email.ps1" }
  '2' { & "E:\Nexara\email\rituals\send-public-announcement.ps1" }
  '3' { & "E:\Nexara\email\rituals\send-group-invocation.ps1" }
  default { Write-Host "Invalid choice. Please try again." -ForegroundColor Red }
}
