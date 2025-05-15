import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  final Color backgroundColor;

  const CharacterTile(this.character, {super.key, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final hasValidImage = character.image.trim().isNotEmpty;

    return Container(
      color: backgroundColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: hasValidImage
              ? NetworkImage(character.image)
              : const AssetImage('assets/icon/default.png') as ImageProvider,
        ),
        title: Text(character.name),
    subtitle: Text(
    character.house?.trim().isEmpty ?? true
    ? 'Ev Bilgisi Girilmemiş'
        : character.house!,
    style: TextStyle(
    color: character.house?.trim().isEmpty ?? true
    ? Colors.red
        : Colors.black,
    ),
    ),

    ),
    );
  }
}
