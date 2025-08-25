'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Categories extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      // 👇 Una categoría tiene muchos eventos
      Categories.hasMany(models.Events, {
        foreignKey: 'categoryId',
        as: 'events'        // alias para acceder a los eventos desde una categoría
      });
    }
  }
  Categories.init({
    name: DataTypes.STRING(30),
    description: DataTypes.STRING,
    image: DataTypes.STRING   // Aquí agregamos el nuevo campo
  }, {
    sequelize,
    modelName: 'Categories',  // Nombre del modelo JavaScript
    tableName: 'categories'   // Nombre de la tabla física en BD
  });
  return Categories;
};