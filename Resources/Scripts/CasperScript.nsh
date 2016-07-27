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

; ------------ Casper Script --------------
Function CasperScript
${If} $Casper != "0"
 Call GetCaspTools
  nsExec::ExecToLog '"$PLUGINSDIR\dd.exe" if=/dev/zero of=$DestDisk\casper-rw bs=1M count=$Casper --progress'
  nsExec::ExecToLog '"$PLUGINSDIR\mke2fs.exe" -L casper-rw $DestDisk\casper-rw'	; was using -b 1024
${EndIf}
FunctionEnd

Function CasperSize
 IntOp $SizeOfCasper $SizeOfCasper + $Casper
FunctionEnd

Function GetCaspTools
SetShellVarContext all
InitPluginsDir
File /oname=$PLUGINSDIR\dd.exe "Binary\dd.exe"
File /oname=$PLUGINSDIR\mke2fs.exe "Binary\mke2fs.exe"
DetailPrint "Now Creating a Casper RW File" 
DetailPrint "Creating the Persistent File: The progress bar will not move until finished. Please be patient..." 
FunctionEnd

Function UseDD
SetShellVarContext all
InitPluginsDir
File /oname=$PLUGINSDIR\dd.exe "Binary\dd.exe"
DetailPrint "Creating the $DistroName Image using DD on $DestDisk. This will take several minutes!"  
DetailPrint "The progress bar will not move until this operation has finished. Please be patient..." 
FunctionEnd