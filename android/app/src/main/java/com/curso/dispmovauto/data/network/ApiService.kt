package com.curso.dispmovauto.data.network

import retrofit2.Retrofit
import retrofit2.converter.scalars.ScalarsConverterFactory
import retrofit2.http.GET

// IP especial de Android para conectar al localhost de la PC hospedadora
private const val BASE_URL = "http://10.0.2.2:5149/"

private val retrofit = Retrofit.Builder()
    .addConverterFactory(ScalarsConverterFactory.create())
    .baseUrl(BASE_URL)
    .build()

interface WeatherApiService {
    @GET("weatherforecast")
    suspend fun getWeather(): String
}

object WeatherApi {
    val retrofitService: WeatherApiService by lazy {
        retrofit.create(WeatherApiService::class.java)
    }
}
