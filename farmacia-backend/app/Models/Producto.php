<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Producto extends Model
{
    /**
     * Define la relación: Un Producto pertenece a una Categoría.
     */
    public function categoria()
    {
        // Esto le dice a Laravel que busque 'categoria_id' en la tabla 'productos'
        // y lo relacione con la tabla 'categorias'.
        return $this->belongsTo(Categoria::class);
    }
}