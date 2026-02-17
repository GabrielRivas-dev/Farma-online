<template>
  <div>
    <div class="sidebar-overlay" v-if="active" @click="$emit('close')"></div>
    <aside class="sidebar" :class="{ active: active }">
      <div class="sidebar-header">
        <h3>Menú</h3>
        <button class="close-sidebar" @click="$emit('close')">
          <i class="fas fa-times"></i>
        </button>
      </div>
      
      <div class="sidebar-content">
        <!-- Área de Usuario -->
        <div class="sidebar-section">
          <h4 class="sidebar-title">
            <i class="fas fa-user-circle"></i>
            Área de Usuario
          </h4>
          <ul class="sidebar-menu">
            <!-- NUEVO: MI PERFIL -->
            <li>
              <a href="#" class="sidebar-link" @click.prevent="showUserProfile">
                <i class="fas fa-user"></i> Mi Perfil
              </a>
            </li>
            <!-- FIN NUEVO -->
            
            <li>
              <a href="#" class="sidebar-link" @click.prevent="showOrderHistory">
                <i class="fas fa-shopping-bag"></i> Mis Pedidos
              </a>
            </li>
            
            <!-- ITEM DE FAVORITOS -->
            <li>
              <a href="#" class="sidebar-link" @click.prevent="showFavorites">
                <i class="fas fa-heart"></i> Mis Favoritos
              </a>
            </li>
            
            <!-- Panel Administrativo (solo para admins) -->
            <div v-if="currentUser && currentUser.is_admin" class="admin-section">
              <h4 class="sidebar-title admin-title">
                <i class="fas fa-cog"></i>
                Panel Administrativo
              </h4>
              <ul class="sidebar-menu">
                <li>
                  <a href="#" class="sidebar-link admin-link" @click.prevent="showAdminPanel">
                    <i class="fas fa-tachometer-alt"></i> Dashboard Admin
                  </a>
                </li>
                <li>
                  <a href="#" class="sidebar-link admin-link" @click.prevent="showInventoryManagement">
                    <i class="fas fa-boxes"></i> Gestión de Inventario
                  </a>
                </li>
                <li>
                  <a href="#" class="sidebar-link admin-link" @click.prevent="showAdminChat">
                    <i class="fas fa-headset"></i> Gestión de Chat
                  </a>
                </li>
              </ul>
            </div>
          </ul>
        </div>

        <!-- Chaos AI -->
        <div class="sidebar-section">
          <h4 class="sidebar-title chaos-title">
            <i class="fas fa-robot"></i>
            🤖 Asistente IA
          </h4>
          <ul class="sidebar-menu">
            <li>
              <a href="#" class="sidebar-link chaos-link" @click.prevent="openChaosAI">
                <i class="fas fa-comments"></i> 
                <span>Chat con Chaos AI</span>
                <span class="status-dot"></span>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </aside>

    <!-- Modal Chaos AI -->
    <ChaosAIModal 
      v-if="showChaosModal"
      @close="showChaosModal = false"
    />
  </div>
</template>

<script>
import ChaosAIModal from './ChaosAIModal.vue'

export default {
  name: 'Sidebar',
  components: {
    ChaosAIModal
  },
  props: {
    active: Boolean,
    currentUser: Object
  },
  data() {
    return {
      showChaosModal: false
    }
  },
  methods: {
    // NUEVO MÉTODO: MI PERFIL
    showUserProfile() {
      console.log('👤 Sidebar: Abriendo perfil de usuario')
      this.$emit('show-user-profile')
      this.$emit('close')
    },
    
    showOrderHistory() {
      this.$emit('show-orders')
      this.$emit('close')
    },
    
    showFavorites() {
      console.log('🔘 Botón Mis Favoritos CLICKEADO en Sidebar')
      this.$emit('show-favorites')
      this.$emit('close')
    },
    
    showAdminPanel() {
      console.log('🔘 Botón Panel Admin CLICKEADO en Sidebar - Abriendo nueva pestaña')
      // Abrir admin panel en la misma pestaña
      this.$router.push('/admin')
      // Cerrar el sidebar
      this.$emit('close')
      console.log('✅ Nueva pestaña abierta y sidebar cerrado')
    },
    
    showInventoryManagement() {
      console.log('🟡 CLIC EN Gestión de Inventario - Emitiendo evento');
      this.$emit('show-inventory-management');
      this.$emit('close');
    },

    // NUEVO MÉTODO: GESTIÓN DE CHAT
    showAdminChat() {
      console.log('📞 Sidebar: Abriendo gestión de chat')
      this.$emit('show-admin-chat')
      this.$emit('close')
    },

    // Chaos AI
    openChaosAI() {
      this.showChaosModal = true
      this.$emit('close')
    }
  }
}
</script>

<style scoped>

/* =========================
   1. OVERLAY ULTRA LIGERO
========================= */

.sidebar-overlay {
  position: fixed;
  inset: 0;
  background: rgba(15, 23, 42, 0.45);
  z-index: 2000;

  opacity: 0;
  pointer-events: none;

  transition: opacity 0.25s ease;
}

/* Activación */
.sidebar-overlay.active {
  opacity: 1;
  pointer-events: auto;
}


/* =========================
   2. SIDEBAR GPU SAFE
========================= */

.sidebar {
  position: fixed;
  top: 0;
  left: 0;
  width: 320px;
  height: 100%;
  background: #fff;
  z-index: 2001;

  display: flex;
  flex-direction: column;
  overflow-y: auto;

  /* 🔥 Solo transform (sin translateZ extra) */
  transform: translateX(-100%);
  transition: transform 0.28s cubic-bezier(0.4, 0, 0.2, 1);

  /* 🔥 Solo lo usamos cuando está activo */
}

.sidebar.active {
  transform: translateX(0);
  will-change: transform;
}


/* =========================
   3. HEADER
========================= */

.sidebar-header {
  padding: 1.5rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #f1f5f9;
}


/* =========================
   4. BOTÓN CERRAR
========================= */

.close-sidebar {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  border: none;
  background: #f1f5f9;
  cursor: pointer;

  display: flex;
  align-items: center;
  justify-content: center;

  transition: transform 0.2s ease, background 0.2s ease;
}
.close-sidebar i {
  color: #475569;
  font-size: 1.2rem;
}

.close-sidebar:hover {
  background: #fee2e2;
  transform: rotate(90deg);
}


/* =========================
   5. LINKS OPTIMIZADOS
========================= */

.sidebar-link {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 0.85rem 1.5rem;
  text-decoration: none;
  color: #475569;
  font-weight: 500;

  transition: transform 0.18s ease, background 0.18s ease;
}

.sidebar-link:hover {
  background: #eff6ff;
  transform: translateX(6px);
}


/* =========================
   6. STATUS DOT LIGERO
========================= */

.status-dot {
  width: 8px;
  height: 8px;
  background: #22c55e;
  border-radius: 50%;
  margin-left: auto;

  animation: pulse-light 2s infinite;
}

@keyframes pulse-light {
  0%,100% { opacity: 1; }
  50% { opacity: 0.4; }
}


/* =========================
   7. MOBILE
========================= */

@media (max-width: 480px) {
  .sidebar {
    width: 280px;
  }
}

</style>