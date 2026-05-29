import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false; // [cite: 39]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.person),
              title: Text("Nom de l'utilisateur"), // [cite: 38]
              subtitle: Text("email@exemple.com"),
              trailing: Icon(Icons.edit), // [cite: 38]
            ),
            SwitchListTile(
              title: const Text("Mode sombre"), // [cite: 39]
              value: isDarkMode,
              onChanged: (val) => setState(() => isDarkMode = val),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => _showDeleteConfirmation(context),
              child: const Text("Vider mes données", style: TextStyle(color: Colors.red)), // [cite: 40]
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"), // [cite: 40]
        content: const Text("Voulez-vous vraiment supprimer toutes vos données ?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Annuler")),
          TextButton(onPressed: () { /* Logique de suppression */ }, child: const Text("Vider")),
        ],
      ),
    );
  }
}