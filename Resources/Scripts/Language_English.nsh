#===========================================================
# English File
# by Darwin Toledo - www.darwintoledo.com
#===========================================================

!define RODRILANG ${LANG_ENGLISH}


       LangString License_Subtitle        ${RODRILANG} "Please review the license terms before proceeding"
       LangString License_Text_Top        ${RODRILANG} "The software within this program falls under the following Licenses."
       LangString License_Text_Bottom     ${RODRILANG} "You must accept the terms of this License agreement to run this ${NAME}. If you agree, Click I Agree to Continue."
       LangString SelectDist_Title        ${RODRILANG} "Drive Selection and Distro Options Page"
       LangString SelectDist_Subtitle     ${RODRILANG} "Choose a Linux Distro, ISO/ZIP file and, your USB Flash Drive."
       LangString Distro_Text             ${RODRILANG} "Step 1: Select a Linux Distribution from the dropdown to put on your USB"
       LangString IsoPage_Title           ${RODRILANG} "Select Your $FileFormat"
       LangString IsoPage_Text            ${RODRILANG} "Step 2: Select the $FileFormat (Name MUST BE the same as above)."
       LangString IsoFile                 ${RODRILANG} "$FileFormat file|$ISOFileName" ;$ISOFileName variable previously *.iso
       LangString DrivePage_Text          ${RODRILANG} "Step 3: Select your USB Flash Drive Letter Only"
       LangString Casper_Text             ${RODRILANG} "Step 4: Set a Persistent file size for storing changes (Optional)."
       LangString Extract                 ${RODRILANG} "Extracting the $FileFormat: The progress bar will not move until finished. Please be patient..."
       LangString CreateSysConfig         ${RODRILANG} "Editing Configuration Files"
       LangString ExecuteSyslinux         ${RODRILANG} "Executing syslinux on $DestDisk"
       LangString SkipSyslinux            ${RODRILANG} "Good Syslinux Exists..."
       LangString WarningSyslinux         ${RODRILANG} "An error ($R8) occurred while executing syslinux.$\r$\nYour USB drive won't be bootable..."
       LangString Install_Title           ${RODRILANG} "Installing $DistroName"
       LangString Install_SubTitle        ${RODRILANG} "Please wait while ${NAME} installs $DistroName on $DestDisk"
       LangString Install_Finish_Sucess   ${RODRILANG} "${NAME} sucessfully installed $DistroName on $DestDisk"
        ;LangString Finish_Install           ${RODRILANG} "$InUnStallation is Complete."
        ;LangString Finish_Title             ${RODRILANG} "${NAME} has completed the $InUnStallation."
        ;LangString Finish_Text              ${RODRILANG} "Your Selections have been $InUnStalled on your USB drive.$\r$\n$\r$\nFeel Free to run this tool again to $InUnStall more Distros.$\r$\n$\r$\n${NAME} will keep track of selections you have already $InUnStalled."
        ;LangString Finish_Link              ${RODRILANG} "Visitar la web de $OfficialName"

       LangString Create_Button           ${RODRILANG} "Create"
       LangString SELPAGE_DOWNLOAD_LINK   ${RODRILANG} "Download Link"
       LangString SELPAGE_VISIT_HOMEPAGE  ${RODRILANG} "Visit the $OfficialName HomePage"
       LangString SELPAGE_BROWSEANDSELECT ${RODRILANG} "Browse to and select the $FileFormat"
       LangString SELPAGE_BROWSE_BUTTON   ${RODRILANG} "Browse"
       LangString SELPAGE_SHOWALLDRIVES   ${RODRILANG} "Show all Drives (USE WITH CAUTION)"
       LangString SELPAGE_FORMATFAT       ${RODRILANG} "Format Drive as Fat32"
       LangString SELPAGE_VISITHELP       ${RODRILANG} "Click HERE to Visit the ${NAME} Page for additional HELP"

       LangString DOWNIT_DOWNLINKOP       ${RODRILANG} "Download Link Opened"
       LangString DOWNIT_DOWNLINK         ${RODRILANG} "Download Link"
       LangString LISTDRIVES_NOWSHOWING   ${RODRILANG} "Now Showing All Drives (BE CAREFUL)"
       LangString LISTDRIVES_SHOWALL      ${RODRILANG} "Show all Drives (USE WITH CAUTION)"
       LangString FORMATIT_WEWILLFORMAT   ${RODRILANG} "We will format $JustDrive Drive as Fat32."
       LangString FORMATIT_FORMATJUST     ${RODRILANG} "Format $JustDrive Drive (Erases Content)"
       LangString ENABLENEXT_FORMATJUST   ${RODRILANG} "Format $JustDrive Drive (Erases Content)"

       LangString DOWNLOADLINKS_DL        ${RODRILANG} "Download Link"
       LangString DOWNLOADLINKS_STEP2     ${RODRILANG} "Step 2: Once your download has finished, Browse to and select the ISO."

       LangString ONSELDISTRO_VISITHOME   ${RODRILANG} "Visit the $OfficialName Home Page"
       LangString ONSELDISTRO_STEP2       ${RODRILANG} "Step 2: Select your $ISOFileName"
       LangString ONSELDISTRO_BROWSE      ${RODRILANG} "Browse to your $ISOFileName  -->"
       LangString ONSELDISTRO_WEFOUND     ${RODRILANG} "We Found and Selected the $FileFormat."
       LangString ONSELDISTRO_STEP2DONE   ${RODRILANG} "Step 2 DONE: $ISOFileName Found and Selected!"
       LangString ONSELDISTRO_DL          ${RODRILANG} "Download Link"
       LangString ONSELDISTRO_BROWSE2     ${RODRILANG} "Browse to and select your $ISOFileName"
       LangString ONSELDISTRO_STEP2PEND   ${RODRILANG} "Step 2 PENDING: Browse to your $ISOFileName"

       LangString ISO_BROWSE_LOCAL        ${RODRILANG} "Local $FileFormat Selected."

       LangString SECDOSTUFF_MB1          ${RODRILANG} "${NAME} is Ready to perform the following actions:$\r$\n$\r$\n1.) Close all Open Explorer Windows $\r$\n$\r$\n2.) Create a $DistroName image on ($DestDisk). WARNING: All Data on ($DestDisk) will be irrecoverably Overwritten by this Image!$\r$\n$\r$\nAre you absolutely positive Drive ($DestDisk) is your USB Device?$\r$\nDouble Check with Windows (My Computer) to make sure!$\r$\n$\r$\nClick YES to perform these actions on ($DestDisk) or NO to Abort."
       LangString SECDOSTUFF_MB2          ${RODRILANG} "NOTE: You must manually close all Explorer Windows currently accessing ($DestDisk) so that this drive can be successfully Fat32 Formatted!$\r$\n$\r$\n ${NAME} is Ready to perform the following actions:$\r$\n$\r$\n1.) Fat32 Format ($DestDisk) - All Data will be Irrecoverably Deleted!$\r$\n$\r$\n2.) Create Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n3.) Create UUI Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n4.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you absolutely positive Drive ($DestDisk) is your USB Device?$\r$\nDouble Check with Windows (My Computer) to make sure!$\r$\n$\r$\nClick YES to perform these actions on ($DestDisk) or NO to Abort."
       LangString SECDOSTUFF_MB3          ${RODRILANG} "${NAME} is Ready to perform the following actions:$\r$\n$\r$\n1.) Create Syslinux MBR on ($DestDisk) - Existing MBR will be Overwritten!$\r$\n$\r$\n2.) Create UUI Label on ($DestDisk) - Existing Label will be Overwritten!$\r$\n$\r$\n3.) Install ($DistroName) on ($DestDisk)$\r$\n$\r$\nAre you positive Drive ($DestDisk) is your USB Device?$\r$\nDouble Check with Windows (My Computer) to make sure!$\r$\n$\r$\nClick YES to perform these actions on ($DestDisk) or NO to Abort."
       LangString SECDOSTUFF_MB4          ${RODRILANG} "ABORTING! ($DestDisk) contains a WINDOWS/SYSTEM32 Directory."
       LangString ONINIT_MB1              ${RODRILANG} "Currently you're trying to run this program as: $Auth$\r$\n$\r$\nYou must run this program with administrative rights...$\r$\n$\r$\nRight click the file and select Run As Administrator or Run As (and select an administrative account)!"

!undef RODRILANG