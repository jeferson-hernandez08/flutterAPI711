'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('events', [
      // Tecnología e Innovación
      {
        name: 'Hackathon 2025',
        description: 'Competencia de programación e innovación tecnológica.',
        starDate: new Date('2025-10-05 08:00:00'),
        endDate: new Date('2025-10-06 20:00:00'),
        categoryId: 1,
        state: 'activo',
        maxCapacity: 150,
        userId: 3,
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Deportes
      {
        name: 'Torneo Intercentros de Fútbol',
        description: 'Campeonato entre diferentes equipos de los centros educativos.',
        starDate: new Date('2025-09-20 14:00:00'),
        endDate: new Date('2025-09-20 18:00:00'),
        categoryId: 2,
        state: 'activo',
        maxCapacity: 22,
        userId: 4,
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Cultura y Arte
      {
        name: 'Festival de Música y Danza',
        description: 'Presentaciones artísticas y muestras culturales.',
        starDate: new Date('2025-09-25 18:00:00'),
        endDate: new Date('2025-09-25 22:00:00'),
        categoryId: 3,
        state: 'activo',
        maxCapacity: 300,
        userId: 5,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      
      // Emprendimiento
      {
        name: 'ExpoStartups 2025',
        description: 'Feria de emprendimiento y networking para jóvenes empresarios.',
        starDate: new Date('2025-10-12 09:00:00'),
        endDate: new Date('2025-10-12 17:00:00'),
        categoryId: 4,
        state: 'activo',
        maxCapacity: 120,
        userId: 1,
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Ciencia
      {
        name: 'Congreso de Innovación Científica',
        description: 'Charlas y ponencias de investigadores destacados.',
        starDate: new Date('2025-10-18 08:00:00'),
        endDate: new Date('2025-10-18 18:00:00'),
        categoryId: 5,
        state: 'activo',
        maxCapacity: 250,
        userId: 2,
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Medio Ambiente
      {
        name: 'Jornada de Reforestación',
        description: 'Actividad para sembrar árboles y promover la sostenibilidad.',
        starDate: new Date('2025-09-28 07:00:00'),
        endDate: new Date('2025-09-28 13:00:00'),
        categoryId: 6,
        state: 'activo',
        maxCapacity: 100,
        userId: 3,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      
      // Salud y Bienestar
      {
        name: 'Feria de la Salud 2025',
        description: 'Charlas médicas, chequeos gratuitos y promoción de hábitos saludables.',
        starDate: new Date('2025-09-30 09:00:00'),
        endDate: new Date('2025-09-30 15:00:00'),
        categoryId: 7,
        state: 'activo',
        maxCapacity: 200,
        userId: 4,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      
      {
        name: 'Taller de Liderazgo y Motivación',
        description: 'Un espacio para fortalecer habilidades blandas y liderazgo personal.',
        starDate: new Date('2025-09-10 09:00:00'),
        endDate: new Date('2025-09-10 12:00:00'),
        categoryId: 7, // Salud y Bienestar
        state: 'activo',
        maxCapacity: 50,
        userId: 1,
        createdAt: new Date(),
        updatedAt: new Date()
      },

      // Educación y Formación
      {
        name: 'Semana Académica 2025',
        description: 'Conferencias, talleres y capacitaciones en distintas áreas del conocimiento.',
        starDate: new Date('2025-10-01 08:00:00'),
        endDate: new Date('2025-10-05 18:00:00'),
        categoryId: 8,
        state: 'activo',
        maxCapacity: 400,
        userId: 5,
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
    await queryInterface.bulkDelete('events', null, {});

    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
