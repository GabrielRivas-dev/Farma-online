<template>
  <section class="productos">
    <div class="container">
      <h2 class="section-title">Nuestros Productos</h2>
      <div class="product-grid">
        <div 
          v-for="producto in productos" 
          :key="producto.id" 
          class="product-card"
        >
          <div class="product-image">
            {{ producto.emoji }}
          </div>
          <h3 class="product-name">{{ producto.nombre }}</h3>
          <p class="product-desc">{{ producto.descripcion }}</p>
          <div class="product-price">${{ producto.precio }}</div>
          <button 
            class="add-to-cart"
            @click="$emit('agregar-al-carrito', producto)"
          >
            🛒 Agregar al Carrito
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'ProductList',
  props: {
    productos: {
      type: Array,
      default: () => []
    }
  }
}
</script>

<style scoped>
.productos {
  padding: 2rem 0;
  background: rgba(248, 250, 252, 0.95); /* ← Fondo semitransparente blanco */
  width: 100%;
  backdrop-filter: blur(2px); /* ← Efecto de desenfoque sutil */
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
}

.section-title {
  text-align: center;
  font-size: 2rem;
  margin-bottom: 2rem;
  color: #2c5aa0;
}

.product-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1.2rem;
  margin-bottom: 2rem;
}

.product-card {
  background: white;
  border-radius: 10px;
  padding: 1rem;
  text-align: center;
  box-shadow: 0 3px 10px rgba(0,0,0,0.08);
  transition: all 0.3s ease;
  border: 1px solid #f1f5f9;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.product-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 5px 15px rgba(0,0,0,0.12);
}

.product-image {
  font-size: 2.2rem;
  margin-bottom: 0.8rem;
}

.product-name {
  font-size: 0.9rem;
  color: #2d3748;
  margin-bottom: 0.5rem;
  font-weight: 600;
  line-height: 1.3;
}

.product-desc {
  color: #718096;
  margin-bottom: 1rem;
  line-height: 1.4;
  font-size: 0.8rem;
  flex-grow: 1;
}

.product-price {
  font-size: 1.2rem;
  font-weight: bold;
  color: #2c5aa0;
  margin-bottom: 1rem;
}

.add-to-cart {
  background: linear-gradient(135deg, #48bb78, #38a169);
  color: white;
  border: none;
  padding: 0.7rem 1rem;
  border-radius: 20px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 0.85rem;
}

.add-to-cart:hover {
  background: linear-gradient(135deg, #38a169, #2f855a);
  transform: scale(1.02);
}

/* Responsive */
@media (max-width: 1024px) {
  .product-grid {
    grid-template-columns: repeat(3, 1fr);
  }
}

@media (max-width: 768px) {
  .product-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
  }
  
  .section-title {
    font-size: 1.6rem;
  }
}

@media (max-width: 480px) {
  .product-grid {
    grid-template-columns: 1fr;
  }
  
  .section-title {
    font-size: 1.4rem;
  }
}
</style>