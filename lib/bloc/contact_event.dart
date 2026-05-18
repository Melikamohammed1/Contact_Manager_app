import 'package:equatable/equatable.dart';
import '../data/models/contact_model.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
  @override
  List<Object?> get props => [];
}

class LoadContacts extends ContactEvent {}
class AddContact extends ContactEvent {
  final Contact contact;
  const AddContact(this.contact);
  @override
  List<Object> get props => [contact];
}
class UpdateContactEvent extends ContactEvent {
  final Contact contact;
  const UpdateContactEvent(this.contact);
  @override
  List<Object> get props => [contact];
}
class DeleteContactEvent extends ContactEvent {
  final int id;
  const DeleteContactEvent(this.id);
  @override
  List<Object> get props => [id];
}