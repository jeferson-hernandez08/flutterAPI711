'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('categories', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      name: {
        type: Sequelize.STRING(30)    // 🧠 Aquí se cambia también  para que No quede de 255 por defecto
      },
      description: {
        type: Sequelize.STRING
      },
      image: {   // Nuevo campo
        type: Sequelize.STRING,
        allowNull: true   // Lo puedo cambiar a false si quierremos que sea obligatorio
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('categories');
  }
};