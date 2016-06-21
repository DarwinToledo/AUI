!macro SetISOFileNames Distro2Check ISO2Check Download2Get Persistent Homepage OfficialName
 ${If} $Checker == "Yes"
 ${NSD_CB_AddString} $Distro "${Distro2Check}"
  
 ${ElseIf} $Checker == "No"  
 ${AndIf} $DistroName == "${Distro2Check}" 
 StrCpy $ISOFileName "${ISO2Check}" 
 StrCpy $DownLink "${Download2Get}"  ; Download Link  
 ;StrCpy $SizeOfCasper "${GimmeSize}" ; Space needed to install
 StrCpy $Persistence "${Persistent}" ; Persistence?
 StrCpy $Homepage "${Homepage}" ; Linux Distro Homepage
 StrCpy $OfficialName "${OfficialName}" ; Linux Distro Name for Home Page Anchor
 ${EndIf}
!macroend