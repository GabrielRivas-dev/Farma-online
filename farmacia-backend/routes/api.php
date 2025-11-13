<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ProductoController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CategoriaController;
use App\Http\Controllers\Api\PromocionController;

/*
|--------------------------------------------------------------------------
| Rutas de Autenticación (Abiertas)
|--------------------------------------------------------------------------
*/
Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);

/*
|--------------------------------------------------------------------------
| Rutas Públicas (Cualquiera puede ver)
|--------------------------------------------------------------------------
*/
// Productos
Route::get('productos', [ProductoController::class, 'index']);
Route::get('productos/{id}', [ProductoController::class, 'show']);

// Categorías
Route::get('categorias', [CategoriaController::class, 'index']);
Route::get('categorias/{id}', [CategoriaController::class, 'show']);

// Promociones
Route::get('promociones', [PromocionController::class, 'index']);
Route::get('promociones/{id}', [PromocionController::class, 'show']);


/*
|--------------------------------------------------------------------------
| Rutas Protegidas (Requieren Login con auth:sanctum)
|--------------------------------------------------------------------------
*/
Route::middleware('auth:sanctum')->group(function () {
    
    // Perfil y Logout
    Route::get('perfil', [AuthController::class, 'profile']);
    Route::post('logout', [AuthController::class, 'logout']);

    // Rutas de escritura de Productos (Crear, Actualizar, Borrar)
    Route::post('productos', [ProductoController::class, 'store']);
    Route::put('productos/{id}', [ProductoController::class, 'update']);
    Route::patch('productos/{id}', [ProductoController::class, 'update']);
    Route::delete('productos/{id}', [ProductoController::class, 'destroy']);

    // Rutas de escritura de Categorías
    Route::post('categorias', [CategoriaController::class, 'store']);
    Route::put('categorias/{id}', [CategoriaController::class, 'update']);
    Route::patch('categorias/{id}', [CategoriaController::class, 'update']);
    Route::delete('categorias/{id}', [CategoriaController::class, 'destroy']);

    // Rutas de escritura de Promociones
    Route::post('promociones', [PromocionController::class, 'store']);
    Route::put('promociones/{id}', [PromocionController::class, 'update']);
    Route::patch('promociones/{id}', [PromocionController::class, 'update']);
    Route::delete('promociones/{id}', [PromocionController::class, 'destroy']);
});