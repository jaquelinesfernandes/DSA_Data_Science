package main

import "fmt"

func main() {

	// Cria uma lista vazia do tipo string
	s := make([]string, 3)
	fmt.Println("Lista Vazia:", s)

	// Atribui valores a cada elemento da lista
	s[0] = "a"
	s[1] = "b"
	s[2] = "c"
	fmt.Println("Valores da Lista:", s)
	fmt.Println("Elemento da Lista:", s[2])
	fmt.Println("Comprimento da Lista:", len(s))

	// Append (inclusão) de elementos na lista
	s = append(s, "d")
	s = append(s, "e", "f")
	fmt.Println("Valores da Lista:", s)

	// Cria uma nova lista e copia o conteúdo da primeira lista
	c := make([]string, len(s))
	copy(c, s)
	fmt.Println("Nova Lista:", c)

	// Slice (indexação) da lista
	l := s[2:5]
	fmt.Println("Slice 1:", l)

	l = s[:5]
	fmt.Println("Slice 2:", l)

	l = s[2:]
	fmt.Println("Slice 3:", l)

	// Cria uma lista inicializando com valores
	t := []string{"g", "h", "i"}
	fmt.Println("Nova Lista:", t)

	// Cria uma matriz e preenche os valores
	twoD := make([][]int, 3)

	for i := 0; i < 3; i++ {
		innerLen := i + 1
		twoD[i] = make([]int, innerLen)
		for j := 0; j < innerLen; j++ {
			twoD[i][j] = i + j
		}
	}

	// Imprime a matriz
	fmt.Println("Matriz: ", twoD)
}
