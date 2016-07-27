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

!include ReplaceInFile.nsh

Function FindConfig ; Set config path and file 
  ${If} ${FileExists} "$DestDisk\HBCD\isolinux.cfg"     
  StrCpy $ConfigPath "HBCD"
  StrCpy $CopyPath "HBCD"
  StrCpy $ConfigFile "isolinux.cfg"  
  ${ElseIf} ${FileExists} "$DestDisk\boot\i386\loader\isolinux.cfg"  ; OpenSuse based 32bit
  StrCpy $ConfigPath "boot/i386/loader"
  StrCpy $CopyPath "boot\i386\loader"
  StrCpy $ConfigFile "isolinux.cfg"   
  ${ElseIf} ${FileExists} "$DestDisk\boot\x86_64\loader\isolinux.cfg"  ; OpenSuse based 64bit
  StrCpy $ConfigPath "boot/x86_64/loader"
  StrCpy $CopyPath "boot\x86_64\loader"
  StrCpy $ConfigFile "isolinux.cfg"  
  ${ElseIf} ${FileExists} "$DestDisk\boot\syslinux\syslinux.cfg"     
  StrCpy $ConfigPath "boot/syslinux"
  StrCpy $CopyPath "boot\syslinux"
  StrCpy $ConfigFile "syslinux.cfg"    
  ${ElseIf} ${FileExists} "$DestDisk\syslinux\syslinux.cfg"    
  StrCpy $ConfigPath "syslinux"
  StrCpy $CopyPath "syslinux"
  StrCpy $ConfigFile "syslinux.cfg"  
  ${ElseIf} ${FileExists} "$DestDisk\syslinux.cfg" 
  StrCpy $ConfigPath ""
  StrCpy $CopyPath ""
  StrCpy $ConfigFile "syslinux.cfg"  
  ${ElseIf} ${FileExists} "$DestDisk\boot\isolinux\isolinux.cfg"
  StrCpy $ConfigPath "boot/isolinux"
  StrCpy $CopyPath "boot\isolinux"
  StrCpy $ConfigFile "isolinux.cfg" 
  ${ElseIf} ${FileExists} "$DestDisk\boot\isolinux\syslinux.cfg"     
  StrCpy $ConfigPath "boot/isolinux"
  StrCpy $CopyPath "boot\isolinux"
  StrCpy $ConfigFile "syslinux.cfg"    
  ${ElseIf} ${FileExists} "$DestDisk\isolinux\isolinux.cfg" 
  StrCpy $ConfigPath "isolinux"
  StrCpy $CopyPath "isolinux"
  StrCpy $ConfigFile "isolinux.cfg"  
  ${ElseIf} ${FileExists} "$DestDisk\isolinux.cfg"  ; Probably Puppy based 
  StrCpy $ConfigPath ""
  StrCpy $CopyPath ""
  StrCpy $ConfigFile "isolinux.cfg"   
  ${ElseIf} ${FileExists} "$DestDisk\isolinux\txt.cfg"  ; Probably Ubuntu based
  StrCpy $ConfigPath "isolinux"
  StrCpy $CopyPath "isolinux"
  StrCpy $ConfigFile "txt.cfg"
  ${ElseIf} ${FileExists} "$DestDisk\isolinux\text.cfg"   ; Probably Ubuntu based
  StrCpy $ConfigPath "isolinux"
  StrCpy $CopyPath "isolinux"
  StrCpy $ConfigFile "text.cfg"
  ${ElseIf} ${FileExists} "$DestDisk\system\isolinux\isolinux.cfg"  ; AOSS
  StrCpy $ConfigPath "system/isolinux"
  StrCpy $CopyPath "system\isolinux"
  StrCpy $ConfigFile "isolinux.cfg"  
  ${ElseIf} ${FileExists} "$DestDisk\isolinux\syslinux.cfg"  ; AVG
  StrCpy $ConfigPath "isolinux"
  StrCpy $CopyPath "isolinux"
  StrCpy $ConfigFile "syslinux.cfg"    
  ${ElseIf} ${FileExists} "$DestDisk\syslinux\txt.cfg"   
  StrCpy $ConfigPath "syslinux"
  StrCpy $CopyPath "syslinux"
  StrCpy $ConfigFile "txt.cfg"
  ${ElseIf} ${FileExists} "$DestDisk\syslinux\text.cfg"   
  StrCpy $ConfigPath "syslinux"
  StrCpy $CopyPath "syslinux"
  StrCpy $ConfigFile "text.cfg"
  ${ElseIf} ${FileExists} "$DestDisk\slax\boot\syslinux.cfg"  ; Slax based 
  StrCpy $ConfigPath "slax/boot"
  StrCpy $CopyPath "slax\boot"
  StrCpy $ConfigFile "syslinux.cfg"    
  ${Else} 
   StrCpy $ConfigFile "NULL"
  ${EndIf}   
  ;MessageBox MB_OK "$ConfigPath/$ConfigFile"   
FunctionEnd

; ------------ Distros Macro --------------
!macro Distros  
 Call FindConfig ; Set config path and file
 ;${WriteToFile} "CONFIG /$ConfigPath/$ConfigFile$\r$\nAPPEND /$ConfigPath" $R0 
 !insertmacro ReplaceInFile "CONFIG CONFILE" "CONFIG /$ConfigPath/$ConfigFile" "all" "all" "$DestDisk\uui\syslinux.cfg"  
 !insertmacro ReplaceInFile "APPEND CONPATH" "APPEND /$ConfigPath" "all" "all" "$DestDisk\uui\syslinux.cfg"
 
; Initiate Plugins Directory for potential use
  SetShellVarContext all
  InitPluginsDir
  DetailPrint $(CreateSysConfig)  

; For Ubuntu Desktop and derivatives
  ${If} ${FileExists} "$DestDisk\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
  !insertmacro ReplaceInFile "initrd=/casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid initrd=/casper" "all" "all" "$DestDisk\isolinux\txt.cfg"   
  ${ElseIf} ${FileExists} "$DestDisk\isolinux\text.cfg" ; Rename the following for isolinux text.cfg
  !insertmacro ReplaceInFile "initrd=/casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid initrd=/casper" "all" "all" "$DestDisk\isolinux\text.cfg"  
  ${ElseIf} ${FileExists} "$DestDisk\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg
  !insertmacro ReplaceInFile "initrd=/casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid initrd=/casper" "all" "all" "$DestDisk\isolinux\isolinux.cfg"     
  ${EndIf}
  ${If} ${FileExists} "$DestDisk\boot\grub\loopback.cfg" ; Rename the following for grub loopback.cfg
  !insertmacro ReplaceInFile "boot=casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid boot=NULL" "all" "all" "$DestDisk\boot\grub\loopback.cfg"  
  !insertmacro ReplaceInFile "boot=NULL" "boot=casper" "all" "all" "$DestDisk\boot\grub\loopback.cfg"  
  ${EndIf}
  ${If} ${FileExists} "$DestDisk\boot\grub\grub.cfg" ; Rename the following for grub.cfg
  !insertmacro ReplaceInFile "boot=casper" "cdrom-detect/try-usb=true noprompt floppy.allowed_drive_mask=0 ignore_uuid boot=NULL" "all" "all" "$DestDisk\boot\grub\grub.cfg"  
  !insertmacro ReplaceInFile "boot=NULL" "boot=casper" "all" "all" "$DestDisk\boot\grub\grub.cfg"  
  ${EndIf}  
  
; Disable Ubuntu modified gfxboot as the Ubuntu gfxboot bootlogo archive may not work with all syslinux versions!
  ${If} ${FileExists} "$DestDisk\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg  
   !insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$DestDisk\isolinux\isolinux.cfg"   
  ${EndIf} 
;  ${If} ${FileExists} "$DestDisk\isolinux\syslinux.cfg"
;   !insertmacro ReplaceInFile "ui gfxboot bootlogo" "# ui gfxboot bootlogo" "all" "all" "$DestDisk\isolinux\syslinux.cfg"      
;  ${EndIf}  
  
; For Ubuntu Server  
  ${If} ${FileExists} "$DestDisk\install\netboot\ubuntu-installer\i386\*.*"  
   ${AndIf} ${FileExists} "$DestDisk\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
   !insertmacro ReplaceInFile "initrd=/install" "cdrom-detect/try-usb=true noprompt initrd=/NULL/netboot/ubuntu-installer/i386" "all" "all" "$DestDisk\isolinux\txt.cfg" 
   !insertmacro ReplaceInFile "/NULL" "/install" "all" "all" "$DestDisk\isolinux\txt.cfg"    
   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /install/netboot/ubuntu-installer/i386/linux" "all" "all" "$DestDisk\isolinux\txt.cfg"    
   ${ElseIf} ${FileExists} "$DestDisk\install\netboot\ubuntu-installer\i386\*.*"     
   ${AndIf} ${FileExists} "$DestDisk\isolinux\text.cfg" ; Rename the following for isolinux text.cfg  
   !insertmacro ReplaceInFile "initrd=/install" "cdrom-detect/try-usb=true noprompt initrd=/NULL/netboot/ubuntu-installer/i386" "all" "all" "$DestDisk\isolinux\text.cfg"  
   !insertmacro ReplaceInFile "/NULL" "/install" "all" "all" "$DestDisk\isolinux\text.cfg"     
   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /install/netboot/ubuntu-installer/i386/linux" "all" "all" "$DestDisk\isolinux\text.cfg"   
   ; Ubuntu Server amd64
   ${ElseIf} ${FileExists} "$DestDisk\install\netboot\ubuntu-installer\amd64\*.*"  
   ${AndIf} ${FileExists} "$DestDisk\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
   !insertmacro ReplaceInFile "initrd=/install" "cdrom-detect/try-usb=true noprompt initrd=/NULL/netboot/ubuntu-installer/amd64" "all" "all" "$DestDisk\isolinux\txt.cfg"  
   !insertmacro ReplaceInFile "/NULL" "/install" "all" "all" "$DestDisk\isolinux\txt.cfg"   
   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /install/netboot/ubuntu-installer/amd64/linux" "all" "all" "$DestDisk\isolinux\txt.cfg"    
   ${ElseIf} ${FileExists} "$DestDisk\install\netboot\ubuntu-installer\amd64\*.*"     
   ${AndIf} ${FileExists} "$DestDisk\isolinux\text.cfg" ; Rename the following for isolinux text.cfg  
   !insertmacro ReplaceInFile "initrd=/install" "cdrom-detect/try-usb=true noprompt initrd=/NULL/netboot/ubuntu-installer/amd64" "all" "all" "$DestDisk\isolinux\text.cfg"
   !insertmacro ReplaceInFile "/NULL" "/install" "all" "all" "$DestDisk\isolinux\text.cfg"     
   !insertmacro ReplaceInFile "kernel /install/vmlinuz" "kernel /install/netboot/ubuntu-installer/amd64/linux" "all" "all" "$DestDisk\isolinux\text.cfg"    
  ${EndIf} 
  ; Ubuntu Server amd64 grub
  ${If} ${FileExists} "$DestDisk\install\netboot\ubuntu-installer\amd64\*.*"  
   ${AndIf} ${FileExists} "$DestDisk\boot\grub\grub.cfg" ; Rename the following for grub grub.cfg  
   !insertmacro ReplaceInFile "linux	/install/" "linux /NOTIN/netboot/ubuntu-installer/amd64/linux cdrom-detect/try-usb=true noprompt NULL=" "all" "all" "$DestDisk\boot\grub\grub.cfg"    
   !insertmacro ReplaceInFile "initrd	/install/" "initrd /NOTIN/netboot/ubuntu-installer/amd64/" "all" "all" "$DestDisk\boot\grub\grub.cfg" 
   !insertmacro ReplaceInFile "NOTIN" "install" "all" "all" "$DestDisk\boot\grub\grub.cfg"  
  ; Ubuntu Server i386 grub  
  ${ElseIf} ${FileExists} "$DestDisk\install\netboot\ubuntu-installer\i386\*.*"  
   ${AndIf} ${FileExists} "$DestDisk\boot\grub\grub.cfg" ; Rename the following for grub grub.cfg  
   !insertmacro ReplaceInFile "linux	/install/" "linux /NOTIN/netboot/ubuntu-installer/i386/linux cdrom-detect/try-usb=true noprompt NULL=" "all" "all" "$DestDisk\boot\grub\grub.cfg"    
   !insertmacro ReplaceInFile "initrd	/install/" "initrd /NOTIN/netboot/ubuntu-installer/i386/" "all" "all" "$DestDisk\boot\grub\grub.cfg" 
   !insertmacro ReplaceInFile "NOTIN" "install" "all" "all" "$DestDisk\boot\grub\grub.cfg"     
  ${EndIf} 
  
; For Debian Based and derivatives
  ${If} ${FileExists} "$DestDisk\isolinux\live.cfg" ; Rename the following for isolinux live.cfg 
  !insertmacro ReplaceInFile "append boot=live" "append noprompt cdrom-detect/try-usb=true boot=live" "all" "all" "$DestDisk\isolinux\live.cfg" 
  ${EndIf} 

; For Fedora Based and derivatives
   ${If} ${FileExists} "$DestDisk\isolinux\isolinux.cfg" 
   ${AndIf} ${FileExists} "$DestDisk\LiveOS\livecd-iso-to-disk"  ; Probably Fedora based
   !insertmacro ReplaceInFile "root=live:CDLABEL=" "root=live:LABEL=UUI NULL=" "all" "all" "$DestDisk\isolinux\isolinux.cfg"   
   ${EndIf} 
   
; Mandriva\CentOS
   ${If} ${FileExists} "$DestDisk\isolinux\isolinux.cfg"
   ${AndIf} ${FileExists} "$DestDisk\LiveOS\*.*"
   !insertmacro ReplaceInFile "root=live:CDLABEL=" "root=live:LABEL=UUI NULL=" "all" "all" "$DestDisk\isolinux\isolinux.cfg"    
   ${EndIf}    

; CentOS EFI   
   ${If} $DistroName == "Centos"   
   ${AndIf} ${FileExists} "$DestDisk\EFI\BOOT\grub.cfg"
   !insertmacro ReplaceInFile "root=live:LABEL=Cent" "root=live:LABEL=UUI NULL=" "all" "all" "$DestDisk\EFI\BOOT\grub.cfg" 
   !insertmacro ReplaceInFile "set default=$\"1$\"" "set default=$\"0$\"" "all" "all" "$DestDisk\EFI\BOOT\grub.cfg"  
   ${EndIf}      

; For Puppy Based and derivatives
   ${If} ${FileExists} "$DestDisk\isolinux.cfg" 
   ${AndIf} ${FileExists} "$DestDisk\help2.msg"  ; Probably Puppy based  
   !insertmacro ReplaceInFile "pmedia=cd" "pmedia=usbflash" "all" "all" "$DestDisk\isolinux.cfg"    
   ${ElseIf} ${FileExists} "$DestDisk\isolinux.cfg" 
   ${AndIf} ${FileExists} "$DestDisk\help\help.msg"  ; Probably Puppy based 
   !insertmacro ReplaceInFile "append search" "append pmedia=usbflash search" "all" "all" "$DestDisk\isolinux.cfg"       
  ${EndIf}  
  
; AOSS
   ${If} ${FileExists} "$DestDisk\system\stage1"  
   !insertmacro ReplaceInFile "boot=cdrom" "boot=usb" "all" "all" "$DestDisk\$CopyPath\$ConfigFile"    
   ${EndIf} 

; Archlinux
   ${If} ${FileExists} "$DestDisk\arch\boot\syslinux\archiso.cfg"     
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\arch\boot\syslinux\archiso_pxe64.cfg"         
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\arch\boot\syslinux\archiso_pxe32.cfg"  
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\arch\boot\syslinux\archiso_sys64.cfg"          
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\arch\boot\syslinux\archiso_sys32.cfg"  
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\loader\entries\archiso-x86_64.conf"  
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\loader\entries\archiso_x86_64.conf"     
   ${EndIf}  
; Archbang
   ${If} ${FileExists} "$DestDisk\arch\boot\syslinux\syslinux.cfg"     
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\arch\boot\syslinux\syslinux.cfg"         
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\loader\entries\archiso-x86_64.conf"
   !insertmacro ReplaceInFile "archisolabel=" "archisolabel=UUI NULL=" "all" "all" "$DestDisk\loader\entries\archiso_x86_64.conf"    
   ${EndIf}  

; Knoppix
   ${If} ${FileExists} "$DestDisk\boot\isolinux\isolinux.cfg"  
   ${OrIf} ${FileExists} "$DestDisk\KNOPPIX\KNOPPIX"    
   !insertmacro ReplaceInFile "APPEND ramdisk_size" "APPEND noprompt ramdisk_size" "all" "all" "$DestDisk\$CopyPath\$ConfigFile"   
   ${EndIf}  
   
; PCLinuxOS
   ${If} ${FileExists} "$DestDisk\isolinux\isolinux.cfg" 
   ${AndIf} ${FileExists} "$DestDisk\livecd.sqfs"    
   !insertmacro ReplaceInFile "append livecd=livecd" "append fromusb livecd=livecd" "all" "all" "$DestDisk\isolinux\isolinux.cfg" 
   !insertmacro ReplaceInFile "prompt" "#NULLprom" "all" "all" "$DestDisk\isolinux\isolinux.cfg"   
   !insertmacro ReplaceInFile "ui gfxboot.com" "#NULLgfx" "all" "all" "$DestDisk\isolinux\isolinux.cfg"  
   !insertmacro ReplaceInFile "timeout" "#NULLtime" "all" "all" "$DestDisk\isolinux\isolinux.cfg"    
   ${EndIf}      
   
; RIP appears to use both syslinux and isolinux directories, but is missing key files from syslinux directory?   
  ${If} $DistroName == "RIP Linux" 
  DetailPrint $(CreateSysConfig)
  Rename "$DestDisk\boot\doc\" "$DestDisk\boot\syslinux\doc\"  
  Rename "$DestDisk\boot\isolinux\" "$DestDisk\boot\syslinux\"
  Rename "$DestDisk\boot\rootfs.cgz" "$DestDisk\boot\syslinux\rootfs.cgz"
  Rename "$DestDisk\boot\kernel32" "$DestDisk\boot\syslinux\kernel32"
  Rename "$DestDisk\boot\kernel64" "$DestDisk\boot\syslinux\kernel64"
  Rename "$DestDisk\boot\isolinux\memtest" "$DestDisk\boot\syslinux\memtest"
  Rename "$DestDisk\boot\initrd.gz" "$DestDisk\boot\syslinux\initrd.gz"
  Rename "$DestDisk\boot\loadlin.exe" "$DestDisk\boot\syslinux\loadlin.exe"
  Rename "$DestDisk\boot\rip.bat" "$DestDisk\boot\syslinux\rip.bat"
  Rename "$DestDisk\boot\grub4dos\grldr" "$DestDisk\boot\syslinux\grldr"
  Rename "$DestDisk\boot\isolinux\menu.c32" "$DestDisk\boot\syslinux\menu.c32"
  Rename "$DestDisk\boot\isolinux\hdt.c32" "$DestDisk\boot\syslinux\hdt.c32"
  Rename "$DestDisk\boot\isolinux\pci.ids" "$DestDisk\boot\syslinux\pci.ids"
  Rename "$DestDisk\boot\isolinux\modules.pci" "$DestDisk\boot\syslinux\modules.pci"
  DetailPrint $(ExecuteSyslinux)  
  nsExec::ExecToLog '$DestDisk\boot\syslinux\syslinux.exe -maf -d /boot/syslinux $DestDisk'   
  ${EndIf}
  
; Kaspersky Rescue Disk
  ${If} $DistroName == "Kaspersky Rescue Disk"   
  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL
  File /oname=$PLUGINSDIR\kav.cfg "texts\kav.cfg"  
  CopyFiles "$PLUGINSDIR\kav.cfg" "$DestDisk\uui\syslinux.cfg"   
  ${EndIf}    
  
; KTrinity Rescue Kit
  ${If} $DistroName == "Trinity Rescue Kit"   
   ${AndIf} ${FileExists} "$DestDisk\syslinux.cfg"       
   !insertmacro ReplaceInFile "append initrd=initrd.trk" "append vollabel=UUI initrd=initrd.trk" "all" "all" "$DestDisk\syslinux.cfg"     
  ${EndIf} 
  
; BlehOS  
  ${If} $DistroName == "BlehOS"   
   !insertmacro ReplaceInFile "ui gfxboot" "#ui NUIL gfxboot" "all" "all" "$DestDisk\boot\i386\loader\isolinux.cfg"     
  ${EndIf}   
  
; Hirens  
  ${If} $DistroName == "Hiren's Boot CD" 
  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL  
  File /oname=$PLUGINSDIR\hirens.cfg "texts\hirens.cfg"
  CopyFiles "$PLUGINSDIR\hirens.cfg" "$DestDisk\uui\syslinux.cfg"     
  ${EndIf}
 
; Kon-Boot 
  ${If} $DistroName == "Kon-Boot FREE" 
  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL    
  File /oname=$PLUGINSDIR\konboot.cfg "texts\konboot.cfg"
  File /oname=$PLUGINSDIR\memdisk "memdisk"  
  CopyFiles "$PLUGINSDIR\chain.c32" "$DestDisk\chain.c32" 
  CopyFiles "$PLUGINSDIR\vesamenu.c32" "$DestDisk\vesamenu.c32"    
  CopyFiles "$PLUGINSDIR\konboot.cfg" "$DestDisk\uui\syslinux.cfg"  
  CopyFiles "$PLUGINSDIR\memdisk" "$DestDisk\memdisk"     
  ${EndIf}
   
  ${If} $DistroName == "Kon-Boot Purchased" 
  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL    
  File /oname=$PLUGINSDIR\konboot.cfg "texts\konboot.cfg"
  File /oname=$PLUGINSDIR\memdisk "memdisk"  
  CopyFiles "$PLUGINSDIR\chain.c32" "$DestDisk\chain.c32" 
  CopyFiles "$PLUGINSDIR\vesamenu.c32" "$DestDisk\vesamenu.c32"    
  CopyFiles "$PLUGINSDIR\konboot.cfg" "$DestDisk\uui\syslinux.cfg"  
  CopyFiles "$PLUGINSDIR\memdisk" "$DestDisk\memdisk"     
  ${EndIf}  
  
; OpenSuse 32/64bit
  ${If} $DistroName == "OpenSUSE 32bit"
  ${OrIf} $DistroName == "OpenSUSE 64bit"    
  !insertmacro ReplaceInFile "append initrd=initrd" "append initrd=NULL" "all" "all" "$DestDisk\$CopyPath\$ConfigFile"
  !insertmacro ReplaceInFile "NULL" "initrd isofrom=/dev/disk/by-label/UUI:/$JustISO isofrom_device=/dev/disk/by-label/UUI isofrom_system=/$JustISO loader=syslinux" "all" "all" "$DestDisk\$CopyPath\$ConfigFile"    
  ${EndIf}   

; Simply Mepis and misc GRUB oriented
  ${If} $ConfigFile == "NULL"
  ${AndIf} ${FileExists} "$DestDisk\boot\grub\menu.lst" 
  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL    
  File /oname=$PLUGINSDIR\grub.cfg "texts\grub.cfg"
  File /oname=$PLUGINSDIR\grldr "grldr"  
  CopyFiles "$PLUGINSDIR\grldr" "$DestDisk\uui\grldr"   
  CopyFiles "$PLUGINSDIR\grub.cfg" "$DestDisk\uui\syslinux.cfg"     
  ${EndIf} 

; Falcon 4 and misc GRUB oriented
  ${If} $ConfigFile == "NULL"
  ${AndIf} ${FileExists} "$DestDisk\menu.lst" 
  ${AndIf} ${FileExists} "$DestDisk\grldr"  
  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL     
  File /oname=$PLUGINSDIR\grubroot.cfg "texts\grubroot.cfg"
  CopyFiles "$PLUGINSDIR\grubroot.cfg" "$DestDisk\uui\syslinux.cfg"
  ${EndIf}  
  
; Eset SysRescue Live  
  ${If} ${FileExists} "$DestDisk\eset-favicon.ico" 
  !insertmacro ReplaceInFile "live-media=/dev/disk/by-label/eSysRescueLiveCD" " " "all" "all" "$DestDisk\$CopyPath\txt.cfg"    
  ${EndIf}  
  
; TAILS

 ; Commented following out as the Tails developers wanted it this way. If you have problems booting your external device, manually remove live-media=removable parameter. I feel this parameter should not be used anyhow as it is too restrictive. 
   ;${If} ${FileExists} "$DestDisk\isolinux\live.cfg" 
   ;${AndIf} ${FileExists} "$DestDisk\isolinux\live486.cfg" 
   ;${AndIf} ${FileExists} "$DestDisk\isolinux\live686.cfg"    
   ;!insertmacro ReplaceInFile "live-media=removable" "root=LABEL=UUI live-media-path=/live" "all" "all" "$DestDisk\isolinux\live.cfg" 
   ;!insertmacro ReplaceInFile "live-media=removable" "root=LABEL=UUI live-media-path=/live" "all" "all" "$DestDisk\isolinux\live486.cfg"   
   ;!insertmacro ReplaceInFile "live-media=removable" "root=LABEL=UUI live-media-path=/live" "all" "all" "$DestDisk\isolinux\live686.cfg"   
   ;${EndIf}    
  
  ${If} ${FileExists} "$DestDisk\boot\grub\mbrid" ; For OpenSuSe like compilations!
   Call MBRID  
  ${EndIf}    
  
; Enable Casper  
  ${If} $Persistence == "casper"
  ${AndIf} $Casper != "0"  
  ; Add Boot Code Persistent
   ${If} ${FileExists} "$DestDisk\isolinux\txt.cfg" ; Rename the following for isolinux txt.cfg
    !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent noprompt" "all" "all" "$DestDisk\isolinux\txt.cfg"   
   ${ElseIf} ${FileExists} "$DestDisk\isolinux\text.cfg" ; Rename the following for isolinux text.cfg
    !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent noprompt" "all" "all" "$DestDisk\isolinux\text.cfg"  
   ${ElseIf} ${FileExists} "$DestDisk\isolinux\isolinux.cfg" ; Rename the following for isolinux.cfg
    !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent noprompt" "all" "all" "$DestDisk\isolinux\isolinux.cfg"     
   ${EndIf} 
   ${If} ${FileExists} "$DestDisk\boot\grub\loopback.cfg" ; Rename the following for grub loopback.cfg
    !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent noprompt" "all" "all" "$DestDisk\boot\grub\loopback.cfg"  
   ${EndIf}  
   ${If} ${FileExists} "$DestDisk\boot\grub\grub.cfg" ; Rename the following for grub.cfg
    !insertmacro ReplaceInFile "cdrom-detect/try-usb=true noprompt" "cdrom-detect/try-usb=true persistent noprompt" "all" "all" "$DestDisk\boot\grub\grub.cfg"  
   ${EndIf}  
  ; Create Casper-rw file
   Call CasperScript  
  ${EndIf}
  
; Old Methods....     
  
  ${If} $JustISO == "ubuntu-12.04.3-alternate-i386.iso"     
  DetailPrint "Renaming .ude to .udeb"  
  ReadEnvStr $R0 COMSPEC ; grab commandline  
  nsExec::Exec "$R0 /C Rename $DestDisk\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Alternate 12.04 i386
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files    
 
  ${ElseIf} $JustISO == "ubuntu-12.04.3-alternate-amd64.iso"  
  DetailPrint "Renaming .ude to .udeb" 
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $DestDisk\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C Rename $DestDisk\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Alternate 12.04 amd64
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files        

  ${ElseIf} $DistroName == "Chakra"  
  Rename "$DestDisk\isolinux\" "$DestDisk\syslinux\"
  Rename "$DestDisk\syslinux\isolinux.cfg" "$DestDisk\syslinux\syslinux.cfg"
  DetailPrint "Creating Label CL_20120208 on $DestDisk"
  nsExec::ExecToLog '"cmd" /c "LABEL $DestDisk CL_20120208"'  

  ${ElseIf} $JustISO == "ubuntu-11.04-server-i386.iso" 
  ${OrIf} $JustISO == "ubuntu-11.04-server-amd64.iso"   
  ${OrIf} $JustISO == "ubuntu-11.10-server-i386.iso" 
  ${OrIf} $JustISO == "ubuntu-11.10-server-amd64.iso"     
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $DestDisk\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files
  
  ${ElseIf} $JustISO == "ubuntu-12.04-server-amd64.iso"
  ${OrIf} $JustISO == "ubuntu-12.10-server-amd64.iso"   
  ${OrIf} $JustISO == "ubuntu-13.04-server-amd64.iso"   
  ${OrIf} $JustISO == "ubuntu-13.10-server-amd64.iso"  
  ${OrIf} $JustISO == "ubuntu-12.10-server-i386.iso"   
  ${OrIf} $JustISO == "ubuntu-13.04-server-i386.iso"   
  ${OrIf} $JustISO == "ubuntu-13.10-server-i386.iso"   
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $DestDisk\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-raring\*.ude *.udeb" ; rename broken udeb files     
  nsExec::Exec "$R0 /C Rename $DestDisk\dists\precise\main\dist-upgrader\binary-amd64\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 amd64
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-raring\*precise*.deb *precise1_amd64.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-raring\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-raring\linux-headers-3.8.0-29_3.8.0-29.42~precise1_amd64.deb linux-headers-3.8.0-29_3.8.0-29.42~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd.deb grub-efi-amd64-signed_1.9~ubuntu12.04.4+1.99-21ubuntu3.10_amd64.deb" ; rename broken udeb files   
  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_amd64.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_amd64.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\g\grub2-signed\grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd6.deb grub-efi-amd64-signed_1.9~ubuntu12.04.3+1.99-21ubuntu3.9_amd64.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files     

  ${ElseIf} $JustISO == "ubuntu-12.04-server-i386.iso"                
  ReadEnvStr $R0 COMSPEC ; grab commandline
  nsExec::Exec "$R0 /C Rename $DestDisk\pool\main\l\linux\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-raring\*.ude *.udeb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*.ude *.udeb" ; rename broken udeb files 
; Ubuntu Server 12.04 i386
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-signed-lts-quantal\*precise*.deb *precise1_i386.deb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*precis*.deb *precise1_i386.deb" ; rename broken udeb files   
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files  
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-quantal\linux-headers-3.5.0-23_3.5.0-23.35~precise1_i386.deb linux-headers-3.5.0-23_3.5.0-23.35~precise1_all.deb" ; rename broken udeb files 
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\l\linux-lts-raring\*precis*.udeb *precise1_i386.udeb" ; rename broken udeb files    
  nsExec::Exec "$R0 /C rename $DestDisk\pool\main\m\maas\python-maas-provisioningserver*.deb python-maas-provisioningserver_1.2+bzr1373+dfsg-0ubuntu1~12.04.1_all.deb" ; rename broken udeb files      
  
  ${ElseIf} $JustISO == "ubuntu-10.04-server-i386.iso"  
  ${OrIf} $JustISO == "ubuntu-10.04-server-amd64.iso" 
  Rename "$DestDisk\pool\l\linux\*.ude" "$DestDisk\pool\l\linux\*.udeb"   

  ${ElseIf} $DistroName == "Windows Vista Installer" 
  ${OrIf} $DistroName == "Windows 7 Installer"   
  ${OrIf} $DistroName == "Windows 8 Installer"  
  ${OrIf} $DistroName == "Windows 10 Installer"    
  StrCpy $ConfigFile == "syslinux.cfg" ; Make sure it isn't NULL      
  File /oname=$PLUGINSDIR\win7.cfg "texts\win7.cfg"
  CopyFiles "$PLUGINSDIR\win7.cfg" "$DestDisk\uui\syslinux.cfg"
  CopyFiles "$PLUGINSDIR\chain.c32" "$DestDisk\chain.c32"  
  
  ${ElseIf} $DistroName == "Try Unlisted Linux ISO"  
  Call RandomISO    
  
  ${EndIf} 
 
  File /oname=$PLUGINSDIR\Uni-USB-Installer-Copying.txt "Uni-USB-Installer-Copying.txt"
  File /oname=$PLUGINSDIR\Uni-USB-Installer-Readme.txt "Uni-USB-Installer-Readme.txt" 
  File /oname=$PLUGINSDIR\license.txt "license.txt"  
  nsExec::ExecToLog '"xcopy" "$PLUGINSDIR\Uni-USB-Installer-Copying.txt" /f/y "$DestDisk\"' ; Copy Licenses to the drive
  nsExec::ExecToLog '"xcopy" "$PLUGINSDIR\Uni-USB-Installer-Readme.txt" /f/y "$DestDisk\"' ; Copy Readme.txt to the drive
  nsExec::ExecToLog '"xcopy" "$PLUGINSDIR\license.txt" /f/y "$DestDisk\"' ; Copy license.txt to the drive  
  Call OldSysFix
  
 ${If} $ConfigFile == "NULL"
  MessageBox MB_OK "I couldn't find a configuration file.$\r$\n'$JustISO' is not supported, please report the exact steps taken to arrive at this message"
 ${EndIf}  
!macroend

Function RandomISO

FunctionEnd

Function OldSysFix ; fix to force use of UUI packaged version of syslinux... 
 ${IfNot} ${FileExists} "$DestDisk\utils\win32\syslinux.exe"
  ${AndIf} $DistroName != "ArchLinux"
    ${AndIf} $DistroName != "ArchBang"
 DetailPrint "Checking if we need to replace vesamenu.c32, menu.c32, and chain.c32"   
  !insertmacro CallFindFiles $DestDisk chain.c32 CBFUNC
  !insertmacro CallFindFiles $DestDisk vesamenu.c32 CBFUNC
  !insertmacro CallFindFiles $DestDisk menu.c32 CBFUNC
 ${EndIf}
FunctionEnd