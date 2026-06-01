package com.curso.dispmovauto.data

import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Update
import kotlinx.coroutines.flow.Flow

@Dao
interface ContactoDao {
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    suspend fun insert(contacto: Contacto)

    @Update
    suspend fun update(contacto: Contacto)

    @Delete
    suspend fun delete(contacto: Contacto)

    @Query("SELECT * FROM contactos ORDER BY nombre ASC")
    fun getAllContactos(): Flow<List<Contacto>>

    @Query("SELECT * FROM contactos WHERE id = :id")
    fun getContacto(id: Int): Flow<Contacto>
}
