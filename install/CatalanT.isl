; *** Inno Setup version 4 Catalan messages ***
;
; To download user-contributed translations of this file, go to:
;   http://www.jrsoftware.org/is3rdparty.php
;
; Note: When translating this text, do not add periods (.) to the end of
; messages that didn't have them already, because on those messages Inno
; Setup adds the periods automatically (appending a period would result in
; two periods being displayed).
;
; Tradu�t per Carles Millan, Barcelona, http://carlesmillan.com (30-01-04)

[LangOptions]

LanguageName=Catal�
LanguageID=$0403

[Messages]

; *** Application titles
SetupAppTitle=Instal�laci�
SetupWindowTitle=Instal�laci� - %1
UninstallAppTitle=Desinstal�laci�
UninstallAppFullTitle=Desinstal�lar %1

; *** Misc. common
InformationTitle=Informaci�
ConfirmTitle=Confirmaci�
ErrorTitle=Error

; *** SetupLdr messages
SetupLdrStartupMessage=Aquest programa instal�lar� %1. Voleu continuar?
LdrCannotCreateTemp=No s'ha pogut crear un fitxer temporal. Instal�laci� cancel�lada
LdrCannotExecTemp=No s'ha pogut executar el fitxer a la carpeta temporal. Instal�laci� cancel�lada

; *** Startup error messages
LastErrorMessage=%1.%n%nError %2: %3
SetupFileMissing=El fitxer %1 no es troba a la carpeta d'instal�laci�. Si us plau, resoleu el problema o obteniu una nova c�pia del programa.
SetupFileCorrupt=Els fitxers d'instal�laci� estan corromputs. Si us plau, obteniu una nova c�pia del programa.
SetupFileCorruptOrWrongVer=Els fitxers d'instal�laci� estan espatllats, o s�n incompatibles amb aquesta versi� del programa. Si us plau, resoleu el problema o obteniu una nova c�pia del programa.
NotOnThisPlatform=Aquest programa no funcionar� sota %1.
OnlyOnThisPlatform=Aquest programa nom�s pot ser executat sota %1.
WinVersionTooLowError=Aquest programa requereix %1 versi� %2 o posterior.
WinVersionTooHighError=Aquest programa no pot ser instal�lat sota %1 versi� %2 o posterior.
AdminPrivilegesRequired=Cal que tingueu privilegis d'administrador per poder instal�lar aquest programa.
PowerUserPrivilegesRequired=Cal que accediu com a administrador o com a membre del grup Power Users en instal�lar aquest programa.
SetupAppRunningError=El programa d'instal�laci� ha detectat que %1 s'est� executant actualment.%n%nSi us plau, tanqueu el programa i premeu Seg�ent per a continuar o Cancel�lar per a sortir.
UninstallAppRunningError=El programa de desinstal�laci� ha detectat que %1 s'est� executant en aquest moment.%n%nSi us plau, tanqueu el programa i premeu Seg�ent per a continuar o Cancel�lar per a sortir.

; *** Misc. errors
ErrorCreatingDir=El programa d'instal�laci� no ha pogut crear la carpeta "%1"
ErrorTooManyFilesInDir=No s'ha pogut crear un fitxer a la carpeta "%1" perqu� cont� massa fitxers

; *** Setup common messages
ExitSetupTitle=Sortir
ExitSetupMessage=La instal�laci� no s'ha completat. Si sortiu ara, el programa no ser� instal�lat.%n%nPer a completar-la podreu tornar a executar el programa d'instal�laci� quan vulgueu.%n%nVoleu sortir-ne?
AboutSetupMenuItem=&Sobre la instal�laci�...
AboutSetupTitle=Sobre la instal�laci�
AboutSetupMessage=%1 versi� %2%n%3%n%nP�gina web de %1:%n%4
AboutSetupNote=

; *** Buttons
ButtonBack=< &Tornar
ButtonNext=&Seg�ent >
ButtonInstall=&Instal�lar
ButtonOK=Seg�ent
ButtonCancel=Cancel�lar
ButtonYes=&S�
ButtonYesToAll=S� a &Tot
ButtonNo=&No
ButtonNoToAll=N&o a tot
ButtonFinish=&Finalitzar
ButtonBrowse=&Explorar...

; *** "Select Language" dialog messages
ButtonWizardBrowse=&Cercar...
ButtonNewFolder=Crear &nova carpeta
SelectLanguageTitle=Seleccioneu idioma
SelectLanguageLabel=Seleccioneu idioma a emprar durant la instal�laci�:

; *** Common wizard text
ClickNext=Premeu Seg�ent per a continuar o Cancel�lar per a abandonar la instal�laci�.
BeveledLabel=

; *** "Welcome" wizard page
BrowseDialogTitle=Trieu una carpeta
BrowseDialogLabel=Trieu la carpeta de destinaci� i premeu Seg�ent.
NewFolderName=Nova carpeta
WelcomeLabel1=Benvingut a l'assistent d'instal�laci� de [name]
WelcomeLabel2=Aquest programa instal�lar� [name/ver] al vostre ordinador.%n%n�s molt recomanable que abans de continuar tanqueu tots els altres programes oberts, per tal d'evitar conflictes durant el proc�s d'instal�laci�.

; *** "Password" wizard page
WizardPassword=Codi d'acc�s
PasswordLabel1=Aquesta instal�laci� est� protegida amb un codi d'acc�s.
PasswordLabel3=Indiqueu el codi d'acc�s i premeu Seg�ent per a continuar. Aquest codi distingeix entre maj�scules i min�scules.
PasswordEditLabel=&Codi:
IncorrectPassword=El codi introdu�t no �s correcte. Torneu-ho a intentar.

; *** "License Agreement" wizard page
WizardLicense=Acceptaci� de la llicencia d'�s.
LicenseLabel=Cal que llegiu aquesta informaci� abans de continuar.
LicenseLabel3=Si us plau, llegiu l'Acord de Llic�ncia seg�ent. Cal que n'accepteu els termes abans de continuar amb la instal�laci�.
LicenseAccepted=&Accepto l'acord
LicenseNotAccepted=&No accepto l'acord

; *** "Information" wizard pages
WizardInfoBefore=Informaci�
InfoBeforeLabel=Si us plau, llegiu la informaci� seg�ent abans de continuar.
InfoBeforeClickLabel=Quan estigueu preparat per a continuar, premeu Seg�ent
WizardInfoAfter=Informaci�
InfoAfterLabel=Si us plau, llegiu la informaci� seg�ent abans de continuar.
InfoAfterClickLabel=Quan estigueu preparat per a continuar, premeu Seg�ent

; *** "User Information" wizard page
WizardUserInfo=Informaci� sobre l'usuari
UserInfoDesc=Si us plau, entreu la vostra informaci�.
UserInfoName=&Nom de l'usuari:
UserInfoOrg=&Organitzaci�
UserInfoSerial=&N�mero de s�rie:
UserInfoNameRequired=Cal que hi entreu un nom

; *** "Select Destination Directory" wizard page
WizardSelectDir=Trieu Carpeta de Destinaci�
SelectDirDesc=On s'ha d'instal�lar [name]?
DiskSpaceMBLabel=Aquest programa necessita un m�nim de [mb] MB d'espai a disc.
ToUNCPathname=La instal�laci� no pot instal�lar el programa en una carpeta UNC. Si esteu  provant d'instal�lar-lo en xarxa, haureu d'assignar una lletra (D:, E:, etc...) al disc de destinaci�.
InvalidPath=Cal donar una ruta completa amb lletra d'unitat, per exemple:%n%nC:\Aplicaci�%n%no b� una ruta UNC en la forma:%n%n\\servidor\compartit
InvalidDrive=El disc o ruta de xarxa seleccionat no existeix, si us plau trieu-ne un altre.
DiskSpaceWarningTitle=No hi ha prou espai al disc
DiskSpaceWarning=El programa d'instal�laci� necessita com a m�nim %1 KB d'espai lliure, per� el disc seleccionat nom�s t� %2 KB disponibles.%n%nTot i amb aix�, desitgeu continuar?
DirNameTooLong=El nom de la carpeta o de la ruta �s massa llarg.
InvalidDirName=El nom de la carpeta no �s v�lid.
BadDirName32=Un nom de carpeta no pot contenir cap dels car�cters seg�ents:%n%n%1
DirExistsTitle=La carpeta existeix
DirExists=La carpeta:%n%n%1%n%nja existeix. Voleu instal�lar igualment el programa en aquesta carpeta?
DirDoesntExistTitle=La Carpeta No Existeix
DirDoesntExist=La carpeta:%n%n%1%n%nno existeix. Voleu que sigui creada?

; *** "Select Program Group" wizard page
WizardSelectComponents=Trieu Components
SelectComponentsDesc=Quins components cal instal�lar?
SelectComponentsLabel2=Seleccioneu els components que voleu instal�lar; elimineu els components que no voleu instal�lar. Premeu Seg�ent per a continuar.
FullInstallation=Instal�laci� completa
; if possible don't translate 'Compact' as 'Minimal' (I mean 'Minimal' in your language)
CompactInstallation=Instal�laci� compacta
CustomInstallation=Instal�laci� personalitzada
NoUninstallWarningTitle=Els components Existeixen
NoUninstallWarning=El programa d'instal�laci� ha detectat que els components seg�ents ja es troben al vostre ordinador:%n%n%1%n%nSi no estan seleccionats no seran desinstal�lats.%n%nVoleu continuar igualment?
ComponentSize1=%1 Kb
ComponentSize2=%1 Mb
ComponentsDiskSpaceMBLabel=Aquesta selecci� requereix un m�nim de [mb] Mb d'espai al disc.

; *** "Select Additional Tasks" wizard page
WizardSelectTasks=Trieu tasques addicionals
SelectTasksDesc=Quines tasques addicionals cal executar?
SelectTasksLabel2=Trieu les tasques addicionals que voleu que siguin executades mentre s'instal�la [name], i despr�s premeu Seg�ent.

; *** "Select Start Menu Folder" wizard page
WizardSelectProgramGroup=Trieu la carpeta del Men� Inici
SelectStartMenuFolderDesc=On cal situar els enlla�os del programa?
NoIconsCheck=&No crear cap icona
MustEnterGroupName=Cal que hi entreu un nom de carpeta.
GroupNameTooLong=El nom de la carpeta o de la ruta �s massa llarg.
InvalidGroupName=El nom de la carpeta no �s v�lid.
BadGroupName=El nom del grup no pot contenir cap dels car�cters seg�ents:%n%n%1
NoProgramGroupCheck2=&No crear una carpeta al Men� Inici

; *** "Ready to Install" wizard page
WizardReady=Preparat per a instal�lar
ReadyLabel1=El programa d'instal�laci� est� preparat per a iniciar la instal�laci� de [name] al vostre ordinador.
ReadyLabel2a=Premeu Instal�lar per a continuar amb la instal�laci�, o Tornar si voleu revisar o modificar les opcions d'instal�laci�.
ReadyLabel2b=Premeu Instal�lar per a continuar amb la instal�laci�.
ReadyMemoUserInfo=Informaci� de l'usuari:
ReadyMemoDir=Carpeta de destinaci�:
ReadyMemoType=Tipus d'instal�laci�:
ReadyMemoComponents=Components seleccionats:
ReadyMemoGroup=Carpeta del Men� Inici:
ReadyMemoTasks=Tasques addicionals:

; *** "Preparing to Install" wizard page
WizardPreparing=Preparant la instal�laci�
PreparingDesc=Preparant la instal�laci� de [name] al vostre ordinador.
PreviousInstallNotCompleted=La instal�laci� o desinstal�laci� anterior no s'ha dut a terme. Caldr� que reinicieu l'ordinador per a finalitzar aquesta instal�laci�.%n%nDespr�s de reiniciar l'ordinador, executeu aquest programa de nou per completar la instal�laci� de [name].
CannotContinue=La instal�laci� no pot continuar. Si us plau, premeu Cancel�lar per a sortir.

; *** "Installing" wizard page
WizardInstalling=Instal�lant
InstallingLabel=Si us plau, espereu mentre s'instal�la [name] al vostre ordinador.

; *** "Setup Completed" wizard page
FinishedHeadingLabel=Completant l'assistent d'instal�laci� de [name]
FinishedLabelNoIcons=El programa ha finalitzat la instal�laci� de [name] al vostre ordinador.
FinishedLabel=El programa ha finalitzat la instal�laci� de [name] al vostre ordinador. L'aplicaci� pot ser iniciada seleccionant les icones instal�lades.
ClickFinish=Premeu Finalitzar per a sortir de la instal�laci�.
FinishedRestartLabel=Per a completar la instal�laci� de [name] cal reiniciar l'ordinador. Voleu fer-ho ara?
FinishedRestartMessage=Per a completar la instal�laci� de [name] cal reiniciar l'ordinador. Voleu fer-ho ara?
ShowReadmeCheck=S�, vull visualitzar el fitxer LLEGIUME.TXT
YesRadio=&S�, reiniciar l'ordinador ara
NoRadio=&No, reiniciar� l'ordinador m�s tard
; used for example as 'Run MyProg.exe'
RunEntryExec=Executar %1
; used for example as 'View Readme.txt'
RunEntryShellExec=Visualitzar %1

; *** "Setup Needs the Next Disk" stuff
ChangeDiskTitle=El programa d'instal�laci� necessita el disc seg�ent
SelectDiskLabel2=Si us plau, introduiu el disc %1 i premeu Continuar.%n%nSi els fitxers d'aquest disc es poden trobar en una carpeta diferent de la indicada tot seguit, entreu-ne la ruta correcta o b� premeu Explorar.
PathLabel=&Ruta:
FileNotInDir2=El fitxer "%1" no s'ha pogut trobar a "%2". Si us plau, introdu�u el disc correcte o trieu una altra carpeta.
SelectDirectoryLabel=Si us plau, indiqueu on es troba el disc seg�ent.
SelectStartMenuFolderLabel3=La instal.laci� crear� el grup de programes al men� inici.
SelectStartMenuFolderBrowseLabel=Per continuar faci clic a seg�ent, pot seleccionar una carpeta diferent.
SelectDirBrowseLabel=Per continuar, faci clic a seg�ent, pot seleccionar una carpeta diferent.
SelectDirLabel3=La instal.laci� copiar� [name] a la carpeta.

; *** Installation phase messages
SetupAborted=La instal�laci� no s'ha completat.%n%n%Si us plau, resoleu el problema i executeu de nou el programa d'instal�laci�.
EntryAbortRetryIgnore=Premeu Reintentar per a intentar-ho de nou, Ignorar per a continuar igualment, o Cancel�lar per a abandonar la instal�laci�.

; *** Installation status messages
StatusCreateDirs=Creant carpetes...
StatusExtractFiles=Extraient fitxers...
StatusCreateIcons=Creant enlla�os del programa...
StatusCreateIniEntries=Creant entrades al fitxer INI...
StatusCreateRegistryEntries=Creant entrades de registre...
StatusRegisterFiles=Registrant fitxers...
StatusSavingUninstall=Desant informaci� de desinstal�laci�...
StatusRunProgram=Finalitzant la instal�laci�...
StatusRollback=Desfent els canvis...

; *** Misc. errors
ErrorInternal2=Error intern: %1
ErrorFunctionFailedNoCode=%1 ha fallat
ErrorFunctionFailed=%1 ha fallat; codi %2
ErrorFunctionFailedWithMessage=%1 ha fallat; codi %2.%n%3
ErrorExecutingProgram=No es pot executar el fitxer:%n%1

; *** Registry errors
ErrorRegOpenKey=Error en obrir la clau de registre:%n%1\%2
ErrorRegCreateKey=Error en crear la clau de registre:%n%1\%2
ErrorRegWriteKey=Error en escriure a la clau de registre:%n%1\%2

; *** INI errors
ErrorIniEntry=Error en crear l'entrada INI al fitxer "%1".

; *** File copying errors
FileAbortRetryIgnore=Premeu Reintentar per a intentar-ho de nou, Ignorar per a saltar-se aquest fitxer (no recomanat), o Cancel�lar per a abandonar la instal�laci�.
FileAbortRetryIgnore2=Premeu Reintentar per a intentar-ho de nou, Ignorar per a continuar igualment (no recomanat), o Cancel�lar per a abandonar la instal�laci�.
SourceIsCorrupted=El fitxer d'origen est� corromput
SourceDoesntExist=El fitxer d'origen "%1" no existeix
ExistingFileReadOnly=El fitxer �s de nom�s lectura.%n%nPremeu Reintentar per a treure-li l'atribut de nom�s lectura i tornar-ho a intentar, Ometre per a saltar-se'l (no recomanat), o Anul�lar per a abandonar la instal�laci�.
ErrorReadingExistingDest=S'ha produ�t un error en llegir el fitxer:
FileExists=El fitxer ja existeix.%n%nVoleu que sigui sobre-escrit?
ExistingFileNewer=El fitxer existent �s m�s nou que el que s'intenta instal�lar. Es recomana mantenir el fitxer existent.%n%nVoleu mantenir-lo?
ErrorChangingAttr=Hi ha hagut un error en canviar els atributs del fitxer:
ErrorCreatingTemp=Hi ha hagut un error en crear un fitxer a la carpeta de destinaci�:
ErrorReadingSource=Hi ha hagut un error en llegir el fitxer d'origen:
ErrorCopying=Hi ha hagut un error en copiar un fitxer:
ErrorReplacingExistingFile=Hi ha hagut un error en reempla�ar el fitxer existent:
ErrorRestartReplace=Ha fallar reempla�ar:
ErrorRenamingTemp=Hi ha hagut un error en reanomenar un fitxer a la carpeta de destinaci�:
ErrorRegisterServer=No s'ha pogut registrar el DLL/OCX: %1
ErrorRegisterServerMissingExport=No s'ha trobat l'exportador DllRegisterServer
ErrorRegisterTypeLib=No s'ha pogut registrar la biblioteca de tipus: %1

; *** Post-installation errors
ErrorOpeningReadme=Hi ha hagut un error en obrir el fitxer LLEGIUME.TXT.
ErrorRestartingComputer=El programa d'instal�laci� no ha pogut reiniciar l'ordinador. Si us plau, feu-ho manualment.

; *** Uninstaller messages
UninstallNotFound=El fitxer "%1" no existeix. No es pot desinstal�lar.
UninstallOpenError=El fitxer "%1" no pot ser obert. No es pot desinstal�lar.
UninstallUnsupportedVer=El fitxer de desinstal�laci� "%1" est� en un format no reconegut per aquesta versi� del desinstal�lador. No es pot desinstal�lar
UninstallUnknownEntry=S'ha trobat una entrada desconeguda (%1) al fitxer de desinstal�laci�.
ConfirmUninstall=Esteu segur de voler eliminar completament %1 i tots els seus components?
OnlyAdminCanUninstall=Aquest programa nom�s pot ser desinstal�lat per un usuari amb privilegis d'administrador.
UninstallStatusLabel=Si us plau, espereu mentre s'elimina %1 del vostre ordinador.
UninstalledAll=%1 ha estat desinstal�lat correctament del vostre ordinador.
UninstalledMost=Desinstal�laci� de %1 completada.%n%nAlguns elements no s'han pogut eliminar. Poden ser eliminats manualment.
UninstalledAndNeedsRestart=Per completar la instal�laci� de %1, cal reiniciar el vostre ordinador.%n%nVoleu fer-ho ara?
UninstallDataCorrupted=El fitxer "%1" est� corromput. No es pot desinstal�lar.

; *** Uninstallation phase messages
ConfirmDeleteSharedFileTitle=Eliminar fitxer compartit?
ConfirmDeleteSharedFile2=El sistema indica que el fitxer compartit seg�ent ja no �s emprat per cap altre programa. Voleu que la desinstal�laci� elimini aquest fitxer?%n%nSi algun programa encara el fa servir i �s eliminat, podria no funcionar correctament. Si no n'esteu segur, trieu No. Deixar el fitxer al sistema no far� cap mal.
SharedFileNameLabel=Nom del fitxer:
SharedFileLocationLabel=Localitzaci�:
WizardUninstalling=Estat de la desinstal�laci�
StatusUninstalling=Desinstal�lant %1...

[CustomMessages]

AdditionalIcons=Icones adicionals:
CreateDesktopIcon=Crear una icona a l'escriptori
CreateQuickLaunchIcon=Crear una icona a la barra del men� inici
ProgramOnTheWeb=%1 a la web
UninstallProgram=Desinstal.lar %1
LaunchProgram=Executar %1
AssocFileExtension=&Associar %1 amb l'extensi� %2
AssocingFileExtension=Associar %1 amb l'extensi� %2...

ReportManagerDesigner=Disenyador Report Manager
DBExpressdatabasedrivers=Controladors DBExpress (Borland DBExpress)
BorlandDatabaseEnginedatabasedrivers=Controladors BDE (Borland Database Engine)
Commandlinetools=Utilitats de l�nia de comandes
Documentation=Documentaci�
TCPserver=Servidor d'informes de xarxa
TCPclientandmetafileviewer=Client de xarxa i visor de metaarxius
Webserver=Servidor web d'informes
ActiveXcomponent=Component ActiveX per programadors
InternetExplorerplugin=Plugin per a Internet Explorer

LaunchReportManagerDesignerXP=Executar disenyador d'informes
DesignerXP=Disenyador d'informes
MetafileViewerandReportClientXP=Client d'informes i visor de metaarxius
TranslationUtility=Utilitat de traducci�
ServerapplicationXP=Servidor d'informes de xarxa
ServerconfigurationXP=Utilitat de configuraci� del servidor de xarxa
RegisterActiveX=Instal.lar ActiveX al registro
UnRegisterActiveX=Eliminar ActiveX del registre
RegisterPlugin=Registrar Plugin
UnRegisterPlugin=Eliminar Plugin del registre
ReportManagerDesignerXP=Disenyador Report Manager
ReportManagerClient=Client Report Manager
ReportSamples=Exemples d'informes

Fullinstallation=Instal.laci� completa
Custominstallation=Instal.laci� personalitzada
ServiceInstallationtool=Utilitat d'instal.laci� de servei
SLicense=LLic�ncia
