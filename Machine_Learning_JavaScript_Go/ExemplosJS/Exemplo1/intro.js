// Introdução à Linguagem JavaScript

/* 

Variáveis

*/

console.log("Variaveis:") 

var nome_dog = "Billy"
console.log(nome_dog)

var temperatura = 28
console.log(temperatura)


/* 

Tipos de Dados

*/

console.log("Tipos de Dados:") 

// Tipo de Dado - String
var primeiroNome = "Bill"
console.log(primeiroNome)

// Tipo de Dado - Number
var idade = 46
console.log(idade)

// Tipo de Dado - Boolean
var acessou_web_site = true
console.log(acessou_web_site)

// Tipo de Dado - Undefined
var job
console.log(job)

// Nomeação de Variáveis
var _3idade = 50
console.log(_3idade)

// Nomeação não permitida
// var if = "teste"
// console.log(if)


/*  

Operadores Lógicos

&& ==> e lógico
|| ==> ou lógico
!  ==> negação

*/

console.log("Operadores Logicos:") 

var nota1, nota2, nota3

nota1 = 100
nota2 = 90
nota3 = 70

console.log("Operador E")
console.log(true && true)
console.log(true && false)
console.log(false && true)
console.log(false && false)

console.log( ((nota1 < nota2) && (nota2 < nota3)) ) // false

console.log("Operador Ou")
console.log(true || true)
console.log(true || false)
console.log(false || true)
console.log(false || false)

console.log( !((nota1 < nota2) || (nota2 < nota3)) ) // true


/* 

Estruturas Condicionais

*/

console.log("Estruturas Condicionais:") 


var notaAluno1, notaAluno2

notaAluno1 = 6
notaAluno2 = 7

if (notaAluno1 >=5 && notaAluno2 > 5){
    console.log("Alunos Aprovados")
} else {
    console.log("Alunos Reprovados")
}


/* 

Operador Ternário

*/

console.log("Operador Ternario:") 

var notaAluno1

notaAluno1 = 4

notaAluno1 >=5 ? console.log("Aprovado") : console.log("Reprovado")



/* 

Estruturas de Repetição

*/

console.log("Estruturas de Repeticao:") 

var lista_linguagens = ['Python', 'C++', 'Scala', 'JavaScript']

var i

for (i = 0; i < lista_linguagens.length; i++){
    console.log(lista_linguagens[i])
}







