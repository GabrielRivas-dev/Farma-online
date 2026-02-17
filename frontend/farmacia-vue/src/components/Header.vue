<template>
  <header class="header">
    <div class="container">
      <div class="header-content">
        <!-- Logo y Menú Hamburguesa -->
        <div class="header-left">
          <button class="menu-toggle" @click="$emit('toggle-menu')">
            <span></span>
            <span></span>
            <span></span>
          </button>
          <div class="logo" @click="goToHome">
            <i class="fas fa-plus-square"></i>
            Farmacia Salud
          </div>
        </div>

        <!-- Barra de Búsqueda -->
        <div class="search-container">
          <div class="search-bar">
            <i class="fas fa-search"></i>
            <input 
              type="text" 
              placeholder="Buscar medicamentos..." 
              v-model="searchQuery"
              @input="$emit('search', searchQuery)"
            >
          </div>
        </div>

        <!-- Navegación Derecha -->
        <div class="header-right">
          <!-- Carrito -->
          <button class="cart-icon" @click="$emit('toggle-cart')">
            <i class="fas fa-shopping-cart"></i>
            <span class="cart-count" v-if="cartCount > 0">{{ cartCount }}</span>
          </button>

          <!-- Usuario no logueado -->
          <button class="login-btn" v-if="!currentUser" @click="$emit('show-login')">
            Iniciar Sesión
          </button>

          <!-- Usuario logueado - VERSIÓN MÁS SIMPLE POSIBLE -->
          <div class="user-menu" v-else>
            <!-- Botón del menú -->
            <button class="user-info" @click="menuAbierto = !menuAbierto">
              <i class="fas fa-user-circle"></i>
              <span>{{ getUserName }}</span>
              <i class="fas fa-chevron-down"></i>
            </button>
            
            <!-- Dropdown - Directo y simple -->
            <div class="dropdown" v-if="menuAbierto">
              <a href="#" @click.prevent="showUserProfile">
                <i class="fas fa-user"></i> Mi Perfil
              </a>
              <a href="#" @click.prevent="showOrderHistory">
                <i class="fas fa-shopping-bag"></i> Mis Pedidos
              </a>
              <a href="#" @click.prevent="showFavorites">
                <i class="fas fa-heart"></i> Favoritos
              </a>
              <hr>
              <a href="#" @click.prevent="$emit('logout')" class="text-red">
                <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  name: 'Header',
  props: {
    cartCount: Number,
    currentUser: Object
  },
  data() {
    return {
      searchQuery: '',
      menuAbierto: false  // Nombre más simple
    }
  },
  computed: {
    getUserName() {
      if (!this.currentUser) return '';
      return this.currentUser.name ? this.currentUser.name.split(' ')[0] : 'Usuario';
    }
  },
  mounted() {
    // Cerrar al hacer clic fuera
    document.addEventListener('click', (e) => {
      if (!this.$el.querySelector('.user-menu')?.contains(e.target)) {
        this.menuAbierto = false;
      }
    });
  },
  methods: {
    showUserProfile() {
      this.menuAbierto = false;
      this.$emit('show-user-profile');
    },
    showOrderHistory() {
      this.menuAbierto = false;
      this.$emit('show-orders');
    },
    showFavorites() {
      this.menuAbierto = false;
      this.$emit('show-favorites');
    },
    goToHome() {
      window.location.href = '/';
    }
  }
}
</script>

<style scoped>
/* ESTILOS MÍNIMOS - Solo lo esencial */
.header {
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  box-shadow: 0 2px 5px rgba(0,0,0,0.1);
  padding: 10px 0;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 20px;
}

.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 15px;
}

.menu-toggle {
  width: 40px;
  height: 40px;
  border: none;
  background: transparent;
  cursor: pointer;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 6px;
}

.menu-toggle span {
  width: 26px;
  height: 4px;
  background: white;
  margin: 0 auto;
}

.logo {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 1.3rem;
  color: #ffffff;
  cursor: pointer;
}

.logo i {
  font-size: 1.8rem;
}

/* Search */
.search-container {
  flex: 1;
  max-width: 500px;
}

.search-bar {
  display: flex;
  align-items: center;
  background: #f5f5f5;
  border-radius: 8px;
  padding: 8px 15px;
}

.search-bar i {
  color: #999;
  margin-right: 10px;
}

.search-bar input {
  flex: 1;
  border: none;
  background: transparent;
  outline: none;
}

/* Header Right */
.header-right {
  display: flex;
  align-items: center;
  gap: 10px;
}

/* Cart */
.cart-icon {
  width: 44px;
  height: 44px;
  background: #f5f5f5;
  border: none;
  border-radius: 8px;
  color: var(--secondary-color);
  font-size: 1.2rem;
  cursor: pointer;
  position: relative;
}

.cart-count {
  position: absolute;
  top: -5px;
  right: -5px;
  background: red;
  color: white;
  font-size: 0.7rem;
  min-width: 18px;
  height: 18px;
  border-radius: 9px;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Login */
.login-btn {
  padding: 8px 20px;
  background: white;
  border: none;
  border-radius: 8px;
  color: var(--secondary-color);
  font-weight: 600;
  cursor: pointer;
  height: 44px;
}

/* User Menu - LO MÁS SIMPLE POSIBLE */
.user-menu {
  position: relative;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 15px;
  background: #f5f5f5;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  height: 44px;
}

.user-info i:first-child {
  color: var(--secondary-color);
  font-size: 1.2rem;
}

.user-info span {
  font-size: 0.9rem;
  color: #333;
}
.user-info i:last-child {
  font-size: 0.8rem;
  color: #0a0a0a;
}

/* DROPDOWN - Forzado a ser visible */
.dropdown {
  position: absolute;
  top: 50px;
  right: 0;
  min-width: 180px;
  background: white;
  border-radius: 8px;
  box-shadow: 0 5px 15px rgba(0,0,0,0.2);
  border: 1px solid #ddd;
  z-index: 99999;
}

.dropdown a {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 12px 15px;
  color: #333;
  text-decoration: none;
  font-size: 0.9rem;
}

.dropdown a:hover {
  background: #f5f5f5;
}

.dropdown a i {
  width: 18px;
  color: #1e3a8a;
}

.dropdown hr {
  margin: 5px 0;
  border: none;
  border-top: 1px solid #eee;
}

.dropdown .text-red {
  color: #dc2626;
}

.dropdown .text-red i {
  color: #dc2626;
}

/* Responsive */
@media (max-width: 768px) {
  .search-container {
    order: 3;
    width: 100%;
    max-width: 100%;
  }
  
  .user-info span {
    display: none;
  }
}
</style>