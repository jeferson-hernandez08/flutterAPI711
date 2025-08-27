const express = require('express')
const app     = express()
const bodyParser = require('body-parser');     // Importar body-parser para manejar datos JSON
const cors = require('cors');                  // 👈 Importa CORS

//********CORS MEJORADO *******/
// // 🔥 Configuración MEJORADA de CORS
// const corsOptions = {
//   origin: function (origin, callback) {
//     // Lista de dominios permitidos
//     const allowedOrigins = [
//       'http://localhost:3000',
//       'http://localhost:8080',
//       'http://localhost:64520',      // 👈 ¡AGREGA ESTE! // Puerto de Flutter web
//       'http://127.0.0.1:3000',
//       'http://127.0.0.1:8080',
//       'http://127.0.0.1:64520',      // 👈 ¡AGREGA ESTE! // Puerto de Flutter web
//       'https://your-flutter-web-domain.com',
//       'http://localhost',            // Para requests sin puerto
//       'http://127.0.0.1'             // Para requests sin puerto
//     ];

//     console.log('🌐 Origin de la petición:', origin); // 🔥 Para debugging
    
//     // Permitir requests sin origen (como apps móviles, Postman, etc.)
//     if (!origin || allowedOrigins.indexOf(origin) !== -1) {
//       callback(null, true);
//     } else {
//       console.log('❌ Origen no permitido:', origin);
//       callback(new Error('No permitido por CORS'));
//     }
//   },
//   methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
//   allowedHeaders: [
//     'Content-Type', 
//     'Authorization', 
//     'X-Requested-With',
//     'Accept',
//     'Origin',
//     'User-Agent'  // 🔥 Agregado para Flutter
//   ],
//   credentials: true,
//   optionsSuccessStatus: 200
// };

// // 🔥 Usar SOLO una configuración de CORS
// app.use(cors(corsOptions));

// // Middleware para preflight requests
// app.options('*', cors(corsOptions));

//********CORS BASICO *******/
//Uso de cors 👇🏼
app.use(cors());

//------
app.get('/',(request, response)=>{
    response.send({
        message: "API Activa"
    })
})

// Configurar el puerto (usa variable de entorno o 4080 por defecto)
app.set('PORT', process.env.PORT || 4000)

// Middleware para registrar las peticiones HTTP
app.use(bodyParser.urlencoded({ extended: false })); // Middleware para recibir datos desde un formulario
app.use(bodyParser.json());                          // Para que el servidor pueda recibir formato Json

// Rutas del api
app.use('/api/v1/categories', require('./api/v1/category.routes'));    // Ruta para categorias
app.use('/api/v1/events', require('./api/v1/event.routes'));    // Ruta para eventos
app.use('/api/v1/rols', require('./api/v1/rol.routes'));    // Ruta para roles
app.use('/api/v1/users', require('./api/v1/user.routes'));    // Ruta para usuarios

// Ruta para categories (Prueba)
//app.use('/api/categories', require('./api/categories'));    // Ruta para categorias


app.listen(app.get('PORT'), ()=>{
    console.log(`🚀 Servidor corriendo en el PUERTO: ${app.get('PORT')}`)
    console.log(`🌐 URL de acceso: http://localhost:${app.get('PORT')}`)
    console.log(`🔧 CORS configurado para desarrollo`)
})