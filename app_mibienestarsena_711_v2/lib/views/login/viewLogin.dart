import 'package:app_mibienestarsena_711_v2/views/interface/inicio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../api/apiBienestar.dart';
import '../../main.dart';

class ViewLoginCPIC extends StatefulWidget {
  const ViewLoginCPIC({super.key});

  @override
  State<ViewLoginCPIC> createState() => _ViewLoginCPICState();
}

class _ViewLoginCPICState extends State<ViewLoginCPIC> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  // Función para manejar el login
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      // Cerrar teclado
      FocusScope.of(context).unfocus();
      
      setState(() => _isLoading = true);
      
      // Simular un pequeño delay para que se vea la animación de carga
      await Future.delayed(const Duration(milliseconds: 500));
      
      bool success = await loginApi(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      setState(() => _isLoading = false);

      if (success) {
        // Mostrar mensaje de éxito con una animación
        Get.snackbar(
          '¡Éxito!', 
          'Inicio de sesión satisfactorio',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade600,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
        );
        
        // Navegar al inicio después de un breve delay
        await Future.delayed(const Duration(milliseconds: 1500));
        Get.offAll(() => Inicio());
      } else {
        // Mostrar error con vibración
        HapticFeedback.heavyImpact();
        Get.snackbar(
          'Error', 
          'Credenciales incorrectas. Por favor, inténtalo de nuevo.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
          icon: const Icon(Icons.error_outline, color: Colors.white),
          shouldIconPulse: true,
          barBlur: 20,
          isDismissible: true,
          duration: const Duration(seconds: 4),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
        );
      }
    }
  }

  // Función para recuperar contraseña
  void _handleForgotPassword() {
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      Get.snackbar(
        'Email requerido', 
        'Por favor, ingresa tu email para recuperar tu contraseña',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade600,
        colorText: Colors.white,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recuperar contraseña'),
          content: Text(
              '¿Deseas enviar un enlace de recuperación a ${_emailController.text}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.snackbar(
                  'Enlace enviado', 
                  'Revisa tu correo electrónico para restablecer tu contraseña',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.shade600,
                  colorText: Colors.white,
                );
              },
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.1, 0.4, 0.7, 0.9],
              colors: [
                Colors.blue.shade800,
                Colors.blue.shade700,
                Colors.blue.shade600,
                Colors.blue.shade400,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo y título
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_person,
                            size: 50,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Mi Bienestar SENA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Inicia sesión en tu cuenta',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Formulario
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Campo de email
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Correo electrónico',
                                prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu correo electrónico';
                                }
                                if (!value.contains('@') || !value.contains('.')) {
                                  return 'Por favor ingresa un correo electrónico válido';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // Campo de contraseña
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: 'Contraseña',
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu contraseña';
                                }
                                if (value.length < 6) {
                                  return 'La contraseña debe tener al menos 6 caracteres';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => _handleLogin(),
                            ),
                            const SizedBox(height: 10),

                            // Recordar contraseña y olvidé contraseña
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Row(
                                //   children: [
                                //     Checkbox(
                                //       value: _rememberMe,
                                //       onChanged: (value) {
                                //         setState(() {
                                //           _rememberMe = value!;
                                //         });
                                //       },
                                //       activeColor: Colors.blue,
                                //     ),
                                //     const Text(
                                //       'Recordarme',
                                //       style: TextStyle(fontSize: 14),
                                //     ),
                                //   ],
                                // ),
                                TextButton(
                                  onPressed: _handleForgotPassword,
                                  child: const Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Botón de inicio de sesión
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: _handleLogin,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        elevation: 5,
                                        shadowColor: Colors.blue.withOpacity(0.5),
                                      ),
                                      child: const Text(
                                        'INICIAR SESIÓN',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 15),

                            // // Divider
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Divider(
                            //         color: Colors.grey.shade400,
                            //         thickness: 1,
                            //       ),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 10),
                            //       child: Text(
                            //         'O continúa con',
                            //         style: TextStyle(
                            //           color: Colors.grey.shade600,
                            //           fontSize: 14,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Divider(
                            //         color: Colors.grey.shade400,
                            //         thickness: 1,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 15),

                            // Botones de redes sociales
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     // Google
                            //     InkWell(
                            //       onTap: () {
                            //         // Lógica para inicio con Google
                            //         Get.snackbar(
                            //           'Próximamente', 
                            //           'Inicio con Google estará disponible pronto',
                            //           snackPosition: SnackPosition.BOTTOM,
                            //         );
                            //       },
                            //       child: Container(
                            //         padding: const EdgeInsets.all(12),
                            //         decoration: BoxDecoration(
                            //           color: Colors.grey.shade100,
                            //           shape: BoxShape.circle,
                            //           border: Border.all(color: Colors.grey.shade300),
                            //         ),
                            //         child: Image.asset(
                            //           'assets/google.png',
                            //           height: 24,
                            //           width: 24,
                            //         ),
                            //       ),
                            //     ),
                            //     const SizedBox(width: 20),
                                
                            //     // Facebook
                            //     InkWell(
                            //       onTap: () {
                            //         // Lógica para inicio con Facebook
                            //         Get.snackbar(
                            //           'Próximamente', 
                            //           'Inicio con Facebook estará disponible pronto',
                            //           snackPosition: SnackPosition.BOTTOM,
                            //         );
                            //       },
                            //       child: Container(
                            //         padding: const EdgeInsets.all(12),
                            //         decoration: BoxDecoration(
                            //           color: const Color(0xFF1877F2),
                            //           shape: BoxShape.circle,
                            //         ),
                            //         child: const Icon(
                            //           Icons.facebook,
                            //           color: Colors.white,
                            //           size: 24,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Pie de página
                    const Text(
                      '© 2025 Mi Bienestar SENA. Todos los derechos reservados.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}