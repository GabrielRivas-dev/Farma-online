<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;
    protected $fillable = [
        'name','sku','category_id','supplier_id',
        'dosage_form','strength','unit','price_cost',
        'price_sale','barcode','description','stock_min','requires_prescription'
    ];

    public function category() { return $this->belongsTo(Category::class); }
    public function supplier() { return $this->belongsTo(Supplier::class); }
    public function stockMovements() { return $this->hasMany(StockMovement::class); }
    public function purchaseItems() { return $this->hasMany(PurchaseItem::class); }
    public function saleItems() { return $this->hasMany(SaleItem::class); }
}