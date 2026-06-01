package com.curso.dispmovauto.ui

import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.curso.dispmovauto.data.network.WeatherApi
import kotlinx.coroutines.launch

class WeatherViewModel : ViewModel() {
    
    var weatherResponse: String by mutableStateOf("Sin consultar")
        private set
        
    var isError: Boolean by mutableStateOf(false)
        private set

    fun fetchWeatherForecast() {
        weatherResponse = "Cargando..."
        isError = false
        viewModelScope.launch {
            try {
                val response = WeatherApi.retrofitService.getWeather()
                weatherResponse = response
            } catch (e: Exception) {
                isError = true
                weatherResponse = "Fallo de conexión:\n${e.localizedMessage ?: e.message}"
            }
        }
    }
}
