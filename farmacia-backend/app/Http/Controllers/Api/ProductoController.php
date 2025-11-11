<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Producto; // <-- 1. AÑADE ESTA LÍNEA

class ProductoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // 2. AÑADE ESTAS DOS LÍNEAS:
        $productos = Producto::all(); // Obtiene todos los productos de la BD
        return response()->json($productos); // Devuelve los productos como JSON
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        // (Lo dejaremos vacío por ahora)
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        // (Lo dejaremos vacío por ahora)
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        // (Lo dejaremos vacío por ahora)
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        // (Lo dejaremos vacío por ahora)
    }
}