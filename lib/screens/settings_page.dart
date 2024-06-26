import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/screens/home_page.dart';
import 'package:passwordmanager/services/local_auth_service.dart';
import 'package:passwordmanager/services/import_export_json.dart';
import 'package:passwordmanager/theme/themes.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../theme/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLocalAuthOn = Hive.box<bool>('preferences').get('localAuthState', defaultValue: false)!;
  bool isLightTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.systemOverlayStyle!.statusBarColor,
        statusBarIconBrightness: Theme.of(context).appBarTheme.systemOverlayStyle!.statusBarIconBrightness,
        systemNavigationBarColor: Theme.of(context).appBarTheme.systemOverlayStyle!.systemNavigationBarColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).appBarTheme.systemOverlayStyle!.systemNavigationBarIconBrightness,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                            child: Icon(Icons.home_rounded, size: 32,color: Theme.of(context).primaryTextTheme.headlineMedium?.color,)),
                        Text(
                          ' / Settings',
                          style: Theme.of(context).primaryTextTheme.headlineMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Manage the app's behaviour",
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 32),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "Biometric Lock",
                                style: Theme.of(context).primaryTextTheme.bodySmall,
                              ),
                            ),
                            const Spacer(),
                            Switch(
                              value: isLocalAuthOn,
                              activeColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                              onChanged: (value) async {
                                bool auth = await LocalAuth.authenticate();
                                Hive.box<bool>('preferences').put('localAuthState', auth);
                                setState(() {
                                  isLocalAuthOn = auth;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: (){
                        context.read<ThemeProvider>().toggleTheme();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Text(
                                "Toggle Theme",
                                style: Theme.of(context).primaryTextTheme.bodySmall,
                              ),
                              const Spacer(),
                              Icon(
                                  isLightTheme(context)
                                      ? Icons.light_mode
                                      : Icons.dark_mode,
                                  size: 30)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () => filePermHandler(context, true),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  "Import JSON file",
                                  style: Theme.of(context).primaryTextTheme.bodySmall,
                                ),
                                const Spacer(),
                                const Icon(Icons.download_rounded, size: 32),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: () => filePermHandler(context, false),
                          borderRadius: BorderRadius.circular(16),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  "Export JSON file",
                                  style: Theme.of(context).primaryTextTheme.bodySmall,
                                ),
                                const Spacer(),
                                const Icon(Icons.upload_rounded, size: 32),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                      "Sujan ⌁ Yeril ⌁ Sarthak ⌁ Yogesh",
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.bodySmall?.color,
                        fontSize: 12,
                        letterSpacing: 1.5,
                      ),
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
