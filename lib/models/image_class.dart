const imageList = [
  'assets/images/pexels-1.jpg',
  'assets/images/pexels-2.jpg',
  'assets/images/pexels-3.jpg',
  'assets/images/pexels-4.jpg',
  'assets/images/pexels-5.jpg',
  'assets/images/pexels-6.jpg',
];

class ImageClass {
  final String imageUrl;
  final String title;
  final String id;
  final int imageNumber;

  const ImageClass({
    required this.imageUrl,
    required this.title,
    required this.id,
    required this.imageNumber,
  });
}
