<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Cross-Origin Resource Sharing (CORS) Configuration
    |--------------------------------------------------------------------------
    |
    | Here you may configure your settings for cross-origin resource sharing
    | or "CORS". This determines what cross-origin operations may execute
    | in web browsers. You are free to adjust these settings as needed.
    |
    | To learn more: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
    |
    */

    'paths' => ['api/*', 'sanctum/csrf-cookie'],

    'allowed_methods' => ['*'],

    /*
    |--------------------------------------------------------------------------
    | CAMBIO 1: Reemplaza '*' con la URL de tu app de Vue
    |--------------------------------------------------------------------------
    */
    'allowed_origins' => [
        'http://localhost:8080', // Puerto común de Vue 2/3
        'http://localhost:5173', // Puerto común de Vite (Vue 3)
        // 'http://localhost:3000', // Puerto común de React
    ],

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    /*
    |--------------------------------------------------------------------------
    | CAMBIO 2: Pon esto en 'true' para permitir el login
    |--------------------------------------------------------------------------
    */
    'supports_credentials' => true,

];