<template>
  <div id="app">
    <!-- Header -->
    <header class="header">
      <div class="container">
        <div class="header-content">
          <!-- Logo y Menú Hamburguesa -->
          <div class="header-left">
            <div class="menu-toggle" @click="toggleMenu">
              <span></span>
              <span></span>
              <span></span>
            </div>
            <div class="logo">
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
                @input="filterProducts"
              >
            </div>
          </div>

          <!-- Navegación Derecha -->
          <div class="header-right">
            <div class="filters-section">
              <span class="filters-label">Filtros</span>
              <select class="filter-select" v-model="selectedCategory" @change="filterProducts">
               <option value="">Todas las categorías</option>
               <option value="aseo-personal">Aseo Personal</option>
              <option value="medicamentos">Medicamentos</option>
              <option value="cuidado-bebes">Cuidado Bebés</option>
              <option value="cuidado-piel">Cuidado Piel</option>
              <option value="vitaminas">Vitaminas</option>
              <option value="primeros-auxilios">Primeros Auxilios</option>
              <option value="bebidas-alimentos">Bebidas y Alimentos</option>
</select>
            </div>

            <nav class="main-nav">
              <a href="#" class="nav-link">Inicio</a>
              <a href="#" class="nav-link">Medicamentos</a>
            </nav>

            <div class="cart-icon" @click="toggleCart">
              <i class="fas fa-shopping-cart"></i>
              <span class="cart-count">{{ cartItems.length }}</span>
            </div>

            <!-- Solo botón de Iniciar Sesión -->
            <div class="auth-section" v-if="!currentUser">
              <button class="login-btn" @click="showLoginModal = true">
                Iniciar Sesión
              </button>
            </div>

            <!-- Usuario logueado -->
            <div class="user-menu" v-else>
              <div class="user-info">
                <i class="fas fa-user-circle"></i>
                <span class="user-name">Hola, {{ currentUser.name }}</span>
                <div class="user-dropdown">
                  <a href="#" class="dropdown-item"><i class="fas fa-user"></i> Mi Perfil</a>
                  <a href="#" class="dropdown-item"><i class="fas fa-shopping-bag"></i> Mis Pedidos</a>
                  <a href="#" class="dropdown-item"><i class="fas fa-heart"></i> Favoritos</a>
                  <a href="#" class="dropdown-item" @click="logout"><i class="fas fa-sign-out-alt"></i> Cerrar Sesión</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Menú Lateral Hamburguesa -->
    <div class="sidebar-overlay" v-if="menuActive" @click="toggleMenu"></div>
    <aside class="sidebar" :class="{ active: menuActive }">
      <div class="sidebar-header">
        <h3>Menú</h3>
        <button class="close-sidebar" @click="toggleMenu">
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
            <li><a href="#"><i class="fas fa-user"></i> Mi Perfil</a></li>
            <li><a href="#"><i class="fas fa-shopping-bag"></i> Mis Pedidos</a></li>
            <li><a href="#"><i class="fas fa-heart"></i> Favoritos</a></li>
            <li><a href="#"><i class="fas fa-history"></i> Historial</a></li>
          </ul>
        </div>

        <!-- Medicamentos -->
        <div class="sidebar-section">
          <h4 class="sidebar-title">
            <i class="fas fa-pills"></i>
            Medicamentos
          </h4>
          <ul class="sidebar-menu">
            <li><a href="#"><i class="fas fa-capsules"></i> Analgésicos</a></li>
            <li><a href="#"><i class="fas fa-prescription-bottle"></i> Antibióticos</a></li>
            <li><a href="#"><i class="fas fa-heartbeat"></i> Vitaminas</a></li>
            <li><a href="#"><i class="fas fa-band-aid"></i> Cuidado Personal</a></li>
          </ul>
        </div>
      </div>
    </aside>

    <!-- Carousel de Promociones Pequeño -->
    <div class="promotions-carousel" :class="{ hidden: promotionsHidden }">
      <button class="close-promotions" @click="togglePromotions">
        <i class="fas fa-times"></i>
      </button>
      
      <div class="carousel-container">
        <div class="carousel-track" :style="{ transform: `translateX(-${currentPromotion * 100}%)` }">
          <div class="carousel-slide" v-for="(promotion, index) in promotions" :key="promotion.id">
            <div class="promotion-badge">{{ promotion.discount }}</div>
            <img :src="promotion.image" :alt="promotion.name" class="promotion-image">
            <div class="promotion-info">
              <h4>{{ promotion.name }}</h4>
              <p class="promotion-price">
                <span class="old-price">${{ promotion.oldPrice }}</span>
                <span class="new-price">${{ promotion.newPrice }}</span>
              </p>
              <button class="promotion-btn" @click="addToCartFromPromotion(promotion)">
                Agregar
              </button>
            </div>
          </div>
        </div>
        
        <!-- Indicadores -->
        <div class="carousel-indicators">
          <button 
            v-for="(promotion, index) in promotions" 
            :key="index"
            :class="{ active: currentPromotion === index }"
            @click="currentPromotion = index"
          ></button>
        </div>
      </div>
    </div>

    <!-- Contenido Principal -->
    <main class="main-content">
      <!-- Banner Hero -->
      <section class="hero-banner">
        <div class="container">
          <div class="hero-content">
            <h1 class="hero-title">Tu salud es nuestra mayor prioridad</h1>
            <p class="hero-subtitle">Encuentra los mejores productos farmacéuticos con calidad garantizada</p>
            <button class="hero-btn">Ver Productos</button>
          </div>
        </div>
      </section>

      <!-- Sección de Productos -->
      <section class="products-section">
        <div class="container">
          <h2 class="section-title">Nuestros Productos</h2>
          <div class="products-grid">
            <div 
              class="product-card" 
              v-for="product in filteredProducts" 
              :key="product.id"
            >
              <div class="product-image-container">
                <img :src="product.image" :alt="product.name" class="product-image">
                <div class="product-badge" v-if="product.badge">{{ product.badge }}</div>
              </div>
              <div class="product-info">
                <h3 class="product-name">{{ product.name }}</h3>
                <p class="product-description">{{ product.description }}</p>
                <div class="product-price-section">
                  <span class="product-price">${{ product.price }}</span>
                  <button class="add-to-cart" @click="addToCart(product)">
                    Agregar al Carrito
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </main>

    <!-- Footer -->
    <footer class="footer">
      <div class="container">
        <div class="footer-content">
          <div class="footer-section">
            <h3>Farmacia Salud</h3>
            <p>Tu salud es nuestra prioridad. Ofrecemos productos farmacéuticos de calidad con entrega rápida.</p>
          </div>
          <div class="footer-section">
            <h3>Enlaces Rápidos</h3>
            <ul>
              <li><a href="#">Inicio</a></li>
              <li><a href="#">Productos</a></li>
              <li><a href="#">Ofertas</a></li>
              <li><a href="#">Contacto</a></li>
            </ul>
          </div>
          <div class="footer-section">
            <h3>Categorías</h3>
            <ul>
              <li><a href="#">Medicamentos</a></li>
              <li><a href="#">Vitaminas</a></li>
              <li><a href="#">Cuidado Personal</a></li>
              <li><a href="#">Primeros Auxilios</a></li>
            </ul>
          </div>
          <div class="footer-section">
            <h3>Contacto</h3>
            <ul>
              <li><i class="fas fa-map-marker-alt"></i> Dirección: Calle Falsa 123</li>
              <li><i class="fas fa-phone"></i> Teléfono: +1 234 567 890</li>
              <li><i class="fas fa-envelope"></i> Email: info@farmaciasalud.com</li>
            </ul>
          </div>
        </div>
        <div class="footer-bottom">
          <p>&copy; 2024 Farmacia Salud. Todos los derechos reservados.</p>
        </div>
      </div>
    </footer>

    <!-- Modal de Inicio de Sesión -->
    <div class="modal" v-if="showLoginModal" @click="showLoginModal = false">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h2>Iniciar Sesión</h2>
          <button class="close-btn" @click="showLoginModal = false">&times;</button>
        </div>
        <div class="modal-body">
          <form @submit.prevent="login">
            <div class="form-group">
              <label for="email">Email:</label>
              <input type="email" id="email" v-model="loginForm.email" required placeholder="tu@email.com">
            </div>
            <div class="form-group">
              <label for="password">Contraseña:</label>
              <input type="password" id="password" v-model="loginForm.password" required placeholder="••••••••">
            </div>
            <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
            
            <div class="auth-links">
              <p>¿Olvidaste tu contraseña? <a href="#" class="link">Recuperar</a></p>
              <div class="register-prompt">
                <p>¿No tienes cuenta?</p>
                <button type="button" class="btn-register" @click="switchToRegister">
                  Crear Cuenta
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Modal de Registro -->
    <div class="modal" v-if="showRegisterModal" @click="showRegisterModal = false">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h2>Crear Cuenta</h2>
          <button class="close-btn" @click="showRegisterModal = false">&times;</button>
        </div>
        <div class="modal-body">
          <form @submit.prevent="register">
            <div class="form-group">
              <label for="registerName">Nombre Completo:</label>
              <input type="text" id="registerName" v-model="registerForm.name" required placeholder="Tu nombre completo">
            </div>
            <div class="form-group">
              <label for="registerEmail">Email:</label>
              <input type="email" id="registerEmail" v-model="registerForm.email" required placeholder="tu@email.com">
            </div>
            <div class="form-group">
              <label for="registerPassword">Contraseña:</label>
              <input type="password" id="registerPassword" v-model="registerForm.password" required placeholder="Mínimo 6 caracteres">
            </div>
            <div class="form-group">
              <label for="registerConfirmPassword">Confirmar Contraseña:</label>
              <input type="password" id="registerConfirmPassword" v-model="registerForm.confirmPassword" required placeholder="Repite tu contraseña">
            </div>
            <button type="submit" class="btn btn-primary">Registrarse</button>
            
            <div class="auth-links">
              <div class="login-prompt">
                <p>¿Ya tienes cuenta?</p>
                <button type="button" class="btn-login" @click="switchToLogin">
                  Iniciar Sesión
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Modal del Carrito -->
    <div class="modal" v-if="cartVisible" @click="closeCart">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h2>Carrito de Compras</h2>
          <button class="btn btn-primary checkout-btn" @click="startCheckout">
  Proceder al Pago
</button>
        </div>
        <div class="modal-body">
          <div v-if="cartItems.length === 0">
            <p>Tu carrito está vacío</p>
          </div>
          <div v-else>
            <div class="cart-item" v-for="item in cartItems" :key="item.id">
              <img :src="item.image" :alt="item.name" class="cart-item-image">
              <div class="cart-item-details">
                <h3>{{ item.name }}</h3>
                <p>${{ item.price }} x {{ item.quantity }}</p>
              </div>
              <div class="cart-item-actions">
                <button @click="decreaseQuantity(item)">-</button>
                <span>{{ item.quantity }}</span>
                <button @click="increaseQuantity(item)">+</button>
                <button @click="removeFromCart(item)" class="remove-btn">Eliminar</button>
              </div>
            </div>
            <div class="cart-total">
              <h3>Total: ${{ cartTotal }}</h3>
            </div>
            <button class="btn btn-primary checkout-btn">Proceder al Pago</button>
          </div>
        </div>
      </div>
      <!-- Modal de Proceso de Pago -->
<div class="modal" v-if="showPaymentModal" @click="showPaymentModal = false">
  <div class="modal-content payment-modal" @click.stop>
    <div class="modal-header">
      <h2>Proceso de Pago</h2>
      <button class="close-btn" @click="showPaymentModal = false">&times;</button>
    </div>
    <div class="modal-body">
      <!-- Paso 1: Información del Pedido -->
      <div v-if="paymentStep === 1" class="payment-step">
        <h3>Resumen de tu Pedido</h3>
        <div class="order-summary">
          <div class="order-items">
            <div class="order-item" v-for="item in cartItems" :key="item.id">
              <span class="item-name">{{ item.name }}</span>
              <span class="item-quantity">x{{ item.quantity }}</span>
              <span class="item-price">${{ (item.price * item.quantity).toFixed(2) }}</span>
            </div>
          </div>
          <div class="order-total">
            <strong>Total: ${{ cartTotal }}</strong>
          </div>
        </div>
        <button class="btn btn-primary" @click="paymentStep = 2">Continuar con el Pago</button>
      </div>

      <!-- Paso 2: Información de Envío -->
      <div v-if="paymentStep === 2" class="payment-step">
        <h3>Información de Envío</h3>
        <form @submit.prevent="goToPayment">
          <div class="form-group">
            <label for="fullName">Nombre Completo:</label>
            <input type="text" id="fullName" v-model="shippingInfo.fullName" required>
          </div>
          <div class="form-group">
            <label for="address">Dirección:</label>
            <input type="text" id="address" v-model="shippingInfo.address" required>
          </div>
          <div class="form-group">
            <label for="city">Ciudad:</label>
            <input type="text" id="city" v-model="shippingInfo.city" required>
          </div>
          <div class="form-group">
            <label for="phone">Teléfono:</label>
            <input type="tel" id="phone" v-model="shippingInfo.phone" required>
          </div>
          <div class="form-actions">
            <button type="button" class="btn btn-outline" @click="paymentStep = 1">Atrás</button>
            <button type="submit" class="btn btn-primary">Continuar al Pago</button>
          </div>
        </form>
      </div>

      <!-- Paso 3: Método de Pago -->
      <div v-if="paymentStep === 3" class="payment-step">
        <h3>Método de Pago</h3>
        <div class="payment-methods">
          <label class="payment-method">
            <input type="radio" v-model="paymentInfo.method" value="credit-card" required>
            <span class="checkmark"></span>
            💳 Tarjeta de Crédito/Débito
          </label>
          <label class="payment-method">
            <input type="radio" v-model="paymentInfo.method" value="cash" required>
            <span class="checkmark"></span>
            💰 Pago en Efectivo
          </label>
        </div>
        
        <div v-if="paymentInfo.method === 'credit-card'" class="card-info">
          <div class="form-group">
            <label for="cardNumber">Número de Tarjeta:</label>
            <input type="text" id="cardNumber" v-model="paymentInfo.cardNumber" placeholder="1234 5678 9012 3456">
          </div>
          <div class="form-row">
            <div class="form-group">
              <label for="expiryDate">Fecha de Expiración:</label>
              <input type="text" id="expiryDate" v-model="paymentInfo.expiryDate" placeholder="MM/AA">
            </div>
            <div class="form-group">
              <label for="cvv">CVV:</label>
              <input type="text" id="cvv" v-model="paymentInfo.cvv" placeholder="123">
            </div>
          </div>
        </div>

        <div class="form-actions">
          <button type="button" class="btn btn-outline" @click="paymentStep = 2">Atrás</button>
          <button type="button" class="btn btn-primary" @click="processPayment">Pagar ${{ cartTotal }}</button>
        </div>
      </div>

      <!-- Paso 4: Confirmación -->
      <div v-if="paymentStep === 4" class="payment-step confirmation">
        <div class="confirmation-icon">✅</div>
        <h3>¡Pago Exitoso!</h3>
        <p>Tu pedido ha sido procesado correctamente.</p>
        <p><strong>Número de orden:</strong> #{{ orderNumber }}</p>
        <p>Recibirás un correo de confirmación shortly.</p>
        <button class="btn btn-primary" @click="finishPayment">Continuar Comprando</button>
      </div>
    </div>
  </div>
</div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'App',
  data() {
  return {
    menuActive: false,
    cartVisible: false,
    showLoginModal: false,
    showRegisterModal: false,
    
    // NUEVO: Variables para el proceso de pago
    showPaymentModal: false,
    paymentStep: 1,
    orderNumber: null,
    shippingInfo: {
      fullName: '',
      address: '',
      city: '',
      phone: ''
    },
    paymentInfo: {
      method: '',
      cardNumber: '',
      expiryDate: '',
      cvv: ''
    },
    
    searchQuery: '',
    selectedCategory: '',
    
    // Estado de promociones
    promotionsHidden: false,
    currentPromotion: 0,
    carouselInterval: null,
    
    // Estado de usuario
    currentUser: null,
    
    // Formularios
    loginForm: {
      email: '',
      password: ''
    },
    registerForm: {
      name: '',
      email: '',
      password: '',
      confirmPassword: ''
    },
    
    // Productos (tu lista completa)
    products: [
      // ===== ASEO PERSONAL =====
      {
        id: 1,
        name: 'Aceite para bebé Johnson',
        description: 'Hidratación suave para la piel del bebé',
        price: 8.50,
        image: 'https://via.placeholder.com/300x200/FFE0B2/white?text=Aceite+Bebé',
        category: 'aseo-personal',
        badge: 'Esencial'
      },
      {
        id: 2,
        name: 'Algodón estéril',
        description: 'Bolsa de 100 gramos de algodón 100% natural',
        price: 3.20,
        image: 'https://via.placeholder.com/300x200/FFFFFF/333?text=Algodón',
        category: 'aseo-personal',
        badge: 'Más Vendido'
      },
      {
        id: 3,
        name: 'Cepillo dental suave',
        description: 'Cerdas suaves para cuidado dental diario',
        price: 4.80,
        image: 'https://via.placeholder.com/300x200/81D4FA/white?text=Cepillo',
        category: 'aseo-personal'
      },
      {
        id: 4,
        name: 'Champú anticaspa',
        description: 'Control de caspa y picazón en el cuero cabelludo',
        price: 12.50,
        image: 'https://via.placeholder.com/300x200/4FC3F7/white?text=Champú',
        category: 'aseo-personal'
      },
      {
        id: 5,
        name: 'Crema dental blanqueadora',
        description: 'Protección contra caries y blanqueamiento',
        price: 6.75,
        image: 'https://via.placeholder.com/300x200/E1F5FE/333?text=Pasta+Dental',
        category: 'aseo-personal',
        badge: 'Oferta'
      },
      {
        id: 6,
        name: 'Desodorante roll-on',
        description: '48 horas de protección contra el mal olor',
        price: 7.30,
        image: 'https://via.placeholder.com/300x200/F3E5F5/333?text=Desodorante',
        category: 'aseo-personal'
      },
      {
        id: 7,
        name: 'Gel de baño hidratante',
        description: 'Aroma refrescante con vitamina E',
        price: 9.80,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Gel+Baño',
        category: 'aseo-personal'
      },
      {
        id: 8,
        name: 'Hisopos algodón',
        description: 'Paquete con 100 hisopos de algodón',
        price: 2.50,
        image: 'https://via.placeholder.com/300x200/FFF3E0/333?text=Hisopos',
        category: 'aseo-personal',
        badge: 'Esencial'
      },
      {
        id: 9,
        name: 'Jabón líquido manos',
        description: 'Antibacterial con aroma a manzana',
        price: 5.60,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Jabón+Líquido',
        category: 'aseo-personal'
      },
      {
        id: 10,
        name: 'Papel higiénico 12 rollos',
        description: 'Doble hoja suave y resistente',
        price: 15.90,
        image: 'https://via.placeholder.com/300x200/FFF9C4/333?text=Papel+Higienico',
        category: 'aseo-personal',
        badge: 'Más Vendido'
      },
      {
        id: 11,
        name: 'Pañales talla M',
        description: 'Paquete con 36 pañales ultra absorbentes',
        price: 22.50,
        image: 'https://via.placeholder.com/300x200/FCE4EC/333?text=Pañales',
        category: 'cuidado-bebes',
        badge: 'Esencial'
      },
      {
        id: 12,
        name: 'Pañitos húmedos bebé',
        description: 'Toallitas suaves sin alcohol',
        price: 8.20,
        image: 'https://via.placeholder.com/300x200/F3E5F5/333?text=Pañitos',
        category: 'cuidado-bebes'
      },
      {
        id: 13,
        name: 'Protectores diarios',
        description: 'Protección fresca todo el día',
        price: 6.40,
        image: 'https://via.placeholder.com/300x200/FCE4EC/333?text=Protectores',
        category: 'aseo-personal'
      },
      {
        id: 14,
        name: 'Toallas sanitarias',
        description: 'Alas laterales y protección nocturna',
        price: 7.80,
        image: 'https://via.placeholder.com/300x200/FCE4EC/333?text=Toallas+Sanit',
        category: 'aseo-personal',
        badge: 'Esencial'
      },

      // ===== MEDICAMENTOS =====
      {
        id: 15,
        name: 'Paracetamol 500mg',
        description: 'Alivia el dolor y reduce la fiebre',
        price: 5.50,
        image: 'https://via.placeholder.com/300x200/FFEBEE/333?text=Paracetamol',
        category: 'medicamentos',
        badge: 'Más Vendido'
      },
      {
        id: 16,
        name: 'Aspirina 500mg',
        description: 'Alivia dolores leves y moderados',
        price: 8.20,
        image: 'https://via.placeholder.com/300x200/FFEBEE/333?text=Aspirina',
        category: 'medicamentos'
      },
      {
        id: 17,
        name: 'Antiácido Mylanta',
        description: 'Alivia acidez y malestar estomacal',
        price: 12.80,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Antiácido',
        category: 'medicamentos'
      },
      {
        id: 18,
        name: 'Antigripal Theraflu',
        description: 'Alivia síntomas de gripe y resfriado',
        price: 15.50,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Antigripal',
        category: 'medicamentos',
        badge: 'Oferta'
      },
      {
        id: 19,
        name: 'Ibuprofeno 400mg',
        description: 'Antiinflamatorio y analgésico',
        price: 7.90,
        image: 'https://via.placeholder.com/300x200/FFEBEE/333?text=Ibuprofeno',
        category: 'medicamentos'
      },
      {
        id: 20,
        name: 'Laxante suave',
        description: 'Alivia el estreñimiento ocasional',
        price: 9.40,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Laxante',
        category: 'medicamentos'
      },
      {
        id: 21,
        name: 'Loperamida 2mg',
        description: 'Controla la diarrea aguda',
        price: 6.80,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Loperamida',
        category: 'medicamentos'
      },
      {
        id: 22,
        name: 'Naproxeno 250mg',
        description: 'Para dolor e inflamación',
        price: 10.20,
        image: 'https://via.placeholder.com/300x200/FFEBEE/333?text=Naproxeno',
        category: 'medicamentos'
      },
      {
        id: 23,
        name: 'Pastillas garganta',
        description: 'Alivia irritación y dolor de garganta',
        price: 4.50,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Pastillas+Garganta',
        category: 'medicamentos'
      },
      {
        id: 24,
        name: 'Suero rehidratación',
        description: 'Recupera electrolitos perdidos',
        price: 3.20,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Suero+Oral',
        category: 'medicamentos',
        badge: 'Esencial'
      },

      // ===== JARABES =====
      {
        id: 25,
        name: 'Ambroxol expectorante',
        description: 'Ayuda a eliminar la flema',
        price: 14.80,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Ambroxol',
        category: 'medicamentos'
      },
      {
        id: 26,
        name: 'Antitusivo jarabe',
        description: 'Controla la tos seca persistente',
        price: 13.50,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Antitusivo',
        category: 'medicamentos'
      },
      {
        id: 27,
        name: 'Clorfenamina 4mg',
        description: 'Alivia síntomas de alergia',
        price: 8.90,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Clorfenamina',
        category: 'medicamentos'
      },
      {
        id: 28,
        name: 'Guaifenesina',
        description: 'Expectorante para tos con flema',
        price: 12.30,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Guaifenesina',
        category: 'medicamentos'
      },
      {
        id: 29,
        name: 'Jarabe para la tos',
        description: 'Alivia múltiples síntomas de tos',
        price: 11.80,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Jarabe+Tos',
        category: 'medicamentos'
      },

      // ===== CUIDADO DE LA PIEL =====
      {
        id: 30,
        name: 'Protector solar FPS 50',
        description: 'Protección alta contra rayos UV',
        price: 18.50,
        image: 'https://via.placeholder.com/300x200/FFF9C4/333?text=Protector+Solar',
        category: 'cuidado-piel',
        badge: 'Nuevo'
      },
      {
        id: 31,
        name: 'Crema pañalitis',
        description: 'Previene y trata la dermatitis del pañal',
        price: 9.80,
        image: 'https://via.placeholder.com/300x200/FCE4EC/333?text=Crema+Pañalitis',
        category: 'cuidado-bebes'
      },
      {
        id: 32,
        name: 'Crema antimicótica',
        description: 'Tratamiento para infecciones por hongos',
        price: 14.20,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Antimicótica',
        category: 'cuidado-piel'
      },
      {
        id: 33,
        name: 'Hidrocortisona 1%',
        description: 'Alivia picaduras y reacciones alérgicas',
        price: 11.50,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Hidrocortisona',
        category: 'cuidado-piel'
      },
      {
        id: 34,
        name: 'Crema hidratante',
        description: 'Hidratación profunda para piel seca',
        price: 13.80,
        image: 'https://via.placeholder.com/300x200/FCE4EC/333?text=Crema+Hidratante',
        category: 'cuidado-piel'
      },
      {
        id: 35,
        name: 'Repelente insectos',
        description: 'Protección hasta 8 horas',
        price: 12.90,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Repelente',
        category: 'cuidado-piel'
      },

      // ===== CUIDADO BEBÉS =====
      {
        id: 36,
        name: 'Biberón anticólicos',
        description: 'Diseño especial para reducir cólicos',
        price: 8.50,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Biberón',
        category: 'cuidado-bebes'
      },
      {
        id: 37,
        name: 'Crema corporal bebé',
        description: 'Hidratación suave para piel delicada',
        price: 7.90,
        image: 'https://via.placeholder.com/300x200/FCE4EC/333?text=Crema+Bebé',
        category: 'cuidado-bebes'
      },
      {
        id: 38,
        name: 'Leche en polvo etapa 1',
        description: 'Fórmula infantil para 0-6 meses',
        price: 28.50,
        image: 'https://via.placeholder.com/300x200/FFF9C4/333?text=Leche+Polvo',
        category: 'cuidado-bebes',
        badge: 'Esencial'
      },
      {
        id: 39,
        name: 'Talco para bebé',
        description: 'Suaviza y protege la piel del bebé',
        price: 5.60,
        image: 'https://via.placeholder.com/300x200/FFFFFF/333?text=Talco+Bebé',
        category: 'cuidado-bebes'
      },

      // ===== ADULTOS MAYORES =====
      {
        id: 40,
        name: 'Gel analgésico tópico',
        description: 'Alivia dolores musculares y articulares',
        price: 11.80,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Gel+Analgésico',
        category: 'cuidado-piel'
      },
      {
        id: 41,
        name: 'Apósitos estériles',
        description: 'Paquete con 10 apósitos de diferentes tamaños',
        price: 6.90,
        image: 'https://via.placeholder.com/300x200/FFFFFF/333?text=Apósitos',
        category: 'primeros-auxilios'
      },
      {
        id: 42,
        name: 'Cremas dentadura postiza',
        description: 'Fijación segura y cómoda',
        price: 9.40,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Crema+Dentadura',
        category: 'aseo-personal'
      },
      {
        id: 43,
        name: 'Tiras glucosa',
        description: '50 tiras para medir niveles de glucosa',
        price: 45.90,
        image: 'https://via.placeholder.com/300x200/FFEBEE/333?text=Tiras+Glucosa',
        category: 'medicamentos'
      },

      // ===== VITAMINAS =====
      {
        id: 44,
        name: 'Complejo B',
        description: 'Suplemento de vitaminas del grupo B',
        price: 16.80,
        image: 'https://via.placeholder.com/300x200/FFF9C4/333?text=Complejo+B',
        category: 'vitaminas'
      },
      {
        id: 45,
        name: 'Hierro 65mg',
        description: 'Suplemento para prevenir anemia',
        price: 12.50,
        image: 'https://via.placeholder.com/300x200/FFEBEE/333?text=Hierro',
        category: 'vitaminas'
      },
      {
        id: 46,
        name: 'Multivitamínico adulto',
        description: 'Completo suplemento vitamínico',
        price: 22.90,
        image: 'https://via.placeholder.com/300x200/FFF9C4/333?text=Multivitamínico',
        category: 'vitaminas',
        badge: 'Oferta'
      },
      {
        id: 47,
        name: 'Vitamina C 1000mg',
        description: 'Refuerza el sistema inmunológico',
        price: 14.80,
        image: 'https://via.placeholder.com/300x200/FFEBEE/333?text=Vitamina+C',
        category: 'vitaminas'
      },
      {
        id: 48,
        name: 'Vitamina D 1000UI',
        description: 'Esencial para huesos y sistema inmune',
        price: 13.20,
        image: 'https://via.placeholder.com/300x200/FFF9C4/333?text=Vitamina+D',
        category: 'vitaminas'
      },
      {
        id: 49,
        name: 'Probióticos',
        description: 'Mejora la salud digestiva',
        price: 25.50,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Probióticos',
        category: 'vitaminas',
        badge: 'Nuevo'
      },

      // ===== BEBIDAS Y ALIMENTOS =====
      {
        id: 50,
        name: 'Agua mineral 1L',
        description: 'Agua purificada y mineralizada',
        price: 1.20,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Agua+Mineral',
        category: 'bebidas-alimentos'
      },
      {
        id: 51,
        name: 'Bebida isotónica',
        description: 'Recupera electrolitos después del ejercicio',
        price: 2.80,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Bebida+Isotónica',
        category: 'bebidas-alimentos'
      },
      {
        id: 52,
        name: 'Café instantáneo',
        description: 'Frasco de 100g de café soluble',
        price: 6.50,
        image: 'https://via.placeholder.com/300x200/8D6E63/white?text=Café',
        category: 'bebidas-alimentos'
      },
      {
        id: 53,
        name: 'Galletas saladas',
        description: 'Paquete familiar de galletas integrales',
        price: 3.90,
        image: 'https://via.placeholder.com/300x200/FFF9C4/333?text=Galletas+Saladas',
        category: 'bebidas-alimentos'
      },
      {
        id: 54,
        name: 'Jugo de naranja 1L',
        description: 'Jugo 100% natural sin conservantes',
        price: 4.20,
        image: 'https://via.placeholder.com/300x200/FFF9C4/333?text=Jugo+Naranja',
        category: 'bebidas-alimentos'
      },
      {
        id: 55,
        name: 'Leche UHT 1L',
        description: 'Leche entera ultrapasteurizada',
        price: 2.50,
        image: 'https://via.placeholder.com/300x200/FFFFFF/333?text=Leche+UHT',
        category: 'bebidas-alimentos',
        badge: 'Esencial'
      },

      // ===== DULCES Y GOLOSINAS =====
      {
        id: 56,
        name: 'Caramelos de menta',
        description: 'Bolsa con 50 caramelos refrescantes',
        price: 3.80,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Caramelos+Menta',
        category: 'bebidas-alimentos'
      },
      {
        id: 57,
        name: 'Chicles sin azúcar',
        description: 'Sabor menta, paquete con 12 chicles',
        price: 2.90,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Chicles',
        category: 'bebidas-alimentos'
      },
      {
        id: 58,
        name: 'Chocolate negro',
        description: 'Tableta de 100g chocolate 70% cacao',
        price: 5.40,
        image: 'https://via.placeholder.com/300x200/8D6E63/white?text=Chocolate',
        category: 'bebidas-alimentos'
      },
      {
        id: 59,
        name: 'Gomitas frutales',
        description: 'Bolsa de 200g de gomitas surtidas',
        price: 4.60,
        image: 'https://via.placeholder.com/300x200/FFCDD2/333?text=Gomitas',
        category: 'bebidas-alimentos'
      },

      // ===== PRIMEROS AUXILIOS =====
      {
        id: 60,
        name: 'Alcohol etílico 250ml',
        description: 'Antiséptico para limpieza de heridas',
        price: 4.20,
        image: 'https://via.placeholder.com/300x200/E8F5E8/333?text=Alcohol+Etílico',
        category: 'primeros-auxilios',
        badge: 'Esencial'
      },
      {
        id: 61,
        name: 'Curitas variedad',
        description: 'Caja con curitas de diferentes tamaños',
        price: 5.80,
        image: 'https://via.placeholder.com/300x200/FFEBEE/333?text=Curitas',
        category: 'primeros-auxilios'
      },
      {
        id: 62,
        name: 'Gasas estériles',
        description: 'Paquete con 10 gasas estériles',
        price: 3.90,
        image: 'https://via.placeholder.com/300x200/FFFFFF/333?text=Gasas+Estériles',
        category: 'primeros-auxilios'
      },
      {
        id: 63,
        name: 'Guantes desechables',
        description: 'Caja con 50 guantes de látex',
        price: 8.50,
        image: 'https://via.placeholder.com/300x200/FFFFFF/333?text=Guantes',
        category: 'primeros-auxilios'
      },
      {
        id: 64,
        name: 'Termómetro digital',
        description: 'Medición rápida y precisa',
        price: 18.90,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Termómetro',
        category: 'primeros-auxilios',
        badge: 'Más Vendido'
      },
      {
        id: 65,
        name: 'Vendas elásticas',
        description: 'Paquete con 2 vendas de 10cm x 4m',
        price: 7.40,
        image: 'https://via.placeholder.com/300x200/FFFFFF/333?text=Vendas+Elásticas',
        category: 'primeros-auxilios'
      },
      {
        id: 66,
        name: 'Agua oxigenada 100ml',
        description: 'Antiséptico para limpieza de heridas',
        price: 3.50,
        image: 'https://via.placeholder.com/300x200/E3F2FD/333?text=Agua+Oxigenada',
        category: 'primeros-auxilios'
      }
    ],
    filteredProducts: [],
    cartItems: [],
    
    // Array de promociones
    promotions: [
      {
        id: 101,
        name: 'Paracetamol x2',
        description: 'Llévate 2 y paga 1',
        oldPrice: 17.00,
        newPrice: 8.50,
        discount: '50% OFF',
        image: 'https://via.placeholder.com/80x80/4CAF50/white?text=2x1'
      },
      {
        id: 102,
        name: 'Kit Auxilios',
        description: 'Todo en uno',
        oldPrice: 45.00,
        newPrice: 32.00,
        discount: '30% OFF',
        image: 'https://via.placeholder.com/80x80/2196F3/white?text=Kit'
      },
      {
        id: 103,
        name: 'Vitaminas Pack',
        description: 'Completo mensual',
        oldPrice: 60.00,
        newPrice: 45.00,
        discount: '25% OFF',
        image: 'https://via.placeholder.com/80x80/FF9800/white?text=Vitaminas'
      }
    ]
  }
},
  computed: {
  cartTotal() {
    return this.cartItems.reduce((total, item) => {
      return total + (item.price * item.quantity)
    }, 0).toFixed(2)
  }
}, // <-- Esta coma es importante

// AGREGA ESTO DESPUÉS DEL COMPUTED
mounted() {
  this.filterProducts() // Esto hará que los productos aparezcan al cargar
  this.startCarousel()
},
  methods: {
    toggleMenu() {
      this.menuActive = !this.menuActive;
    },

    toggleCart() {
      this.cartVisible = !this.cartVisible;
    },

    closeCart() {
      this.cartVisible = false;
    },

    filterProducts() {
      this.filteredProducts = this.products.filter(product => {
        const matchesSearch = product.name.toLowerCase().includes(this.searchQuery.toLowerCase()) ||
                              product.description.toLowerCase().includes(this.searchQuery.toLowerCase());
        const matchesCategory = !this.selectedCategory || product.category === this.selectedCategory;
        
        return matchesSearch && matchesCategory;
      });
    },

    addToCart(product) {
      const existingItem = this.cartItems.find(item => item.id === product.id);
      
      if (existingItem) {
        existingItem.quantity += 1;
      } else {
        this.cartItems.push({
          ...product,
          quantity: 1
        });
      }
      
      alert(`${product.name} agregado al carrito`);
    },

    removeFromCart(item) {
      this.cartItems = this.cartItems.filter(cartItem => cartItem.id !== item.id);
    },

    increaseQuantity(item) {
      item.quantity += 1;
    },

    decreaseQuantity(item) {
      if (item.quantity > 1) {
        item.quantity -= 1;
      } else {
        this.removeFromCart(item);
      }
    },

    switchToRegister() {
      this.showLoginModal = false;
      this.showRegisterModal = true;
    },

    switchToLogin() {
      this.showRegisterModal = false;
      this.showLoginModal = true;
    },

    login() {
      if (this.loginForm.email && this.loginForm.password) {
        this.currentUser = {
          name: this.loginForm.email.split('@')[0],
          email: this.loginForm.email
        };
        this.showLoginModal = false;
        this.loginForm = { email: '', password: '' };
        alert(`¡Bienvenido ${this.currentUser.name}!`);
      } else {
        alert('Por favor completa todos los campos');
      }
    },

    register() {
      if (this.registerForm.password !== this.registerForm.confirmPassword) {
        alert('Las contraseñas no coinciden');
        return;
      }
      
      if (this.registerForm.name && this.registerForm.email && this.registerForm.password) {
        this.currentUser = {
          name: this.registerForm.name,
          email: this.registerForm.email
        };
        this.showRegisterModal = false;
        this.registerForm = { name: '', email: '', password: '', confirmPassword: '' };
        alert(`¡Cuenta creada exitosamente! Bienvenido ${this.currentUser.name}`);
      } else {
        alert('Por favor completa todos los campos');
      }
    },

    logout() {
      this.currentUser = null;
      alert('Sesión cerrada correctamente');
    },

    // Métodos para carousel de promociones
    togglePromotions() {
      this.promotionsHidden = !this.promotionsHidden;
      if (!this.promotionsHidden) {
        this.startCarousel();
      } else {
        this.stopCarousel();
      }
    },

    addToCartFromPromotion(promotion) {
      const product = {
        id: promotion.id,
        name: promotion.name,
        description: promotion.description,
        price: promotion.newPrice,
        image: promotion.image
      };
      this.addToCart(product);
    },

    startCarousel() {
      this.stopCarousel(); // Limpiar intervalo anterior
      this.carouselInterval = setInterval(() => {
        this.currentPromotion = (this.currentPromotion + 1) % this.promotions.length;
      }, 3000); // Cambia cada 3 segundos
    },

    stopCarousel() {
      if (this.carouselInterval) {
        clearInterval(this.carouselInterval);
        this.carouselInterval = null;
      }
    },

    nextPromotion() {
      this.currentPromotion = (this.currentPromotion + 1) % this.promotions.length;
    },

    prevPromotion() {
      this.currentPromotion = (this.currentPromotion - 1 + this.promotions.length) % this.promotions.length;
    },

    // Métodos para el proceso de pago
    startCheckout() {
  if (this.cartItems.length === 0) {
    alert('Tu carrito está vacío');
    return;
  }
  this.showPaymentModal = true;
  this.paymentStep = 1;
  // NO cerrar el carrito aquí - lo cerraremos después
},

    goToPayment() {
      // Validar información de envío
      if (!this.shippingInfo.fullName || !this.shippingInfo.address || !this.shippingInfo.city || !this.shippingInfo.phone) {
        alert('Por favor completa toda la información de envío');
        return;
      }
      this.paymentStep = 3;
    },

    processPayment() {
      // Validar método de pago
      if (!this.paymentInfo.method) {
        alert('Por favor selecciona un método de pago');
        return;
      }

      if (this.paymentInfo.method === 'credit-card') {
        if (!this.paymentInfo.cardNumber || !this.paymentInfo.expiryDate || !this.paymentInfo.cvv) {
          alert('Por favor completa la información de la tarjeta');
          return;
        }
      }

      // Simular procesamiento de pago
      this.orderNumber = 'ORD' + Date.now().toString().slice(-6);
      
      // Mostrar confirmación
      this.paymentStep = 4;
    },

    finishPayment() {
  // Limpiar carrito y resetear proceso
  this.cartItems = [];
  this.showPaymentModal = false;
  this.cartVisible = false; // ← Ahora SÍ cerramos el carrito
  this.paymentStep = 1;
  this.shippingInfo = { fullName: '', address: '', city: '', phone: '' };
  this.paymentInfo = { method: '', cardNumber: '', expiryDate: '', cvv: '' };
  
  alert(`¡Gracias por tu compra! Tu orden #${this.orderNumber} ha sido procesada.`);
}
  }
}
</script>