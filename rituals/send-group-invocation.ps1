$recipients = @(
  @{ EmailAddress = @{ Address = "group1@outlook.com" } },
  @{ EmailAddress = @{ Address = "group2@outlook.com" } }
)

$subject = "Group Ritual Coordination"
$body = "Prepare for our next constitutional coordination session."

Send-MgUserMail -UserId 'me' -Message @{
  Subject = $subject
  Body = @{ ContentType = "Text"; Content = $body }
  ToRecipients = $recipients
} -SaveToSentItems
