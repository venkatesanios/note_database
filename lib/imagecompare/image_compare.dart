import 'dart:io';
import 'package:image/image.dart';
import 'package:image_compare/image_compare.dart';

void main(List<String> arguments) async {
  var url1 =
      'https://www.tompetty.com/sites/g/files/g2000007521/f/sample_01.jpg';
  var url2 =
      'https://fujifilm-x.com/wp-content/uploads/2019/08/x-t30_sample-images03.jpg';

  var file1 = File('../images/img1.png');
  var file2 = File('../images/img2.png');

  var bytes1 = File('../images/img1.png').readAsBytesSync();
  var bytes2 = File('../images/img2.png').readAsBytesSync();

  var image1 = decodeImage(bytes1);
  var image2 = decodeImage(bytes2);

  // Calculate IMED between two asset images
  var assetResult = await compareImages(
      src1: image1, src2: image2, algorithm: IMED(blurRatio: 0.001));

  print('Difference: ${assetResult * 100}%');

  // Calculate intersection histogram difference between two bytes of images
  var byteResult = await compareImages(
      src1: bytes1, src2: bytes2, algorithm: IntersectionHistogram());

  print('Difference: ${byteResult * 100}%');

  // Calculate euclidean color distance between two images
  var imageResult = await compareImages(
      src1: file1,
      src2: file2,
      algorithm: EuclideanColorDistance(ignoreAlpha: true));

  print('Difference: ${imageResult * 100}%');

  // Calculate pixel matching between one network and one asset image
}
