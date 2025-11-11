<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable; // <-- Importante para Auth
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable // <-- Debe extender Authenticatable
{
    use HasFactory, Notifiable;

    /**
     * La tabla asociada con el modelo.
     *
     * @var string
     */
    protected $table = 'users'; // <-- Conecta con tu tabla 'usuarios' 

    /**
     * Los atributos que se pueden asignar masivamente.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name', // <-- Tu campo de la BD 
        'email',
        'password',
    ];

    /**
     * Los atributos que deben ocultarse para la serialización.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Los atributos que deben ser convertidos a tipos nativos.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed', // <-- Le dice a Laravel que el password está hasheado
    ];
}