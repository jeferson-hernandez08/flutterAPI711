const event_service = require('../services/eventService');   // Importamos el servicio de categorias

const testEventAPI = (req, resp) => {
    console.log("TestEventAPI");
    resp.status(200).send({
        "status": 200,
        "message": 'API User state: avaliable - En funcionamiento eventos OK',
    });
};

const getAllEvents  = async(req, resp) => {
    const events = await event_service.getAllEvents();   // Llamamos al servicio para obtener todos los eventos
    if (events) 
        resp.status(200).send({
            "status": "Ok", 
            "message": "Eventos obtenidos con éxito", 
            "data": events
        });
    else 
        resp.status(400).send({"status": "FAILED", "message": "Error al obtener los eventos"});

}

// Ruta getOneCategory 
const getOneEvent = async (req, resp) => { 
    const id = req.params.id;   // Obtenemos el id del evento desde los parámetros de la solicitud
    const event = await event_service.getOneEvent(id);   // Llamamos al servicio para obtener un evento por su id
    if (event) 
        resp.status(200).send({
            "status": "Ok", 
            "message": "Evento traido con éxito", 
            "data": event
        });
    else 
        resp.status(400).send({"status": "FAILED", "message": "Error al traer el evento"});
}

// Ruta createEvent
const createEvent = async (req, resp) => { 
    const {body} = req;
    const createEvent = await event_service.createEvent(body.name, body.description, body.starDate, body.endDate, body.categoryId, body.state, body.maxCapacity, body.userId );   // Llamamos al servicio para crear un evento
    if (createEvent) 
        resp.status(201).send({ status: "Ok",  data: createEvent });
    else 
        resp.status(400).send({"status": "FAILED", data: createEvent});
};

// Ruta updateEvent 
const updateEvent  = async (req, resp) => { 
    const id = req.params.id;   // Obtenemos el id de la categoria desde los parámetros de la solicitud
    const {body} = req;
    const updateEvent  = await event_service.updateEvent (id, body.name, body.description, body.starDate, body.endDate, body.categoryId, body.state, body.userId );   // Llamamos al servicio para actualizar un evento por su id
    if (updateEvent ) 
        resp.status(200).send({ status: "Ok",  data: updateEvent  });
    else 
        resp.status(400).send({"status": "FAILED", data: updateEvent });
};

// Ruta deleteEvent
const deleteEvent = async (req, resp) => { 
    const id = req.params.id;   // Obtenemos el id del evento desde los parámetros de la solicitud
    const deleteEvent = await event_service.deleteEvent(id);   // Llamamos al servicio para eliminar un evento por su id
    if (deleteEvent) 
        resp.status(200).send({ status: "Ok",  data: deleteEvent });
    else 
        resp.status(400).send({"status": "FAILED", data: deleteEvent});
};



module.exports = {testEventAPI, getAllEvents, getOneEvent, createEvent, updateEvent, deleteEvent };   // Exportamos las funciones para que puedan ser utilizadas en otros archivos