package com.curso.dispmovauto.data

import kotlinx.coroutines.flow.Flow

interface ContactosRepository {
    fun getAllContactosStream(): Flow<List<Contacto>>
    fun getContactoStream(id: Int): Flow<Contacto?>
    suspend fun insertContacto(contacto: Contacto)
    suspend fun deleteContacto(contacto: Contacto)
    suspend fun updateContacto(contacto: Contacto)
}

class OfflineContactosRepository(private val contactoDao: ContactoDao) : ContactosRepository {
    override fun getAllContactosStream(): Flow<List<Contacto>> = contactoDao.getAllContactos()
    override fun getContactoStream(id: Int): Flow<Contacto?> = contactoDao.getContacto(id)
    override suspend fun insertContacto(contacto: Contacto) = contactoDao.insert(contacto)
    override suspend fun deleteContacto(contacto: Contacto) = contactoDao.delete(contacto)
    override suspend fun updateContacto(contacto: Contacto) = contactoDao.update(contacto)
}
