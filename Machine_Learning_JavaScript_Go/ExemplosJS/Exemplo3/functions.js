
/* 

Funções

*/

// Function 1
function square(x){
    return x * x;
}

console.log("Function 1:");
console.log(square(4));

// Function 2
function calculaComissao(salario) {
    return salario * 0.15;
}

var Func1Comissao = calculaComissao(2500);
var Func2Comissao = calculaComissao(7400);
var Func3Comissao = calculaComissao(5000);

console.log("Function 2:");
console.log(Func1Comissao, Func2Comissao, Func3Comissao);

// Function 3
function calculaComissaoTurno(salario, turno) {
    
    var comissao = calculaComissao(salario);
    
    if (turno == "Noite") {
        console.log('Turno ' + turno + ' recebe adicional de 100 reais. Comissao = ' + (comissao + 100));
    } else {
        console.log('Turno ' + turno + ' recebe valor normal. Comissao = ' + comissao);
    }
    
}

console.log("Function 3:");
calculaComissaoTurno(10000, 'Noite');
calculaComissaoTurno(6500, 'Dia');
calculaComissaoTurno(8000, 'Noite');

// Function 4
function potencia(base, exponent) {
    
    if (exponent == undefined)
        exponent = 2;
    
    var result = 1;
    
    for (var count = 0; count < exponent; count++)
        result *= base;
    
    return result;
}
  
console.log("Function 4:");
console.log(potencia(5));
console.log(potencia(5, 3));
console.log(potencia(5, 3, 9));
console.log(potencia());

// Function 5
function power2(base, exponent) {
    if (exponent == 0)
      return 1;
    else
      return base * power2(base, exponent - 1);
  }
  
console.log("Function 5:");
console.log(power2(2, 3));
