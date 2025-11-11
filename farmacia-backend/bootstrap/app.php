<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware) { // <-- Tu función
        
        // REEMPLAZA EL '//' CON ESTA LÍNEA:
        $middleware->validateCsrfTokens(except: [
            'api/*' // Esto excluye /api/register, /api/login, etc.
        ]);

    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create();