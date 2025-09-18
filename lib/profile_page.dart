import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0, // 👈 Evita que se oscurezca al hacer scroll
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Perfil",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Foto de perfil con botón de edición cuadrado
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage:
                    AssetImage("assets/images/imagen_user.webp"),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0061FF), // Azul principal
                  borderRadius: BorderRadius.circular(8), // cuadrado con bordes redondeados
                ),
                padding: const EdgeInsets.all(6),
                child: const Icon(Icons.edit, color: Colors.white, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            "Usuario",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Divider(thickness: 1, height: 20),

          // Opciones de perfil
          Expanded(
            child: ListView(
              children: [
                _buildProfileOption(Icons.calendar_today_outlined, "Mi reserva"),
                _buildProfileOption(Icons.payment_outlined, "Pagos"),
                const Divider(thickness: 1, height: 20),
                _buildProfileOption(Icons.person_outline, "Perfil"),
                _buildProfileOption(Icons.notifications_none, "Notificación"),
                _buildProfileOption(Icons.lock_outline, "Seguridad"),
                _buildProfileOption(Icons.language, "Idioma"),
                _buildProfileOption(Icons.help_outline, "Centro de ayuda"),
                _buildProfileOption(Icons.group_add_outlined, "Invita amigos"),

                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    "Cerrar sesión",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
      onTap: () {},
    );
  }
}
