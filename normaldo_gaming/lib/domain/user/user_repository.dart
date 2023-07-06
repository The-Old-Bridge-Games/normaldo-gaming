import 'entities/user.dart';

abstract interface class UserRepository {
  Future<User> getUser();
  Future<User> updateUser();
  Future<User> createUser();
  Future<void> deleteUser();
}
