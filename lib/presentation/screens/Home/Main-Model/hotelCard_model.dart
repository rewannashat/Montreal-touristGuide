class HotelModel {
  final String imagePath;
  final String title;
  final String location;
  final double rating;
  final String? category; // <- Add this

  HotelModel({
    required this.imagePath,
    required this.title,
    required this.location,
    required this.rating,
     this.category,
  });
}



final List<HotelModel> hotels = [
  HotelModel(
    imagePath: 'assets/images/rec.png',
    title: 'Urban Stay',
    location: '300m city center',
    rating: 4.80,
    category: 'hotels',
  ),
  HotelModel(
    imagePath: 'assets/images/rec.png',
    title: 'Le Centre Sheraton',
    location: '500m city center',
    rating: 4.96,
    category: 'hotels',
  ),
  HotelModel(
    imagePath: 'assets/images/rec.png',
    title: 'Hotel Luxor',
    location: '1.2km from downtown',
    rating: 4.85,
    category: 'hotels',

  ),
  HotelModel(
    imagePath: 'assets/images/rec.png',
    title: 'Hilton Garden',
    location: '500m city center',
    rating: 4.96,
    category: 'hotels',
  ),];
