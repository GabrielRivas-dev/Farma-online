<template>
  <div class="full-width-footer">
    <div class="footer-container">
      <div class="footer-content">
        <!-- Información de la empresa -->
        <div class="footer-section">
          <h3>🏥 Farmacia Salud</h3>
          <p>Tu salud es nuestra prioridad. Más de 20 años sirviendo a la comunidad con los mejores productos farmacéuticos y atención personalizada.</p>
          <div class="social-links">
            <a href="#" class="social-link">📘 Facebook</a>
            <a href="#" class="social-link">📷 Instagram</a>
            <a href="#" class="social-link">🐦 Twitter</a>
          </div>
        </div>

        <!-- Enlaces rápidos -->
        <div class="footer-section">
          <h4>Enlaces Rápidos</h4>
          <ul class="footer-links">
            <li><a href="#">Inicio</a></li>
            <li><a href="#">Medicamentos</a></li>
            <li><a href="#">Cuidado Personal</a></li>
            <li><a href="#">Equipamiento Médico</a></li>
            <li><a href="#">Promociones</a></li>
          </ul>
        </div>

        <!-- Categorías -->
        <div class="footer-section">
          <h4>Categorías</h4>
          <ul class="footer-links">
            <li><a href="#">Analgésicos</a></li>
            <li><a href="#">Vitaminas</a></li>
            <li><a href="#">Antigripales</a></li>
            <li><a href="#">Cuidado Infantil</a></li>
            <li><a href="#">Primeros Auxilios</a></li>
          </ul>
        </div>

        <!-- Información de contacto -->
        <div class="footer-section">
          <h4>Contacto</h4>
          <div class="contact-info">
            <p>📍 Av. Principal #123, Ciudad</p>
            <p>📞 (123) 456-7890</p>
            <p>✉️ info@farmaciasalud.com</p>
            <p>🕒 Lun-Sab: 8:00 AM - 10:00 PM</p>
            <p>🕒 Dom: 9:00 AM - 8:00 PM</p>
          </div>
        </div>
      </div>

      <!-- Línea divisoria -->
      <div class="footer-divider"></div>

      <!-- Copyright -->
      <div class="footer-bottom">
        <p>&copy; 2025 Farmacia Salud. Todos los derechos reservados.</p>
        <div class="footer-bottom-links">
          <a href="#">Términos de Servicio</a>
          <a href="#">Política de Privacidad</a>
          <a href="#">Aviso Legal</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'FooterComponent'
}
</script>

<style scoped>
.full-width-footer {
  width: 100vw;
  margin-left: -50vw;
  left: 50%;
  position: relative;
  background: linear-gradient(135deg, #2c5aa0, #1e3a8a);
  color: white;
  margin-top: 3rem;
}

.footer-container {
  max-width: 100vw;
  padding: 3rem 0 1rem;
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.5fr;
  gap: 1.5rem;
  margin-bottom: 1.5rem;
}

.footer-section h3 {
  font-size: 1.3rem;
  margin-bottom: 1rem;
}

.footer-section h4 {
  font-size: 1rem;
  margin-bottom: 0.8rem;
  color: #e2e8f0;
}

.footer-section p {
  line-height: 1.5;
  color: #cbd5e0;
  margin-bottom: 0.8rem;
  font-size: 0.9rem;
}

.social-links {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.social-link {
  color: #cbd5e0;
  text-decoration: none;
  transition: color 0.3s ease;
}

.social-link:hover {
  color: #fff;
}

.footer-links {
  list-style: none;
  padding: 0;
}

.footer-links li {
  margin-bottom: 0.5rem;
}

.footer-links a {
  color: #cbd5e0;
  text-decoration: none;
  transition: color 0.3s ease;
}

.footer-links a:hover {
  color: #fff;
}

.contact-info p {
  margin-bottom: 0.5rem;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.footer-divider {
  height: 1px;
  background: rgba(255, 255, 255, 0.2);
  margin: 2rem auto;
  max-width: 1200px;
  width: calc(100% - 2rem);
}

.footer-bottom {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 1rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 1rem;
}

.footer-bottom p {
  color: #cbd5e0;
  margin: 0;
}

.footer-bottom-links {
  display: flex;
  gap: 1.5rem;
}

.footer-bottom-links a {
  color: #cbd5e0;
  text-decoration: none;
  font-size: 0.9rem;
  transition: color 0.3s ease;
}

.footer-bottom-links a:hover {
  color: #fff;
}

/* Responsive */
@media (max-width: 1024px) {
  .footer-content {
    grid-template-columns: 1fr 1fr;
  }
}

@media (max-width: 768px) {
  .footer-content {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .footer-bottom {
    flex-direction: column;
    text-align: center;
  }
  
  .footer-bottom-links {
    justify-content: center;
  }
}
</style>