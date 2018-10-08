$cred = Get-Credential
$tenantId = "8db5b030-89df-4359-8d4f-926af1102a4e" 

Connect-AzureAD -Credential $cred -TenantId $tenantId

$invitations = import-csv "C:\B2B Invitations\invitations.csv"
$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo
$messageInfo.customizedMessageBody = "Hey there! Check this out. I created an invitation through PowerShell"

foreach ($email in $invitations) {
    New-AzureADMSInvitation -InvitedUserEmailAddress $email.InvitedUserEmailAddress `
                            -InvitedUserDisplayName $email.Name `
                            -InviteRedirectUrl https://myapps.microsoft.com `
                            -InvitedUserMessageInfo $messageInfo `
                            -SendInvitationMessage $true
                        }