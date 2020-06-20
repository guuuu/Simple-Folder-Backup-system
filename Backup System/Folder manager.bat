SET "params=%*"
rem cd /d "%~dp0" && ( IF exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  ECHO SET UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
@ECHO off
cls
SETLOCAL EnableExtensions
SETLOCAL EnableDelayedExpansion

::                      -------------Início do Progama-------------
::
::     ==================================IMPORTANTE=====================================
::     |                    ENVOLVER SEMPRE O DIRECTÓRIO COM ASPAS                     |
::     |           NÃO USAR DIRECTÓRIOS COM CARACTERES ESPECIAIS, EX: ACENTOS          |
::     |       NÃO USAR DIRECTÓRIOS COM CARACTERES ESPECIAIS, EX: C CEDILHADO Ç        |
::     |     NÃO USAR DIRECTÓRIOS COM CARACTERES ESPECIAIS NÃO ACEITES PELO WINDOWS    |
::     |  VER CARACTERES NÃO ACEITES PELO WINDOWS - https://pastebin.com/raw/NNEN70aD  |
::     |                 NÃO COLOCAR FICHEIROS A COPIAR, SEMPRE PASTAS!                |
::     ==================================IMPORTANTE=====================================

if not exist "%USERPROFILE%\AppData\Local\MVTI Systems\" (
	MKDIR "%USERPROFILE%\AppData\Local\MVTI Systems" & attrib +h "%USERPROFILE%\AppData\Local\MVTI Systems" /s /d
)

SET /a dir_count = 0
SET /a dir_count2 = 1

echo.&echo.&echo.
echo                    ==================================IMPORTANTE=====================================
echo                    I                                                                               I
echo                    I           NAO USAR DIRECTORIOS COM CARACTERES ESPECIAIS, EX: ACENTOS          I
echo                    I       NAO USAR DIRECTORIOS COM CARACTERES ESPECIAIS, EX: C CEDILHADO          I
echo                    I     NAO USAR DIRECTORIOS COM CARACTERES ESPECIAIS NAO ACEITES PELO WINDOWS    I
echo                    I  VER CARACTERES NAO ACEITES PELO WINDOWS - https://pastebin.com/raw/NNEN70aD  I
echo                    I                 NAO COLOCAR FICHEIROS A COPIAR, SEMPRE PASTAS!                 I
echo                    I                                                                               I
echo                    ==================================IMPORTANTE=====================================
echo.&echo.&echo.

:QuantidadeDirectorios
	echo Este script serve para selecionar as pastas que vao ser alvo de backups&echo.
	set /p ask_um="Quantas pastas pretende copiar (max. 5): "&echo.
	echo %ask_um%| findstr /r "^[1-9][0-9]*$">nul
	if %errorlevel% equ 0 (
		if %ask_um% GTR 0 (
			if %ask_um% GTR 5 (
				GOTO :QuantidadeDirectorios
			) else (
				set quant_dir=%ask_um%
				GOTO :DirectorioPrompt
			)
		) else (
			GOTO :QuantidadeDirectorios
		)
	) else (
		GOTO :QuantidadeDirectorios
	)
::

:DirectorioPrompt
	if %dir_count% LSS %quant_dir% (
		set /p dir_ans="Directorio !dir_count2!: "
		REM Remover a barra do fim do directório se existir
		if [!dir_ans:~-1!] EQU [\] (
			set dir_ans=!dir_ans:~0,-1!
		) else (
			if [!dir_ans:~-1!] EQU [/] (
				set dir_ans=!dir_ans:~0,-1!
			)
		)
		if exist "!dir_ans!" (
			REM Ainda não foram adicionados directorios portanto adicionar pelo menos 1
			if !dir_count! EQU 0 (
				set /a dir_count += 1
				set /a dir_count2 += 1
				set arr_dir[!dir_count!]=!dir_ans!
				GOTO :DirectorioPrompt
			) else (
				REM Verificar se os introduzidos depois do primeiro são iguais a algum já na lista
				for /l %%x in (1, 1, !dir_count!) do (
					if /I !dir_ans! EQU !arr_dir[%%x]! (
						set /a bool5 = 1
					)
				)
			)
			REM O directório introduzido é igual a algum outro portanto perguntar novamente.
			if !bool5! EQU 1 (
				echo.&echo O directorio introduzido ja foi registado, tente outro por favor&echo.
				set /a bool5 = 0
				GOTO :DirectorioPrompt
			) else (
				set /a dir_count += 1
				set /a dir_count2 += 1
				set arr_dir[!dir_count!]=!dir_ans!
				set /a bool5 = 0
				GOTO :DirectorioPrompt
			)
		) else (
			echo.&echo O directorio nao existe, tente outro por favor&echo.
			set /a bool5 = 0
			GOTO :DirectorioPrompt
		)
	) else (
		GOTO :TerminarDirectorios
	)
::

:TerminarDirectorios
	if exist "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Pastas.txt" attrib -r -h "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Pastas.txt"
	break > "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Pastas.txt"
	for /l %%x in (1, 1, !dir_count!) do (
		echo !arr_dir[%%x]!>> "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Pastas.txt"
	)
	attrib "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Pastas.txt" +h +r
	echo. & echo Ficheiros criados com sucesso.
	%SystemRoot%\explorer.exe "%USERPROFILE%\AppData\Local\MVTI Systems"
	endlocal
	echo.&echo Prima qualquer tecla para fechar o programa
	pause>NUL
	exit
::
