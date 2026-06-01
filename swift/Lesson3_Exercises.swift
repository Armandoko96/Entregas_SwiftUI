//
//  Lesson3_Exercises.swift
//  DispMovAUTO - Swift Ejercicios de Lógica
//

import Foundation

print("=== LECCIÓN 3: EJERCICIOS DE LÓGICA ===")

// EJERCICIO 1: Cálculo de Factorial
// Diseñar una función recursiva o iterativa para obtener el factorial de un número.
func calcularFactorial(de numero: Int) -> Int {
    if numero <= 1 { return 1 }
    var resultado = 1
    for i in 2...numero {
        resultado *= i
    }
    return resultado
}
let numFact = 5
print("Factorial de \(numFact) es \(calcularFactorial(de: numFact))")

// EJERCICIO 2: Secuencia de Fibonacci
// Generar un arreglo con los primeros N números de la serie de Fibonacci.
func generarFibonacci(n: Int) -> [Int] {
    guard n > 0 else { return [] }
    if n == 1 { return [0] }
    var serie = [0, 1]
    while serie.count < n {
        let siguiente = serie[serie.count - 1] + serie[serie.count - 2]
        serie.append(siguiente)
    }
    return serie
}
let limiteFib = 8
print("Primeros \(limiteFib) de Fibonacci: \(generarFibonacci(n: limiteFib))")

// EJERCICIO 3: Clasificación de Números y Filtrado (Programación Funcional)
// Filtrar números pares e impares de una lista y calcular promedios.
let numerosAleatorios = [12, 5, 8, 21, 3, 16, 9, 14]

// Swift soporta filtros de closures abreviados como '$0 % 2 == 0'
let pares = numerosAleatorios.filter { $0 % 2 == 0 }
let impares = numerosAleatorios.filter { $0 % 2 != 0 }

print("Todos los números: \(numerosAleatorios)")
print("Números pares: \(pares)")
print("Números impares: \(impares)")

// Sumar elementos usando 'reduce'
let sumaPares = pares.reduce(0, +)
let promedioPares = Double(sumaPares) / Double(pares.count)
print("Promedio de pares: \(promedioPares)")
