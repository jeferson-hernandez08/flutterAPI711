const db = require('../models');

const getAllCategories = async () => {
    try {
        const allCategories = await db.Categories.findAll();
        return allCategories;
    } catch (error) {
        //throw new Error(`Error al traer las categorias ${error.meessage}`); 
        const errorMsg = error.message || 'Mensaje de error no disponible';
        throw new Error(`Error al traer las categorias: ${errorMsg}`);
    }    
};

// Ruta getOneCategory
const getOneCategory = async (id) => {
    try {
        const category = await db.Categories.findByPk(id);
        return category;
    } catch (error) {
        throw new Error(`Error al traer la categoria ${error.message}`); 
    }    
}

// Ruta createCategory
const createCategory = async (name, description, image) => { 
    try {
        const newCategory = await db.Categories.create({ name, description, image });
        return newCategory;
    } catch (error) {
        throw new Error(`Error al crear la categoria ${error.message}`);
    }
}

// Ruta updateCategory
const updateCategory = async (id, name, description, image) => { 
    try {
        const category = await db.Categories.findByPk(id);
        if (!category) {
            throw new Error('Categoria no encontrada');
        }
        category.name = name;
        category.description = description;
        category.image = image;
        await category.save();
        return category;
    } catch (error) {
        throw new Error(`Error al actualizar la categoria ${error.message}`);
    }
}

// Ruta deleteCategory
const deleteCategory = async (id) => { 
    try {
        const category = await db.Categories.findByPk(id);
        if (!category) {
            throw new Error('Categoria no encontrada');
        }
        await category.destroy();
        return category;
    } catch (error) {
        throw new Error(`Error al eliminar la categoria ${error.message}`);
    }
}

module.exports = { getAllCategories, getOneCategory, createCategory, updateCategory, deleteCategory };   // Exportamos las funciones para que puedan ser utilizadas en otros archivos};