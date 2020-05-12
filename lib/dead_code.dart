/*
class HorizontalListDash extends StatelessWidget {
  final List data;
  HorizontalListDash(this.data);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    var screen = Provider.of<Screen>(context);

    return ListTitle(
        Text("Related", style: textTheme.body2),
        SizedBox.fromSize(
          size: Size.fromHeight(screen.heightConverter(161)),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            padding:
                EdgeInsets.symmetric(horizontal: screen.widthConverter(16)),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) => SizedBox.fromSize(
              child: FutureProvider<Response<Map<String, dynamic>>>(
                catchError: (_, __) => Response(),
                child: Consumer<Response<Map<String, dynamic>>>(
                    builder: (_, Response<Map<String, dynamic>> response, __) {
                  if (response == null) {
                    return myShimmer(context: context);
                  } else {
                    var horizontalListElement = HorizontalListElement.fromJson(
                        response.data['success']);
                    return ImageWithItsText(
                      onTap: () {
                        Navigator.pushNamed(context, InfoRoot.route,
                            arguments: horizontalListElement);
                      },
                      imageUrl: horizontalListElement.mainImagePath,
                      alignmentGeometry: Alignment(0, 0.90),
                      text: Text(
                        horizontalListElement.getTitle,
                        style: textTheme.caption,
                      ),
                    );
                  }
                }),
                create: (BuildContext context) =>
                    Dio().get(ApisUrls.info + data[index]['tour_id']),
              ),
              size: Size.fromWidth(
                screen.widthConverter(133),
              ),
            ),
            itemCount: data.length,
            separatorBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.widthConverter(10))),
          ),
        ));
  }
}   MyFutureBuilder<Position>(
                request: Geolocator().getCurrentPosition(),
                loading: Container(
                  height: 20,
                  width: 80,
                  color: Colors.red,
                ),
                fullResponse: (snapshot) {
                  print(snapshot.longitude.toString() + '!!');
                  return MyFutureBuilder<List<Placemark>>(
                    loading:
                        Container(height: 20, width: 20, color: Colors.green),
                    request: Geolocator().placemarkFromPosition(snapshot,
                        localeIdentifier:
                            Localization.of(context).locale.languageCode),
                    fullResponse: (snapshot) {
                      String address = '';
                      var placeMark = snapshot.first.toJson();
                      placeMark.remove('position');
                      placeMark.remove('isoCountryCode');
                      placeMark.removeWhere((k, v) => v.toString().isEmpty);
                      placeMark.values.toSet();
                      var values = placeMark.values.toSet().toList();

                      for (var i = 0; i < values.length; i++) {
                        address += values[i].toString() +
                            (i == values.length - 1 ? '' : ',');
                      }

                      address.trim();
                      return InfoLine(
                          iconData: Icons.location_on, text: address);
                    },
                  );
                },
              ),

*/
