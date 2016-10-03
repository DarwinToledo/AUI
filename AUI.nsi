#===========================================================
# AUI (Absolute USB Installer)
# Developed by Darwin Toledo http://www.usbwithlinux.com/
# Based on UUI
#===========================================================
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

  Universal USB Installer (UUI) ©2009-2016 Lance http://www.pendrivelinux.com (See Uni-USB-Installer-Copying.txt and -Readme.txt for more information, and additional credits)
  7-Zip © Igor Pavlovis http://7-zip.org (unmodified binaries used)
  Syslinux © H. Peter Anvin http://syslinux.zytor.com (unmodified binary used)
  dd.exe © John Newbigin http://www.chrysocome.net/dd (unmodified binary used)
  mke2fs.exe © Matt WU http://ext2fsd.sourceforge.net (unmodified binary used)
  grldr GRUB4DOS © the Gna! people http://www.gnu.org/software/grub (unmodified binary used)
  Fat32format.exe © Tom Thornhill Ridgecorp Consultants http://www.ridgecrop.demon.co.uk (unmodified binary used)
  NSIS Installer © Contributors http://nsis.sourceforge.net - This script was created using NSIS, you must install and use NSIS to compile this script. http://nsis.sourceforge.net/Download
  Universal USB Installer may contain remnants of Cedric Tissieres's Tazusb.exe for Slitaz (slitaz@objectif-securite.ch), as his work was used as a base for singular distro installers that preceded UUI.
 */

#===========================================================
# INCLUDES
#===========================================================

            !execute "Resources\Scripts\Build Counter v1.0.exe"
         
            !addincludedir "Resources\Scripts"
            !addplugindir  "Resources\Plugins"
            !include       "Resources\Scripts\Defines.nsh"

            ; MoreInfo Plugin - Adds Version Tab fields to Properties. Plugin created by onad http://nsis.sourceforge.net/MoreInfo_plug-in
            VIProductVersion "${VERSION}"
            VIAddVersionKey CompanyName "www.usbwithlinux.com"
            VIAddVersionKey LegalCopyright "Copyright ©2016 Darwin Toledo www.usbwithlinux.com"
            VIAddVersionKey FileVersion "${VERSION}"
            VIAddVersionKey FileDescription "Universal Linux UFD Creator"
            VIAddVersionKey License "GPL Version 2"

            Name "${NAME}"

            !ifdef BUILD_STABLE
            Caption "${NAME} ${VERSION} - ${RODRI_WEBSITE}"
            OutFile "C:\Users\${DESKTOP_USER}\Desktop\${FILENAME}-${VERSION}.exe"
            BrandingText "${NAME2} - ${RODRI_WEBSITE}"
            !else
            Caption "${NAME} ${VERSION} Beta - ${RODRI_WEBSITE}"
            OutFile "C:\Users\${DESKTOP_USER}\Desktop\${FILENAME}-Beta.exe"
            BrandingText "${NAME2} Beta - ${RODRI_WEBSITE}"
            !endif

            RequestExecutionLevel admin ;highest
            SetCompressor /SOLID /FINAL LZMA
            CRCCheck On
            XPStyle on
            ShowInstDetails show
            CompletedText "Installation Done, Process is Complete!"
            InstallButtonText $(Create_Button)


#===========================================================
#
#===========================================================

            !include WordFunc.nsh
            !include nsDialogs.nsh
            !include MUI2.nsh
            !include FileFunc.nsh
            !include LogicLib.nsh
            !include FileNames.nsh ; FileNames Macro Script created by Lance http://www.pendrivelinux.com
            !include variables.nsh

            !include DiskVoodoo.nsh ; DiskVoodoo Script created by Lance http://www.pendrivelinux.com


#===========================================================
#
#===========================================================

            ; Interface settings
            !define MUI_CUSTOMFUNCTION_GUIINIT AUMBIInit
            ;!define MUI_FINISHPAGE_NOAUTOCLOSE
            !define MUI_HEADERIMAGE
            !define MUI_HEADERIMAGE_BITMAP "Resources\images\AUI_BKG.bmp"
            !define MUI_UI_HEADERIMAGE "Resources\UI\AUMBI_UI.exe"
            ;!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
            ;!define MUI_HEADERIMAGE_RIGHT

            ; License Agreement Page
            !define MUI_TEXT_LICENSE_SUBTITLE $(License_Subtitle)
            !define MUI_LICENSEPAGE_TEXT_TOP $(License_Text_Top)
            !define MUI_LICENSEPAGE_TEXT_BOTTOM $(License_Text_Bottom)
            !define MUI_PAGE_CUSTOMFUNCTION_SHOW License_ShowFunction
            !insertmacro MUI_PAGE_LICENSE "AUI.rtf"

            ; Distro Selection Page
            Page custom SelectionsPage_Show

            ; Install Files Page
            ;!define MUI_INSTFILESPAGE_COLORS "00FF00 000000" ;Green and Black
            !define MUI_TEXT_INSTALLING_TITLE $(Install_Title)
            !define MUI_TEXT_INSTALLING_SUBTITLE $(Install_SubTitle)
         ;!define MUI_INSTFILESPAGE_FINISHHEADER_TEXT $(Finish_Install)
         !define MUI_TEXT_FINISH_SUBTITLE $(Install_Finish_Sucess)
                 !define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFiles_ShowFunction
            !insertmacro MUI_PAGE_INSTFILES
/*
         !define MUI_FINISHPAGE_TITLE $(Finish_Title)
         !define MUI_FINISHPAGE_TEXT $(Finish_Text)
         !define MUI_FINISHPAGE_LINK $(Finish_Link) */
         !define MUI_FINISHPAGE_LINK_LOCATION "${RODRI_WEBLINK}"

            ;!define MUI_WELCOMEFINISHPAGE_BITMAP "Resources\Images\finish.bmp"
            ;!insertmacro MUI_PAGE_FINISH
         Page custom fnc_AUMBI_FINISH_Show
#===========================================================
#
#===========================================================

            ; English Language files
            !insertmacro MUI_LANGUAGE "English" ; first language is the default language
            !include "Language_English.nsh"
            !insertmacro MUI_LANGUAGE "SpanishInternational" ; first language is the default language
            !include "Language_SpanishInternational.nsh"

            !include DistroList.nsh ; DistroList Macro Script created by Lance http://www.pendrivelinux.com
            !include FileManipulation.nsh ; Text File Manipulation

Function SelectionsPage
!insertmacro MUI_HEADER_TEXT $(SelectDist_Title) $(SelectDist_Subtitle) 
  nsDialogs::Create 1018
  Pop $Dialog

; Distro Selection Starts
  ${NSD_CreateLabel} 0 0 100% 15 $(Distro_Text) 
  Pop $LinuxDistroSelection   
  ${NSD_CreateDropList} 0 20 47% 15 ""
  Pop $Distro   
  ${NSD_OnChange} $Distro OnSelectDistro  
  StrCpy $Checker "Yes"
  Call SetISOFileName
  
  ${NSD_CB_SelectString} $Distro $DistroName  
  
; ISO Download Option
  ${NSD_CreateCheckBox} 50% 20 50% 15 "$(SELPAGE_DOWNLOAD_LINK)"
  Pop $DownloadISO
  ${NSD_OnClick} $DownloadISO DownloadIt 

  ;SetCtlColors $DownloadDone /BRANDING 009900  
  
; Clickable Link to Distribution Homepage  
  ${NSD_CreateLink} 55% 35 45% 15 "$(SELPAGE_VISIT_HOMEPAGE)"
  Pop $DistroLink
  ${NSD_OnClick} $DistroLink onClickLinuxSite 
  
; ISO Selection Starts  
  ${NSD_CreateLabel} 0 50 100% 15 $(IsoPage_Text)
  Pop $LabelISOSelection
  ${NSD_CreateText} 0 70 83% 20 "$(SELPAGE_BROWSEANDSELECT)"
  Pop $ISOFileTxt 
  ${NSD_CreateBrowseButton} 85% 70 60 20 "$(SELPAGE_BROWSE_BUTTON)"
  Pop $ISOSelection 
  ${NSD_OnClick} $ISOSelection ISOBrowse  
  
; Drive Selection Starts  
  ${NSD_CreateLabel} 0 100 54% 15 $(DrivePage_Text)
  Pop $LabelDrivePage
  ${NSD_CreateDroplist} 0 120 30% 15 "" ; was 0 120 15% 15
  Pop $DestDriveTxt
  Call ListAllDrives
  ${NSD_OnChange} $DestDriveTxt OnSelectDrive
  
; All Drives Option
  ${NSD_CreateCheckBox} 55% 100 45% 15 "$(SELPAGE_SHOWALLDRIVES)"
  Pop $AllDriveOption
  ${NSD_OnClick} $AllDriveOption ListAllDrives  
  
  ${If} $DestDrive != ""
  ${NSD_CB_SelectString} $DestDriveTxt $DestDrive
  ${EndIf}    
  
; Format Drive Option
  ${NSD_CreateCheckBox} 35% 123 50% 15 "$(SELPAGE_FORMATFAT)" ; was 20% 123 60% 15
  Pop $Format
  ${NSD_OnClick} $Format FormatIt   
; Casper-RW Selection Starts
  ${NSD_CreateLabel} 0 150 75% 15 $(Casper_Text)
  Pop $CasperSelection  
  
; CasperSlider - TrackBar
  !define TBM_SETPOS 0x0405
  !define TBM_GETPOS 0x0400
  !define TBM_SETRANGEMIN 0x0407
  !define TBM_SETRANGEMAX 0x0408

  ${NSD_CreateLabel} 52% 178 25% 25 ""
  Pop $SlideSpot  

  nsDialogs::CreateControl "msctls_trackbar32" "0x50010000|0x00000018" "" 0 174 50% 25 ""
  Pop $CasperSlider

  SendMessage $CasperSlider ${TBM_SETRANGEMIN} 1 0 ; Min Range Value 0
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Max Range Value $RemainingSpace
  ${NSD_OnNotify} $CasperSlider onNotify_CasperSlider  

;; Add a customPayPal donation button
 ; ${NSD_CreateBitmap} 77% 140 23% 50 "PayPal Donation"
  ; Var /Global Donate
  ; Var /Global DonateHandle  
  ; Pop $Donate
 ; ${NSD_SetImage} $Donate $PLUGINSDIR\paypal.bmp $DonateHandle
 ; GetFunctionAddress $DonateHandle OnClickDonate
  ; nsDialogs::OnClick $Donate $DonateHandle    

; Add Help Link
  ${NSD_CreateLink} 0 210 100% 14 "$(SELPAGE_VISITHELP)"
  Pop $Link
  ${NSD_OnClick} $Link onClickMyLink   

Call BKG_BITMAP
; Disable Next Button until a selection is made for all 
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0 
; Remove Back Button
  GetDlgItem $6 $HWNDPARENT 3
  ShowWindow $6 0 
; Hide or disable steps until we state to display them 
  EnableWindow $LabelISOSelection 0
  EnableWindow $ISOFileTxt 0
  EnableWindow $ISOSelection 0
  EnableWindow $LabelDrivePage 0
  EnableWindow $AllDriveOption 0
  EnableWindow $DestDriveTxt 0
  ShowWindow $CasperSelection 0 
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0
  ShowWindow $Format 0
  ShowWindow $DistroLink 0 
  ShowWindow $DownloadISO 0
  nsDialogs::Show 
;  ${NSD_FreeImage} $DonateHandle  
FunctionEnd

; Function OnClickDonate
;  ExecShell "open" "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2NC2Z6SPUEBMY"
; FunctionEnd 

Function onClickMyLink
  Pop $Links ; pop something to prevent corruption
  ExecShell "open" "${RODRI_WEBLINK}"
FunctionEnd

Function onClickLinuxSite
  Pop $OfficialSite 
  ExecShell "open" "$Homepage"
FunctionEnd

Function DownloadIt ; Set Download Option
  ${NSD_GetState} $DownloadISO $DownloadMe
  ${If} $DownloadMe == ${BST_CHECKED}
  ${NSD_Check} $DownloadISO
  ${NSD_SetText} $DownloadISO "$(DOWNIT_DOWNLINKOP)"
  Call DownloadLinks
  ${ElseIf} $DownloadMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $DownloadISO 
  ${NSD_SetText} $DownloadISO "$(DOWNIT_DOWNLINK)"
  ${EndIf}  
FunctionEnd

Function ListAllDrives ; Set to Display All Drives
  SendMessage $DestDriveTxt ${CB_RESETCONTENT} 0 0 
  ${NSD_GetState} $AllDriveOption $DisplayAll
  ${If} $DisplayAll == ${BST_CHECKED}
  ${NSD_Check} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "$(LISTDRIVES_NOWSHOWING)"
    ${GetDrives} "ALL" DrivesList ; All Drives Listed  
  ${ElseIf} $DisplayAll == ${BST_UNCHECKED}
  ${NSD_Uncheck} $AllDriveOption
  ${NSD_SetText} $AllDriveOption "$(LISTDRIVES_SHOWALL)"
	${GetDrives} "FDD" DrivesList ; FDD+HDD reduce to FDD for removable media only
  ${EndIf}
FunctionEnd

Function FormatYes ; If Format is checked, do something
  ${If} $FormatMe == "Yes"
  
; Close Open Explorer Windows to allow fat32format to format the drive  
  ;DetailPrint "Closing All Open Explorer Windows" 
  ;FindWindow $R0 CabinetWClass
  ;IsWindow $R0 0 +3
  ;SendMessage $R0 ${WM_SYSCOMMAND} 0xF060 0
  ;Goto -3  
  
  SetShellVarContext all
  InitPluginsDir
  File /oname=$PLUGINSDIR\fat32format.exe "Binary\fat32format.exe"
  DetailPrint "Formatting $DestDisk as Fat32"
  nsExec::ExecToLog '"cmd" /c "echo y|$PLUGINSDIR\fat32format -c$BlockSize $DestDisk /Q /y"'
  ${EndIf} 
FunctionEnd

Function FormatIt ; Set Format Option
  ${NSD_GetState} $Format $FormatMe
  ${If} $FormatMe == ${BST_CHECKED}
  ${NSD_Check} $Format
  StrCpy $FormatMe "Yes"
  ${NSD_SetText} $Format "$(FORMATIT_WEWILLFORMAT)"
  ${ElseIf} $FormatMe == ${BST_UNCHECKED}
  ${NSD_Uncheck} $Format 
  ${NSD_SetText} $Format "$(FORMATIT_FORMATJUST)"
  ${EndIf}  
  Call SetSpace
FunctionEnd
Function EnableNext ; Enable Install Button 
  ${If} $Blocksize >= 4 
  ShowWindow $Format 1 
  ${Else}
  ShowWindow $Format 0
  ${EndIf}
  ${If} $ISOFileName != ""
  ${AndIf} $ISOFile != ""
  ${AndIf} $DestDrive != "" 
  GetDlgItem $6 $HWNDPARENT 1 ; Get "Install" control handle
  EnableWindow $6 1 ; Enable "Install" control button
  ${EndIf}
  
; Test if ISO has been Selected. If not, disable Install Button
  ${If} $ISOTest == ""
  GetDlgItem $6 $HWNDPARENT 1
  EnableWindow $6 0 ; Disable "Install" if ISO not set 
  ${EndIf}
  
; Show Steps in progression
  ${If} $Persistence == "casper" ; If can use Casper Persistence... 
  ${AndIf} $ISOFile != ""
  ${AndIf} $DestDrive != "" 
  ShowWindow $CasperSelection 1
  ShowWindow $CasperSlider 1
  ShowWindow $SlideSpot 1
  ${NSD_SetText} $Format "$(ENABLENEXT_FORMATJUST)"
	
; Or if not using Casper Persistence...  
  ${ElseIf} $ISOFile != ""
  ${AndIf} $DestDrive != ""   
  ShowWindow $CasperSelection 0
  ShowWindow $CasperSlider 0 
  ShowWindow $SlideSpot 0
  ${NSD_SetText} $Format "$(ENABLENEXT_FORMATJUST)"
  ${EndIf}  
  
  ${If} $ISOFileName != "" 
  EnableWindow $LabelISOSelection 1  
  EnableWindow $ISOFileTxt 1
  EnableWindow $ISOSelection 1
  ${EndIf}  
  
  ${If} $ISOFile != ""
  EnableWindow $LabelDrivePage 1
  EnableWindow $AllDriveOption 1
  EnableWindow $DestDriveTxt 1
  ${EndIf} 
  
; Disable Window if ISO was downloaded
  ${If} $TheISO == "$EXEDIR\$ISOFileName"
  ${AndIf} $ISOTest != ""  
  EnableWindow $ISOSelection 0
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${EndIf}   
FunctionEnd

Function DownloadLinks
MessageBox MB_YESNO|MB_ICONQUESTION "Launch the $DistroName Download Link?$\r$\nLet the download finish before moving to step 2." IDYES DownloadIt IDNO Skip
  Skip: ; Reset Download Checkbox Options 
  ${NSD_Uncheck} $DownloadISO 
  ${NSD_SetText} $DownloadISO "$(DOWNLOADLINKS_DL)"
  EnableWindow $DownloadISO 1
  Goto end
  DownloadIt:
  ${NSD_SetText} $LabelISOSelection "$(DOWNLOADLINKS_STEP2)"
  EnableWindow $DownloadISO 0
  ExecShell "open" "$DownLink"  
  EnableWindow $DownloadISO 1	
  end:
FunctionEnd

!include StrContains.nsh ; Let's check if a * wildcard exists

; On Selection of Linux Distro
Function OnSelectDistro
  Pop $Distro 
  ${NSD_GetText} $Distro $DistroName 
  StrCpy $DistroName "$DistroName" 
  StrCpy $Checker "No"
  Call SetISOFileName
  StrCpy $ISOFileName "$ISOFileName"  
  StrCpy $SomeFileExt "$ISOFileName" "" -3 ; Grabs the last 3 characters of the filename... zip or iso?
  StrCpy $FileFormat "$SomeFileExt"

 ; Redraw Home page Links and Download Links as necessary
  ${If} $DownLink == ""
  ShowWindow $DownloadISO 0  
  ${Else}
  ShowWindow $DownloadISO 1 
  ${EndIf}  
	
  ${NSD_SetText} $DistroLink "$(ONSELDISTRO_VISITHOME)"
  ShowWindow $DistroLink 0
  ${If} $OfficialName == ""
  ShowWindow $DistroLink 0
  ${Else}
  ShowWindow $DistroLink 1
  ${EndIf}  
	
  ${NSD_SetText} $LabelISOSelection "$(ONSELDISTRO_STEP2)"
  ${NSD_SetText} $ISOFileTxt "$(ONSELDISTRO_BROWSE)"
  SetCtlColors $ISOFileTxt FF0000 FFFFFF  
  StrCpy $ISOTest "" ; Set to null until a new ISO selection is made 

; Disable Download Link for these, because there are none!   
 ${If} $DistroName == "Try Unlisted Linux ISO" 
 ${OrIf} $DistroName == "Windows Vista Installer"
 ${OrIf} $DistroName == "Windows 7 Installer"
 ${OrIf} $DistroName == "Hiren's Boot CD"  
 ShowWindow $DownloadISO 0
 ${EndIf} 
 
; Autodetect ISO's in same folder and select if they exist  
 ${If} ${FileExists} "$EXEDIR\$ISOFileName"
 ${StrContains} $WILD "*" "$ISOFileName" ; Check for Wildcard and force Browse if * exists.
 ${AndIf} $WILD != "*"  
  StrCpy $TheISO "$EXEDIR\$ISOFileName" 
  StrCpy $ISOFile "$TheISO"  
  ${GetFileName} "$TheISO" $JustISO
  ${GetBaseName} "$JustISO" $JustISOName
  ${GetParent} "$TheISO" $JustISOPath  
  EnableWindow $DownloadISO 0
  ${NSD_SetText} $DownloadISO "$(ONSELDISTRO_WEFOUND)"
  EnableWindow $ISOSelection 0 
  SetCtlColors $ISOFileTxt 009900 FFFFFF  
  ${NSD_SetText} $ISOFileTxt $ISOFile 
  ${NSD_SetText} $LabelISOSelection "$(ONSELDISTRO_STEP2DONE)"
  StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next    
  Call EnableNext 

 ${ElseIf} $WILD == "*"    
  EnableWindow $DownloadISO 1
  EnableWindow $ISOSelection 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "$(ONSELDISTRO_DL)"
  SetCtlColors $ISOFileTxt FF9B00 FFFFFF  
  ${NSD_SetText} $ISOFileTxt "$(ONSELDISTRO_BROWSE2)"
  ${NSD_SetText} $LabelISOSelection "$(ONSELDISTRO_STEP2PEND)"
  Call EnableNext
  
 ${Else}
  Call EnableNext
  EnableWindow $DownloadISO 1
  ${NSD_Uncheck} $DownloadISO  
  ${NSD_SetText} $DownloadISO "$(ONSELDISTRO_DL)"
 ${EndIf}  
FunctionEnd 

; On Selection of ISO File
Function ISOBrowse
 nsDialogs::SelectFileDialog open "$EXEDIR" $(IsoFile) ; set to "$EXEDIR" rather than "" an empty path..
 Pop $TheISO  
 ${NSD_SetText} $ISOFileTxt $TheISO
 SetCtlColors $ISOFileTxt 009900 FFFFFF
 EnableWindow $DownloadISO 0
 ${NSD_SetText} $DownloadISO "$(ISO_BROWSE_LOCAL)"
 StrCpy $ISOTest "$TheISO" ; Populate ISOTest so we can enable Next 
 StrCpy $ISOFile "$TheISO" 
 ${GetFileName} "$TheISO" $JustISO
 ${GetBaseName} "$JustISO" $JustISOName
 ${GetParent} "$TheISO" $JustISOPath
 Call SetISOSize
 Call EnableNext
FunctionEnd

; On selection of USB Drive
Function OnSelectDrive
  Pop $DestDriveTxt
  ${NSD_GetText} $DestDriveTxt $Letters ; $Letters was $0
  StrCpy $DestDrive "$Letters" ; $Letters was $0
  StrCpy $JustDrive $DestDrive 3    
  StrCpy $DestDisk $DestDrive 2 ; was -1
  Call SetSpace
  Call CheckSpace
  Call EnableNext
FunctionEnd

Function GetDiskVolumeName
;Pop $1 ; get parameter
System::Alloc 1024 ; Allocate string body
Pop $0 ; Get the allocated string's address

!define GetVolumeInformation "Kernel32::GetVolumeInformation(t,t,i,*i,*i,*i,t,i) i"
System::Call '${GetVolumeInformation}("$9",.r0,1024,,,,,1024)' ;

;Push $0 ; Push result
${If} $0 != ""
 StrCpy $VolName "$0"
${Else}
 StrCpy $VolName ""
${EndIf}
FunctionEnd

Function DiskSpace
${DriveSpace} "$9" "/D=T /S=G" $1 ; used to find total space of each drive
${If} $1 > "0"
 StrCpy $Capacity "$1GB"
${Else}
 StrCpy $Capacity ""
${EndIf}
FunctionEnd

Function DrivesList
 Call GetDiskVolumeName
 Call DiskSpace
 SendMessage $DestDriveTxt ${CB_ADDSTRING} 0 "STR:$9 $VolName $Capacity"
 Push 1 ; must push something - see GetDrives documentation
FunctionEnd

Function FreeDiskSpace
${If} $FormatMe == "Yes"
${DriveSpace} "$JustDrive" "/D=T /S=M" $1
${Else}
${DriveSpace} "$JustDrive" "/D=F /S=M" $1
${EndIf}
FunctionEnd

Function TotalSpace
${DriveSpace} "$JustDrive" "/D=T /S=M" $1 ; used to find total space of disk
FunctionEnd

Function CheckSpace ; Check total available space so we can set block size
  Call TotalSpace
  ${If} $1 <= 511
  StrCpy $BlockSize 1
  ${ElseIf} $1 >= 512
  ${AndIf} $1 <= 8191
  StrCpy $BlockSize 4
  ${ElseIf} $1 >= 8192 
  ${AndIf} $1 <= 16383
  StrCpy $BlockSize 8
  ${ElseIf} $1 >= 16384
  ${AndIf} $1 <= 32767
  StrCpy $BlockSize 16
  ${ElseIf} $1 > 32768
  StrCpy $BlockSize 32
  ${EndIf}
  ;MessageBox MB_ICONSTOP|MB_OK "$0 Drive is $1 MB in size, blocksize = $BlockSize KB."  
FunctionEnd

Function SetSpace ; Set space available for persistence
  ;StrCpy $0 '$0'
  Call FreeDiskSpace
  IntOp $MaxPersist 4090 + $CasperSize ; Space required for distro and 4GB max persistent file
 ${If} $1 > $MaxPersist ; Check if more space is available than we need for distro + 4GB persistent file
  StrCpy $RemainingSpace 4090 ; Set maximum possible value to 4090 MB (any larger wont work on fat32 Filesystem)
 ${Else}
  StrCpy $RemainingSpace "$1"
  IntOp $RemainingSpace $RemainingSpace - $SizeOfCasper ; Remaining space minus distro size
 ${EndIf}
  IntOp $RemainingSpace $RemainingSpace - 1 ; Subtract 1MB so that we don't error for not having enough space
  SendMessage $CasperSlider ${TBM_SETRANGEMAX} 1 $RemainingSpace ; Re-Setting Max Value
FunctionEnd

Function HaveSpace ; Check space required before installing
  Call CasperSize
  Call FreeDiskSpace
  System::Int64Op $1 > $SizeOfCasper ; Compare the space available with the total space required
  Pop $3 ; Get the result ...
  IntCmp $3 1 okay ; ... and compare it
  MessageBox MB_ICONSTOP|MB_OK "Oops: There is not enough disk space! $1 MB Free, $SizeOfCasper MB Needed on $JustDrive Drive."
  Quit ; Close the program if the disk space was too small...
  okay: ; Proceed to execute...
  ;MessageBox MB_OK "ISO + Persistence will use $SizeOfCasper MB of the $1 MB Free disk space on $JustDrive Drive."  
  ;quit ; enable for testing message above
FunctionEnd

Function DoSyslinux ; Install Syslinux on chosen USB 

  SetShellVarContext all
  InitPluginsDir
  File /oname=$PLUGINSDIR\syslinux.exe "Binary\syslinux.exe"
  File /oname=$PLUGINSDIR\syslinux603.exe "Binary\syslinux603.exe"
  File /oname=$PLUGINSDIR\syslinux.cfg "Binary\syslinux.cfg"
  File /oname=$PLUGINSDIR\7zG.exe "Binary\7zG.exe"
  File /oname=$PLUGINSDIR\7z.dll "Binary\7z.dll"
  File /oname=$PLUGINSDIR\chain.c32 "Binary\chain.c32"
  File /oname=$PLUGINSDIR\menu.c32 "Binary\menu.c32"
  File /oname=$PLUGINSDIR\vesamenu.c32 "Binary\vesamenu.c32"
  File /oname=$PLUGINSDIR\mbrid "Binary\mbrid"

  CreateDirectory "$DestDisk\AUI" ; Create the AUI directory
  CopyFiles "$PLUGINSDIR\syslinux.cfg" "$DestDisk\AUI\syslinux.cfg" ; Copy syslinux.cfg to AUI directory... we will redirect syslinux from here.
  DetailPrint $(ExecuteSyslinux)
  ;${If} $DistroName == "Tails"
  ;${OrIf} $DistroName == "Clonezilla"  
   ; Do nothing here... we will use the Newer Syslinux version packed with the ISO
  ${If} $DistroName == "ArchLinux"
  ${OrIf} $DistroName == "Archbang"
  ExecWait '$PLUGINSDIR\syslinux603.exe -maf -d /AUI $DestDisk' $R8 ; directory path for syslinux /AUI
  DetailPrint "Syslinux Errors $R8"
  ${Else}
  ExecWait '$PLUGINSDIR\syslinux.exe -maf -d /AUI $DestDisk' $R8 ; directory path for syslinux /AUI
  DetailPrint "Syslinux Errors $R8"
  Banner::destroy
    ${If} $R8 != 0
     MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
    ${EndIf} 
  ${EndIf}    
  
  DetailPrint "Creating Label AUI on $DestDisk"
  ;nsExec::ExecToStack '"cmd" /c "VOL $DestDisk"' 
   ;Pop $VolLabErr
    ;Pop $VolLab
    ;MessageBox MB_ICONEXCLAMATION|MB_OK $VolLab
  nsExec::ExecToLog '"cmd" /c "LABEL $DestDisk AUI"'
FunctionEnd

Function 7zExtractor ; Extract files from archive 
  
  ${If} $DistroName == "Liberte"
  DetailPrint $(Extract)
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!liberte -o"$JustDrive" -y'
  CopyFiles "$JustDrive\liberte\boot\syslinux\*" "$JustDrive\syslinux\*" 

; Kon-Boot
  ${ElseIf} $DistroName == "Kon-Boot FREE"
  DetailPrint $(Extract)
  ;ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -pkon-boot -o"$EXEDIR\TEMPAUI" -y'
  ;ExecWait '"$PLUGINSDIR\7zG.exe" x "$EXEDIR\TEMPAUI\kon-boot1.1-free\FD0-konboot-v1.1-2in1.zip" -pkon-boot -ir!FD0-konboot-v1.1-2in1 -o"$EXEDIR\TEMPAUI" -y'
  ;CopyFiles $EXEDIR\TEMPAUI\FD0-konboot-v1.1-2in1\FD0-konboot-v1.1-2in1.img "$JustDrive\konboot.img"
  ;RMDir /R "$EXEDIR\TEMPAUI"
  CreateDirectory "$EXEDIR\TEMPAUI" ; Create the TEMP directory
  ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -pkon-boot -o"$EXEDIR\TEMPAUI" -y'
  ExecWait '"$PLUGINSDIR\7zG.exe" e "$EXEDIR\TEMPYUMI\FD0-konboot*.zip" -pkon-boot -o"$EXEDIR\TEMPAUI" -y'
  CopyFiles $EXEDIR\TEMPAUI\FD0-konboot-v1.1-2in1.img "$JustDrive\konboot.img"
  RMDir /R "$EXEDIR\TEMPAUI"
  
  ${ElseIf} $DistroName == "Kon-Boot Purchased"
  DetailPrint $(Extract)
  CreateDirectory "$EXEDIR\TEMPAUI" ; Create the TEMP directory
  ExecWait '"$PLUGINSDIR\7zG.exe" e "$ISOFile" -o"$EXEDIR\TEMPAUI" -y'
  CopyFiles $EXEDIR\TEMPAUI\kon-bootFLOPPY.img "$JustDrive\konboot.img"
  RMDir /R "$EXEDIR\TEMPAUI"
  
; OpenSUSE 32bit 
  ${ElseIf} $DistroName == "OpenSUSE 32bit"
  CopyFiles $ISOFile "$JustDrive" ; Copy the ISO to USB
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -ir!boot -o"$JustDrive" -y'  
 
; OpenSUSE 64bit 
  ${ElseIf} $DistroName == "OpenSUSE 64bit"
  CreateDirectory "$EXEDIR\TEMPAUI" ; Create the TEMP directory
  CopyFiles $ISOFile "$JustDrive" ; Copy the ISO to USB
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$EXEDIR\TEMPAUI" -y'
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$EXEDIR\TEMPAUI\*.img" -ir!boot -o"$JustDrive" -y'
  RMDir /R "$EXEDIR\TEMPAUI"
  
  ${ElseIf} $DistroName == "Mageia"
  ; Close Open Explorer Windows to allow DD to do it's work!  
  DetailPrint "Closing All Open Explorer Windows" 
  FindWindow $R0 CabinetWClass
  IsWindow $R0 0 +3
  SendMessage $R0 ${WM_SYSCOMMAND} 0xF060 0
  Goto -3  
  ; Set DD for rawrite usage
  Call UseDD
  nsExec::ExecToLog '"$PLUGINSDIR\dd.exe" if=$ISOFile of=\\.\$DestDisk bs=4M --progress'
  
  ${Else}
  DetailPrint $(Extract)
  ExecWait '"$PLUGINSDIR\7zG.exe" x "$ISOFile" -o"$JustDrive" -y -x![BOOT]*'
  ${EndIf}
  
  ; Check to see if we need to replace Syslinux with a packaged version
  ${If} ${FileExists} "$DestDisk\utils\win32\syslinux.exe"
   ExecWait '$DestDisk\utils\win32\syslinux.exe -maf -d /AUI $DestDisk' $R8 ; directory path for syslinux /AUI
   DetailPrint "Installing the packaged Syslinux version from the ISO"
    DetailPrint "Syslinux Errors $R8"
    Banner::destroy
    ${If} $R8 != 0
     MessageBox MB_ICONEXCLAMATION|MB_OK $(WarningSyslinux)
    ${EndIf} 
  ${EndIf}    
FunctionEnd  

; Custom Includes
!include "CasperScript.nsh" 
!include "Distros.nsh" ; ##################################### ADD NEW DISTRO ########################################

; ---- Let's Do This Stuff ----
Section 
${If} $DistroName == "Mageia"
MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(SECDOSTUFF_MB1)" IDYES proceed
Quit
${Else}
Goto routine
${EndIf}
routine:
${If} $FormatMe == "Yes" 
;MessageBox MB_YESNO|MB_ICONEXCLAMATION "${NAME} is Ready to perform the following actions:$\r$\n$\r$\n1.) Close Explorer Windows - Allows ($DestDisk) to be Fat32 Formatted!$\r$\n$\r$\n2.) Fat32 Format ($DestDisk) - All Data will be Irrecoverably Deleted!$\r$\n$\r$\n3.) Create Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n4.) Create AUI Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n5.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive Drive ($DestDisk) is your USB Device?$\r$\nDouble Check with Windows (My Computer) to make sure!$\r$\n$\r$\nClick YES to perform these actions on ($DestDisk) or NO to Abort." IDYES proceed
MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(SECDOSTUFF_MB2)" IDYES proceed
Quit
${Else}
MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(SECDOSTUFF_MB3)" IDYES proceed
Quit
${EndIf}
proceed:
${If} ${FileExists} "$DestDisk\windows\system32" ; To add additional safeguard from user ignorance.
MessageBox MB_ICONSTOP|MB_OK "$(SECDOSTUFF_MB4)"
Quit
${Else}
 Call FormatYes ; Format the Drive?
 Call HaveSpace ; Got enough Space? Lets Check!
 Call DoSyslinux ; Install Syslinux on the drive
 Call 7zExtractor ; Extract the ISO
!insertmacro Distros
${EndIf}
SectionEnd

; --- Stuff to do at startup of script ---
Function .onInit
 StrCpy $FileFormat "iso"
 userInfo::getAccountType
  Pop $Auth
   strCmp $Auth "Admin" done
    Messagebox MB_OK|MB_ICONINFORMATION "$(ONINIT_MB1)"
  abort
 done:
 SetShellVarContext all
 InitPluginsDir
 ; File /oname=$PLUGINSDIR\paypal.bmp "paypal.bmp" 
FunctionEnd

Function onNotify_CasperSlider
Pop $Casper
SendMessage $CasperSlider ${TBM_GETPOS} 0 0 $Casper ; Get Trackbar position
${NSD_SetText} $SlideSpot "$Casper MB"
FunctionEnd

Function SetISOSize ; Get size of ISO
 System::Call 'kernel32::CreateFile(t "$TheISO", i 0x80000000, i 1, i 0, i 3, i 0, i 0) i .r0'
 System::Call "kernel32::GetFileSizeEx(i r0, *l .r1) i .r2"
 System::Alloc $1
 System::Int64Op $1 / 1048576 ; convert to MB
 Pop $1
 StrCpy $SizeOfCasper "$1"
 ;MessageBox MB_OK|MB_ICONINFORMATION "ISO Size: $SizeOfCasper"
 System::Call 'kernel32::CloseHandle(i r0)'
FunctionEnd

           Function .onInstSuccess
                    ExecShell "open" "${RODRI_WEBSITE}"
          FunctionEnd
  
          Function AUMBIInit
                   FindWindow $R0 "#32770" "" $HWNDPARENT
                   GetDlgItem $R0 $HWNDPARENT 9116
                   SendMessage $R0 ${WM_SETTEXT} 0 "STR:"
                   SetCtlColors $R0 0xc9c9c9 transparent

                   CreateFont $1 "Segoe UI" "16" "1000"
                   SendMessage $R0 ${WM_SETFONT} $1 1

                   GetDlgItem $R8 $HWNDPARENT 1256
                   ShowWindow $R8 ${SW_HIDE}

                   GetDlgItem $R7 $HWNDPARENT 1028
                   ShowWindow $R7 ${SW_HIDE}
                   GetDlgItem $R6 $HWNDPARENT 1035
                   ShowWindow $R6 ${SW_HIDE}
         FunctionEnd


         Function License_ShowFunction
                  Call PageRefreshPre

                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(LICENSE_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  SetCtlColors $mui.LicensePage 0xFFFFFF transparent
                  SetCtlColors $mui.LicensePage.TopText 0x000000 transparent
                  SetCtlColors $mui.LicensePage.Text 0x000000 transparent


         FunctionEnd
         
         Function PageRefreshPre
                    SetBrandingImage /IMGID=1046 "$PLUGINSDIR\modern-header.bmp"
         FunctionEnd

         Var AUMBI_CST_Bitmap1
         Var AUMBI_CST_Bitmap1_hImage
         Function BKG_BITMAP

                  ${NSD_CreateBitmap} 0u 0u 297.52u 141.54u ""
                  Pop $AUMBI_CST_Bitmap1
                  File "/oname=$PLUGINSDIR\AUMBI_ND_BKG.bmp" "Resources\Images\AUMBI_ND_BKG.bmp"
                  ${NSD_SetImage} $AUMBI_CST_Bitmap1 "$PLUGINSDIR\AUMBI_ND_BKG.bmp" $AUMBI_CST_Bitmap1_hImage

         FunctionEnd

         Function SelectionsPage_Color_Title

                  Call PageRefreshPre
                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(SELECTION_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  Call PageRefreshShow
         FunctionEnd

         Function PageRefreshShow
                    GetDlgItem $0 $HWNDPARENT 1
                    ShowWindow $0 ${SW_HIDE}
                    GetDlgItem $0 $HWNDPARENT 2
                    ShowWindow $0 ${SW_HIDE}
                    GetDlgItem $0 $HWNDPARENT 1
                    ShowWindow $0 ${SW_SHOW}
                    GetDlgItem $0 $HWNDPARENT 2
                    ShowWindow $0 ${SW_SHOW}
         FunctionEnd

        Function SelectionsPage_Show
                  Call SelectionsPage_Color_Title
                  Call SelectionsPage
                  nsDialogs::Show
        FunctionEnd


         Var AUMBI_FINISH
         Var AUMBI_FINISH_Link1
         Var AUMBI_FINISH_Label2

         Function InstFinish_ShowFunction

                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(FINISH_AUMBI_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

         FunctionEnd


         Function fnc_AUMBI_FINISH_Create

                  nsDialogs::Create 1044
                  Pop $AUMBI_FINISH
                  ${If} $AUMBI_FINISH == error
                        Abort
                  ${EndIf}
                  SetCtlColors $AUMBI_FINISH 0x000000 transparent

                  ${NSD_CreateLink} 17.11u 172.31u 200.1u 12.31u "$(Finish_Link)"
                  Pop $AUMBI_FINISH_Link1
                  SetCtlColors $AUMBI_FINISH_Link1 0x000000 transparent
                  ${NSD_OnClick} $AUMBI_FINISH_Link1 onClickMyLink

                  ${NSD_CreateLabel} 26.99u 54.77u 273.82u 47.38u "$(Finish_Text)"
                  Pop $AUMBI_FINISH_Label2
                  SetCtlColors $AUMBI_FINISH_Label2 0x000000 transparent

         FunctionEnd


         Function fnc_AUMBI_FINISH_Show
                  Call PageRefreshPre
                  Call fnc_AUMBI_FINISH_Create
                  Call InstFinish_ShowFunction
                  nsDialogs::Show
         FunctionEnd

         Function InstFiles_ShowFunction
                  Call PageRefreshPre
                  GetDlgItem $R0 $HWNDPARENT 9116
                  SendMessage $R0 ${WM_SETTEXT} 0 "STR:$(INSTALL_AUMBI_TOP_TEXT)"
                  SetCtlColors $R0 0xc9c9c9 transparent

                  CreateFont $1 "Segoe UI" "16" "1000"
                  SendMessage $R0 ${WM_SETFONT} $1 1

                  SetCtlColors $mui.InstFilesPage      0xFFFFFF transparent
                  ;SetCtlColors $mui.InstFilesPage.Text 0x000000 transparent

                  Call PageRefreshShow
         FunctionEnd
