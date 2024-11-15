#!/bin/bash


PORT="2022"

echo "1. ENVIO DE CABECERA"

echo "DMAM" | nc 127.0.0.1 $PORT

DATA=`nc -l $PORT`

echo "3. COMPROBANDO HEADER"

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: El header se envió incorrectamente"
	exit 1
fi

echo "4. ENVIANDO EL FILE_NAME"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc localhost $PORT

echo "7. RECIBIENDO COMPROBACION FILE_NAME"

DATA=`nc -l $PORT`

if [ "$DATA" !="OK_FILE_NAME" ]
then
	echo "ERROR 2:
