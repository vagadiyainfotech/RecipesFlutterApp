import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeInlinePage extends StatefulWidget {
  const NativeInlinePage({Key? key}) : super(key: key);

  @override
  State<NativeInlinePage> createState() => _NativeInlinePageState();
}

class _NativeInlinePageState extends State<NativeInlinePage> {
  // TODO: Add _kAdIndex
  static final _kAdIndex = 4;

  // TODO: Add a NativeAd instance
  late NativeAd _ad;

  // TODO: Add _isAdLoaded
  bool _isAdLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // TODO: Add _getDestinationItemIndex()
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void initState() {
    super.initState();

    // TODO: Create a NativeAd instance
    _ad = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }
}
