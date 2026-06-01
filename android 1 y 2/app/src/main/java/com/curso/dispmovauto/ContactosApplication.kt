package com.curso.dispmovauto

import android.app.Application
import com.curso.dispmovauto.data.AppContainer
import com.curso.dispmovauto.data.AppDataContainer

class ContactosApplication : Application() {
    /**
     * AppContainer instance used by the rest of classes to obtain dependencies
     */
    lateinit var container: AppContainer

    override fun onCreate() {
        super.onCreate()
        container = AppDataContainer(this)
    }
}
