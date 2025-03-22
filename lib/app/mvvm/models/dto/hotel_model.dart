class Hotel {
  final String id;
  final String name;
  final String location;
  final String description;
  final double rating;
  final double price;
  final List<String> images;
  final List<String> videoUrls;
  final List<String> amenities;
  final List<String> tags;
  final String songName;
  final String artistName;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.rating,
    required this.price,
    required this.images,
    required this.videoUrls,
    required this.amenities,
    required this.tags,
    required this.songName,
    required this.artistName,
  });

  factory Hotel.empty() {
    return Hotel(
      id: '',
      name: '',
      location: '',
      description: '',
      rating: 0.0,
      price: 0.0,
      images: [],
      videoUrls: [],
      amenities: [],
      tags: [],
      songName: '',
      artistName: '',
    );
  }
}
