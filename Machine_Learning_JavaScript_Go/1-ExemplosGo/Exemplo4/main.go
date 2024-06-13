package main

import "fmt"

// Cria uma struct
type pessoa struct {
	nome  string
	idade int
}

// Função para nova pessoa
func novaPessoa(nome string) *pessoa {

	p := pessoa{nome: nome}
	p.idade = 42

	return &p
}

// Função main
func main() {

	fmt.Println(pessoa{"Bob", 29})

	fmt.Println(pessoa{nome: "Maria", idade: 50})

	fmt.Println(pessoa{nome: "Fred"})

	fmt.Println(&pessoa{nome: "Ana", idade: 45})

	fmt.Println(novaPessoa("Zico"))

	s := pessoa{nome: "Silva", idade: 32}
	fmt.Println(s.nome)

	sp := &s
	fmt.Println(sp.idade)

	sp.idade = 58
	fmt.Println(sp.idade)
}
