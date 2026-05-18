import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/contact_model.dart';
import '../../../bloc/contact_bloc.dart';
import '../../../bloc/contact_event.dart';

class ContactFormScreen extends StatefulWidget {
  final Contact? contact; 

  const ContactFormScreen({super.key, this.contact});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _phoneController = TextEditingController(text: widget.contact?.phone ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final contact = Contact(
        id: widget.contact?.id,
        name: _nameController.text,
        phone: _phoneController.text,
      );

      if (widget.contact == null) {
        context.read<ContactBloc>().add(AddContact(contact));
      } else {
        context.read<ContactBloc>().add(UpdateContactEvent(contact));
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                child: const Text('Save Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}