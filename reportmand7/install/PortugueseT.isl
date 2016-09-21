; *** Inno Setup version 4.1.8+ Portuguese (Standard) messages ***
; Author: RAC2004, Based on: NARS
; Last update: 26 Fev 2004
;
; To download user-contributed translations of this file, go to:
;   http://www.jrsoftware.org/is3rdparty.php
;
; Note: When translating this text, do not add periods (.) to the end of
; messages that didn't have them already, because on those messages Inno
; Setup adds the periods automatically (appending a period would result in
; two periods being displayed).

[LangOptions]
LanguageName=Portuguese (Standard)
LanguageID=$0816
; If the language you are translating to requires special font faces or
; sizes, uncomment any of the following entries and change them accordingly.
;DialogFontName=MS Shell Dlg
;DialogFontSize=8
;WelcomeFontName=Verdana
;WelcomeFontSize=12
;TitleFontName=Arial
;TitleFontSize=29
;CopyrightFontName=Arial
;CopyrightFontSize=8

[Messages]

; *** Application titles
SetupAppTitle=Instala��o
SetupWindowTitle=%1 - Instala��o
UninstallAppTitle=Desinstala��o
UninstallAppFullTitle=%1 - Desinstala��o

; *** Misc. common
InformationTitle=Informa��o
ConfirmTitle=Confirma��o
ErrorTitle=Erro

; *** SetupLdr messages
SetupLdrStartupMessage=Ir� ser instalado o %1. Deseja continuar?
LdrCannotCreateTemp=N�o foi poss�vel criar um ficheiro tempor�rio. Instala��o cancelada
LdrCannotExecTemp=N�o foi poss�vel executar um ficheiro na directoria tempor�ria. Instala��o cancelada

; *** Startup error messages
LastErrorMessage=%1.%n%nErro %2: %3
SetupFileMissing=O ficheiro %1 n�o foi encontrado na pasta de instala��o. Corrija o problema ou obtenha uma nova c�pia do programa.
SetupFileCorrupt=Os ficheiros de instala��o est�o corrompidos. Obtenha uma nova c�pia do programa.
SetupFileCorruptOrWrongVer=Os ficheiros de instala��o est�o corrompidos, ou s�o incompat�veis com esta vers�o do Assistente de Instala��o. Corrija o problema ou obtenha uma nova c�pia do programa.
NotOnThisPlatform=Este programa n�o pode ser executado no %1.
OnlyOnThisPlatform=Este programa deve ser executado no %1.
WinVersionTooLowError=Este programa necessita do %1 vers�o %2 ou mais recente.
WinVersionTooHighError=Este programa n�o pode ser instalado no %1 vers�o %2 ou mais recente.
AdminPrivilegesRequired=Deve iniciar sess�o como administrador para instalar este programa.
PowerUserPrivilegesRequired=Deve iniciar sess�o como administrador ou membro do grupo de Super Utilizadores para instalar este programa.
SetupAppRunningError=O Assistente de Instala��o detectou que o %1 est� em execu��o. Feche-o e de seguida clique em OK para continuar, ou clique em Cancelar para cancelar a instala��o.
UninstallAppRunningError=O Assistente de Desinstala��o detectou que o %1 est� em execu��o. Feche-o e de seguida clique em OK para continuar, ou clique em Cancelar para cancelar a desinstala��o.

; *** Misc. errors
ErrorCreatingDir=O Assistente de Instala��o n�o consegue criar a directoria "%1"
ErrorTooManyFilesInDir=N�o � poss�vel criar um ficheiro na directoria "%1" porque esta cont�m demasiados ficheiros

; *** Setup common messages
ExitSetupTitle=Terminar a instala��o
ExitSetupMessage=A instala��o n�o est� completa. Se terminar agora, o programa n�o ser� instalado.%n%nMais tarde poder� executar novamente este Assistente de Instala��o e concluir a instala��o.%n%nDeseja terminar a instala��o?
AboutSetupMenuItem=&Acerca de...
AboutSetupTitle=Acerca do Assistente de Instala��o
AboutSetupMessage=%1 vers�o %2%n%3%n%n%1 home page:%n%4
AboutSetupNote=Traduzido por RAC2004 (baseado em NARS)

; *** Buttons
ButtonBack=< &Anterior
ButtonNext=&Seguinte >
ButtonInstall=&Instalar
ButtonOK=OK
ButtonCancel=Cancelar
ButtonYes=&Sim
ButtonYesToAll=Sim para &todos
ButtonNo=&N�o
ButtonNoToAll=N�&o para todos
ButtonFinish=&Concluir
ButtonBrowse=&Procurar...
ButtonWizardBrowse=&Procurar...
ButtonNewFolder=&Criar Pasta

; *** "Select Language" dialog messages
SelectLanguageTitle=Seleccione o Idioma do Assistente de Instala��o
SelectLanguageLabel=Seleccione o idioma para usar durante a Instala��o:

; *** Common wizard text
ClickNext=Clique em Seguinte para continuar ou em Cancelar para cancelar a instala��o.
BeveledLabel=
BrowseDialogTitle=Procurar uma Pasta
BrowseDialogLabel=Seleccione uma Pasta na lista e depois clique em OK.
NewFolderName=Nova Pasta

; *** "Welcome" wizard page
WelcomeLabel1=Bem-vindo ao Assistente de Instala��o do [name]
WelcomeLabel2=O Assistente de Instala��o ir� instalar o [name/ver] no seu computador.%n%n� recomendado que feche todas as outras aplica��es antes de continuar.

; *** "Password" wizard page
WizardPassword=Password
PasswordLabel1=Esta instala��o est� protegida por uma password.
PasswordLabel3=Insira a password e de seguida clique em Seguinte para continuar. Nas passwords existe diferen�a entre mai�sculas e min�sculas.
PasswordEditLabel=&Password:
IncorrectPassword=A password que introduziu n�o est� correcta. Tente novamente.

; *** "License Agreement" wizard page
WizardLicense=Contrato de licen�a
LicenseLabel=� importante que leia as seguintes informa��es antes de continuar.
LicenseLabel3=Leia atentamente o seguinte contrato de licen�a. Deve aceitar os termos do contrato antes de continuar a instala��o.
LicenseAccepted=A&ceito o contrato
LicenseNotAccepted=&N�o aceito o contrato

; *** "Information" wizard pages
WizardInfoBefore=Informa��o
InfoBeforeLabel=� importante que leia as seguintes informa��es antes de continuar.
InfoBeforeClickLabel=Quando estiver pronto para continuar clique em Seguinte.
WizardInfoAfter=Informa��o
InfoAfterLabel=� importante que leia as seguintes informa��es antes de continuar.
InfoAfterClickLabel=Quando estiver pronto para continuar clique em Seguinte.

; *** "User Information" wizard page
WizardUserInfo=Informa��es do utilizador
UserInfoDesc=Introduza as suas informa��es.
UserInfoName=Nome do &utilizador:
UserInfoOrg=&Organiza��o:
UserInfoSerial=N�mero de &s�rie:
UserInfoNameRequired=Deve introduzir um nome.

; *** "Select Destination Directory" wizard page
WizardSelectDir=Escolha a directoria de destino
SelectDirDesc=Onde dever� ser instalado o [name]?
SelectDirLabel3=O [name] ser� instalado na seguinte pasta.
SelectDirBrowseLabel=Para continuar, clique em Seguinte. Se desejar escolher uma pasta diferente, clique em Procurar.
DiskSpaceMBLabel=Este programa necessita de pelo menos [mb] MB de espa�o em disco.
ToUNCPathname=O Assistente de Instala��o n�o pode instalar num caminho do tipo UNC. Se est� a tentar fazer a instala��o numa rede, precisa de mapear a unidade de rede.
InvalidPath=� necess�rio indicar o caminho completo com a letra de unidade; por exemplo:%n%nC:\APP%n%nou um caminho UNC no formato:%n%n\\servidor\partilha
InvalidDrive=A unidade ou partilha UNC seleccionada n�o existe ou n�o est� acess�vel. Seleccione outra.
DiskSpaceWarningTitle=N�o h� espa�o suficiente no disco
DiskSpaceWarning=O Assistente de Instala��o necessita de pelo menos %1 KB de espa�o livre, mas a unidade seleccionada tem apenas %2 KB dispon�veis.%n%nDeseja continuar de qualquer forma?
DirNameTooLong=O nome da pasta ou o caminho indicado � demasiado longo.
InvalidDirName=O nome da pasta indicado n�o � v�lido.
BadDirName32=O nome da directoria n�o pode conter nenhum dos seguintes caracteres:%n%n%1
DirExistsTitle=A directoria j� existe
DirExists=A directoria:%n%n%1%n%nj� existe. Pretende instalar nesta directoria?
DirDoesntExistTitle=A directoria n�o existe
DirDoesntExist=A directoria:%n%n%1%n%nn�o existe. Pretende que esta directoria seja criada?

; *** "Select Components" wizard page
WizardSelectComponents=Escolha os componentes
SelectComponentsDesc=Que componentes devem ser instalados?
SelectComponentsLabel2=Seleccione os componentes que quer instalar e desseleccione os componentes que n�o quer instalar. Clique em Seguinte quando estiver pronto para continuar.
FullInstallation=Instala��o Completa
; if possible don't translate 'Compact' as 'Minimal' (I mean 'Minimal' in your language)
CompactInstallation=Instala��o Compacta
CustomInstallation=Instala��o Personalizada
NoUninstallWarningTitle=Componentes Encontrados
NoUninstallWarning=O Assistente de Instala��o detectou que os seguintes componentes est�o instalados no seu computador:%n%n%1%n%nSe desseleccionar estes componentes eles n�o ser�o desinstalados.%n%nDeseja continuar?
ComponentSize1=%1 KB
ComponentSize2=%1 MB
ComponentsDiskSpaceMBLabel=A selec��o actual necessita de pelo menos [mb] MB de espa�o em disco.

; *** "Select Additional Tasks" wizard page
WizardSelectTasks=Seleccione tarefas adicionais
SelectTasksDesc=Que tarefas adicionais devem ser executadas?
SelectTasksLabel2=Seleccione as tarefas adicionais que deseja que o Assistente de Instala��o execute na instala��o do [name] e depois clique em Seguinte.

; *** "Select Start Menu Folder" wizard page
WizardSelectProgramGroup=Escolha a pasta do Menu Iniciar
SelectStartMenuFolderDesc=Onde devem ser colocados os �cones de atalho do programa?
SelectStartMenuFolderLabel3=Os atalhos do programa ser�o criados na seguinte pasta do Menu Iniciar.
SelectStartMenuFolderBrowseLabel=Para continuar, clique em Seguinte. Se desejar escolher uma pasta diferente, clique em Procurar.
NoIconsCheck=&N�o criar �cones
MustEnterGroupName=� necess�rio introduzir um nome para a pasta.
GroupNameTooLong=O nome da pasta ou o caminho indicado � demasiado longo.
InvalidGroupName=O nome da pasta indicado n�o � v�lido.
BadGroupName=O nome da pasta n�o pode conter nenhum dos seguintes caracteres:%n%n%1
NoProgramGroupCheck2=&N�o criar nenhuma pasta no Menu Iniciar

; *** "Ready to Install" wizard page
WizardReady=Pronto para Instalar
ReadyLabel1=O Assistente de Instala��o est� pronto para instalar o [name] no seu computador.
ReadyLabel2a=Clique em Instalar para continuar a instala��o, ou clique em Anterior se desejar rever ou alterar alguma das configura��es.
ReadyLabel2b=Clique em Instalar para continuar a instala��o.
ReadyMemoUserInfo=Informa��es do utilizador:
ReadyMemoDir=Directoria de destino:
ReadyMemoType=Tipo de instala��o:
ReadyMemoComponents=Componentes seleccionados:
ReadyMemoGroup=Pasta do Menu Iniciar:
ReadyMemoTasks=Tarefas adicionais:

; *** "Preparing to Install" wizard page
WizardPreparing=Preparando-se para instalar
PreparingDesc=Preparando-se para instalar o [name] no seu computador.
PreviousInstallNotCompleted=A instala��o/remo��o de um programa anterior n�o foi completada. Necessitar� de reiniciar o computador para completar essa instala��o.%n%nDepois de reiniciar o computador, execute novamente este Assistente de Instala��o para completar a instala��o do [name].
CannotContinue=A Instala��o n�o pode continuar. Clique em Cancelar para sair.

; *** "Installing" wizard page
WizardInstalling=A instalar
InstallingLabel=Aguarde enquanto o Assistente de Instala��o instala o [name] no seu computador.

; *** "Setup Completed" wizard page
FinishedHeadingLabel=Terminando a instala��o do [name]
FinishedLabelNoIcons=O Assistente de Instala��o concluiu a instala��o do [name] no seu computador.
FinishedLabel=O Assistente de Instala��o concluiu a instala��o do [name] no seu computador. A aplica��o pode ser iniciada atrav�s dos �cones instalados.
ClickFinish=Clique em Concluir para finalizar o Assistente de Instala��o.
FinishedRestartLabel=Para completar a instala��o do [name], o Assistente de Instala��o dever� reiniciar o seu computador. Deseja reiniciar agora?
FinishedRestartMessage=Para completar a instala��o do [name], o Assistente de Instala��o dever� reiniciar o seu computador.%n%nDeseja reiniciar agora?
ShowReadmeCheck=Sim, desejo ver o ficheiro LEIAME
YesRadio=&Sim, desejo reiniciar o computador agora
NoRadio=&N�o, desejo reiniciar o computador mais tarde
; used for example as 'Run MyProg.exe'
RunEntryExec=Executar %1
; used for example as 'View Readme.txt'
RunEntryShellExec=Visualizar %1

; *** "Setup Needs the Next Disk" stuff
ChangeDiskTitle=O Assistente de Instala��o precisa do disco seguinte
SelectDiskLabel2=Introduza o disco %1 e clique em OK.%n%nSe os ficheiros deste disco estiverem num local diferente do mostrado abaixo, indique o caminho correcto ou clique em Procurar.
PathLabel=&Caminho:
FileNotInDir2=O ficheiro "%1" n�o foi encontrado em "%2". Introduza o disco correcto ou escolha outra pasta.
SelectDirectoryLabel=Indique a localiza��o do disco seguinte.

; *** Installation phase messages
SetupAborted=A instala��o n�o est� completa.%n%nCorrija o problema e execute o Assistente de Instala��o novamente.
EntryAbortRetryIgnore=Clique em Repetir para tentar novamente, Ignorar para continuar de qualquer forma, ou Abortar para cancelar a instala��o.

; *** Installation status messages
StatusCreateDirs=A criar directorias...
StatusExtractFiles=A extrair ficheiros...
StatusCreateIcons=A criar atalhos...
StatusCreateIniEntries=A criar entradas em INI...
StatusCreateRegistryEntries=A criar entradas no registo...
StatusRegisterFiles=A registar ficheiros...
StatusSavingUninstall=A guardar informa��es para desinstala��o...
StatusRunProgram=A concluir a instala��o...
StatusRollback=A anular as altera��es...

; *** Misc. errors
ErrorInternal2=Erro interno: %1
ErrorFunctionFailedNoCode=%1 falhou
ErrorFunctionFailed=%1 falhou; c�digo %2
ErrorFunctionFailedWithMessage=%1 falhou; c�digo %2.%n%3
ErrorExecutingProgram=N�o � poss�vel executar o ficheiro:%n%1

; *** Registry errors
ErrorRegOpenKey=Erro ao abrir a chave de registo:%n%1\%2
ErrorRegCreateKey=Erro ao criar a chave de registo:%n%1\%2
ErrorRegWriteKey=Erro ao escrever na chave de registo:%n%1\%2

; *** INI errors
ErrorIniEntry=Erro ao criar entradas em INI no ficheiro "%1".

; *** File copying errors
FileAbortRetryIgnore=Clique em Repetir para tentar novamente, Ignorar para ignorar este ficheiro (n�o recomendado), ou Abortar para cancelar a instala��o.
FileAbortRetryIgnore2=Clique em Repetir para tentar novamente, Ignorar para continuar de qualquer forma (n�o recomendado), ou Abortar para cancelar a instala��o.
SourceIsCorrupted=O ficheiro de origem est� corrompido
SourceDoesntExist=O ficheiro de origem "%1" n�o existe
ExistingFileReadOnly=O ficheiro existente tem o atributo "s� de leitura".%n%nClique em Repetir para remover o atributo "s� de leitura" e tentar novamente, Ignorar para ignorar este ficheiro, ou Abortar para cancelar a instala��o.
ErrorReadingExistingDest=Ocorreu um erro ao tentar ler o ficheiro existente:
FileExists=O ficheiro j� existe.%n%nDeseja substitu�-lo?
ExistingFileNewer=O ficheiro existente � mais recente que o que est� a ser instalado. � recomendado que mantenha o ficheiro existente.%n%nDeseja manter o ficheiro existente?
ErrorChangingAttr=Ocorreu um erro ao tentar alterar os atributos do ficheiro existente:
ErrorCreatingTemp=Ocorreu um erro ao tentar criar um ficheiro na directoria de destino:
ErrorReadingSource=Ocorreu um erro ao tentar ler o ficheiro de origem:
ErrorCopying=Ocorreu um erro ao tentar copiar um ficheiro:
ErrorReplacingExistingFile=Ocorreu um erro ao tentar substituir o ficheiro existente:
ErrorRestartReplace=O RestartReplace falhou:
ErrorRenamingTemp=Ocorreu um erro ao tentar mudar o nome de um ficheiro na directoria de destino:
ErrorRegisterServer=N�o � poss�vel registar o DLL/OCX: %1
ErrorRegisterServerMissingExport=DllRegisterServer export n�o encontrado
ErrorRegisterTypeLib=N�o foi poss�vel registar a type library: %1

; *** Post-installation errors
ErrorOpeningReadme=Ocorreu um erro ao tentar abrir o ficheiro LEIAME.
ErrorRestartingComputer=O Assistente de Instala��o n�o consegue reiniciar o computador. Por favor reinicie manualmente.

; *** Uninstaller messages
UninstallNotFound=O ficheiro "%1" n�o existe. N�o � poss�vel desinstalar.
UninstallOpenError=N�o foi poss�vel abrir o ficheiro "%1". N�o � poss�vel desinstalar.
UninstallUnsupportedVer=O ficheiro log de desinstala��o "%1" est� num formato que n�o � reconhecido por esta vers�o do desinstalador. N�o � poss�vel desinstalar
UninstallUnknownEntry=Foi encontrada uma entrada desconhecida (%1) no ficheiro log de desinstala��o
ConfirmUninstall=Tem a certeza que deseja remover completamente o %1 e todos os seus componentes?
OnlyAdminCanUninstall=Esta desinstala��o s� pode ser realizada por um utilizador com privil�gios administrativos.
UninstallStatusLabel=Por favor aguarde enquanto o %1 est� a ser removido do seu computador.
UninstalledAll=O %1 foi removido do seu computador com sucesso.
UninstalledMost=A desinstala��o do %1 est� conclu�da.%n%nAlguns elementos n�o puderam ser removidos. Estes elementos podem ser removidos manualmente.
UninstalledAndNeedsRestart=Para completar a desinstala��o do %1, o computador deve ser reiniciado.%n%nDeseja reiniciar agora?
UninstallDataCorrupted=O ficheiro "%1" est� corrompido. N�o � poss�vel desinstalar

; *** Uninstallation phase messages
ConfirmDeleteSharedFileTitle=Remover ficheiro partilhado?
ConfirmDeleteSharedFile2=O sistema indica que o seguinte ficheiro partilhado j� n�o est� a ser utilizado por nenhum programa. Deseja remov�-lo?%n%nSe algum programa ainda necessitar deste ficheiro, poder� n�o funcionar correctamente depois de o remover. Se n�o tiver a certeza, escolha N�o. Manter o ficheiro n�o causar� nenhum problema.
SharedFileNameLabel=Nome do ficheiro:
SharedFileLocationLabel=Localiza��o:
WizardUninstalling=Estado da desinstala��o
StatusUninstalling=A desinstalar o %1...



[CustomMessages]

AdditionalIcons=Additional icons:
CreateDesktopIcon=Create a &desktop icon
CreateQuickLaunchIcon=Create a &Quick Launch icon
ProgramOnTheWeb=%1 on the Web
UninstallProgram=Uninstall %1
LaunchProgram=Launch %1
AssocFileExtension=&Associate %1 with the %2 file extension
AssocingFileExtension=Associating %1 with the %2 file extension...

ReportManagerDesigner=Report Manager Designer
DBExpressdatabasedrivers=Borland DBExpress database drivers
BorlandDatabaseEnginedatabasedrivers=Borland Database Engine database drivers
Commandlinetools=Command line tools
Documentation=Documentation
TCPserver=Net Server
TCPclientandmetafileviewer=Net client and metafile viewer
Webserver=Web server
ActiveXcomponent=ActiveX component for developers
InternetExplorerplugin=Internet Explorer plugin

LaunchReportManagerDesignerXP=Launch Report Manager Designer
DesignerXP=Designer XP
MetafileViewerandReportClientXP=Metafile Viewer and Report Client
TranslationUtility=Translation Utility
ServerapplicationXP=Net Server application
ServerconfigurationXP=Net Server configuration utility
RegisterActiveX=Register ActiveX
UnRegisterActiveX=UnRegister ActiveX
RegisterPlugin=Register Plugin
UnRegisterPlugin=UnRegister Plugin
ReportManagerDesignerXP=Report Manager Designer
ReportManagerClient=Report Manager client
ReportSamples=Report Examples

Fullinstallation=Full Installation
Custominstallation=Custom installation
ServiceInstallationtool=Service Installation tool
SLicense=License
