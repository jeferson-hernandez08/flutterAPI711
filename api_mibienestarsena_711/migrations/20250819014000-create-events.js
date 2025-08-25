'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('events', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      name: {
        type: Sequelize.STRING
      },
      description: {
        type: Sequelize.STRING
      },
      starDate: {
        type: Sequelize.DATE
      },
      endDate: {
        type: Sequelize.DATE
      },
      categoryId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'categories', // 👈🧠referencia a la tabla Categories | ← Esto NO se refiere al modelo JavaScript, , sino al nombre de la tabla física en la base de datos.
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'RESTRICT'    // No se puede borrar una categoría si tienen eventos
      },
      state: {
        type: Sequelize.STRING
      },
      maxCapacity: {
        type: Sequelize.INTEGER
      },
      userId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'users', // 👈 referencia a la tabla Users | ← Esto NO se refiere al modelo JavaScript, , sino al nombre de la tabla física en la base de datos.
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'RESTRICT'   // No se puede eliminar un usuario si tiene eventos
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
    await queryInterface.dropTable('events');
  }
};

// gui4 pagina 12