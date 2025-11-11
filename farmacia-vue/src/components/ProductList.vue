<template>
  <section class="productos">
    <div class="container">
      <h2 class="section-title">Nuestros Productos</h2>
      
      <!-- Estado de carga -->
      <div v-if="loading" class="loading">
        <div class="spinner"></div>
        <p>Cargando productos...</p>
      </div>
      
      <!-- Estado de error -->
      <div v-else-if="error" class="error">
        <p>❌ {{ error }}</p>
        <button @click="fetchProductos" class="retry-btn">Reintentar</button>
      </div>
      
      <!-- Productos -->
      <div v-else class="product-grid">
        <div 
          v-for="producto in productos" 
          :key="producto.id" 
          class="product-card"
        >
          <div class="product-image">
            {{ getProductEmoji(producto.categoria || producto.nombre) }}
          </div>
          <h3 class="product-name">{{ producto.nombre }}</h3>
          <p class="product-desc">{{ producto.descripcion }}</p>
          <div class="product-meta">
            <span class="product-price">${{ producto.precio }}</span>
            <span v-if="producto.stock !== undefined" 
                  :class="['product-stock', producto.stock > 0 ? 'in-stock' : 'out-of-stock']">
              {{ producto.stock > 0 ? `Stock: ${producto.stock}` : 'Agotado' }}
            </span>
          </div>
          <button 
            class="add-to-cart"
            @click="$emit('agregar-al-carrito', producto)"
            :disabled="producto.stock === 0"
            :class="{ 'disabled': producto.stock === 0 }"
          >
            {{ producto.stock === 0 ? '❌ Agotado' : '🛒 Agregar al Carrito' }}
          </button>
        </div>
      </div>
      
      <!-- Mensaje si no hay productos -->
      <div v-if="!loading && !error && productos.length === 0" class="no-products">
        <p>No hay productos disponibles en este momento.</p>
      </div>
    </div>
  </section>
</template>

<script>
import api from '@/services/api';

export default {
  name: 'ProductList',
  data() {
    return {
      productos: [],
      loading: false,
      error: null
    }
  },
  async mounted() {
    await this.fetchProductos();
  },
  methods: {
    async fetchProductos() {
      this.loading = true;
      this.error = null;
      
      try {
        const response = await api.get('/products');
        this.productos = response.data;
        console.log('Productos cargados:', this.productos);
      } catch (error) {
        console.error('Error cargando productos:', error);
        this.error = this.getErrorMessage(error);
      } finally {
        this.loading = false;
      }
    },
    
    getErrorMessage(error) {
      if (error.response?.status === 404) {
        return 'No se encontraron productos. Verifica la conexión con el servidor.';
      } else if (error.response?.status === 500) {
        return 'Error del servidor. Intenta más tarde.';
      } else if (error.code === 'NETWORK_ERROR') {
        return 'Error de conexión. Verifica que el servidor esté ejecutándose.';
      } else {
        return 'Error al cargar los productos.';
      }
    },
    
    getProductEmoji(categoria) {
      const emojis = {
        'medicamento': '💊',
        'vitamina': '🧪',
        'cuidado': '🧴',
        'bebe': '👶',
        'primeros': '🩹',
        'default': '🛍️'
      };
      
      if (!categoria) return emojis.default;
      
      categoria = categoria.toLowerCase();
      for (const [key, emoji] of Object.entries(emojis)) {
        if (categoria.includes(key)) return emoji;
      }
      
      return emojis.default;
    }
  }
}
</script>

<style scoped>
.productos {
  padding: 2rem 0;
  background: rgba(248, 250, 252, 0.95);
  width: 100%;
  backdrop-filter: blur(2px);
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

/* Estados de carga y error */
.loading {
  text-align: center;
  padding: 2rem;
}

.spinner {
  border: 4px solid #f3f3f3;
  border-top: 4px solid #2c5aa0;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  animation: spin 1s linear infinite;
  margin: 0 auto 1rem;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.error {
  text-align: center;
  padding: 2rem;
  color: #e53e3e;
}

.retry-btn {
  background: #2c5aa0;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  cursor: pointer;
  margin-top: 1rem;
}

.no-products {
  text-align: center;
  padding: 2rem;
  color: #718096;
}

/* Grid de productos */
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

.product-meta {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.product-price {
  font-size: 1.2rem;
  font-weight: bold;
  color: #2c5aa0;
}

.product-stock {
  font-size: 0.8rem;
  font-weight: 500;
}

.in-stock {
  color: #38a169;
}

.out-of-stock {
  color: #e53e3e;
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

.add-to-cart:hover:not(.disabled) {
  background: linear-gradient(135deg, #38a169, #2f855a);
  transform: scale(1.02);
}

.add-to-cart.disabled {
  background: #cbd5e0;
  cursor: not-allowed;
  transform: none;
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
  
  .product-meta {
    flex-direction: column;
    gap: 0.5rem;
  }
}
</style>