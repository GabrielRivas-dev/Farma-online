<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ProductoController; // <-- AGREGA ESTA LÍNEA
use App\Http\Controllers\Api\AuthController; // <-- 1. AGREGA ESTA LÍNEA

Route::get('/', function () {
    return view('welcome');
});

// AGREGA ESTA LÍNEA AL FINAL para tu API de productos [cite: 365, 368-377]
Route::get('/api/productos', [ProductoController::class, 'index']);

// Registro
Route::post('/api/register', [AuthController::class, 'register']);

// Login
Route::post('/api/login', [AuthController::class, 'login']);

// Perfil del Usuario (protegido)
Route::get('/api/perfil', [AuthController::class, 'profile'])->middleware('auth');

// Logout (protegido)
Route::post('/api/logout', [AuthController::class, 'logout'])->middleware('auth');