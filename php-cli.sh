#!/bin/bash

ficheroDestino="test.php"
prompter="myphpcli "
comandoListar="listar"
comandoEjecutar=""
comandoBorrar="borrar"
comandoLimpiar="clear"
comandos=()



function listaComandos() {
	acumulados=${#comandos[@]}
	for((i=0;i<$acumulados;i++))
	do
<<COMMENTARIO
		if [ $i -lt 10000 ]
		then
			echo -n " "
		fi
		if [ $i -lt 1000 ]
		then
			echo -n " "
		fi
		if [ $i -lt 100 ]
		then
			echo -n " "
		fi
		if [ $i -lt 10 ]
		then
			echo -n " "
		fi
COMMENTARIO
		echo -n "["
		echo -n ${i}
		echo -n "] : "
		echo -n ${comandos[$i]}
		echo ;
	done
}
function borraComando() {
	unset comandos[${#comandos[@]}-1]="";
	listaComandos;
}
function ejecutaComandos() {
	echo "<?php" > $ficheroDestino;
	acumulados=${#comandos[@]}
	for((i=0;i<$acumulados;i++))
	do
		echo ${comandos[$i]} >> $ficheroDestino;
	done
	echo "?>" >> $ficheroDestino;
	echo "###############";
	php $ficheroDestino;
	echo;
	echo "###############";
}
function apendizaComando() {
	comandos[${#comandos[@]}]=$comando
	listaComandos;
}






while true
do
	read -rp "$prompter > " comando
	if test "$comando" = "$comandoListar" 
	then
		listaComandos;
	elif test "$comando" = "$comandoBorrar"
	then
		borraComando;
	elif test "$comando" = "$comandoEjecutar"
	then
		ejecutaComandos;
	elif test "$comando" = "$comandoLimpiar"
	then
		clear;
	else 
		apendizaComando;
	fi
done
