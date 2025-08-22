const db = require('../models');

const getAllEvents = async () => {
    try {
        const allEvents = await db.Events.findAll({
            include: [
                {
                    // Aquí permitimos mostrar las categorias con la informacion del evento
                    model: db.Categories,
                    //required: true, // Requerido para que solo muestre los eventos con categoria
                    as: "category", // Alias del modelo
                    attributes: ['id', 'name', 'description', 'image'],
                },
                {
                    // Aquí permitimos mostrar los eventos con la informacion del usuario
                    model: db.Users,
                    //required: true, // Requerido para que solo muestre los usuarios con eventos
                    as: "user", // Alias del modelo
                    attributes: ['id', 'userName', 'email', 'password', 'phone', 'birthdate', 'document', 'gender'],
                }
            ],
            attributes: {
                exclude: ['createdAt', 'updatedAt']  // Excluir campos de fecha de creación y actualización
            },
        });
        return allEvents;
    } catch (error) {
        throw new Error(`Error al traer los eventos ${error.meessage}`); 
    }    
};

// Ruta getOneEvent
const getOneEvent = async (id) => {
    try {
        const event = await db.Events.findByPk(id);
        return event;
    } catch (error) {
        throw new error(`Error al traer el evento ${error.message}`); 
    }    
}

// Ruta createEvent
const createEvent = async (name, description, starDate, endDate, categoryId, state, maxCapacity, userId) => { 
    try {
        const newEvent = await db.Events.create({ name, description, starDate, endDate, categoryId, state, maxCapacity, userId });
        return newEvent;
    } catch (error) {
        throw new Error(`Error al crear el evento ${error.message}`);
    }
}

// Ruta updateEvent
const updateEvent = async (id, name, description, starDate, endDate, categoryId, state, maxCapacity, userId) => { 
    try {
        const event = await db.Events.findByPk(id);
        if (!event) {
            throw new Error('Evento no encontrado');
        }
        event.name = name;
        event.description = description;
        event.starDate = starDate;
        event.endDate = endDate;
        event.categoryId = categoryId;
        event.state = state;
        event.maxCapacity = maxCapacity;
        event.userId = userId;
        await event.save();
        return event;
    } catch (error) {
        throw new Error(`Error al actualizar el evento ${error.message}`);
    }
}

// Ruta deleteEvent
const deleteEvent = async (id) => { 
    try {
        const event = await db.Events.findByPk(id);
        if (!event) {
            throw new Error('Evento no encontrado');
        }
        await event.destroy();
        return event;
    } catch (error) {
        throw new Error(`Error al eliminar el evento ${error.message}`);
    }
}

module.exports = { getAllEvents, getOneEvent, createEvent, updateEvent, deleteEvent };   // Exportamos las funciones para que puedan ser utilizadas en otros archivos};