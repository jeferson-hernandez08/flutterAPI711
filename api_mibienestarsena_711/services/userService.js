const db = require('../models');

const getAllUsers = async () => {     
    try {
        const allUsers = await db.Users.findAll({
            // Aquí permitimos mostrar los usuarios con el rol que pertenece
            include: {
                model: db.Rols,
                required: true, // Requerido para que solo muestre los roles con los usuarios
                as: "rol", // Alias del modelo
                attributes: ['id', 'name'],
            },
            attributes: {
                exclude: ['createdAt', 'updatedAt']  // Excluir campos de fecha de creación y actualización
            },
        });
        return allUsers;
    } catch (error) {
        throw new Error(`Error al traer los usuarios ${error.meessage}`); 
    }    
};

// Ruta getOneUser
const getOneUser = async (id) => {
    try {
        const user = await db.Users.findByPk(id);
        return user;
    } catch (error) {
        throw new error(`Error al traer el evento ${error.message}`); 
    }    
}

// Ruta createEvent
const createUser = async (userName, email, password, phone, birthdate, document, gender, state, rolId, passwordResetToken, passwordResetExpires ) => { 
    try {
        const newUser = await db.Users.create({ userName, email, password, phone, birthdate, document, gender, state, rolId, passwordResetToken, passwordResetExpires });
        return newUser;
    } catch (error) {
        throw new Error(`Error al crear el usuario ${error.message}`);
    }
}

// Ruta updateUser
const updateUser = async (id, userName, email, password, phone, birthdate, document, gender, state, rolId, passwordResetToken, passwordResetExpires ) => { 
    try {
        const user = await db.Users.findByPk(id);
        if (!user) {
            throw new Error('Usuario no encontrado');
        }
        user.userName = userName;
        user.email = email;
        user.password = password;
        user.phone = phone;
        user.birthdate = birthdate;
        user.document = document;
        user.gender = gender;
        user.state = state;
        user.rolId = rolId;
        user.passwordResetToken = passwordResetToken;
        user.passwordResetExpires = passwordResetExpires;
        await user.save();
        return user;
    } catch (error) {
        throw new Error(`Error al actualizar el usuario ${error.message}`);
    }
}

// Ruta deleteUser
const deleteUser = async (id) => { 
    try {
        const user = await db.Users.findByPk(id);
        if (!user) {
            throw new Error('Usuario no encontrado');
        }
        await user.destroy();
        return user;
    } catch (error) {
        throw new Error(`Error al eliminar el usuario ${error.message}`);
    }
}

module.exports = { getAllUsers, getOneUser, createUser, updateUser, deleteUser };   // Exportamos las funciones para que puedan ser utilizadas en otros archivos};