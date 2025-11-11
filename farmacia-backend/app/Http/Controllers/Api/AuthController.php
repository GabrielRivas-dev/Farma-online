<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    /**
     * Registra un nuevo usuario.
     */
    public function register(Request $request)
    {
        // Validación de los campos
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255', // 'name' como en tu formulario de Vue [cite: 36]
            'email' => 'required|string|email|max:255|unique:users', // 'unique' en la tabla 'usuarios'
            'password' => 'required|string|min:6|confirmed', // 'confirmed' busca 'password_confirmation'
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        // Creamos el usuario
        $user = User::create([
            'name' => $request->name, // Mapeamos 'name' del form a 'nombre' de la BD [cite: 36, 378]
            'email' => $request->email,
            'password' => Hash::make($request->password), // Hasheamos la contraseña
        ]);

        // Iniciar sesión automáticamente
        Auth::login($user);

        return response()->json($user, 201); // 201 = Creado
    }

    /**
     * Inicia sesión (Login).
     */
    public function login(Request $request)
    {
        // Validación
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        // Intentar autenticar
        if (!Auth::attempt($request->only('email', 'password'))) {
            // Si falla, devolvemos error
            throw ValidationException::withMessages([
                'email' => ['Las credenciales proporcionadas son incorrectas.'],
            ]);
        }

        // Regenerar la sesión
        $request->session()->regenerate();

        // Devolver el usuario autenticado
        return response()->json(Auth::user());
    }

    /**
     * Obtiene el perfil del usuario autenticado.
     */
    public function profile()
    {
        // Auth::user() devuelve el usuario actual (o null si no está logueado)
        return response()->json(Auth::user());
    }

    /**
     * Cierra la sesión (Logout).
     */
    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return response()->json(['message' => 'Sesión cerrada correctamente']);
    }
}