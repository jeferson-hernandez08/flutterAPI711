const express = require('express')
const app     = express()
const bodyParser = require('body-parser');     // Importar body-parser para manejar datos JSON

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
app.use('/api/categories', require('./api/categories'));    // Ruta para categorias


app.listen(app.get('PORT'), ()=>{
    console.log(`🚀 Servidor corriendo en el PUERTO: ${app.get('PORT')}`)
    console.log(`🌐 URL de acceso: http://localhost:${app.get('PORT')}`)
})