import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:parcial_2/model/user_model.dart';
import 'package:parcial_2/service/user_service.dart';


class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserModel? _user;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = await UserService.getProfile();
    if (!mounted) return;
    setState(() {
      _user = user;
      _error = user == null ? 'No se pudo cargar el perfil' : null;
      _loading = false;
    });
  }

  Future<void> _logout() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    if (!mounted) return;
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 48),
                      const SizedBox(height: 12),
                      Text(_error!),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () {
                          setState(() => _loading = true);
                          _loadProfile();
                        },
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        CircleAvatar(
                          radius: 56,
                          backgroundImage: _user!.avatar.isNotEmpty
                              ? NetworkImage(_user!.avatar)
                              : null,
                          child: _user!.avatar.isEmpty
                              ? const Icon(Icons.person, size: 56)
                              : null,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _user!.name,
                          style: theme.textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Chip(
                          label: Text(_user!.role.toUpperCase()),
                          backgroundColor: theme.colorScheme.primaryContainer,
                        ),
                        const SizedBox(height: 32),
                        _InfoTile(icon: Icons.email_outlined,        label: 'Email',          value: _user!.email),
                        const SizedBox(height: 12),
                        _InfoTile(icon: Icons.badge_outlined,        label: 'ID de usuario',  value: '#${_user!.id}'),
                        const SizedBox(height: 12),
                        _InfoTile(icon: Icons.manage_accounts_outlined, label: 'Rol',         value: _user!.role),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _logout,
                            icon: const Icon(Icons.logout),
                            label: const Text('Cerrar sesión'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.colorScheme.error,
                              side: BorderSide(color: theme.colorScheme.error),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Icon(icon, color: theme.colorScheme.primary),
        title: Text(label,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        subtitle: Text(value, style: theme.textTheme.bodyLarge),
      ),
    );
  }
}