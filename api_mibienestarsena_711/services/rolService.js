const db = require('../models');

const getAllRols = async () => {
    try {
        const allRols = await db.Rols.findAll();
        return allRols;
    } catch (error) {
        throw new error(`Error al traer los roles ${error.meessage}`); 
    }    
};

// Ruta getOneRol
const getOneRol = async (id) => {
    try {
        const rol = await db.Rols.findByPk(id);
        return rol;
    } catch (error) {
        throw new error(`Error al traer el rol ${error.message}`); 
    }    
}

// Ruta createRol
const createRol = async (name) => { 
    try {
        const newRol = await db.Rols.create({ name });
        return newRol;
    } catch (error) {
        throw new Error(`Error al crear el rol ${error.message}`);
    }
}

// Ruta updateRol
const updateRol = async (id, name) => { 
    try {
        const rol = await db.Rols.findByPk(id);
        if (!rol) {
            throw new Error('Rol no encontrado');
        }
        rol.name = name;
        await rol.save();
        return rol;
    } catch (error) {
        throw new Error(`Error al actualizar el rol ${error.message}`);
    }
}

// Ruta deleteCategory
const deleteRol = async (id) => { 
    try {
        const rol = await db.Rols.findByPk(id);
        if (!rol) {
            throw new Error('Rol no encontrado');
        }
        await rol.destroy();
        return rol;
    } catch (error) {
        throw new Error(`Error al eliminar el rol ${error.message}`);
    }
}

module.exports = { getAllRols, getOneRol, createRol, updateRol, deleteRol };   // Exportamos las funciones para que puedan ser utilizadas en otros archivos};