REM Forçar a execução com administrador
REM set "params=%*"
REM cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC=CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
cls
@echo off
SETLOCAL EnableExtensions
SETLOCAL EnableDelayedExpansion

set data=%date%_%time%
set data=%data:/=-%
set data=%data::=-%
set data=%data:,=-%
REM 0 = Falso (nao existe ficheiro) | 1 = True (Existe ficheiro)
set /a copiar_para_dir_um=0
set /a copiar_para_dir_dois=0
set /a abc=0
Set alw=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
set log_file="%USERPROFILE%\AppData\Local\MVTI Systems\logs\log_%data%.txt"

call :Atencao

:Inicio

%alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%. & %alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%                                                     %alw:~40,1%%alw:~33,1%%alw:~14,1%%alw:~12,1%%alw:~30,1%%alw:~29,1%%alw:~10,1%%alw:~27,1% %alw:~37,1%%alw:~10,1%%alw:~12,1%%alw:~20,1%%alw:~30,1%%alw:~25,1% & %alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%                                                        %alw:~31,1%.%alw:~2,1% %alw:~2,1%%alw:~7,1%/%alw:~0,1%%alw:~5,1% & %alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%. & %alw:~28,1%%alw:~14,1%%alw:~29,1% /%alw:~10,1% %alw:~10,1%%alw:~11,1%%alw:~12,1%=%alw:~1,1%
%alw:~28,1%%alw:~14,1%%alw:~29,1% /%alw:~10,1% %alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%=%alw:~1,1%
%alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%                                         %alw:~39,1%%alw:~14,1%%alw:~28,1%%alw:~14,1%%alw:~23,1%%alw:~31,1%%alw:~24,1%%alw:~21,1%%alw:~31,1%%alw:~18,1%%alw:~13,1%%alw:~24,1% %alw:~25,1%%alw:~24,1%%alw:~27,1% %alw:~39,1%%alw:~18,1%%alw:~24,1%%alw:~16,1%%alw:~24,1%, %alw:~42,1%%alw:~24,1%%alw:~23,1%%alw:~12,1%%alw:~10,1%%alw:~21,1%%alw:~24,1% %alw:~14,1% %alw:~42,1%%alw:~30,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~31,1%%alw:~24,1%
%alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%                                                       %alw:~48,1%%alw:~57,1%%alw:~55,1%%alw:~44,1% %alw:~54,1%%alw:~34,1%%alw:~28,1%%alw:~29,1%%alw:~14,1%%alw:~22,1%%alw:~28,1% & %alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%.
%alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)

echo.&echo Aguarde enquanto verificamos se esta tudo pronto para realizar o backup&echo.
echo A verificar... [0/15]

REM Verificações da existência dos ficheiros necessários
FOR %%i IN ("%USERPROFILE%\AppData\Local\MVTI Systems\") DO (
	IF EXIST %%~si\NUL (
		call :SplashScreen
		echo A verificar... [1/15]
		if not exist "%USERPROFILE%\AppData\Local\MVTI Systems\logs" (
			MKDIR "%USERPROFILE%\AppData\Local\MVTI Systems\logs"
		)
		>>%log_file% echo [%date% %time%] O script 'Fazer Backup' foi iniciado & >>%log_file% echo.
		>>%log_file% echo [%date% %time%] Verificação dos ficheiros necessários iniciada
		>>%log_file% echo [%date% %time%] A pasta 'MVTI Systems' existe
		dir /a-d "%USERPROFILE%\AppData\Local\MVTI Systems\*" >nul 2>nul && (
			for %%R in ("%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info.txt") do (
				if /i not %%~zR EQU 0 (
					call :SplashScreen
					echo A verificar... [2/15]
					>>%log_file% echo [%date% %time%] O ficheiro de texto dos números de série existe
				) else (
					>>%log_file% echo [%date% %time%] O ficheiro de texto dos números de série não existe ou está vazio
					>>%log_file% echo [%date% %time%] Verificação dos ficheiros necessários concluída
					GOTO :Erro
				)
			)
			for %%R in ("%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Pastas.txt") do (
				if /i not %%~zR EQU 0 (
					call :SplashScreen
					echo A verificar... [3/15]
					>>%log_file% echo [%date% %time%] O ficheiro de texto das pastas a serem copiadas existe
				) else (
					>>%log_file% echo [%date% %time%] O ficheiro de texto das pastas a serem copiadas não existe ou está vazio
					>>%log_file% echo [%date% %time%] Verificação dos ficheiros necessários concluída
					GOTO :Erro
				)
			)
			for %%R in ("%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Directorios.txt") do (
				if /i not %%~zR EQU 0 (
					REM Passar o bool de haver directórios que levam com backups para true
          set /a copiar_para_dir_um=1
					>>%log_file% echo [%date% %time%] [NÃO OBRIGATÓRIO] - O ficheiro de texto dos directórios que ficam com as cópias existe
				) else (
					>>%log_file% echo [%date% %time%] [NÃO OBRIGATÓRIO] - O ficheiro de texto dos directórios que ficam com as cópias não existe ou está vazio
				)
				call :SplashScreen
				echo A verificar... [4/15]
			)
		) || (
			>>%log_file% echo [%date% %time%] Nenhum dos ficheiros necessários existe
			>>%log_file% echo [%date% %time%] Verificação dos ficheiros necessários concluída
			GOTO :Erro
		)
	) else (
		MKDIR "%USERPROFILE%\AppData\Local\MVTI Systems" & attrib +h "%USERPROFILE%\AppData\Local\MVTI Systems" /s /d
		cls
		call :Inicio
	)
)
call :SplashScreen
echo A verificar... [5/15]
>>%log_file% echo [%date% %time%] Verificação dos ficheiros necessários concluída & >>%log_file% echo.
>>%log_file% echo [%date% %time%] Verificação dos processos do Sage iniciada

:Codigo
	set /a count=1
	set /a count_drives=0
	set /a count_letters=0
	set /a copias_feitas=0
	set /a count_pastas_tamanho=0
	set /a count_final=0
	set /a aux_calc=3
	set /a validos=0
	set /a count_verificar_dir=0
	set /a count_verificar_dir_dois=0
	set /a dir_quant=0
	set /a alvo_quant=0

  REM ====================================================================================================================================================

  %alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
	REM Preencher o array com as pastas que vão ser copiadas
	FOR /F "tokens=* USEBACKQ" %%F IN ("%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Pastas.txt") DO (
		set /a dir_quant+=1
		set copiar_dir[!dir_quant!]="%%F"
	)

  REM Preencher o array com todas as pens presentes no ficheiro txt
  FOR /F "tokens=* USEBACKQ" %%F IN ("%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info.txt") DO (
    set /a count_drives+=1
    set serials[!count_drives!]=%%F
    set serials_backup[!count_drives!]=%%F
  )

  REM Verificar se o bool está true para mandar os directórios para um array
  if !copiar_para_dir_um! EQU 1 (
    REM Preencher o array com todos os directorios para onde vão ser copiadas as pastas
    FOR /F "tokens=* USEBACKQ" %%F IN ("%USERPROFILE%\AppData\Local\MVTI Systems\MVTI_Info_Directorios.txt") DO (
      set /a alvo_quant+=1
      set alvo_copiar_dir[!alvo_quant!]="%%F"
    )
  )

  REM ====================================================================================================================================================

  %alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
  >>%log_file% echo [%date% %time%] Verificação do conteúdo dos ficheiros de texto iniciada
  REM Se não houver conteúdo no txt de pastas, abortar o programa
  if !dir_quant! EQU 0 (
    >>%log_file% echo [%date% %time%] Não existem pastas no ficheiro MVTI_Info_Pastas, corra o script de Gestor de Pastas
    >>%log_file% echo [%date% %time%] Verificação do conteúdo dos ficheiros de texto concluída & >>%log_file% echo.
    GOTO :Erro
  ) else (
    >>%log_file% echo [%date% %time%] Existem pastas no ficheiro MVTI_Info_Pastas
  )
	call :SplashScreen
	echo A verificar... [6/15]

  REM Se não houver conteúdo no txt de números de série, abortar o programa
  if !count_drives! EQU 0 (
    >>%log_file% echo [%date% %time%] Não existem números de série no ficheiro MVTI_Info, corra o script de Gerar Serial
    >>%log_file% echo [%date% %time%] Verificação do conteúdo dos ficheiros de texto concluída & >>%log_file% echo.
    GOTO :Erro
  ) else (
    >>%log_file% echo [%date% %time%] Existem números de série no ficheiro MVTI_Info
  )
	call :SplashScreen
	echo A verificar... [7/15]

  REM Se o bool tiver a 1 e se não houver conteúdo no txt de directórios, abortar o programa
  if !copiar_para_dir_um! EQU 1 (
    if !alvo_quant! EQU 0 (
      >>%log_file% echo [%date% %time%] Não existem directórios no ficheiro MVTI_Info_Directorios mas não é obrigatório, o script irá continuar
      >>%log_file% echo [%date% %time%] Verificação do conteúdo dos ficheiros de texto concluída & >>%log_file% echo.
    ) else (
      set /a copiar_para_dir_dois=1
      >>%log_file% echo [%date% %time%] Existem directórios no ficheiro MVTI_Info_Directorios
    )
  ) else (
    >>%log_file% echo [%date% %time%] O ficheiro MVTI_Info_Directorios não existe mas não é obrigatório, o script irá continuar
  )
  >>%log_file% echo [%date% %time%] Verificação do conteúdo dos ficheiros de texto concluída & >>%log_file% echo.
	call :SplashScreen
	echo A verificar... [8/15]

  REM ====================================================================================================================================================

  %alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
  >>%log_file% echo [%date% %time%] Verificação de directórios iguais nos ficheiros de texto MVTI_Info_Pastas e MVTI_Info_Directorios iniciada
  if !copiar_para_dir_dois! EQU 1 (
    REM Verificar se algum directório do ficheiro MVTI_Info_Pastas é igual a outro do ficheiro MVTI_Info_Directorios
    for /l %%s in (1, 1, %dir_quant%) do (
      for /l %%x in (1, 1, %alvo_quant%) do (
        if !copiar_dir[%%s]! EQU !alvo_copiar_dir[%%x]! (
          >>%log_file% echo [%date% %time%] Existe pelo menos 1 directório igual nos ficheiros MVTI_Info_Pastas e MVTI_Info_Directorios
          >>%log_file% echo [%date% %time%] Verificação de directórios iguais nos ficheiros de texto MVTI_Info_Pastas e MVTI_Info_Directorios concluída & >>%log_file% echo.
          GOTO :Erro
        )
      )
    )
    >>%log_file% echo [%date% %time%] Não existem directórios iguais nos ficheiros MVTI_Info_Pastas e MVTI_Info_Directorios
  ) else (
    >>%log_file% echo [%date% %time%] A saltar a verificação de directórios iguais entre as duas pastas pois não é obrigatório ter directórios no ficheiro MVTI_Info_Directorios
  )
  >>%log_file% echo [%date% %time%] Verificação de directórios iguais nos ficheiros de texto MVTI_Info_Pastas e MVTI_Info_Directorios concluída & >>%log_file% echo.
	call :SplashScreen
	echo A verificar... [9/15]

  REM ====================================================================================================================================================

 %alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
  REM Colocar as pens encontradas e iguais ao ficheiro de texto num array
  for /l %%s in (1, 1, %count_drives%) do (
    for %%i in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
      @if exist %%i: (
        for /F "skip=1 tokens=5" %%a in ('vol %%i:') do (
          if %%a equ ABCD-EF01 do (
            if /I !serials[%%s]! equ %%a (
              set /a count_letters+=1
              set letras_encontradas[!count_letters!]=%%i
              set pens_encontradas[!count_letters!]=%%a
            )
          )
        )
      )
    )
  )

  >>%log_file% echo ================================================================
  >>%log_file% echo [%date% %time%] Status das Pens & >>%log_file% echo.
  >>%log_file% echo [%date% %time%] Pens guardadas no ficheiro de texto:
  for /l %%x in (1, 1, %count_drives%) do (
    >>%log_file% echo [%date% %time%] Serial %%x. = !serials[%%x]!
  )
  >>%log_file% echo.
  >>%log_file% echo [%date% %time%] Pens inseridas:
  for /l %%x in (1, 1, %count_letters%) do (
    >>%log_file% echo [%date% %time%] Serial %%x. = !pens_encontradas[%%x]!
  )

  REM Verificar se há alguma pen que está no txt mas não está inserida
  if %count_letters% LSS %count_drives% (
      REM Verificar se há pelo menos 1 pen inserida
      if %count_letters% GEQ 1 (
        REM Pode continuar porque há pelo menos uma pen
        REM Informar as pens que não estão inseridas e aquela para onde vai ser feito o backup
        for /l %%x in (1, 1, %count_drives%) do (
          for /l %%b in (1, 1, %count_letters%) do if not defined break (
            if !serials[%%x]! EQU !pens_encontradas[%%b]! (
              set serials_backup[%%x]=-1
            )
          )
        )
        for /l %%x in (1, 1, %count_drives%) do (
          if !serials_backup[%%x]! NEQ -1 (
            >>%log_file% echo [%date% %time%] Serial %%x. = !serials[%%x]! [NÃO ENCONTRADA]
          )
        )
      ) else (
          REM Não pode continuar porque não há nenhuma pen
          >>%log_file% echo [%date% %time%] Nenhuma das pens guardadas no ficheiro de texto foi encontrada
          >>%log_file% echo ================================================================ & >>%log_file% echo.
          GOTO :Erro
      )
  )
	call :SplashScreen
	echo A verificar... [10/15]
  >>%log_file% echo ================================================================ & >>%log_file% echo.

  REM ====================================================================================================================================================

  %alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
  >>%log_file% echo [%date% %time%] Verificação adicional da existência dos directórios do ficheiro MVTI_Info_Pastas iniciada
  REM Verificar se os directórios das pastas a copiar existem
  for /l %%x in (1, 1, %dir_quant%) do (
    if not exist !copiar_dir[%%x]! (
      >>%log_file% echo [%date% %time%] O directório !copiar_dir[%%x]! não existe
    ) else (
      set /a count_verificar_dir+=1
      set dir_validos[!count_verificar_dir!]=!copiar_dir[%%x]!
      >>%log_file% echo [%date% %time%] O directório !copiar_dir[%%x]! existe
    )
  )
  if !count_verificar_dir! EQU 0 (
    >>%log_file% echo [%date% %time%] RESUMO: Todos os directórios introduzidos são inválidos
    >>%log_file% echo [%date% %time%] Verificação adicional da existência dos directórios do ficheiro MVTI_Info_Pastas concluída & >>%log_file% echo.
    GOTO :Erro
  ) else (
    if !count_verificar_dir! LSS %dir_quant% (
      >>%log_file% echo [%date% %time%] RESUMO: Há directórios inválidos, mas o backup irá proceder
    ) else (
      >>%log_file% echo [%date% %time%] RESUMO: Todos os directórios guardados são válidos
    )
  )
  >>%log_file% echo [%date% %time%] Verificação adicional da existência dos directórios do ficheiro MVTI_Info_Pastas concluída& >>%log_file% echo.
	call :SplashScreen
	echo A verificar... [11/15]

  REM ====================================================================================================================================================

	%alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
	>>%log_file% echo [%date% %time%] Verificação adicional da existência dos directórios do ficheiro MVTI_Info_Directorios iniciada

	if !copiar_para_dir_dois! EQU 1 (
		REM Verificar se os directórios das pastas que vão levar os backups existem
		for /l %%x in (1, 1, %alvo_quant%) do (
			if not exist !alvo_copiar_dir[%%x]! (
				>>%log_file% echo [%date% %time%] O directório !alvo_copiar_dir[%%x]! não existe
			) else (
				set /a count_verificar_dir_dois+=1
				set alvo_dir_validos[!count_verificar_dir_dois!]=!alvo_copiar_dir[%%x]!
				>>%log_file% echo [%date% %time%] O directório !alvo_copiar_dir[%%x]! existe
			)
		)
		if !count_verificar_dir_dois! EQU 0 (
			>>%log_file% echo [%date% %time%] RESUMO: Todos os directórios introduzidos são inválidos
			>>%log_file% echo [%date% %time%] Verificação adicional da existência dos directórios do ficheiro MVTI_Info_Directorios concluída & >>%log_file% echo.
			GOTO :Erro
		) else (
			if !count_verificar_dir_dois! LSS %alvo_quant% (
				>>%log_file% echo [%date% %time%] RESUMO: Há directórios inválidos, mas o backup irá proceder
			) else (
				>>%log_file% echo [%date% %time%] RESUMO: Todos os directórios guardados são válidos
			)
		)
	) else (
			>>%log_file% echo [%date% %time%] Esta verificação irá ser saltada visto que não é obrigatório existirem directórios no ficheiro MVTI_Info_Directorios
	)
	>>%log_file% echo [%date% %time%] Verificação adicional da existência dos directórios do ficheiro MVTI_Info_Directorios concluída& >>%log_file% echo.
	call :SplashScreen
	echo A verificar... [12/15]

	REM ====================================================================================================================================================

	%alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
	for /l %%x in (1, 1, %count_verificar_dir%) do (
		set MYDIR1_TEMP=!copiar_dir[%%x]:"=!
		if [!MYDIR1_TEMP:~-1!] EQU [\] (
		  set MYDIR1=!MYDIR1_TEMP:~0,-1!
		) else (
		  if [!MYDIR1_TEMP:~-1!] EQU [/] (
		    set MYDIR1=!MYDIR1_TEMP:~0,-1!
		  ) else (
		    set MYDIR1=!MYDIR1_TEMP!
		  )
		)
		set /a count_final+=1
		set dir_alvo_final[%%x]="!MYDIR1!"
		for %%I in (!dir_alvo_final[%%x]!) do set nome_pasta[%%x]=%%~nxI
	)
	call :SplashScreen
	echo A verificar... [13/15]
::

:Copiar
	%alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
	>>%log_file% echo ================================================================
	>>%log_file% echo [%date% %time%] Resumo do Backup &echo.
	>>%log_file% echo. & >>%log_file% echo [%date% %time%] As pastas que vão ser alvo de backup:
	for /l %%x in (1, 1, %count_final%) do (
		>>%log_file% echo [%date% %time%] %%x. !dir_alvo_final[%%x]!
	)
	>>%log_file% echo. & >>%log_file% echo [%date% %time%] Os diretorios finais nas PENS que ficam com os backups:
	for /l %%b in (1, 1, %count_letters%) do (
		for /l %%x in (1, 1, %count_final%) do (
			>>%log_file% echo [%date% %time%] PEN !pens_encontradas[%%b]! - "!letras_encontradas[%%b]!:\Copias\!nome_pasta[%%x]!"
		)
	)
	>>%log_file% echo. & >>%log_file% echo [%date% %time%] Os diretorios finais nos DIRECTÓRIOS que ficam com os backups:
	if !copiar_para_dir_dois! EQU 1 (
		for /l %%b in (1, 1, %count_verificar_dir_dois%) do (
			set alvo_dir_validos[%%b]=!alvo_dir_validos[%%b]:"=!
			for /l %%x in (1, 1, %count_final%) do (
				>>%log_file% echo [%date% %time%] Diretorio %%b - "!alvo_dir_validos[%%b]!\Copias\!nome_pasta[%%x]!"
			)
		)
	) else (
		>>%log_file% echo [%date% %time%] Os backups não irão ser feitos para directórios pois não é obrigatório existirem directórios no ficheiro MVTI_Info_Directorios
	)
	call :SplashScreen
	echo A verificar... [14/15]
	>>%log_file% echo ================================================================ & >>%log_file% echo.

REM ====================================================================================================================================================

	%alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
	>>%log_file% echo [%date% %time%] Última verificação antes de realizar o backup
	if !count_letters! EQU 0 (
		>>%log_file% echo [%date% %time%] Não existem pens disponíveis para realizar o Backup
		>>%log_file% echo [%date% %time%] Fim da última verificação antes de realizar o backup&>>%log_file% echo.
		GOTO :Erro
	) else (
		>>%log_file% echo [%date% %time%] Existem pens disponíveis para realizar o Backup
		if !copiar_para_dir_dois! EQU 1 (
			if !count_verificar_dir_dois! EQU 0 (
				>>%log_file% echo [%date% %time%] Não existem directórios disponíveis para levarem com os backups
				>>%log_file% echo [%date% %time%] Fim da última verificação antes de realizar o backup&>>%log_file% echo.
				GOTO :Erro
			) else (
				>>%log_file% echo [%date% %time%] Existem directórios e pens disponíveis para levarem com os backups
				>>%log_file% echo [%date% %time%] Fim da última verificação antes de realizar o backup&>>%log_file% echo.
				GOTO :ExecutarCopia
			)
		) else (
			>>%log_file% echo [%date% %time%] Não é obrigatório existirem directórios disponíveis para levarem com os backups
			>>%log_file% echo [%date% %time%] Fim da última verificação antes de realizar o backup&>>%log_file% echo.
			GOTO :ExecutarCopia
		)
	)
::

:ExecutarCopia
	%alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
	call :SplashScreen
	echo A verificar... [15/15]&echo.
	echo A verificacao foi concluida com sucesso, a executar copia...
	>>%log_file% echo ================================================================&>>%log_file% echo.
	echo [%time%] Copia dos ficheiros iniciada&echo.
	>>%log_file% echo [%date% %time%] Cópia dos ficheiros iniciada&>>%log_file% echo.
	REM Realizar cópia para as Pens	
	for /l %%d in (1 , 1, !count_letters!) do (
		echo [%time%] A copia vai ser inciada para a pen [!letras_encontradas[%%d]!:] & echo.
		>>%log_file% echo [%date% %time%] A cópia vai ser inciada para a pen [!letras_encontradas[%%d]!:]&>>%log_file% echo.
		REM Copiar todos os directorios válidos
		for /l %%x in (1, 1, %count_final%) do (
			>>%log_file% echo [%date% %time%] A fazer backup da pasta: !dir_alvo_final[%%x]!
			echo [%time%] A fazer backup da pasta: !dir_alvo_final[%%x]!&echo.
			xcopy /D /E /I /S /Y !dir_alvo_final[%%x]! "!letras_encontradas[%%d]!:\Copias\!nome_pasta[%%x]!" | tee.exe -a %log_file%
			echo. && >>%log_file% echo.
		)
		echo [%time%] A copia para a pen [!letras_encontradas[%%d]!:] foi concluida com sucesso!&echo.
		>>%log_file% echo [%date% %time%] A cópia para a pen [!letras_encontradas[%%d]!:] foi concluída com sucesso!&>>%log_file% echo.
	)	
	if !copiar_para_dir_dois! EQU 1 (
		for /l %%b in (1, 1, %count_verificar_dir_dois%) do (
			set alvo_dir_validos[%%b]=!alvo_dir_validos[%%b]:"=!
			for /l %%x in (1, 1, %count_final%) do (
				echo [%time%] A copia vai ser inciada para o directorio "!alvo_dir_validos[%%b]!\Copias\!nome_pasta[%%x]!"&echo.
				>>%log_file% echo [%date% %time%] A cópia vai ser inciada para o directório "!alvo_dir_validos[%%b]!\Copias\!nome_pasta[%%x]!"&>>%log_file% echo.
				echo [%time%] A fazer backup da pasta: !dir_alvo_final[%%x]!&echo.
				>>%log_file% echo [%date% %time%] A fazer backup da pasta: !dir_alvo_final[%%x]!
				xcopy /D /E /I /S /Y !dir_alvo_final[%%x]! "!alvo_dir_validos[%%b]!\Copias\!nome_pasta[%%x]!" | tee.exe -a %log_file%
				echo [%time%] A copia para o directorio "!alvo_dir_validos[%%b]!\Copias\!nome_pasta[%%x]!" foi concluida com sucesso!&echo.
				>>%log_file% echo [%date% %time%] A cópia para o directório "!alvo_dir_validos[%%b]!\Copias\!nome_pasta[%%x]!" foi concluída com sucesso!&>>%log_file% echo.
			)
		)
	) else (
		echo Nao vao ser realizadas copias para directorios pois os mesmos nao foram configurados e nao e obrigatorio
		>>%log_file% echo [%date% %time%] Não vão ser realizadas cópias para directórios pois os mesmos não foram configurados e não é obrigatório&>>%log_file% echo.
	)
	echo As copias foram concluidas com sucesso, prima um tecla para sair do programa
	>>%log_file% echo [%date% %time%] As cópias foram concluídas com sucesso, prima um tecla para sair do programa
	set /p ask_final=""
	exit
::

:Atencao
	echo.
	echo                                 .d8b.  d888888b d88888b d8b   db  .o88b.  .d8b.   .d88b.
	echo                                d8' `8b `~~88~~' 88'     888o  88 d8P  Y8 d8' `8b .8P  Y8.
	echo                                88ooo88    88    88ooooo 88V8o 88 8P      88ooo88 88    88
	echo                                88~~~88    88    88~~~~~ 88 V8o88 8b      88~~~88 88    88
	echo                                88   88    88    88.     88  V888 Y8b  d8 88   88 `8b  d8'
	echo                                YP   YP    YP    Y88888P VP   V8P  `Y88P' YP   YP  `Y88P'
	echo. &echo. &echo.
	echo Para a copia ser efetuada com sucesso tem que ter qualquer programa Sage fechado
	echo Verifique que nao tem nenhum desses programas abertos e prima qualquer tecla para continuar
	pause >nul
	GOTO :EOF
::

:Erro
	>>%log_file% echo Ocorreu um erro
	>>%log_file% echo Por favor, contacte a MVTI
	>>%log_file% echo suporte@mvti.pt
	>>%log_file% echo 917 078 866 / 918 718 745 / 967 440 530 / 229 955 454
	echo.
	echo                                 .d88b.   .o88b.  .d88b.  d8888b. d8888b. d88888b db    db
	echo                                .8P  Y8. d8P  Y8 .8P  Y8. 88  `8D 88  `8D 88'     88    88
	echo                                88    88 8P      88    88 88oobY' 88oobY' 88ooooo 88    88
	echo                                88    88 8b      88    88 88`8b   88`8b   88~~~~~ 88    88
	echo                                `8b  d8' Y8b  d8 `8b  d8' 88 `88. 88 `88. 88.     88b  d88
	echo                                 `Y88P'   `Y88P'  `Y88P'  88   YD 88   YD Y88888P ~Y8888P'
	echo.
	echo                                  db    db .88b  d88.    d88888b d8888b. d8888b.  .d88b.
	echo                                  88    88 88'YbdP`88    88'     88  `8D 88  `8D .8P  Y8.
	echo                                  88    88 88  88  88    88ooooo 88oobY' 88oobY' 88    88
	echo                                  88    88 88  88  88    88~~~~~ 88`8b   88`8b   88    88
	echo                                  88b  d88 88  88  88    88.     88 `88. 88 `88. `8b  d8'
	echo                                  ~Y8888P' YP  YP  YP    Y88888P 88   YD 88   YD  `Y88P'
	echo. &echo. &echo.
	echo 	                  ********************************************************************
	echo 	                  *                    Por favor, contacte a MVTI                    *
	echo 	                  *                         suporte@mvti.pt                          *
	echo 	                  *      917 078 866 / 918 718 745 / 967 440 530 / 229 955 454       *
	echo 	                  ********************************************************************
	echo. &echo. &echo.
	set /p ex1="Prima qualquer tecla para sair do programa "
	exit
::

:SplashScreen
	cls
	%alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%. & %alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%                                                     %alw:~40,1%%alw:~33,1%%alw:~14,1%%alw:~12,1%%alw:~30,1%%alw:~29,1%%alw:~10,1%%alw:~27,1% %alw:~37,1%%alw:~10,1%%alw:~12,1%%alw:~20,1%%alw:~30,1%%alw:~25,1% & %alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%                                                        %alw:~31,1%.%alw:~2,1% %alw:~2,1%%alw:~7,1%/%alw:~0,1%%alw:~5,1% & %alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%. & %alw:~28,1%%alw:~14,1%%alw:~29,1% /%alw:~10,1% %alw:~10,1%%alw:~11,1%%alw:~12,1%=%alw:~1,1%
	%alw:~28,1%%alw:~14,1%%alw:~29,1% /%alw:~10,1% %alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%=%alw:~1,1%
	%alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%                                         %alw:~39,1%%alw:~14,1%%alw:~28,1%%alw:~14,1%%alw:~23,1%%alw:~31,1%%alw:~24,1%%alw:~21,1%%alw:~31,1%%alw:~18,1%%alw:~13,1%%alw:~24,1% %alw:~25,1%%alw:~24,1%%alw:~27,1% %alw:~39,1%%alw:~18,1%%alw:~24,1%%alw:~16,1%%alw:~24,1%, %alw:~42,1%%alw:~24,1%%alw:~23,1%%alw:~12,1%%alw:~10,1%%alw:~21,1%%alw:~24,1% %alw:~14,1% %alw:~42,1%%alw:~30,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~31,1%%alw:~24,1%
	%alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%                                                       %alw:~48,1%%alw:~57,1%%alw:~55,1%%alw:~44,1% %alw:~54,1%%alw:~34,1%%alw:~28,1%%alw:~29,1%%alw:~14,1%%alw:~22,1%%alw:~28,1% & %alw:~14,1%%alw:~12,1%%alw:~17,1%%alw:~24,1%.
	%alw:~18,1%%alw:~15,1% !%alw:~25,1%%alw:~10,1%%alw:~28,1%%alw:~29,1%%alw:~10,1%%alw:~28,1%_%alw:~14,1%%alw:~23,1%%alw:~12,1%%alw:~24,1%%alw:~23,1%%alw:~29,1%%alw:~27,1%%alw:~10,1%%alw:~13,1%%alw:~10,1%%alw:~28,1%! %alw:~49,1%%alw:~40,1%%alw:~52,1% %alw:~1,1% (%alw:~42,1%%alw:~50,1%%alw:~55,1%%alw:~50,1% :%alw:~40,1%%alw:~27,1%%alw:~27,1%%alw:~24,1%)
	echo.&echo Aguarde enquanto verificamos se esta tudo pronto para realizar o backup&echo.
	GOTO :EOF
::
