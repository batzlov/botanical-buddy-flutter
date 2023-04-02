import 'package:flutter/material.dart';
import 'package:botanicalbuddy/components/label_checkox.dart';
import 'package:botanicalbuddy/components/icon_button_row.dart';

import 'package:botanicalbuddy/models/settings.dart';
import 'package:botanicalbuddy/services/api_service.dart';
import 'package:botanicalbuddy/services/auth_service.dart';
import 'package:botanicalbuddy/shared/utils.dart';

import '../welcome.dart';

class VSettings extends StatefulWidget {
  const VSettings({ Key? key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<VSettings> {
  ApiService api = ApiService();
  AuthService auth = AuthService();

  var headlineStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold
  );
  var textStyle = const TextStyle(
    fontSize: 15
  );

  Settings settings = Settings(
    id: 0,
    pourNotifications: false,
    fertilizeNotifications: false,
    mondayNotifications: false,
    tuesdayNotifications: false,
    wednesdayNotifications: false,
    thursdayNotifications: false,
    fridayNotifications: false,
    saturdayNotifications: false,
    sundayNotifications: false,
    remindDaily: false,
    remindWeekly: false,
  );

  @override
  void initState() {
    api.fetchSettings().then((fetchedSettings) {
      setState(() {
        settings = fetchedSettings;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Welche Benachrichtigungen möchtest du bekommen?",
                style: headlineStyle,
              ),
              const SizedBox(
                height: 3
              ),
              Text(
                "Du kannst hier Einstellen welche Art von Erinnerungen du bekommen möchtest.",
                style: textStyle,
              ),
              const SizedBox(
                height: 5
              ),
              LabelCheckbox(
                value: settings.pourNotifications, 
                onValueChange: (value) {
                  setState(() {
                    settings.pourNotifications = value;
                  });
                }, 
                alignHorizontal: true, 
                label: "Gieß-Erinnerungen"
              ),
              LabelCheckbox(
                value: settings.fertilizeNotifications, 
                onValueChange: (value) {
                  setState(() {
                    settings.fertilizeNotifications = value;
                  });
                }, 
                alignHorizontal: true, 
                label: "Dünge-Erinnerungen"
              ),
              const SizedBox(
                height: 10
              ),
              Text(
                "Wann dürfen wir dich stören?",
                style: headlineStyle,
              ),
              const SizedBox(
                height: 5
              ),
              Text(
                "Wähle die Tage in der Woche an denen wir dich stören dürfen. (Work in Progress)",
                style: textStyle,
              ),
              const SizedBox(
                height: 5
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LabelCheckbox(
                    value: settings.mondayNotifications, 
                    onValueChange: (value) {
                      setState(() {
                        settings.mondayNotifications = value;
                      });
                    }, 
                    alignHorizontal: false, 
                    label: "Mo"
                  ),
                  LabelCheckbox(
                    value: settings.tuesdayNotifications, 
                    onValueChange: (value) {
                      setState(() {
                        settings.tuesdayNotifications = value;
                      });
                    }, 
                    alignHorizontal: false, 
                    label: "Di"
                  ),
                  LabelCheckbox(
                    value: settings.wednesdayNotifications, 
                    onValueChange: (value) {
                      setState(() {
                        settings.wednesdayNotifications = value;
                      });
                    }, 
                    alignHorizontal: false, 
                    label: "Mi"
                  ),
                  LabelCheckbox(
                    value: settings.thursdayNotifications, 
                    onValueChange: (value) {
                      setState(() {
                        settings.thursdayNotifications = value;
                      });
                    }, 
                    alignHorizontal: false, 
                    label: "Do"
                  ),
                  LabelCheckbox(
                    value: settings.fridayNotifications, 
                    onValueChange: (value) {
                      setState(() {
                        settings.fridayNotifications = value;
                      });
                    }, 
                    alignHorizontal: false, 
                    label: "Fr"
                  ),
                  LabelCheckbox(
                    value: settings.saturdayNotifications, 
                    onValueChange: (value) {
                      setState(() {
                        settings.saturdayNotifications = value;
                      });
                    }, 
                    alignHorizontal: false, 
                    label: "Sa"
                  ),
                  LabelCheckbox(
                    value: settings.sundayNotifications, 
                    onValueChange: (value) {
                      setState(() {
                        settings.sundayNotifications = value;
                      });
                    }, 
                    alignHorizontal: false, 
                    label: "So"
                  ),
                ],
              ),
              const SizedBox(
                height: 3
              ),
              const SizedBox(
                height: 10
              ),
              Text(
                "Wie oft dürfen wir dich stören?",
                style: headlineStyle,
              ),
              const SizedBox(
                height: 3
              ),
              Text(
                "Wähle hier wie oft du daran erinnert werden möchtest, zu prüfen ob deine Pflanzen Wasser benötigen.",
                style: textStyle,
              ),
              const SizedBox(
                height: 5
              ),
              LabelCheckbox(
                value: settings.remindDaily, 
                onValueChange: (value) {
                  setState(() {
                    settings.remindDaily = value;
                    settings.remindWeekly = !value;
                  });
                }, 
                alignHorizontal: true, 
                label: "jeden Tag erinnern"
              ),
              LabelCheckbox(
                value: settings.remindWeekly, 
                onValueChange: (value) {
                  setState(() {
                    settings.remindWeekly = value;
                    settings.remindDaily = !value;
                  });
                }, 
                alignHorizontal: true, 
                label: "wöchentlich erinnern"
              ),
              const SizedBox(
                height: 10
              ),
              IconButtonRow(
                headline: "Einstellungen speichern!", 
                subHeadline: "Nur ein klick.", 
                onPressed: () async {
                  await api.saveSettings(settings);
                }, 
                icon: const Icon(Icons.save),
                backgroundColor: Colors.green.shade800
              ),
              const SizedBox(
                height: 15
              ),
              IconButtonRow(
                headline: "Vom Account abmelden?", 
                subHeadline: "Bis hoffentlich bald!", 
                onPressed: () async {
                  await auth.signOut();
                  resetNavigationAndOpenScreen(context, const Welcome());
                }, 
                icon: const Icon(Icons.exit_to_app),
                backgroundColor: Colors.red.shade400
              ),
            ]
          ),
        )
      ),
    );
  }
}