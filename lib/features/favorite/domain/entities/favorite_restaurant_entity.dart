import 'package:objectbox/objectbox.dart';

@Entity()
class FavoriteRestaurantEntity {
  @Id()
  int id = 0;

  @Index()
  late String restaurantId;

  FavoriteRestaurantEntity();
}
