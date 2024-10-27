enum UserRole {
  admin('Administrator'),
  editor('Editor'),
  viewer('Viewer'),
  guest('Guest');

  final String description;

  const UserRole(this.description);
}
