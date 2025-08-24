const category_service = require('../services/categoryService');   // Importamos el servicio de categorias

const testCategoryAPI = (req, resp) => {
    console.log("TestCategoryAPI");
    resp.status(200).send({
        "status": 200,
        "message": 'API User state: avaliable - En funcionamiento categories OK',
    });
};

const getAllCategories  = async(req, resp) => {
    const categories = await category_service.getAllCategories();   // Llamamos al servicio para obtener todos las categorias
    if (categories) 
        resp.status(200).send({
            "status": "Ok", 
            "message": "Categorias obtenidas con éxito", 
            "data": categories
        });
    else 
        resp.status(400).send({"status": "FAILED", "message": "Error al obtener las categorias"});

}

// Ruta getOneCategory 
const getOneCategory = async (req, resp) => { 
    const id = req.params.id;   // Obtenemos el id de la categoria desde los parámetros de la solicitud
    const category = await category_service.getOneCategory(id);   // Llamamos al servicio para obtener un usuario por su id
    if (category) 
        resp.status(200).send({
            "status": "Ok", 
            "message": "Categoria traida con éxito", 
            "data": category
        });
    else 
        resp.status(400).send({"status": "FAILED", "message": "Error al traer la categoria"});
}

// Ruta createCategory
const createCategory = async (req, resp) => { 
    const {body} = req;
    const createCategory = await category_service.createCategory(body.name, body.description, body.image);   // Llamamos al servicio para crear una nueva categoria
    if (createCategory) 
        resp.status(201).send({ status: "Ok",  data: createCategory });
    else 
        resp.status(400).send({"status": "FAILED", data: createCategory});
};

// Ruta updateCategory 
const updateCategory  = async (req, resp) => { 
    const id = req.params.id;   // Obtenemos el id de la categoria desde los parámetros de la solicitud
    const {body} = req;
    const updateCategory  = await category_service.updateCategory (id, body.name, body.description, body.image);   // Llamamos al servicio para actualizar una categoria por su id
    if (updateCategory ) 
        resp.status(200).send({ status: "Ok",  data: updateCategory  });
    else 
        resp.status(400).send({"status": "FAILED", data: updateCategory });
};

// Ruta deleteCategory
const deleteCategory = async (req, resp) => { 
    const id = req.params.id;   // Obtenemos el id de la categoria desde los parámetros de la solicitud
    const deleteCategory = await category_service.deleteCategory(id);   // Llamamos al servicio para eliminar una categoria por su id
    if (deleteCategory) 
        resp.status(200).send({ status: "Ok",  data: deleteCategory });
    else 
        resp.status(400).send({"status": "FAILED", data: deleteCategory});
};



module.exports = {testCategoryAPI, getAllCategories, getOneCategory, createCategory, updateCategory, deleteCategory };   // Exportamos las funciones para que puedan ser utilizadas en otros archivos