package main

import (
	"fmt"
	"log"
	"os"

	"github.com/go-gota/gota/dataframe"
)

func main() {

	// Abre o arquivo
	dados, err := os.Open("./dataset.csv")

	if err != nil {
		log.Fatal(err)
	}

	// Cria um dataframe
	df := dataframe.ReadCSV(dados)

	// Imrime na tela
	fmt.Println(df)
}
