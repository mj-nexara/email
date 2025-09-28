$recipient = "trusted@example.com"
$subject = "Private Ritual Update"
$body = "This message is intended for a trusted guardian only."

Send-MgUserMail -UserId 'me' -Message @{
  Subject = $subject
  Body = @{ ContentType = "Text"; Content = $body }
  ToRecipients = @(@{ EmailAddress = @{ Address = $recipient } })
} -SaveToSentItems
