package com.curso.tarea3

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                Surface(modifier = Modifier.fillMaxSize(), color = MaterialTheme.colorScheme.background) {
                    AppNavigation()
                }
            }
        }
    }
}

enum class Screen {
    MENU, DETAIL
}

data class Producto(val nombre: String, val precio: Double, var cantidad: Int)

@Composable
fun AppNavigation() {
    var currentScreen by remember { mutableStateOf(Screen.MENU) }
    
    val productos = remember {
        mutableStateListOf(
            Producto("Tacos al Pastor", 18.0, 0),
            Producto("Gringa de Queso", 35.0, 0),
            Producto("Refresco de Vidrio", 20.0, 0),
            Producto("Quesadilla de Harina", 22.0, 0)
        )
    }
    var propinaPercent by remember { mutableStateOf(0) }

    when (currentScreen) {
        Screen.MENU -> PedidoMenuScreen(
            listaProductos = productos,
            onGoToTotal = { currentScreen = Screen.DETAIL }
        )
        Screen.DETAIL -> PedidoDetailScreen(
            listaProductos = productos,
            propinaPercent = propinaPercent,
            onSelectPropina = { propinaPercent = it },
            onBack = { currentScreen = Screen.MENU }
        )
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PedidoMenuScreen(listaProductos: List<Producto>, onGoToTotal: () -> Unit) {
    Scaffold(
        topBar = { TopAppBar(title = { Text("Menú de Alimentos") }) },
        bottomBar = {
            Button(
                onClick = onGoToTotal,
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp)
            ) {
                Text("Ver Total Pedido")
            }
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            items(listaProductos) { prod ->
                var qty by remember { mutableStateOf(prod.cantidad) }
                Card(modifier = Modifier.fillMaxWidth()) {
                    Row(
                        modifier = Modifier
                            .padding(16.dp)
                            .fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween,
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Column {
                            Text(prod.nombre, style = MaterialTheme.typography.titleMedium)
                            Text(String.format("$%.2f c/u", prod.precio), style = MaterialTheme.typography.bodyMedium)
                        }
                        Row(verticalAlignment = Alignment.CenterVertically) {
                            Button(
                                onClick = { if(qty > 0) { qty--; prod.cantidad = qty } },
                                contentPadding = PaddingValues(1.dp),
                                modifier = Modifier.size(36.dp)
                            ) {
                                Text("-")
                            }
                            Text("$qty", modifier = Modifier.padding(horizontal = 12.dp), style = MaterialTheme.typography.titleMedium)
                            Button(
                                onClick = { qty++; prod.cantidad = qty },
                                contentPadding = PaddingValues(1.dp),
                                modifier = Modifier.size(36.dp)
                            ) {
                                Text("+")
                            }
                        }
                    }
                }
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun PedidoDetailScreen(
    listaProductos: List<Producto>,
    propinaPercent: Int,
    onSelectPropina: (Int) -> Unit,
    onBack: () -> Unit
) {
    val itemsFiltrados = listaProductos.filter { it.cantidad >= 1 }
    val subtotal = itemsFiltrados.sumOf { it.precio * it.cantidad }
    val propina = subtotal * (propinaPercent.toDouble() / 100.0)
    val total = subtotal + propina

    Scaffold(
        topBar = { TopAppBar(title = { Text("Detalle de Cuenta") }) }
    ) { padding ->
        Column(
            modifier = Modifier
                .padding(padding)
                .fillMaxSize()
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            Text("Productos Solicitados (1 o más):", style = MaterialTheme.typography.titleMedium)
            
            LazyColumn(modifier = Modifier.weight(1f).fillMaxWidth()) {
                items(itemsFiltrados) { p ->
                    Row(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(vertical = 4.dp),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Text("${p.cantidad}x ${p.nombre}")
                        Text(String.format("$%.2f", p.precio * p.cantidad))
                    }
                }
            }

            Divider()

            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                Text("Subtotal:")
                Text(String.format("$%.2f", subtotal))
            }

            Text("Agregar Propina:")
            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceEvenly) {
                Button(
                    onClick = { onSelectPropina(0) },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = if(propinaPercent == 0) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surfaceVariant,
                        contentColor = if(propinaPercent == 0) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                ) {
                    Text("0%")
                }
                Button(
                    onClick = { onSelectPropina(10) },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = if(propinaPercent == 10) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surfaceVariant,
                        contentColor = if(propinaPercent == 10) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                ) {
                    Text("10%")
                }
                Button(
                    onClick = { onSelectPropina(15) },
                    colors = ButtonDefaults.buttonColors(
                        containerColor = if(propinaPercent == 15) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surfaceVariant,
                        contentColor = if(propinaPercent == 15) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurfaceVariant
                    )
                ) {
                    Text("15%")
                }
            }

            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                Text("Propina (${propinaPercent}%):")
                Text(String.format("$%.2f", propina))
            }

            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                Text("TOTAL A PAGAR:", style = MaterialTheme.typography.titleMedium)
                Text(String.format("$%.2f", total), style = MaterialTheme.typography.titleLarge)
            }

            Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
                TextButton(onClick = onBack) {
                    Text("Volver a Modificar")
                }
            }
        }
    }
}
