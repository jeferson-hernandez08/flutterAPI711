'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up (queryInterface, Sequelize) {
    await queryInterface.bulkInsert('Users', [
      {
        id: 1,
        userName: 'admin_master',
        email: 'admin@sistema.com',
        password: '123456', // 🔒 en la práctica deberías usar bcrypt
        phone: '3001234567',
        birthdate: new Date('1990-01-01'),
        document: '1002003001',
        gender: 'M',
        state: true,
        rolId: 1, // Admin
        passwordResetToken: null,
        passwordResetExpires: null,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 2,
        userName: 'coordinador_01',
        email: 'coordinador@sistema.com',
        password: '123456',
        phone: '3012345678',
        birthdate: new Date('1985-05-10'),
        document: '1002003002',
        gender: 'F',
        state: true,
        rolId: 2, // Coordinador
        passwordResetToken: null,
        passwordResetExpires: null,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 3,
        userName: 'instructor_01',
        email: 'instructor@sistema.com',
        password: '123456',
        phone: '3023456789',
        birthdate: new Date('1992-03-15'),
        document: '1002003003',
        gender: 'M',
        state: true,
        rolId: 3, // Instructor
        passwordResetToken: null,
        passwordResetExpires: null,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 4,
        userName: 'aprendiz_01',
        email: 'aprendiz@sistema.com',
        password: '123456',
        phone: '3034567890',
        birthdate: new Date('2002-07-20'),
        document: '1002003004',
        gender: 'F',
        state: true,
        rolId: 4, // Aprendiz
        passwordResetToken: null,
        passwordResetExpires: null,
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        id: 5,
        userName: 'bienestar_01',
        email: 'bienestar@sistema.com',
        password: '123456',
        phone: '3045678901',
        birthdate: new Date('1988-11-11'),
        document: '1002003005',
        gender: 'F',
        state: true,
        rolId: 5, // Profesional Bienestar
        passwordResetToken: null,
        passwordResetExpires: null,
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
    await queryInterface.bulkDelete('Users', null, {});
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
  }
};
