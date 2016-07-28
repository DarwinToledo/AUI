#===========================================================
# English File
# by Darwin Toledo - www.darwintoledo.com
#===========================================================

!define RODRILANG ${LANG_SPANISHINTERNATIONAL}


       LangString License_Subtitle        ${RODRILANG} "Por favor, revise los términos de la licencia antes de continuar"
       LangString License_Text_Top        ${RODRILANG} "El software dentro de este programa se dividen en las siguientes licencias."
       LangString License_Text_Bottom     ${RODRILANG} "Debe aceptar los términos de este acuerdo de licencia para ejecutar ${NAME}. Si está de acuerdo, haga clic en Acepto para continuar."
       LangString SelectDist_Title        ${RODRILANG} "Selección de unidad y opciones de Distro."
       LangString SelectDist_Subtitle     ${RODRILANG} "Elija una unidad USB, y una Distribución, archivo ISO/ZIP."
       LangString Distro_Text             ${RODRILANG} "Paso 1: Seleccione un sistema operativo desde el menú desplegable para su USB"
       LangString IsoPage_Title           ${RODRILANG} "Seleccione su $FileFormat"
       LangString IsoPage_Text            ${RODRILANG} "Paso 2: Seleccione el $FileFormat (nombre igual al anterior)."
       LangString IsoFile                 ${RODRILANG} "Archivo $FileFormat| $ISOFileName" ;$ISOFileName variable previously *.iso
       LangString DrivePage_Text          ${RODRILANG} "Paso 3: Seleccione la letra de la unidad flash USB"
       LangString Casper_Text             ${RODRILANG} "Paso 4: Establecer el tamaño del archivo persistente (opcional)."
       LangString Extract                 ${RODRILANG} "Extracting the $FileFormat: The progress bar will not move until finished. Please be patient..."
       LangString CreateSysConfig         ${RODRILANG} "Archivos de configuración de edición"
       LangString ExecuteSyslinux         ${RODRILANG} "Ejecutando Syslinux en $DestDisk"
       LangString SkipSyslinux            ${RODRILANG} "Bueno Syslinux Existe..."
       LangString WarningSyslinux         ${RODRILANG} "An error ($R8) occurred while executing syslinux.$\r$\nYour USB drive won't be bootable..."
       LangString Install_Title           ${RODRILANG} "Instalando $DistroName"
       LangString Install_SubTitle        ${RODRILANG} "Por favor, espere mientras que ${NAME} instala $DistroName en $DestDisk"
       LangString Install_Finish_Sucess   ${RODRILANG} "${NAME} sucessfully installed $DistroName on $DestDisk"

       LangString Create_Button           ${RODRILANG} "Crear"
       LangString SELPAGE_DOWNLOAD_LINK   ${RODRILANG} "Enlace de descarga"
       LangString SELPAGE_VISIT_HOMEPAGE  ${RODRILANG} "Visitar la web de $OfficialName"
       LangString SELPAGE_BROWSEANDSELECT ${RODRILANG} "Busque y seleccione $FileFormat"
       LangString SELPAGE_BROWSE_BUTTON   ${RODRILANG} "Examinar"
       LangString SELPAGE_SHOWALLDRIVES   ${RODRILANG} "Mostrar Unidades (PRECAUCIÓN)"
       LangString SELPAGE_FORMATFAT       ${RODRILANG} "Formatear unidad como FAT32"
       LangString SELPAGE_VISITHELP       ${RODRILANG} "Haga clic aquí para visitar la web de ${NAME} para Ayuda!"

       LangString DOWNIT_DOWNLINKOP       ${RODRILANG} "Enlace de descarga abierto"
       LangString DOWNIT_DOWNLINK         ${RODRILANG} "Enlace de descarga"
       LangString LISTDRIVES_NOWSHOWING   ${RODRILANG} "Mostrando unidades (PRECAUCIÓN)"
       LangString LISTDRIVES_SHOWALL      ${RODRILANG} "Mostrar Unidades (PRECAUCIÓN)"
       LangString FORMATIT_WEWILLFORMAT   ${RODRILANG} "We will format $JustDrive Drive as Fat32."
       LangString FORMATIT_FORMATJUST     ${RODRILANG} "Format $JustDrive Drive (Erases Content)"
       LangString ENABLENEXT_FORMATJUST   ${RODRILANG} "Format $JustDrive Drive (Erases Content)"

       LangString DOWNLOADLINKS_DL        ${RODRILANG} "Download Link"
       LangString DOWNLOADLINKS_STEP2     ${RODRILANG} "Step 2: Once your download has finished, Browse to and select the ISO."

       LangString ONSELDISTRO_VISITHOME   ${RODRILANG} "Visit the $OfficialName Home Page"
       LangString ONSELDISTRO_STEP2       ${RODRILANG} "Paso 2: Seleccione $ISOFileName"
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