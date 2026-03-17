import 'package:flutter/material.dart';
import 'package:hangman/services/game_setting.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Consumer<GameSettingsProvider>(
        builder: (context, settings, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SwitchListTile(
                title: const Text('Sound'),
                subtitle: const Text('Toggle game sounds on/off'),
                value: !settings.isSoundMuted,
                onChanged: (enabled) {
                  settings.setSoundMuted(!enabled);
                },
                secondary: const Icon(Icons.volume_up),
              ),
              const SizedBox(height: 16),
        
            ],
          );
        },
      ),
    );
  }
}
