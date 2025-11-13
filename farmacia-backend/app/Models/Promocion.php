<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Promocion extends Model
{
    use HasFactory;
    protected $table = 'promociones'; // Especifica el nombre de tu tabla
    protected $guarded = []; // Permite asignación masiva
    public $timestamps = false; // Tu tabla SQL no tiene created_at/updated_at
}