package com.curso.dispmovauto.data

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase

@Database(entities = [Contacto::class], version = 1, exportSchema = false)
abstract class ContactosDatabase : RoomDatabase() {

    abstract fun contactoDao(): ContactoDao

    companion object {
        @Volatile
        private var Instance: ContactosDatabase? = null

        fun getDatabase(context: Context): ContactosDatabase {
            return Instance ?: synchronized(this) {
                Room.databaseBuilder(
                    context.applicationContext,
                    ContactosDatabase::class.java,
                    "contactos_database"
                )
                .fallbackToDestructiveMigration()
                .build()
                .also { Instance = it }
            }
        }
    }
}
