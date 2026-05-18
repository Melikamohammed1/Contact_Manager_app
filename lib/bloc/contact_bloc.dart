import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/contact_repository.dart';
import '../data/models/contact_model.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;

  ContactBloc({required this.repository}) : super(ContactLoading()) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<UpdateContactEvent>(_onUpdateContact);
    on<DeleteContactEvent>(_onDeleteContact);
  }

  Future<void> _onLoadContacts(LoadContacts event, Emitter<ContactState> emit) async {
    emit(ContactLoading());
    try {
      final contacts = await repository.getContacts();
      emit(ContactLoaded(contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onAddContact(AddContact event, Emitter<ContactState> emit) async {
    if (state is ContactLoaded) {
      final currentContacts = (state as ContactLoaded).contacts;
      try {
        
        final newContact = await repository.createContact(event.contact);
        final updatedList = List<Contact>.from(currentContacts)..add(newContact.copyWith(id: currentContacts.length + 1));
        emit(ContactLoaded(updatedList));
      } catch (e) {
        emit(ContactError("Could not add contact."));
      }
    }
  }

  Future<void> _onUpdateContact(UpdateContactEvent event, Emitter<ContactState> emit) async {
    if (state is ContactLoaded) {
      final currentContacts = (state as ContactLoaded).contacts;
      try {
        await repository.updateContact(event.contact);
        final updatedList = currentContacts.map((c) => c.id == event.contact.id ? event.contact : c).toList();
        emit(ContactLoaded(updatedList));
      } catch (e) {
        emit(ContactError("Could not update contact."));
      }
    }
  }

  Future<void> _onDeleteContact(DeleteContactEvent event, Emitter<ContactState> emit) async {
    if (state is ContactLoaded) {
      final currentContacts = (state as ContactLoaded).contacts;
      try {
        await repository.deleteContact(event.id);
        final updatedList = currentContacts.where((c) => c.id != event.id).toList();
        emit(ContactLoaded(updatedList));
      } catch (e) {
        emit(ContactError("Could not delete contact."));
      }
    }
  }
}