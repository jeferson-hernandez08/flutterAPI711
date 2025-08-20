const { Router } = require('express');
const router = Router(); // Creamos una instancia del Router

const event_controller = require('../../controllers/eventController');   // Importamos el controlador de categorias

router.get('/testEventApi', event_controller.testEventAPI); // Ruta para probar la API de categorias
router.get('/', event_controller.getAllEvents); 
router.get('/:id', event_controller.getOneEvent); 
router.post('/', event_controller.createEvent); 
router.put('/:id', event_controller.updateEvent); 
router.delete('/:id', event_controller.deleteEvent); 

// Exportar el módulo
module.exports = router;    // Exportamos el router para que pueda ser utilizado en otros archivos