import 'package:flutter/material.dart';
import 'package:jsonplaceholder/models/users.dart';

class UserWidget extends StatelessWidget {
  final Users user;
  final VoidCallback? onTap;

  const UserWidget({super.key, required this.user, this.onTap});

  static const List<Color> _userColors = [
    Color(0xFF006874),
    Color(0xFF4A6267),
    Color(0xFF525E7D),
    Color(0xFF6B5778),
    Color(0xFF7B5436),
    Color(0xFF386A20),
  ];

  Color _colorForUser(int id) {
    final index = (id.abs() - 1) % _userColors.length;
    return _userColors[index];
  }

  String _initials(String name, String username) {
    final source = name.trim().isNotEmpty ? name.trim() : username.trim();
    if (source.isEmpty) return '#${user.id}';
    final parts = source.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts.first.substring(0, parts.first.length.clamp(1, 2)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accentColor = _colorForUser(user.id);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    child: Text(
                      _initials(user.name, user.username),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '@${user.username}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'ID #${user.id}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Divider(
                height: 1,
                color: colorScheme.outlineVariant.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 12),
              _UserInfoRow(
                icon: Icons.email_outlined,
                label: 'Email',
                value: user.email,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _UserInfoRow(
                icon: Icons.phone_outlined,
                label: 'Phone',
                value: user.phone,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _UserInfoRow(
                icon: Icons.language_outlined,
                label: 'Website',
                value: user.website,
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _UserInfoRow(
                icon: Icons.location_on_outlined,
                label: 'Address',
                value: '${user.address.street}, ${user.address.city}',
                colorScheme: colorScheme,
              ),
              const SizedBox(height: 8),
              _UserInfoRow(
                icon: Icons.business_outlined,
                label: 'Company',
                value: user.company.name,
                colorScheme: colorScheme,
              ),
              if (user.company.catchPhrase.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.55,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '"${user.company.catchPhrase}"',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ColorScheme colorScheme;

  const _UserInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}