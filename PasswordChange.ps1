#Script to Change Password for users in a group
##Author: Joseph Say

$verbosepreference = "continue"  
 
write-verbose "Change Password for Users in the group specified" 
  
$group = Read-Host -Prompt 'Input the Group name'

$users =Get-ADGroupMember -identity "$group" | select DistinguishedName


foreach ($user in $users) {
    $outObject = new-object -typename psobject
    $outobject | Add-member -MemberType NoteProperty -Name distinguishedName -Value $user.distinguishedname
    $outobject | Add-Member -MemberType NoteProperty -Name OldPasswordLastSet -value $user.passwordlastset
    set-aduser $user -ChangePasswordAtLogon:$true
    $outObject
} 