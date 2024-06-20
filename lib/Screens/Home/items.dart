// class Items {
//   Items(
//       this.name, this.discription, this.previousPrice, this.price, this.image_);
//   String image_;
//   String name;
//   String discription;
//   double price;
//   double previousPrice;
// }

class Items {
  final String id;
  final String name;
  final String description;
  final double price;
  final double previousPrice;
  final String image;
  int quntity;

  Items({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.previousPrice,
    required this.image,
    required this.quntity
  });
}
