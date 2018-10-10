#set Azure AD Admin variables
$username = $Env:AADUsername
$password = $Env:AADPassword

# POST method: $req
$requestBody = Get-Content $req -Raw | ConvertFrom-Json
$firstname = $requestBody.firstname
$lastname = $requestBody.lastname
$emailaddress = $requestBody.emailaddress

# GET method: each querystring parameter is its own variable
if ($req_query_firstname) 
{
    $firstname = $req_query_firstname 
}
if ($req_query_lastname) 
{
    $lastname = $req_query_lastname 
}
if ($req_query_emailaddress) 
{
    $emailaddress = $req_query_emailaddress 
}

$secpassword = $password | ConvertTo-SecureString -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($username, $secpassword)
$tenantId = "<your-tenantID>" 

Connect-AzureAD -Credential $cred -TenantId $tenantId

$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo
$messageInfo.customizedMessageBody = "Hey there! Check this out. I created an invitation through an Azure Function"

New-AzureADMSInvitation -InvitedUserEmailAddress $emailaddress `
                            -InvitedUserDisplayName $firstname `
                            -InviteRedirectUrl https://myapps.microsoft.com `
                            -InvitedUserMessageInfo $messageInfo `
                            -SendInvitationMessage $true
