$recipient = "public@list.com"
$subject = "NexaraSovereign Public Announcement"
$body = "<h1>We are initiating a new constitutional ritual</h1>"

Send-MgUserMail -UserId 'me' -Message @{
  Subject = $subject
  Body = @{ ContentType = "HTML"; Content = $body }
  ToRecipients = @(@{ EmailAddress = @{ Address = $recipient } })
} -SaveToSentItems
