'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Categories', [
      {
        name: 'Tecnología e Innovación',
        description: 'Eventos relacionados con avances tecnológicos, innovación y nuevas tendencias digitales.',
        image: 'https://example.com/tecnologia.jpg',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Deportes',
        description: 'Actividades deportivas, torneos, competencias y jornadas de bienestar físico.',
        image: 'https://example.com/deportes.jpg',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Cultura y Arte',
        description: 'Eventos culturales, muestras artísticas, teatro, música y danza.',
        image: 'https://example.com/cultura.jpg',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Emprendimiento',
        description: 'Espacios para la creación de ideas de negocio, startups y proyectos innovadores.',
        image: 'https://example.com/emprendimiento.jpg',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Ciencia',
        description: 'Charlas y exposiciones relacionadas con investigación científica y descubrimientos.',
        image: 'https://example.com/ciencia.jpg',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Medio Ambiente',
        description: 'Iniciativas sobre sostenibilidad, reciclaje y cuidado del entorno natural.',
        image: 'https://example.com/medioambiente.jpg',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Salud y Bienestar',
        description: 'Talleres y campañas enfocadas en la salud física y mental.',
        image: 'https://example.com/salud.jpg',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        name: 'Educación y Formación',
        description: 'Actividades académicas, capacitaciones, cursos y formación continua.',
        image: 'https://example.com/educacion.jpg',
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ], {});
     
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
    */
  },

  async down (queryInterface, Sequelize) {
    await queryInterface.bulkDelete('Categories', null, {});

    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
