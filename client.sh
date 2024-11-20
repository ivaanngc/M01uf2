#!/bin/bash

if [ "$1" == "" ]
then
	echo "Debes indicar la dirección del servidor."
	echo "Ejemplo:"
	echo -e "\t$0 127.0.0.1"
	exit 1
fi


IP_SERVER=$1

IP=`ip a | grep "scope global" | xargs | cut -d " " -f 2 | cut -d "/" -f 1`

PORT="2022"

echo "1. ENVIO DE CABECERA"

echo "DMAM $IP" | nc $IP $PORT

DATA=`nc -l $PORT`

echo "3. COMPROBANDO HEADER"

if [ "$DATA" != "OK_HEADER" ]
then
	echo "ERROR 1: El header se envió incorrectamente"
	exit 1
fi

echo "4. ENVIANDO EL FILE_NAME"

FILE_NAME="dragon.txt"

echo "FILE_NAME $FILE_NAME" | nc $IP $PORT

echo "7. RECIBIENDO COMPROBACION FILE_NAME"

DATA=`nc -l $PORT`

if [ "$DATA" != "OK_FILE_NAME" ]
then
	echo "ERROR 2: Prefijo de archivo incorrecto"
	exit 2
fi

echo "8. ENVIAMOS EL CONTENIDO DEL ARCHIVO"

cat client/dragon.txt | nc $IP $PORT


