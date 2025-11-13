<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Categoria;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class CategoriaController extends Controller
{
    public function index()
    {
        return Categoria::all();
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nombre' => 'required|string|max:100|unique:categorias',
            'slug' => 'required|string|max:100|unique:categorias',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $categoria = Categoria::create($request->all());
        return response()->json($categoria, 201);
    }

    public function show(string $id)
    {
        $categoria = Categoria::find($id);
        if (!$categoria) {
            return response()->json(['message' => 'Categoría no encontrada'], 404);
        }
        return response()->json($categoria);
    }

    public function update(Request $request, string $id)
    {
        $categoria = Categoria::find($id);
        if (!$categoria) {
            return response()->json(['message' => 'Categoría no encontrada'], 404);
        }
        
        $validator = Validator::make($request->all(), [
            'nombre' => 'sometimes|string|max:100|unique:categorias,nombre,' . $id,
            'slug' => 'sometimes|string|max:100|unique:categorias,slug,' . $id,
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $categoria->update($request->all());
        return response()->json($categoria);
    }

    public function destroy(string $id)
    {
        $categoria = Categoria::find($id);
        if (!$categoria) {
            return response()->json(['message' => 'Categoría no encontrada'], 404);
        }
        
        $categoria->delete();
        return response()->json(['message' => 'Categoría eliminada']);
    }
}