@echo off
title SMP - Paper Server (12GB)
cd /d "%~dp0"

REM ============================================================
REM   SMP Launcher - 12GB RAM with Aikar's G1GC flags
REM
REM   Java requirements:
REM     - Paper 26.x  -> Java 25 (Eclipse Temurin / Adoptium)
REM     - Paper 1.21.x -> Java 21
REM   Check with:  java -version
REM ============================================================

REM --- Server jar file name (rename your downloaded jar to this) ---
set JAR=paper.jar

REM --- Heap size: 12GB. Safe on 32GB RAM (Windows + JVM overhead
REM     needs ~4GB on top of Xmx). If you raise this ABOVE 12G,
REM     also swap the G1 flags at the bottom of JAVA_ARGS (see
REM     docs/OPTIMIZATION.md "Bigger heap than 12G"). ---
set RAM=12G

REM --- Java executable. If 'java' is not found or the wrong
REM     version is used, point JAVA at your full java.exe path:
REM     set "JAVA=C:\Program Files\Eclipse Adoptium\jdk-25.0.1.9-hotspot\bin\java.exe"
set "JAVA=java"

REM --- JVM flags (Aikar's Flags - https://mcflags.emc.gs) ---
set "JAVA_ARGS=-Xms%RAM% -Xmx%RAM% -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true"

:restart
echo [%date% %time%] Starting server...
"%JAVA%" %JAVA_ARGS% -jar %JAR% --nogui
echo.
echo Server stopped or crashed. Restarting in 5 seconds...
echo Press Ctrl+C in this window to stop it for good.
timeout /t 5 /nobreak >nul
goto restart
