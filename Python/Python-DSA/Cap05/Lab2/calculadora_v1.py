# Calculadora em Python

import math

print("\n******************* Calculadora em Python *******************")

print ("Selecione o numero da operacao desejada: ")

print(" 1 - Soma")
print(" 2 - Subtracao")
print(" 3 - Multiplicacao")
print(" 4 - Divisao")
operacao = input("Digite sua operacao (1/2/3/4): ")
num1 = input("Digite o primeiro numero: ")
num2 = input("Digite o segundo numero: ")



if operacao == "1" :
    resultado = int(num1) + int(num2)
    print("Resultado: " + str(resultado))
if operacao == "2" :
    resultado = int(num1) - int(num2)
    print("Resultado: " + str(resultado))
if operacao == "3" :
    resultado = int(num1) * int(num2)
    print("Resultado: " + str(resultado))
if operacao == "4" :
    resultado = int(num1) / int(num2)
    print("Resultado: "  + str(resultado))
else : 
    print("Selecione uma opcao valida")
    
        



