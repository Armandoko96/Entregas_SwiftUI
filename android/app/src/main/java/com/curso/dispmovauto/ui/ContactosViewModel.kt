package com.curso.dispmovauto.ui

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.curso.dispmovauto.data.Contacto
import com.curso.dispmovauto.data.ContactosRepository
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch

class ContactosViewModel(private val repository: ContactosRepository) : ViewModel() {

    // Lista de contactos en tiempo real expuesta como StateFlow
    val contactosState: StateFlow<List<Contacto>> = repository.getAllContactosStream()
        .stateIn(
            scope = viewModelScope,
            started = SharingStarted.WhileSubscribed(5000),
            initialValue = emptyList()
        )

    fun insertContacto(contacto: Contacto) {
        viewModelScope.launch {
            repository.insertContacto(contacto)
        }
    }

    fun deleteContacto(contacto: Contacto) {
        viewModelScope.launch {
            repository.deleteContacto(contacto)
        }
    }

    fun updateContacto(contacto: Contacto) {
        viewModelScope.launch {
            repository.updateContacto(contacto)
        }
    }
}
