abstract class FavouriteRepository {
  Future getFavourite();
  Future addFavourite(int? id);
  Future deleteFavourite(int? id);
}