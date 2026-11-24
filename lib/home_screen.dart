import 'package:flutter/material.dart';

import 'contact_model.dart';
import 'contact_card.dart';
import 'add_contact_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Contact> contacts = [];

  Future<void> addContact() async {
    final contact = await showModalBottomSheet<Contact>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddContactSheet(),
    );

    if (!mounted || contact == null) return;

    setState(() {
      contacts.add(contact);
    });
  }

  void deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF29384B),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset('assets/images/route.png', width: 65),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: contacts.isEmpty
                    // Empty Screen
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/img_home screen.png',
                              width: 180,
                              height: 180,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'There is No Contacts Added Here',
                              style: TextStyle(color: Color(0xFFFFF1D4)),
                            ),
                          ],
                        ),
                      )
                    // Contacts Grid
                    : GridView.builder(
                        itemCount: contacts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.68,
                            ),

                        itemBuilder: (context, index) {
                          return ContactCard(
                            contact: contacts[index],
                            onDelete: () {
                              deleteContact(index);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: addContact,
        backgroundColor: const Color(0xFFFFF1D4),
        child: const Icon(Icons.add, color: Color(0xFF29384B)),
      ),
    );
  }
}
