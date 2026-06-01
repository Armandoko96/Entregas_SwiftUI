package com.curso.dispmovauto.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import coil.compose.AsyncImage
import com.curso.dispmovauto.data.Contacto
import com.curso.dispmovauto.ui.AppViewModelProvider
import com.curso.dispmovauto.ui.ContactosViewModel
import com.curso.dispmovauto.ui.WeatherViewModel

enum class ActiveScreen {
    DASHBOARD,
    ASYNC_IMAGE,
    ROOM_CRUD,
    RETROFIT_WEATHER
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MainScreen() {
    var currentScreen by remember { mutableStateOf(ActiveScreen.DASHBOARD) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { 
                    Text(
                        text = when(currentScreen) {
                            ActiveScreen.DASHBOARD -> "DispMovAUTO Dashboard"
                            ActiveScreen.ASYNC_IMAGE -> "AsyncImage Demo"
                            ActiveScreen.ROOM_CRUD -> "Room SQLite CRUD"
                            ActiveScreen.RETROFIT_WEATHER -> "Retrofit Web API"
                        }
                    ) 
                },
                navigationIcon = {
                    if (currentScreen != ActiveScreen.DASHBOARD) {
                        IconButton(onClick = { currentScreen = ActiveScreen.DASHBOARD }) {
                            Icon(imageVector = Icons.Default.ArrowBack, contentDescription = "Atrás")
                        }
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primaryContainer,
                    titleContentColor = MaterialTheme.colorScheme.onPrimaryContainer
                )
            )
        }
    ) { innerPadding ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
        ) {
            when (currentScreen) {
                ActiveScreen.DASHBOARD -> DashboardScreen(
                    onNavigate = { screen -> currentScreen = screen }
                )
                ActiveScreen.ASYNC_IMAGE -> AsyncImageScreen()
                ActiveScreen.ROOM_CRUD -> RoomCrudScreen()
                ActiveScreen.RETROFIT_WEATHER -> RetrofitWeatherScreen()
            }
        }
    }
}

@Composable
fun DashboardScreen(onNavigate: (ActiveScreen) -> Unit) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text(
            text = "Prácticas de Programación Móvil",
            style = MaterialTheme.typography.headlineMedium,
            textAlign = TextAlign.Center,
            modifier = Modifier.padding(bottom = 8.dp)
        )
        
        DashboardCard(
            title = "Carga de Imágenes (Coil)",
            description = "Clase 1: Implementación de AsyncImage en LazyColumn.",
            icon = Icons.Default.PlayArrow,
            onClick = { onNavigate(ActiveScreen.ASYNC_IMAGE) }
        )
        
        DashboardCard(
            title = "Base de Datos Room (SQLite)",
            description = "Clases 2-6: CRUD completo de Contactos con Corrutinas y Flow.",
            icon = Icons.Default.Add,
            onClick = { onNavigate(ActiveScreen.ROOM_CRUD) }
        )
        
        DashboardCard(
            title = "Consumo de API (Retrofit)",
            description = "Clases 7-8: Consulta remota asíncrona de clima local.",
            icon = Icons.Default.Refresh,
            onClick = { onNavigate(ActiveScreen.RETROFIT_WEATHER) }
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DashboardCard(
    title: String,
    description: String,
    icon: androidx.compose.ui.graphics.vector.ImageVector,
    onClick: () -> Unit
) {
    Card(
        onClick = onClick,
        modifier = Modifier.fillMaxWidth(),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surfaceVariant
        )
    ) {
        Row(
            modifier = Modifier
                .padding(16.dp)
                .fillMaxWidth(),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            Icon(
                imageVector = icon,
                contentDescription = null,
                tint = MaterialTheme.colorScheme.primary,
                modifier = Modifier.size(36.dp)
            )
            Column(modifier = Modifier.weight(1f)) {
                Text(text = title, style = MaterialTheme.typography.titleMedium)
                Text(text = description, style = MaterialTheme.typography.bodySmall)
            }
        }
    }
}

@Composable
fun AsyncImageScreen() {
    val imageUrls = listOf(
        "https://picsum.photos/id/10/800/600",
        "https://picsum.photos/id/20/800/600",
        "https://picsum.photos/id/30/800/600",
        "https://picsum.photos/id/40/800/600",
        "https://picsum.photos/id/50/800/600"
    )

    LazyColumn(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        item {
            Text(
                text = "Lista de Imágenes cargadas asíncronamente desde Picsum",
                style = MaterialTheme.typography.bodyLarge
            )
        }
        items(imageUrls) { url ->
            Card(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(200.dp)
            ) {
                AsyncImage(
                    model = url,
                    contentDescription = "Imagen Remota",
                    modifier = Modifier.fillMaxSize(),
                    contentScale = ContentScale.Crop
                )
            }
        }
    }
}

@Composable
fun RoomCrudScreen(
    viewModel: ContactosViewModel = viewModel(factory = AppViewModelProvider.Factory)
) {
    val contactos by viewModel.contactosState.collectAsState()
    
    var nombre by remember { mutableStateOf("") }
    var direccion by remember { mutableStateOf("") }
    var correo by remember { mutableStateOf("") }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        Card(
            modifier = Modifier.fillMaxWidth(),
            colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.secondaryContainer)
        ) {
            Column(
                modifier = Modifier.padding(16.dp),
                verticalArrangement = Arrangement.spacedBy(8.dp)
            ) {
                Text("Nuevo Contacto (SQLite)", style = MaterialTheme.typography.titleMedium)
                OutlinedTextField(
                    value = nombre,
                    onValueChange = { nombre = it },
                    label = { Text("Nombre") },
                    modifier = Modifier.fillMaxWidth()
                )
                OutlinedTextField(
                    value = direccion,
                    onValueChange = { direccion = it },
                    label = { Text("Dirección") },
                    modifier = Modifier.fillMaxWidth()
                )
                OutlinedTextField(
                    value = correo,
                    onValueChange = { correo = it },
                    label = { Text("Correo Electrónico") },
                    keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
                    modifier = Modifier.fillMaxWidth()
                )
                Button(
                    onClick = {
                        if (nombre.isNotBlank() && correo.isNotBlank()) {
                            viewModel.insertContacto(
                                Contacto(nombre = nombre, direccion = direccion, correo = correo)
                            )
                            nombre = ""
                            direccion = ""
                            correo = ""
                        }
                    },
                    modifier = Modifier.align(Alignment.End)
                ) {
                    Text("Agregar")
                }
            }
        }

        Text(
            text = "Contactos Registrados: ${contactos.size}",
            style = MaterialTheme.typography.titleMedium
        )

        LazyColumn(
            modifier = Modifier.fillMaxWidth(),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            items(contactos) { contacto ->
                Card(modifier = Modifier.fillMaxWidth()) {
                    Row(
                        modifier = Modifier
                            .padding(12.dp)
                            .fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column {
                            Text(text = contacto.nombre, style = MaterialTheme.typography.titleMedium)
                            Text(text = "Dir: ${contacto.direccion}", style = MaterialTheme.typography.bodyMedium)
                            Text(text = contacto.correo, style = MaterialTheme.typography.bodySmall)
                        }
                        IconButton(onClick = { viewModel.deleteContacto(contacto) }) {
                            Icon(
                                imageVector = Icons.Default.Delete,
                                contentDescription = "Eliminar",
                                tint = Color.Red
                            )
                        }
                    }
                }
            }
        }
    }
}

@Composable
fun RetrofitWeatherScreen(viewModel: WeatherViewModel = viewModel()) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        verticalArrangement = Arrangement.spacedBy(20.dp),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Icon(
            imageVector = Icons.Default.LocationOn,
            contentDescription = null,
            modifier = Modifier.size(64.dp),
            tint = MaterialTheme.colorScheme.primary
        )

        Text(
            text = "Consumo de API de Clima Local",
            style = MaterialTheme.typography.titleLarge
        )

        Text(
            text = "Esta demo consulta el endpoint de pruebas local (localhost / 10.0.2.2) exponiendo la respuesta.",
            style = MaterialTheme.typography.bodyMedium,
            textAlign = TextAlign.Center
        )

        Card(
            modifier = Modifier
                .fillMaxWidth()
                .weight(1f),
            colors = CardDefaults.cardColors(
                containerColor = if (viewModel.isError) Color(0xFFFFEBEE) else MaterialTheme.colorScheme.surfaceVariant
            )
        ) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(16.dp),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = viewModel.weatherResponse,
                    style = MaterialTheme.typography.bodyMedium,
                    color = if (viewModel.isError) Color.Red else Color.Unspecified
                )
            }
        }

        Button(
            onClick = { viewModel.fetchWeatherForecast() },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Consultar Endpoint")
        }
    }
}
