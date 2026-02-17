<template>
  <section class="products-section">
    <div class="container">
      <!-- ENCABEZADO CON CONTADOR DINÁMICO -->
      <div class="section-header">
        <h2 class="section-title">
          {{ showAllProducts ? 'Todos Nuestros Productos' : 'Productos Destacados' }}
          <span class="product-count">({{ displayedCount }})</span>
        </h2>

      <div class="filters-section">
          <span class="filters-label">Filtros</span>
          <select class="filter-select" v-model="categoriaLocal" @change="$emit('filter-category', categoriaLocal)">
            <option value="">Todas las categorías</option>
            <option value="aseo-personal">Aseo Personal</option>
            <option value="analgesicos">Analgésicos</option> <option value="antigripales">Antigripales</option>
            <option value="vitaminas">Vitaminas</option>
            <option value="primeros-auxilios">Primeros Auxilios</option>
            <option value="equipamiento">Equipamiento</option>
          </select>
        </div>

        <button 
          v-if="showAllProducts" 
          class="view-less-btn"
          @click="$emit('show-limited-products')"
        >
          <i class="fas fa-times"></i> Ver Menos Productos
        </button>
      </div>
    

      <!-- GRILLA DE PRODUCTOS -->
      <div class="products-grid">
        <div 
          class="product-card" 
          v-for="product in products" 
          :key="product.id"
        >
          <!-- CORAZÓN DE FAVORITOS -->
          <button 
            class="favorite-btn" 
            :class="{ active: isFavorite(product.id) }"
            @click="toggleFavorite(product)"
            :title="isFavorite(product.id) ? 'Quitar de favoritos' : 'Agregar a favoritos'"
          >
            <i class="fas fa-heart"></i>
          </button>

          <div class="product-image-container">
            <img :src="product.image" :alt="product.name" class="product-image">
          </div>
          
          <div class="product-info">
            <h3 class="product-name">{{ product.name }}</h3>
            <p class="product-description">{{ product.description }}</p>
            
            <div class="product-price-section">
              <span class="product-price">${{ product.price }}</span>
              
              <div class="product-actions">
                <!-- BOTÓN AGREGAR AL CARRITO -->
                <button class="add-to-cart" @click="$emit('add-to-cart', product)">
                  <i class="fas fa-cart-plus"></i>
                  Agregar
                </button>
                
                <!-- BOTÓN ESCRIBIR RESEÑA -->
                <button 
                  class="write-review" 
                  @click="$emit('write-review', product)"
                  title="Escribir reseña"
                >
                  <i class="fas fa-star"></i> Reseñar
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- MENSAJE CUANDO NO HAY PRODUCTOS -->
      <div v-if="products.length === 0" class="no-products">
        <p>No se encontraron productos.</p>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'ProductList',
  props: {
    products: {
      type: Array,
      required: true
    },
    favoriteProducts: {
      type: Array,
      default: () => []
    },
    showAllProducts: {
      type: Boolean,
      default: false
    },
    totalProducts: {
      type: Number,
      default: 0
    },
    displayedCount: {
      type: Number,
      default: 0
    },
    selectedCategory: {  // ← Prop para el filtro
      type: String,
      default: ''
    }
  },
  // ⚠️ IMPORTANTE: NO declarar selectedCategory en data()
  data() {
    return {
      searchQuery: '',  // ← Solo searchQuery, NO selectedCategory
      categoriaLocal: ''
    }
  },
  methods: {
    emitirFiltro() {
    console.log("1. Hijo: Categoría seleccionada en select:", this.categoriaLocal);
    this.$emit('filter-category', this.categoriaLocal);
  },
    toggleFavorite(product) {
      this.$emit('toggle-favorite', product);
    },
    
    isFavorite(productId) {
      return this.favoriteProducts?.includes(productId) || false;
    }
  }
}
</script>

<style scoped>
.products-section {
  padding: 40px 0;
  background: #f8f9fa;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

/* ENCABEZADO CON CONTADOR */
.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  flex-wrap: wrap;
  gap: 15px;
}

.section-title {
  font-size: 2rem;
  color: #2c3e50;
  font-weight: 700;
  display: flex;
  align-items: center;
  gap: 10px;
  margin: 0;
}

.product-count {
  font-size: 1rem;
  color: #666;
  font-weight: normal;
  background: #e3f2fd;
  padding: 4px 12px;
  border-radius: 20px;
  border: 1px solid #bbdefb;
}

/* BOTÓN VER MENOS */
.view-less-btn {
  background: linear-gradient(135deg, #666, #444);
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: 6px;
  cursor: pointer;
  font-weight: bold;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.3s ease;
  box-shadow: 0 2px 8px rgba(0,0,0,0.2);
}

.view-less-btn:hover {
  background: linear-gradient(135deg, #555, #333);
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.3);
}

/* GRILLA DE PRODUCTOS */
/* Estilos generales para el contenedor de productos */
.products-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 25px;
  padding: 20px;
}

/* Card principal - Estilo mejorado */
.product-card {
  position: relative;
  background: #ffffff;
  border-radius: 14px;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  border: 1px solid #e5e7eb;
  transition: all 0.3s ease;
}

.product-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 12px 25px rgba(30, 58, 138, 0.08);
  border-color: #dbeafe;
}

/* Botón de favoritos mejorado */
.favorite-btn {
  position: absolute;
  top: 12px;
  right: 12px;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  background: white;
  border: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 10;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
  transition: all 0.3s ease;
  color: #ff4757;
  font-size: 1.2rem;
}

.favorite-btn:hover {
  transform: scale(1.15);
  background: #ff4757;
  color: white;
  box-shadow: 0 6px 15px rgba(255, 71, 87, 0.4);
}

.favorite-btn.active {
  background: #ff4757;
  color: white;
  animation: heartbeat 1.5s ease infinite;
}

@keyframes heartbeat {
  0% { transform: scale(1); }
  14% { transform: scale(1.1); }
  28% { transform: scale(1); }
  42% { transform: scale(1.1); }
  70% { transform: scale(1); }
}

/* Contenedor de imagen mejorado */
.product-image-container {
  height: 240px;
  background: #f8fafc;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 20px;
  border-bottom: 1px solid #f1f5f9;
}

.product-image {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  transition: transform 0.3s ease;
}

.product-card:hover .product-image {
  transform: scale(1.04);
}


/* Información del producto */
.product-info {
  padding: 10px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  flex: 1;
  background-color: white;
}


.product-name {
 font-size: 1.1rem;
  font-weight: 600;
  color: #111111;
  line-height: 1.4; 
  margin: 0 0 10px 0;
  transition: color 0.3s ease;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.product-card:hover .product-name {
  color: #3498db;
}

.product-description {
  font-size: 0.88rem;
   color: #6b7280;
  line-height: 1.4;
  margin: 0 0 15px 0;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  overflow: hidden;
  flex: 1;
}

/* Sección de precios y acciones */
.product-price-section {
  margin-top: auto;
  padding-top: 12px;
  border-top: 1px solid #e5e7eb;
}

.product-price {
  font-size: 2rem;
  font-weight: 700;
  color: #16a34a;
}

.product-price::before {
  font-size: 1rem;
  margin-right: 4px;
  color: #94a3b8;
}

/* Contenedor de acciones */
.product-actions {
  display: flex;
  gap: 10px;
}

/* Botón agregar al carrito mejorado */
.add-to-cart {
  flex: 2;
  padding: 11px;
  background: #1e3a8a;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 0.9rem;
  font-weight: 600;
  transition: all 0.25s ease;
}

.add-to-cart:hover {
  background: #2563eb;
  box-shadow: 0 8px 18px rgba(37, 99, 235, 0.25);
}


.add-to-cart:active {
  transform: translateY(0);
}

.add-to-cart i {
  font-size: 1.1rem;
  transition: transform 0.3s ease;
}

.add-to-cart:hover i {
  transform: translateX(3px) scale(1.1);
}

/* Botón escribir reseña mejorado */
.write-review {
  flex: 1;
  padding: 11px;
  background: #f1f5f9;
  border: 1px solid #cbd5e1;
  color: #1e3a8a;
  border-radius: 8px;
  font-size: 0.85rem;
  font-weight: 600;
  transition: all 0.25s ease;
}

.write-review:hover {
  background: #e0f2fe;
  border-color: #2563eb;
}


.write-review:hover i {
  transform: rotate(180deg) scale(1.1);
}

.write-review:active {
  transform: translateY(0);
}

/* Responsive Design */
@media (max-width: 768px) {
  .products-grid {
    grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
    gap: 15px;
    padding: 15px;
  }

  .product-image-container {
    height: 220px;
  }

  .product-name {
    font-size: 1.1rem;
  }

  .product-price {
    font-size: 1.5rem;
  }

  .product-actions {
    flex-direction: column;
  }

  .add-to-cart, .write-review {
    width: 100%;
  }

  .favorite-btn {
    width: 40px;
    height: 40px;
    font-size: 1rem;
    top: 10px;
    right: 10px;
  }
}

/* Pantallas muy pequeñas */
@media (max-width: 480px) {
  .product-image-container {
    height: 200px;
  }

  .product-info {
    padding: 15px;
  }

  .product-name {
    font-size: 1rem;
  }

  .product-description {
    font-size: 0.85rem;
  }
}

/* RESPONSIVE */
@media (max-width: 768px) {
  .section-header {
    flex-direction: column;
    align-items: stretch;
    text-align: center;
  }
  
  .products-grid {
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
  }
  
  .section-title {
    font-size: 1.6rem;
  }
  
  .view-less-btn {
    width: 100%;
    justify-content: center;
  }
}

@media (max-width: 480px) {
  .products-grid {
    grid-template-columns: 1fr;
  }
  
  .product-card {
    padding: 15px;
  }
}
.filters-section {
  display: flex;
  align-items: center;
  gap: 15px;
  background: white;
  padding: 10px 20px;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03); /* Sombra muy sutil */
  border: 1px solid rgba(226, 232, 240, 0.8);
  max-width: fit-content; /* Se ajusta al contenido */
  margin-bottom: 30px; /* Espacio antes de la grilla */
}

/* Etiqueta "Filtros" */
.filters-label {
  font-size: 0.9rem;
  font-weight: 700;
  color: #64748b; /* Gris azulado medio (Slate) */
  text-transform: uppercase;
  letter-spacing: 0.5px;
  display: flex;
  align-items: center;
  gap: 8px;
}

/* Icono decorativo antes de la palabra Filtros (Opcional) */
.filters-label::before {
  content: ''; /* Podrías usar un icono de fontawesome aquí si tienes */
  display: block;
  width: 6px;
  height: 6px;
  background: #3b82f6; /* Azul brillante */
  border-radius: 50%;
  box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.2);
}

/* EL SELECT PERSONALIZADO */
.filter-select {
  /* 1. Resetear estilos nativos feos */
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;
  
  /* 2. Dimensiones y Texto */
  padding: 10px 45px 10px 18px; /* Espacio extra a la derecha para la flecha */
  font-size: 0.95rem;
  font-family: 'Inter', sans-serif;
  color: #1e293b; /* Texto oscuro pero no negro */
  font-weight: 600;
  cursor: pointer;
  background-color: #f8fafc; /* Fondo gris muy pálido */
  
  /* 3. Bordes */
  border: 1px solid #cbd5e1;
  border-radius: 12px;
  
  /* 4. La Magia: Flecha personalizada (SVG encoded) */
  /* Esta es una flecha "Chevron Down" azul */
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%233b82f6' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 15px center;
  background-size: 16px;
  
  /* 5. Transiciones suaves */
  transition: all 0.3s ease;
}

/* Estado Hover (Pasar el mouse) */
.filter-select:hover {
  background-color: #fff;
  border-color: #3b82f6; /* El borde se pone azul */
  box-shadow: 0 4px 12px rgba(59, 130, 246, 0.1); /* Brillo azul suave */
}

/* Estado Focus (Cuando haces clic) */
.filter-select:focus {
  outline: none;
  background-color: #fff;
  border-color: #2563eb;
  /* Anillo de enfoque azul estilo moderno */
  box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.15); 
}

/* RESPONSIVE */
@media (max-width: 600px) {
  .filters-section {
    width: 100%;
    max-width: 100%;
    flex-direction: column; /* Apilar en vertical */
    align-items: flex-start;
    gap: 10px;
  }
  
  .filter-select {
    width: 100%; /* Ocupar todo el ancho en móvil */
  }
}
</style>