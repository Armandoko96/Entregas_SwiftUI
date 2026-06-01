//
//  Lesson1_Intro.swift
//  DispMovAUTO - Swift Fundamentos
//
//  Creado para estudio y comparación de sintaxis básica.
//

import Foundation

print("=== LECCIÓN 1: INTRODUCCIÓN A SWIFT ===")

// 1. VARIABLES Y CONSTANTES
// Usar 'let' para valores inmutables (preferido en Swift por seguridad) y 'var' para mutables.
let pais = "México"
var edad = 20

// Intentar cambiar 'pais' daría error de compilación: pais = "España"
edad = 21 // Válido porque es 'var'

print("País: \(pais), Edad: \(edad)")

// 2. TIPOS DE DATOS (Inferencia de tipo vs Explicidad)
let entero: Int = 10
let decimal: Double = 9.99
let cadena: String = "Hola Swift"
let booleano: Bool = true

// 3. COLECCIONES
// Arrays (Lista ordenada del mismo tipo)
var frutas = ["Manzana", "Plátano", "Naranja"]
frutas.append("Uva")
print("Mis frutas: \(frutas)")

// Diccionarios (Clave-Valor)
var calificaciones = ["Matemáticas": 9.5, "Historia": 8.0]
calificaciones["Física"] = 10.0
print("Mis calificaciones: \(calificaciones)")

// 4. CONTROL DE FLUJO
// Condicionales (Paréntesis no obligatorios en Swift)
if edad >= 18 {
    print("Eres mayor de edad en \(pais).")
} else {
    print("Eres menor de edad.")
}

// Loops
print("Iterando frutas:")
for fruta in frutas {
    print("- \(fruta)")
}

// Bucle por rangos
print("Contador de 1 a 3:")
for i in 1...3 {
    print("Número \(i)")
}

// 5. SWITCH CASE
// En Swift los switch no requieren 'break' explícito, no continúan automáticamente al siguiente caso.
let calificacionLetra = "A"

switch calificacionLetra {
case "A":
    print("Excelente trabajo")
case "B":
    print("Buen desempeño")
default:
    print("Sigue intentando")
}
