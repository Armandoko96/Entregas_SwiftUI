package com.curso.dispmovauto.ui

import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewmodel.CreationExtras
import androidx.lifecycle.viewmodel.initializer
import androidx.lifecycle.viewmodel.viewModelFactory
import com.curso.dispmovauto.ContactosApplication

object AppViewModelProvider {
    val Factory = viewModelFactory {
        initializer {
            ContactosViewModel(
                contactosApplication().container.contactosRepository
            )
        }
    }
}

/**
 * Extension function to queries for [Application] object and returns an instance of
 * [ContactosApplication].
 */
fun CreationExtras.contactosApplication(): ContactosApplication =
    (this[ViewModelProvider.AndroidViewModelFactory.APPLICATION_KEY] as ContactosApplication)
