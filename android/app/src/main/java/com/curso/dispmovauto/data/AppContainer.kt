package com.curso.dispmovauto.data

import android.content.Context

interface AppContainer {
    val contactosRepository: ContactosRepository
}

class AppDataContainer(private val context: Context) : AppContainer {
    override val contactosRepository: ContactosRepository by lazy {
        OfflineContactosRepository(ContactosDatabase.getDatabase(context).contactoDao())
    }
}
