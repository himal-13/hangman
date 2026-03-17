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
              ListTile(
                title: const Text('Max Hints Per Word'),
                subtitle: const Text('Adjust how many hints you can use for each word'),
                trailing: DropdownButton<int>(
                  value: settings.maxHints,
                  items: List.generate(6, (index) => index)
                      .skip(1)
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text('$value'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      settings.setMaxHints(value);
                    }
                  },
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () async {
                  await settings.resetHintUsage();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hints usage reset')),
                    );
                  }
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Hint Usage'),
              ),
            ],
          );
        },
      ),
    );
  }
}
