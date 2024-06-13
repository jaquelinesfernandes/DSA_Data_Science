package main

import (
	"fmt"

	"github.com/sjwhitworth/golearn/base"
	"github.com/sjwhitworth/golearn/evaluation"
	"github.com/sjwhitworth/golearn/knn"
)

func main() {

	fmt.Println("Machine Learning com Linguagem Go")

	// Carrega os dados
	fmt.Println("Carregando os Dados")
	rawData, err := base.ParseCSVToInstances("dataset.csv", true)
	if err != nil {
		panic(err)
	}

	// Cria o modelo KNN
	fmt.Println("Inicializando o Modelo KNN")
	cls := knn.NewKnnClassifier("euclidean", "linear", 2)

	// Divisão dos dados em treino e teste
	fmt.Println("Divisão dos Dados em Treino e Teste")
	trainData, testData := base.InstancesTrainTestSplit(rawData, 0.50)

	// Treinamento do modelo
	cls.Fit(trainData)

	fmt.Println("Fazendo Previsões com o Modelo Treinado")
	predictions, err := cls.Predict(testData)
	if err != nil {
		panic(err)
	}

	// Imprime as previsões
	fmt.Println(predictions)

	// Imprime as métricas
	fmt.Println("Métricas do Modelo")
	confusionMat, err := evaluation.GetConfusionMatrix(testData, predictions)
	if err != nil {
		panic(fmt.Sprintf("Não foi possível gerar a confusion matrix: %s", err.Error()))
	}
	fmt.Println(evaluation.GetSummary(confusionMat))
}