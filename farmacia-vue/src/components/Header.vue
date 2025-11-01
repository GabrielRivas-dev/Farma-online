<template>
  <header class="header">
    <div class="container">
      <!-- Menú Hamburguesa -->
      <button class="menu-toggle" @click="toggleMenu">
        ☰
      </button>
      
      <!-- Logo -->
      <h1 class="logo">🏥 Farmacia Salud</h1>

      <!-- Barra de Búsqueda -->
      <div class="search-container">
        <div class="search-bar">
          <span class="search-icon">🔍</span>
          <input 
            type="text" 
            v-model="busqueda" 
            placeholder="Buscar medicamentos..." 
            class="search-input"
            @input="buscarAutocompletado"
            @focus="mostrarSugerencias = true"
          >
          <button 
            v-if="busqueda" 
            class="clear-btn" 
            @click="limpiarBusqueda"
          >
            ×
          </button>
        </div>
        
        <!-- Sugerencias de Autocompletado -->
        <div 
          v-if="mostrarSugerencias && sugerencias.length > 0" 
          class="sugerencias-dropdown"
        >
          <div 
            v-for="sugerencia in sugerencias" 
            :key="sugerencia.id"
            class="sugerencia-item"
            @click="seleccionarSugerencia(sugerencia)"
          >
            <span class="sugerencia-emoji">{{ sugerencia.emoji }}</span>
            <div class="sugerencia-info">
              <div class="sugerencia-nombre">{{ sugerencia.nombre }}</div>
              <div class="sugerencia-categoria">{{ sugerencia.categoria }}</div>
            </div>
            <div class="sugerencia-precio">${{ sugerencia.precio }}</div>
          </div>
        </div>
      </div>

      <!-- Botón Filtros -->
      <button class="filter-toggle" @click="toggleFiltros">
        🔧 Filtros
      </button>
      

      <!-- Carrito de Compras -->
      <CartComponent 
        :carrito="carrito"
        @actualizar-cantidad="$emit('actualizar-cantidad', $event)"
        @eliminar-del-carrito="$emit('eliminar-del-carrito', $event)"
        @vaciar-carrito="$emit('vaciar-carrito')"
      />

      <!-- Menú de Navegación (solo desktop) -->
      <nav class="nav">
        <a href="#" class="nav-link">Inicio</a>
        <a href="#" class="nav-link">Medicamentos</a>
      </nav>
    </div>

    <!-- Panel de Filtros -->
    <div class="filtros-panel" :class="{ 'filtros-open': filtrosAbiertos }">
      <div class="filtros-header">
        <h3>🔧 Filtros de Búsqueda</h3>
        <button class="close-btn" @click="cerrarFiltros">×</button>
      </div>
      
      <div class="filtros-content">
        <!-- Filtro por Categoría -->
        <div class="filtro-group">
          <label class="filtro-label">Categoría:</label>
          <select v-model="filtros.categoria" class="filtro-select">
            <option value="">Todas las categorías</option>
            <option value="Analgésicos">Analgésicos</option>
            <option value="Antiinflamatorios">Antiinflamatorios</option>
            <option value="Vitaminas">Vitaminas</option>
            <option value="Antigripales">Antigripales</option>
            <option value="Primeros Auxilios">Primeros Auxilios</option>
            <option value="Equipamiento">Equipamiento</option>
            <option value="Higiene">Higiene</option>
            <option value="Cuidado Personal">Cuidado Personal</option>
            <option value="Cuidado Capilar">Cuidado Capilar</option>
            <option value="Infantil">Infantil</option>
          </select>
        </div>

        <!-- Filtro por Precio -->
        <div class="filtro-group">
          <label class="filtro-label">Rango de Precio:</label>
          <div class="precio-inputs">
            <input 
              type="number" 
              v-model="filtros.precioMin" 
              placeholder="Mínimo" 
              class="filtro-input"
            >
            <span class="precio-separador">-</span>
            <input 
              type="number" 
              v-model="filtros.precioMax" 
              placeholder="Máximo" 
              class="filtro-input"
            >
          </div>
        </div>

        <!-- Botones de Acción -->
        <div class="filtro-actions">
          <button class="btn-aplicar" @click="aplicarFiltros">
            ✅ Aplicar Filtros
          </button>
          <button class="btn-limpiar" @click="limpiarFiltros">
            🗑️ Limpiar
          </button>
        </div>

        <!-- Resultados del Filtro -->
        <div v-if="productosFiltrados.length > 0" class="resultados-filtro">
          <h4>📋 Resultados ({{ productosFiltrados.length }})</h4>
          <div class="resultados-list">
            <div 
              v-for="producto in productosFiltrados" 
              :key="producto.id"
              class="resultado-item"
              @click="seleccionarProducto(producto)"
            >
              <span class="resultado-emoji">{{ producto.emoji }}</span>
              <div class="resultado-info">
                <div class="resultado-nombre">{{ producto.nombre }}</div>
                <div class="resultado-details">
                  {{ producto.categoria }} • ${{ producto.precio }}
                </div>
              </div>
            </div>
          </div>
        </div>

        <div v-else-if="filtrosAplicados" class="sin-resultados">
          😞 No se encontraron productos con los filtros aplicados
        </div>
      </div>
    </div>

    <!-- Menú Lateral -->
    <div class="sidebar" :class="{ 'sidebar-open': menuAbierto }">
      <div class="sidebar-header">
        <h2>🏥 Categorías</h2>
        <button class="close-btn" @click="cerrarMenu">×</button>
      </div>
      
      <nav class="sidebar-nav">
        <div class="nav-section">
          <h3>💊 Medicamentos</h3>
          <a href="#" class="sidebar-link">Analgésicos</a>
          <a href="#" class="sidebar-link">Antibióticos</a>
          <a href="#" class="sidebar-link">Vitaminas</a>
          <a href="#" class="sidebar-link">Antigripales</a>
        </div>
        
        <div class="nav-section">
          <h3>🧴 Cuidado Personal</h3>
          <a href="#" class="sidebar-link">Cuidado de la Piel</a>
          <a href="#" class="sidebar-link">Cuidado Oral</a>
          <a href="#" class="sidebar-link">Cuidado Capilar</a>
          <a href="#" class="sidebar-link">Higiene Personal</a>
        </div>
        
        <div class="nav-section">
          <h3>👶 Infantil</h3>
          <a href="#" class="sidebar-link">Pañales</a>
          <a href="#" class="sidebar-link">Leches Infantiles</a>
          <a href="#" class="sidebar-link">Jarabes Infantiles</a>
        </div>
        
        <div class="nav-section">
          <h3>🔬 Equipamiento</h3>
          <a href="#" class="sidebar-link">Termómetros</a>
          <a href="#" class="sidebar-link">Tensiómetros</a>
          <a href="#" class="sidebar-link">Nebulizadores</a>
        </div>
      </nav>
    </div>

    <!-- Overlay para cerrar menús -->
    <div 
      class="overlay" 
      :class="{ 'overlay-open': menuAbierto || filtrosAbiertos }" 
      @click="cerrarTodosMenus"
    ></div>
  </header>
</template>

<script>
import CartComponent from './cart.vue'

export default {
  name: 'HeaderComponent',
  components: {
    CartComponent
  },
  props: {
    carrito: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      menuAbierto: false,
      busqueda: '',
      mostrarSugerencias: false,
      sugerencias: [],
      filtrosAbiertos: false,
      filtrosAplicados: false,
      filtros: {
        categoria: '',
        precioMin: '',
        precioMax: ''
      },
      todosProductos: [
        {
          id: 1,
          nombre: 'Paracetamol 500mg',
          categoria: 'Analgésicos',
          precio: 8.50,
          emoji: '💊'
        },
        {
          id: 2,
          nombre: 'Ibuprofeno 400mg',
          categoria: 'Antiinflamatorios',
          precio: 10.20,
          emoji: '💊'
        },
        {
          id: 3,
          nombre: 'Jarabe para la Tos',
          categoria: 'Antigripales',
          precio: 12.00,
          emoji: '🍯'
        },
        {
          id: 4,
          nombre: 'Vitamina C 1000mg',
          categoria: 'Vitaminas',
          precio: 15.75,
          emoji: '🍊'
        },
        {
          id: 5,
          nombre: 'Curitas Antisépticas',
          categoria: 'Primeros Auxilios',
          precio: 5.25,
          emoji: '🩹'
        },
        {
          id: 6,
          nombre: 'Termómetro Digital',
          categoria: 'Equipamiento',
          precio: 22.00,
          emoji: '🌡️'
        },
        {
          id: 7,
          nombre: 'Alcohol en Gel 500ml',
          categoria: 'Higiene',
          precio: 9.80,
          emoji: '🧴'
        },
        {
          id: 8,
          nombre: 'Protector Solar FPS 50',
          categoria: 'Cuidado Personal',
          precio: 18.50,
          emoji: '☀️'
        },
        {
          id: 9,
          nombre: 'Shampoo Anticaspa',
          categoria: 'Cuidado Capilar',
          precio: 12.30,
          emoji: '🧴'
        },
        {
          id: 10,
          nombre: 'Pañales Talla M',
          categoria: 'Infantil',
          precio: 25.00,
          emoji: '👶'
        }
      ]
    }
  },
  computed: {
    productosFiltrados() {
      if (!this.filtrosAplicados) return [];

      return this.todosProductos.filter(producto => {
        // Filtro por categoría
        if (this.filtros.categoria && producto.categoria !== this.filtros.categoria) {
          return false;
        }

        // Filtro por precio mínimo
        if (this.filtros.precioMin && producto.precio < parseFloat(this.filtros.precioMin)) {
          return false;
        }

        // Filtro por precio máximo
        if (this.filtros.precioMax && producto.precio > parseFloat(this.filtros.precioMax)) {
          return false;
        }

        return true;
      });
    }
  },
  methods: {
    toggleMenu() {
      this.menuAbierto = !this.menuAbierto;
      if (this.menuAbierto) this.filtrosAbiertos = false;
    },
    cerrarMenu() {
      this.menuAbierto = false;
    },
    toggleFiltros() {
      this.filtrosAbiertos = !this.filtrosAbiertos;
      if (this.filtrosAbiertos) this.menuAbierto = false;
    },
    cerrarFiltros() {
      this.filtrosAbiertos = false;
    },
    cerrarTodosMenus() {
      this.menuAbierto = false;
      this.filtrosAbiertos = false;
      this.mostrarSugerencias = false;
    },
    buscarAutocompletado() {
      if (this.busqueda.trim().length === 0) {
        this.sugerencias = [];
        return;
      }
      
      const busquedaLower = this.busqueda.toLowerCase();
      this.sugerencias = this.todosProductos.filter(producto =>
        producto.nombre.toLowerCase().includes(busquedaLower) ||
        producto.categoria.toLowerCase().includes(busquedaLower)
      ).slice(0, 5);
    },
    seleccionarSugerencia(sugerencia) {
      this.busqueda = sugerencia.nombre;
      this.mostrarSugerencias = false;
      this.realizarBusqueda(sugerencia.nombre);
    },
    realizarBusqueda(termino) {
      console.log('Buscando:', termino);
      // Aquí puedes integrar con tu lógica principal de búsqueda
    },
    limpiarBusqueda() {
      this.busqueda = '';
      this.sugerencias = [];
      this.mostrarSugerencias = false;
    },
    aplicarFiltros() {
      this.filtrosAplicados = true;
      this.cerrarFiltros();
    },
    limpiarFiltros() {
      this.filtros = {
        categoria: '',
        precioMin: '',
        precioMax: ''
      };
      this.filtrosAplicados = false;
    },
    seleccionarProducto(producto) {
      this.busqueda = producto.nombre;
      this.filtrosAbiertos = false;
      this.realizarBusqueda(producto.nombre);
    }
  },
  mounted() {
    this.clickHandler = (e) => {
      if (!this.$el.contains(e.target)) {
        this.mostrarSugerencias = false;
      }
    };
    document.addEventListener('click', this.clickHandler);
  },
  beforeUnmount() {
    document.removeEventListener('click', this.clickHandler);
  }
}
</script>

<style scoped>
.header {
  background: linear-gradient(135deg, #2c5aa0, #1e3a8a);
  color: white;
  padding: 1rem 0;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  width: 100%;
  z-index: 1000;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  padding: 0 1rem;
  gap: 1rem;
}

/* Menú Hamburguesa */
.menu-toggle {
  background: none;
  border: none;
  color: white;
  font-size: 1.5rem;
  cursor: pointer;
  padding: 0.5rem;
  border-radius: 5px;
  transition: background-color 0.3s ease;
  flex-shrink: 0;
}

.menu-toggle:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.logo {
  margin: 0;
  font-size: 1.5rem;
  font-weight: bold;
  white-space: nowrap;
  flex-shrink: 0;
}

/* Botón Filtros */
.filter-toggle {
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid rgba(255, 255, 255, 0.3);
  color: white;
  padding: 0.5rem 1rem;
  border-radius: 20px;
  cursor: pointer;
  font-size: 0.9rem;
  transition: all 0.3s ease;
  flex-shrink: 0;
  white-space: nowrap;
}

.filter-toggle:hover {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.5);
}

/* Barra de Búsqueda */
.search-container {
  position: relative;
  flex: 1;
  max-width: 500px;
  margin: 0 1rem;
}

.search-bar {
  display: flex;
  align-items: center;
  background: white;
  border-radius: 25px;
  padding: 0.5rem 1rem;
  box-shadow: 0 2px 10px rgba(0,0,0,0.1);
  border: 2px solid transparent;
  transition: all 0.3s ease;
}

.search-bar:focus-within {
  border-color: #48bb78;
  box-shadow: 0 2px 15px rgba(72, 187, 120, 0.2);
}

.search-icon {
  font-size: 1rem;
  margin-right: 0.5rem;
  color: #718096;
}

.search-input {
  flex: 1;
  border: none;
  padding: 0.5rem 0;
  font-size: 0.9rem;
  outline: none;
  background: transparent;
  color: #2d3748;
}

.search-input::placeholder {
  color: #a0aec0;
}

.clear-btn {
  background: none;
  border: none;
  color: #718096;
  font-size: 1.2rem;
  cursor: pointer;
  padding: 0;
  width: 20px;
  height: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
}

.clear-btn:hover {
  background: #e2e8f0;
}

/* Sugerencias */
.sugerencias-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  border-radius: 10px;
  box-shadow: 0 5px 20px rgba(0,0,0,0.15);
  margin-top: 0.5rem;
  overflow: hidden;
  z-index: 1002;
}

.sugerencia-item {
  display: flex;
  align-items: center;
  padding: 0.8rem;
  cursor: pointer;
  border-bottom: 1px solid #f7fafc;
  gap: 0.8rem;
}

.sugerencia-item:hover {
  background: #f7fafc;
}

.sugerencia-emoji {
  font-size: 1.3rem;
  width: 30px;
  text-align: center;
}

.sugerencia-info {
  flex: 1;
}

.sugerencia-nombre {
  font-weight: 600;
  color: #2d3748;
  font-size: 0.9rem;
}

.sugerencia-categoria {
  font-size: 0.8rem;
  color: #718096;
}

.sugerencia-precio {
  font-weight: bold;
  color: #48bb78;
  font-size: 0.9rem;
}

/* Navegación */
.nav {
  display: flex;
  gap: 1rem;
  flex-shrink: 0;
}

.nav-link {
  color: white;
  text-decoration: none;
  font-weight: 500;
  padding: 0.5rem 1rem;
  border-radius: 5px;
  transition: all 0.3s ease;
  white-space: nowrap;
  font-size: 0.9rem;
}

.nav-link:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

/* Panel de Filtros */
.filtros-panel {
  position: fixed;
  top: 0;
  right: -350px;
  width: 350px;
  height: 100vh;
  background: white;
  box-shadow: -2px 0 10px rgba(0,0,0,0.1);
  transition: right 0.3s ease;
  z-index: 1001;
  overflow-y: auto;
}

.filtros-open {
  right: 0;
}

.filtros-header {
  background: linear-gradient(135deg, #48bb78, #38a169);
  color: white;
  padding: 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.filtros-header h3 {
  margin: 0;
  font-size: 1.2rem;
}

.filtros-content {
  padding: 1.5rem;
}

.filtro-group {
  margin-bottom: 1.5rem;
}

.filtro-label {
  display: block;
  font-weight: 600;
  color: #2d3748;
  margin-bottom: 0.5rem;
  font-size: 0.9rem;
}

.filtro-select {
  width: 100%;
  padding: 0.7rem;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  font-size: 0.9rem;
  transition: border-color 0.3s ease;
}

.filtro-select:focus {
  outline: none;
  border-color: #48bb78;
}

.precio-inputs {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.filtro-input {
  flex: 1;
  padding: 0.7rem;
  border: 2px solid #e2e8f0;
  border-radius: 8px;
  font-size: 0.9rem;
  transition: border-color 0.3s ease;
}

.filtro-input:focus {
  outline: none;
  border-color: #48bb78;
}

.precio-separador {
  color: #718096;
  font-weight: bold;
}

.filtro-actions {
  display: flex;
  gap: 0.5rem;
  margin: 1.5rem 0;
}

.btn-aplicar {
  flex: 2;
  background: #48bb78;
  color: white;
  border: none;
  padding: 0.8rem;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.btn-aplicar:hover {
  background: #38a169;
}

.btn-limpiar {
  flex: 1;
  background: #e53e3e;
  color: white;
  border: none;
  padding: 0.8rem;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 600;
  transition: background-color 0.3s ease;
}

.btn-limpiar:hover {
  background: #c53030;
}

.resultados-filtro {
  margin-top: 1.5rem;
  border-top: 2px solid #e2e8f0;
  padding-top: 1.5rem;
}

.resultados-filtro h4 {
  color: #2d3748;
  margin-bottom: 1rem;
  font-size: 1rem;
}

.resultados-list {
  max-height: 300px;
  overflow-y: auto;
}

.resultado-item {
  display: flex;
  align-items: center;
  padding: 0.8rem;
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  margin-bottom: 0.5rem;
  cursor: pointer;
  transition: all 0.3s ease;
  gap: 0.8rem;
}

.resultado-item:hover {
  background: #f7fafc;
  border-color: #48bb78;
}

.resultado-emoji {
  font-size: 1.2rem;
  width: 25px;
  text-align: center;
}

.resultado-info {
  flex: 1;
}

.resultado-nombre {
  font-weight: 600;
  color: #2d3748;
  font-size: 0.9rem;
}

.resultado-details {
  font-size: 0.8rem;
  color: #718096;
}

.sin-resultados {
  text-align: center;
  color: #718096;
  padding: 2rem;
  font-style: italic;
}

/* Menú Lateral */
.sidebar {
  position: fixed;
  top: 0;
  left: -350px;
  width: 350px;
  height: 100vh;
  background: white;
  box-shadow: 2px 0 10px rgba(0,0,0,0.1);
  transition: left 0.3s ease;
  z-index: 1001;
  overflow-y: auto;
}

.sidebar-open {
  left: 0;
}

.sidebar-header {
  background: linear-gradient(135deg, #2c5aa0, #1e3a8a);
  color: white;
  padding: 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.sidebar-header h2 {
  margin: 0;
  font-size: 1.3rem;
}

.close-btn {
  background: none;
  border: none;
  color: white;
  font-size: 2rem;
  cursor: pointer;
  padding: 0;
  width: 30px;
  height: 30px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.sidebar-nav {
  padding: 1.5rem;
}

.nav-section {
  margin-bottom: 2rem;
}

.nav-section h3 {
  color: #2c5aa0;
  margin-bottom: 1rem;
  font-size: 1.1rem;
  border-bottom: 2px solid #e2e8f0;
  padding-bottom: 0.5rem;
}

.sidebar-link {
  display: block;
  color: #4a5568;
  text-decoration: none;
  padding: 0.7rem 0;
  border-bottom: 1px solid #f7fafc;
  transition: all 0.3s ease;
}

.sidebar-link:hover {
  color: #2c5aa0;
  padding-left: 0.5rem;
  background-color: #f7fafc;
}

/* Overlay */
.overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.5);
  opacity: 0;
  visibility: hidden;
  transition: all 0.3s ease;
  z-index: 1000;
}

.overlay-open {
  opacity: 1;
  visibility: visible;
}

/* Responsive */
@media (max-width: 768px) {
  .nav {
    display: none;
  }
  
  .search-container {
    margin: 0 0.5rem;
    max-width: 300px;
  }
  
  .logo {
    font-size: 1.3rem;
  }

  .filter-toggle {
    padding: 0.4rem 0.8rem;
    font-size: 0.8rem;
  }

  .filtros-panel {
    width: 280px;
    right: -280px;
  }
}

@media (max-width: 480px) {
  .container {
    padding: 0 0.5rem;
    gap: 0.5rem;
  }
  
  .logo {
    font-size: 1.2rem;
  }
  
  .search-container {
    max-width: 200px;
  }
  
  .search-bar {
    padding: 0.4rem 0.8rem;
  }
  
  .search-input {
    font-size: 0.8rem;
  }
  
  .sidebar {
    width: 280px;
    left: -280px;
  }

  .filter-toggle {
    font-size: 0.7rem;
    padding: 0.3rem 0.6rem;
  }
}
</style>p