import 'package:objectbox/objectbox.dart';

@Entity()
class FavoriteDishEntity {
  @Id()
  int id = 0;

  @Index()
  late String dishId;

  String? restaurantId;

  FavoriteDishEntity();
}
