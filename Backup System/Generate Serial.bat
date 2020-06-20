SET "params=%*"
rem cd /d "%~dp0" && ( IF exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  ECHO SET UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
@ECHO off
cls
SETLOCAL enabledelayedexpansion

SET /a count = 1
SET /a drive_count = 0
SET /a chosen_count = 1
SET /a chosen_count2 = 0
SET /a bool1 = 0
SET /a bool2 = 0
SET /a bool3 = 0
SET /a bool4 = 0
SET /a bool5 = 0
SET /a num_perguntado = 0
SET /a dir_count = 0
SET /a dir_count2 = 1

:QuantidadePens
	IF !bool1! EQU 0 (
		GOTO MostrarLista
	) ELSE (
		SET /p pen_quant="Quantidade de pens: " &ECHO.
		GOTO VerificarQuantidade
	)
::

:MostrarLista
	ECHO Escolha, da lista de drives seguintes, qual o serial da(s) pen(s) dos backups. & ECHO.
	FOR %%i in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		@IF exist %%i: (
			FOR /F "skip=1 tokens=5" %%a in ('vol %%i:') do (
				IF %%a equ ABCD-EF01 do (
					SET vector[!count!]=%%a
					SET vector_available_ids[!count!]=!count!
					FOR /F "tokens=6" %%x in ('vol %%i:') do (
						IF "%%x" == "no" (
							ECHO !count!. Drive [%%i:] Label: SEM NOME - Serial: %%a & ECHO.
						) ELSE (
							ECHO !count!. Drive [%%i:] Label: %%x - Serial: %%a & ECHO.
						)
					)
					SET /a count += 1
					SET /a drive_count += 1
				)
			)
		)
	)
	SET /a bool1 = 1
	SET /p pen_quant="Quantidade de pens: " &ECHO.
	GOTO VerificarQuantidade
::

:VerificarQuantidade
	IF %pen_quant% GTR %drive_count% (
		ECHO A quantidade escolhida nao e valida! & echo.
		GOTO QuantidadePens
	)
	IF %pen_quant% LEQ %drive_count% (
		IF %pen_quant% LEQ 0 (
			ECHO A quantidade escolhida nao e valida! & echo.
			GOTO QuantidadePens
		) ELSE (
			GOTO Manager
		)
	)
::

:Manager
	IF %num_perguntado% LSS %pen_quant% (
		IF !bool3! EQU 0 (
			SET /a num_perguntado += 1
		)
		SET /p nmr="Numero da drive !num_perguntado!: " & echo.
		GOTO VerificiarDrives
	) ELSE (
		IF !bool3! EQU 1 (
			SET /p nmr="Numero da drive !num_perguntado!: " & echo.
			GOTO VerificiarDrives
		)
		echo Determinacao de drives concluida!
		GOTO Fim
		PAUSE
	)
::

:VerificiarDrives
	IF !nmr! LEQ 0 (
		echo O numero escolhido e invalido! & echo.
		SET /a bool3 = 1
		GOTO Manager
	) ELSE (
		IF !bool2! EQU 0 (
			for /l %%x in (1, 1, %drive_count%) do (
				if !nmr! EQU !vector_available_ids[%%x]! (
					SET vector_drives_chosen[!chosen_count!]=!nmr!
					SET vector_available_ids[%%x]=-1
					SET /a chosen_count += 1
					SET /a chosen_count2 += 1
					SET /a bool2 = 1
					SET /a bool3 = 0
					GOTO Manager
				) else (
					IF %%x EQU %drive_count% (
						echo O numero escolhido e invalido! & echo.
						SET /a bool3 = 1
						GOTO Manager
					)
				)
			)
		) ELSE (
			for /l %%k in (1, 1, %chosen_count2%) do (
				if !nmr! EQU !vector_drives_chosen[%%k]! (
					echo Numero ja foi escolhido, tente outro! & echo.
					SET /a bool3 = 1
					GOTO Manager
				)
			)
			for /l %%x in (1, 1, %drive_count%) do (
				if !nmr! EQU !vector_available_ids[%%x]! (
					SET vector_drives_chosen[!chosen_count!]=!nmr!
					SET vector_available_ids[%%x]=-1
					SET /a chosen_count += 1
					SET /a chosen_count2 += 1
					SET /a bool2 = 1
					SET /a bool3 = 0
					GOTO Manager
				) else (
					IF %%x EQU %drive_count% (
						echo O numero escolhido e invalido! & echo.
						SET /a bool3 = 1
						GOTO Manager
					)
				)
			)
		)
	)
::

:Fim
	if exist "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info.txt" attrib -r -h "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info.txt"
	if not exist "%USERPROFILE%\AppData\Local\MVTI Systems" ( MKDIR "%USERPROFILE%\AppData\Local\MVTI Systems" & attrib +h "%USERPROFILE%\AppData\Local\MVTI Systems" /s /d)
	break > "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info.txt"
	if not exist "%USERPROFILE%\AppData\Local\MVTI Systems\logs" ( MKDIR "%USERPROFILE%\AppData\Local\MVTI Systems\logs")
	for /l %%x in (1, 1, %drive_count%) do (
		for /l %%w in (1, 1, %chosen_count2%) do (
			if !vector_drives_chosen[%%w]! EQU %%x (
				echo !vector[%%x]!>> "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info.txt"
			)
		)
	)
	attrib "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info.txt" +h +r
	echo. & echo Ficheiro criado com sucesso. & echo.
	GOTO :PromptDirectorios
::

:PromptDirectorios
	set /p continuar="Efetuar copias tambem para directorios, por ex: OneDrive (S = sim, N = nao): "
	if /I "%continuar%" EQU "S" cls & GOTO :QuantidadeDirectorios
	if /I "%continuar%" EQU "s" cls & GOTO :QuantidadeDirectorios
	if /I "%continuar%" EQU "N" (
		%SystemRoot%\explorer.exe "%USERPROFILE%\AppData\Local\MVTI Systems"
		endlocal
		echo.&echo Prima qualquer tecla para fechar o programa
		pause>NUL
		exit
	)
	if /I "%continuar%" EQU "n" (
		%SystemRoot%\explorer.exe "%USERPROFILE%\AppData\Local\MVTI Systems"
		endlocal
		echo.&echo Prima qualquer tecla para fechar o programa
		pause>NUL
		exit
	) else (
		REM Se não for nenhuma das opções, perguntar outra vez
		GOTO :PromptDirectorios
	)
::

:QuantidadeDirectorios
	cls
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
	echo Este script serve para selecionar os directorios que vao ficar com os backups (por ex: OneDrive)&echo.
	set /p ask_um="Quantos directorios pretende guardar (max. 5): "&echo.
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
	if exist "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Directorios.txt" attrib -r -h "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Directorios.txt"
	break > "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Directorios.txt"
	for /l %%x in (1, 1, !dir_count!) do (
		echo !arr_dir[%%x]!>> "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Directorios.txt"
	)
	attrib "%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Directorios.txt" +h +r
	echo. & echo Ficheiros criados com sucesso.
	%SystemRoot%\explorer.exe "%USERPROFILE%\AppData\Local\MVTI Systems"
	endlocal
	echo.&echo Prima qualquer tecla para fechar o programa
	pause>NUL
	exit
::
