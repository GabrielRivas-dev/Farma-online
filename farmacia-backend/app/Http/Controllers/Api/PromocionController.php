<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Promocion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PromocionController extends Controller
{
    public function index()
    {
        return Promocion::where('activo', true)->get();
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nombre' => 'required|string|max:255',
            'descripcion' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $promocion = Promocion::create($request->all());
        return response()->json($promocion, 201);
    }

    public function show(string $id)
    {
        $promocion = Promocion::find($id);
         if (!$promocion) {
            return response()->json(['message' => 'Promoción no encontrada'], 404);
        }
        return response()->json($promocion);
    }

    public function update(Request $request, string $id)
    {
        $promocion = Promocion::find($id);
        if (!$promocion) {
            return response()->json(['message' => 'Promoción no encontrada'], 404);
        }

        $promocion->update($request->all());
        return response()->json($promocion);
    }

    public function destroy(string $id)
    {
        $promocion = Promocion::find($id);
        if (!$promocion) {
            return response()->json(['message' => 'Promoción no encontrada'], 404);
        }

        $promocion->delete();
        return response()->json(['message' => 'Promoción eliminada']);
    }
}