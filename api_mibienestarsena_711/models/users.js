'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Users extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      // 👇 Una usuario tiene muchos eventos
      Users.hasMany(models.Events, {
        foreignKey: 'userId',
        as: 'events'        // alias para acceder a los eventos desde un usuario
      });

      // 👇 Un usuario pertenece a un rol
      Users.belongsTo(models.Rols, {
        foreignKey: 'rolId',
        as: 'rol'     // Alias para acceder al rol desde un usuario
      });
      
    }
  }
  Users.init({
    userName: DataTypes.STRING,
    email: DataTypes.STRING,
    password: DataTypes.STRING,
    phone: DataTypes.STRING,
    birthdate: DataTypes.DATEONLY,
    document: DataTypes.STRING,
    gender: DataTypes.STRING,
    state: DataTypes.STRING,
    rolId: DataTypes.INTEGER,
    passwordResetToken: DataTypes.STRING,
    passwordResetExpires: DataTypes.DATE
  }, {
    sequelize,
    modelName: 'Users',
  });
  return Users;
};