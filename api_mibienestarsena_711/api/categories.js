const db = require('../models');          // Importar modelos de la base de datos
const { Router } = require('express');   // Extraer el método Router de Express
// Creamos el router para poder usar los verbos HTTP
const router = Router();                // Crear una instancia de enrutador de Express

// req => request   => En request llegan los datos del body
// res => response  => Se envían  los datos hacia el cliente
router.get('/', (req, res) => {
    // Enviar respuesta JSON al cliente
    res.send({
        Title: 'Hello ADSO !',
    });
});

// Ruta POST
router.post('/new', async (req, res) => {
    let name = req.body.name;
    let description = req.body.description;
    let image = req.body.image;
    try {
        await db.Categories.create({
            name,
            description,         
            image
        });
        res.status(200).send('Categoria creada correctamente');
    } catch (error) {
        res.status(400).send('Error al crear la categoria');
    }
});

// Ruta ALL
router.get('/all', async (req, res) => {
    try {
        let categories = await db.Categories.findAll();
        res.status(200).send(categories);
    } catch (error) {
        res.status(400).send('Error al obtener las categorias');
    }
});

// Ruta Get{id}
router.get('/:id', async (req, res) => {
    try {
        let id   = req.params.id;
        let categories = await db.Categories.findByPk(id);
        res.status(200).send(categories);
    } catch (error) {
        res.status(400).send('Error al obtener la categoria');
    }
});

// Ruta PUT
router.put('/:id', async (req, res) => {
    try {
        let id   = req.params.id;
        let { name, description, image} = req.body;
        await db.Categories.update(
            { name, description, image }, 
            {
                where: { 
                    id 
                }
            }
        );
        res.status(200).send('Categoria actualizada correctamente');
    } catch (error) {
        res.status(400).send('Error al actualizar la categoria');
    }
});

// Ruta DELETE
router.delete('/:id', async (req, res) => {
    try {
        let id   = req.params.id;
        await db.Categories.destroy({
            where: { 
                id 
            }
        });
        res.status(200).send('Categoria eliminada correctamente');
    } catch (error) {
        res.status(400).send('Error al eliminar la categoria');
    }
});

// Exportar el enrutador para su uso en otros archivos
module.exports = router;