import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final Icon icon;
  final String title;
  final VoidCallback? onPressed;
  final Color? color; // Couleur optionnelle pour l'icône

  const ButtonCard({
    super.key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.color, // Le paramètre couleur est facultatif
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color ?? const Color(0xFF2962FF), // Utilisation de la couleur passée, sinon la couleur par défaut
            child: Icon(
              icon.icon,
              color: Colors.white, // La couleur de l'icône est toujours blanche
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          onTap: () {
            onPressed?.call();
          },
        ),
      ),
    );
  }
}
