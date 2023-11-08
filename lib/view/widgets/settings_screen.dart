import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitchedNotification = false;
  bool isSwitchedDarklight = false;
  String dropdownvalue = 'Malayalam';
  var languages = [
    'Malayalam',
    'English',
    'Hindi',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F41BB),
        title: Text("Settings"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              children: [
                Card(
                  color: Color(0xFFF3F4F6),
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 30,
                      color: const Color(0xFF4A4A5F),
                    ),
                    title: Text('Account',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 16,
                        )),
                  ),
                ),
                Card(
                  color: Color(0xFFF3F4F6),
                  child: ListTile(
                    leading: Icon(
                      Icons.privacy_tip_outlined,
                      size: 30,
                      color: const Color(0xFF4A4A5F),
                    ),
                    title: Text('Privacy and policy',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 16,
                        )),
                  ),
                ),
                Card(
                  color: Color(0xFFF3F4F6),
                  child: ListTile(
                    leading: Icon(Icons.notifications,
                        size: 30, color: const Color(0xFF4A4A5F)),
                    title: Text('Notification',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 16,
                        )),
                    trailing: Transform.scale(
                      scale:
                          0.9, // Adjust the scale factor to change the switch size
                      child: Switch(
                        onChanged: (value) {
                          setState(() {
                            isSwitchedNotification = value;
                          });
                          print(
                              'Switch Button is ${isSwitchedNotification ? 'ON' : 'OFF'}');
                        },
                        value: isSwitchedNotification,
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.yellow,
                        inactiveThumbColor: Colors.redAccent,
                        inactiveTrackColor: Colors.orange,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Color(0xFFF3F4F6),
                  child: ListTile(
                    leading: Icon(Icons.dark_mode,
                        size: 30, color: const Color(0xFF4A4A5F)),
                    title: Text('Dark/Light Mode',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 16,
                        )),
                    trailing: Transform.scale(
                      scale:
                          0.9, // Adjust the scale factor to change the switch size
                      child: Switch(
                        onChanged: (value) {
                          setState(() {
                            isSwitchedDarklight = value;
                          });
                          print(
                              'Switch Button is ${isSwitchedDarklight ? 'ON' : 'OFF'}');
                        },
                        value: isSwitchedDarklight,
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.yellow,
                        inactiveThumbColor: Colors.redAccent,
                        inactiveTrackColor: Colors.orange,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Color(0xFFF3F4F6),
                  child: ListTile(
                      leading: Icon(Icons.language,
                          size: 30, color: const Color(0xFF4A4A5F)),
                      title: Text('Language',
                          style: TextStyle(
                            fontFamily: 'Poppins-Regular',
                            fontSize: 16,
                          )),
                      trailing: DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: languages.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      )),
                ),
                const Card(
                  color: Color(0xFFF3F4F6),
                  child: ListTile(
                    leading: Icon(Icons.password,
                        size: 30, color: Color(0xFF4A4A5F)),
                    title: Text('Change Password',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 16,
                        )),
                  ),
                ),
                const Card(
                  color: Color(0xFFF3F4F6),
                  child: ListTile(
                    leading: Icon(Icons.delete,
                        size: 30, color: Color(0xFF4A4A5F)),
                    title: Text('Delete Account',
                        style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 16,
                        )),
                  ),
                ),
                const Card(
                  color: Color(0xFFF3F4F6),
                  child: ListTile(
                    leading: Icon(Icons.logout,
                        size: 30, color: Color(0xFF4A4A5F)),
                    title: Text(
                      'Log Out',
                      style: TextStyle(
                        fontFamily: 'Poppins-Regular',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
