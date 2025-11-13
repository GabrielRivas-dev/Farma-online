<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Http\Request;

// --- ¡IMPORTANTE! ---
// Importamos AMBAS clases: la que creamos y la que está en 'vendor'
use App\Http\Middleware\Authenticate as AppAuthenticate;
use Illuminate\Auth\Middleware\Authenticate as VendorAuthenticate;
// --------------------

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php', // ¡Ahora cargamos el archivo api.php!
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) {
        
        $middleware->validateCsrfTokens(except: [
            'api/*' // Excluimos la API de CSRF
        ]);

        $middleware->statefulApi(); // Activamos Sanctum

        // --- ¡LA SOLUCIÓN AL ERROR 500! ---
        // Reemplazamos el middleware de auth por defecto por el nuestro
        $middleware->replace(
            VendorAuthenticate::class,
            AppAuthenticate::class
        );
        // ------------------------------------

    })
    ->withExceptions(function (Exceptions $exceptions) {
        
        // Un "seguro" final por si el reemplazo de middleware falla
        $exceptions->render(function (AuthenticationException $e, Request $request) {
            if ($request->is('api/*')) {
                return response()->json([
                    'message' => 'Unauthenticated (Manejador de Excepción)'
                ], 401);
            }
        });

    })->create();