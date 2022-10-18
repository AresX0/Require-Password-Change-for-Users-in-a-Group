#Script to Change Password for users in a group
##Author: Joseph Say

$verbosepreference = "continue"  
 
write-verbose "Change Password for Users in the group specified" 
  
$group = Read-Host -Prompt 'Input the Group name'

$Users = Get-ADGroup "$group" -Properties Member | 
Select-Object -ExpandProperty Member |
Get-ADUser | select DistinguishedName


foreach ($user in $users) {
    $outObject = new-object -typename psobject
    $outobject | Add-member -MemberType NoteProperty -Name distinguishedName -Value $user.distinguishedname
    $outobject | Add-Member -MemberType NoteProperty -Name OldPasswordLastSet -value $user.passwordlastset
    set-aduser $user -ChangePasswordAtLogon:$true 
    $outObject
} 
