/*
  This file is part of Universal USB Installer (UUI).
 
  UUI is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 2 of the License, or
  any later version.
 
  UUI is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
 
  You should have received a copy of the GNU General Public License
  along with UUI.  If not, see <http://www.gnu.org/licenses/>.
 */

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