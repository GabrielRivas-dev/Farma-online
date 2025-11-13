<?php

use Illuminate\Support\Facades\Route;

/*
| Ruta de Bienvenida
*/
Route::get('/', function () {
    return view('welcome');
});

/*
|--------------------------------------------------------------------------
| Ruta "Falsa" de Login (Solución al error 'Route [login] not defined')
|--------------------------------------------------------------------------
|
| Esta ruta intercepta la redirección fallida del middleware de autenticación
| y devuelve el error JSON 401 que la API debe enviar.
|
*/
Route::get('login', function () {
    return response()->json([
        'message' => 'Unauthenticated. Debes iniciar sesión para acceder a este recurso.'
    ], 401);
})->name('login'); // <-- El .name('login') es la parte más importante