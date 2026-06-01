//
//  Lesson2_Structures.swift
//  DispMovAUTO - Swift Avanzado y Estructuras
//

import Foundation

print("=== LECCIÓN 2: ESTRUCTURAS, FUNCIONES Y OPCIONALES ===")

// 1. FUNCIONES
// Definición básica con parámetros etiquetados y tipo de retorno ->
func saludar(nombre: String, saludo: String = "Hola") -> String {
    return "\(saludo), \(nombre)!"
}
print(saludar(nombre: "Juan"))
print(saludar(nombre: "Sofía", saludo: "Buenos días"))

// 2. OPCIONALES (Optionals)
// En Swift las variables no pueden ser nulas ('nil') por defecto. Deben declararse opcionales con '?'.
var emailDeUsuario: String? = nil
emailDeUsuario = "estudiante@universidad.edu"

// Desempaquetado Seguro (Unwrapping)
// Método A: 'if let' (Local scope)
if let emailSeguro = emailDeUsuario {
    print("El email es: \(emailSeguro)")
} else {
    print("El usuario no tiene registrado un email.")
}

// Método B: Operador de Coalescencia Nula '??' (Valor por defecto)
let emailParaMostrar = emailDeUsuario ?? "correo@no-registrado.com"
print("Mostrar: \(emailParaMostrar)")

// Método C: 'guard let' (Fuerza la salida si es nil, ideal dentro de funciones)
func enviarCorreo(correo: String?) {
    guard let correoValido = correo else {
        print("Error: Correo inválido. Abortando.")
        return
    }
    print("Correo enviado exitosamente a \(correoValido)")
}
enviarCorreo(correo: emailDeUsuario)

// 3. STRUCT (Tipos por Valor - Value Types)
// Son copiados al pasarse o asignarse. Ideal para datos inmutables y modelos.
struct Producto {
    let id: Int
    var nombre: String
    var precio: Double
}

var prod1 = Producto(id: 1, nombre: "Cuaderno", precio: 2.5)
var prod2 = prod1 // Se COPIA el valor completo en memoria
prod2.nombre = "Lapicero" // Cambiar prod2 no afecta a prod1
print("Original (prod1): \(prod1.nombre) - Copia (prod2): \(prod2.nombre)")

// 4. CLASS (Tipos por Referencia - Reference Types)
// Apuntan al mismo objeto en memoria. Requieren inicializador 'init' manual.
class Estudiante {
    var nombre: String
    var promedio: Double
    
    init(nombre: String, promedio: Double) {
        self.nombre = nombre
        self.promedio = promedio
    }
}

let est1 = Estudiante(nombre: "Carlos", promedio: 9.0)
let est2 = est1 // Apuntan a la misma dirección de memoria
est2.nombre = "Mateo" // Cambiar est2 también modifica est1
print("Original (est1): \(est1.nombre) - Referencia (est2): \(est2.nombre)")
