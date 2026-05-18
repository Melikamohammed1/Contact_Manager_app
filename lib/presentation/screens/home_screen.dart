import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/contact_bloc.dart';
import '../../bloc/contact_state.dart';
import '../../bloc/contact_event.dart';
import '../widgets/contact_tile.dart';
import './contact_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Manager'),
        actions: [
          // Refresh button to easily re-fetch contacts from the API
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ContactBloc>().add(LoadContacts());
            },
          ),
        ],
      ),
      body: BlocConsumer<ContactBloc, ContactState>(
        
        listener: (context, state) {
          if (state is ContactError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
       
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ContactLoaded) {
            if (state.contacts.isEmpty) {
              return const Center(
                child: Text(
                  'No contacts found.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.contacts.length,
              itemBuilder: (context, index) {
                final contact = state.contacts[index];
                return ContactTile(contact: contact);
              },
            );
          } else if (state is ContactError) {
           
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  const Text('Failed to load contacts.'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ContactBloc>().add(LoadContacts());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ContactFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}