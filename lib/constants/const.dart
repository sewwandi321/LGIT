import 'package:uuid/uuid.dart';

/*Created by - IT19246024 - Warnakulasuriya D.A*/
/* Learn from tutorial
This method generate ids which is used in blog_service and storage_service classes */
String generateId() {
  return const Uuid().v1();
}
