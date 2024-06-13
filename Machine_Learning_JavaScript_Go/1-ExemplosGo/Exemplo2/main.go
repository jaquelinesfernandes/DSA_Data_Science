package main

import "fmt"

func main() {

	// Variável do tipo int
	var numero int
	numero = 100
	println(numero)

	// Variável do tipo float
	var preco float32 = 25.
	println(preco)

	// Variável do tipo string
	palavra := "DSA"
	println(palavra)

	// Cria lista em Go
	lista_numeros_float := []float32{45., 27., 92.}

	// print
	fmt.Println(lista_numeros_float)
	fmt.Println(len(lista_numeros_float))

	// Atribui um valor à lista
	lista_numeros_float[1] = 128

	// print
	fmt.Println(lista_numeros_float)
	fmt.Println(len(lista_numeros_float))

}
