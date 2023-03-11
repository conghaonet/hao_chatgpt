enum ChatRole {
  system('system'),
  user('user'),
  assistant('assistant');

  const ChatRole(this.name);

  final String name;
}