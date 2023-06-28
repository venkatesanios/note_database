import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:image_compare/image_compare.dart';

// class ImageCompare extends StatelessWidget {
//   const ImageCompare({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ImageComparePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

class ImageComparePage extends StatelessWidget {
  const ImageComparePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('image Compare'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
              onPressed: () async {
                var assetBundle = DefaultAssetBundle.of(context);
                var bytes1 = await assetBundle.load('assets/images/img1.png');
                var bytes2 =
                    await assetBundle.load('assets/images/loginbgdrop.png');
// assets/images/loginbgdrop.png
                var image1 = decodeImage(bytes1.buffer.asUint8List());
                var image2 = decodeImage(bytes2.buffer.asUint8List());

                var assetResult = await compareImages(
                    src1: image1,
                    src2: image2,
                    algorithm: IMED(blurRatio: 0.001));

                print('Difference: ${assetResult * 100}%');

                // Calculate intersection histogram difference between two bytes of images
                var byteResult = await compareImages(
                    src1: bytes1.buffer.asUint8List(),
                    src2: bytes2.buffer.asUint8List(),
                    algorithm: IntersectionHistogram());

                print('Difference: ${byteResult * 100}%');

                // Calculate euclidean color distance between two images
                var imageResult = await compareImages(
                    src1: image1,
                    src2: image2,
                    algorithm: EuclideanColorDistance(ignoreAlpha: true));

                print('Difference: ${imageResult * 100}%');
              },
              child: const Text('Compare Images'),
            ),
          ],
        ),
      ),
    );
  }
}
