<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductsTable extends Migration
{
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('sku')->unique();
            $table->unsignedBigInteger('category_id');
            $table->unsignedBigInteger('supplier_id')->nullable();
            $table->string('dosage_form')->nullable();
            $table->string('strength')->nullable();
            $table->string('unit')->default('unidad');
            $table->decimal('price_cost', 10, 2)->nullable();
            $table->decimal('price_sale', 10, 2);
            $table->string('barcode')->nullable()->unique();
            $table->boolean('requires_prescription')->default(false);
            $table->text('description')->nullable();
            $table->integer('stock_min')->default(0);
            $table->timestamps();

            $table->foreign('category_id')->references('id')->on('categories')->onDelete('cascade');
            $table->foreign('supplier_id')->references('id')->on('suppliers')->onDelete('set null');
        });
    }

    public function down()
    {
        Schema::dropIfExists('products');
    }
}