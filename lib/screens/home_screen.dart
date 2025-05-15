import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/character_provider.dart';
import '../widgets/character_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characterAsyncValue = ref.watch(characterProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade700,
        centerTitle: true,
        title: const Text(
          'Harry Potter Karakterleri',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              'assets/icon/harry_potter_logo1.png',
              height: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),

      body: Container(
        color: Colors.grey.shade100,
        child: characterAsyncValue.when(
          data: (characters) => ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              final tileColor = index.isEven
                  ? Colors.white
                  : Colors.grey.shade200;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: CharacterTile(
                  character,
                  backgroundColor: tileColor,
                ),
              );
            },

          ),
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.deepPurple),
          ),
          error: (e, _) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/icon/error.png",
                  height: 90,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Bir hata oluştu.Lütfen tekrar deneyin.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => ref.refresh(characterProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const Text(
                    'Yeniden Dene',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
