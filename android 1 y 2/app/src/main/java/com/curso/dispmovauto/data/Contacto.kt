package com.curso.dispmovauto.data

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "contactos")
data class Contacto(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val nombre: String,
    val direccion: String,
    val correo: String
)
