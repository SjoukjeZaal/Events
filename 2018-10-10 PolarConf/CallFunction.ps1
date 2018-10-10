# Set Function URL
$functionURL = '<your-B2B-URL'

# Use the POST method provided
$Body = @{firstname = 'Sjoukje Demo Function'; lastname = 'Zaal'; emailaddress = 'emailaddress@email.com' } | ConvertTo-Json
Invoke-RestMethod -Method Post -Body $Body -Uri $functionURL