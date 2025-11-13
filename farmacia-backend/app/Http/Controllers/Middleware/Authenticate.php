<?php

namespace App\Http\Middleware;

use Illuminate\Auth\Middleware\Authenticate as Middleware;
use Illuminate\Http\Request; // <-- Importante

class Authenticate extends Middleware
{
    /**
     * Get the path the user should be redirected to when they are not authenticated.
     */
    protected function redirectTo(Request $request): ?string
    {
        // Si la petición YA espera un JSON, Laravel lo maneja solo.
        if ($request->expectsJson()) {
            return null;
        }

        // ESTA ES LA SOLUCIÓN:
        // Si la petición es un navegador visitando una ruta 'api/'...
        if ($request->is('api/*')) {
            
            // ...no intentes redirigir. Falla con un error JSON 401.
            abort(response()->json(
                ['message' => 'Unauthenticated. Debes iniciar sesión para acceder a este recurso.'], 
                401
            ));
        }

        // Para cualquier otra ruta (que no sea 'api/'), haz lo de siempre.
        return route('login');
    }
}