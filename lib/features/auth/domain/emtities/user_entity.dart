import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? role;
  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
     this.role,
  });

  @override
  List<Object?> get props => [id, email];
}
