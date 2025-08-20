'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Events extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
      // 👇 Un evento pertenece a una categoría
      Events.belongsTo(models.Categories, {
        foreignKey: 'categoryId',
        as: 'category'     // alias para acceder a la categoría desde un evento
      });
    }
  }
  Events.init({
    name: DataTypes.STRING,
    description: DataTypes.STRING,
    starDate: DataTypes.DATE,
    endDate: DataTypes.DATE,
    categoryId: DataTypes.INTEGER,
    state: DataTypes.STRING,
    maxCapacity: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Events',
  });
  return Events;
};