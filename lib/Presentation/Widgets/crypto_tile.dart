import 'package:flutter/material.dart';
import 'package:mock_tradex/Presentation/Screens/graph_page.dart';
import 'package:mock_tradex/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cached_network_image/cached_network_image.dart';

// name too long or price too long overlow issue
class CryptoTile extends StatelessWidget {
  final String? cryptoName;
  final String? cryptoSymbol;
  final String? currentPrice;
  final double? priceChange;
  final String? imageUrl;
  final int? index;
  final double? high_24h;
  final double? low_24h;
  final double? totalVolume;

  const CryptoTile({
    Key? key,
    this.cryptoName,
    this.cryptoSymbol,
    this.currentPrice,
    this.priceChange,
    this.imageUrl,
    this.index,
    this.high_24h,
    this.low_24h,
    this.totalVolume,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GraphPage(
              cryptoSymbol: cryptoSymbol,
              cryptoName: cryptoName,
              cryptoPrice: currentPrice,
              priceChange: priceChange,
              high_24h: high_24h,
              low_24h: low_24h,
              totalVolume: totalVolume,
              imageurl: imageUrl,
              index: index,
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        color:Color(0xff080c10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: 0.5,
              decoration: BoxDecoration(
                border: Border(
                  bottom: Divider.createBorderSide(context,
                      color: Colors.black, width: 0.5),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.black,
                        child: CachedNetworkImage(
                          imageUrl: imageUrl!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                cryptoSymbol!,
                                style: kTickerTextStyle.copyWith(fontSize: 16),
                              ),
                              Text(
                                '/USD',
                                style: kTickerSubTextStyle.copyWith(
                                  fontSize: 10,
                                ),
                              )
                            ],
                          ),
                          Text(
                            cryptoName!,
                            style: kTickerTextStyle.copyWith(
                                fontSize: 12, color: Color(0xFF596777)),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        '\$' + currentPrice.toString(),
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                    ),

                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            (priceChange! > 0) ? Color(0xff139b4d) : Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                      ),
                      width: 72.0,
                      height: 32,
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            (priceChange! > 0)
                                ? Icons.arrow_upward
                                : Icons.arrow_downward,
                            color: Colors.white,
                            size: 12,
                          ),
                          Text(
                            ' ' + priceChange!.toStringAsFixed(2) + '%',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.5,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              )
            ]),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  left: Divider.createBorderSide(context,
                      color: Colors.black, width: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
