import 'package:flutter/material.dart';
import 'package:m/commons/utils/screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

typedef Widget Item<LT>(
    {BuildContext context, List<LT> data, int index, void cast});

class ListTitle extends StatelessWidget {
  final Widget title;
  final Widget list;
  final double top;
  ListTitle(this.title, this.list, {this.top = 23.5});
  @override
  Widget build(BuildContext context) {
    Screen screen = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: screen.heightConverter(top),
              bottom: screen.heightConverter(13),
              right: screen.widthConverter(18.5),
              left: screen.widthConverter(16)),
          child: title,
        ),
        list
      ],
    );
  }
}

Widget myShimmer(
    {@required BuildContext context,
    List<dynamic> data,
    int index,
    void cast}) {
  Screen screen = Provider.of<Screen>(context);

  return Shimmer.fromColors(
    enabled: false,
    child: Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(screen.aspectRatioConverter(10))),
        color: Colors.white,
      ),
      height: screen.heightConverter(15),
    ),
    baseColor: Color(0xfff3f3f4),
    highlightColor: Colors.white,
  );
}

/*


GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(More.route);
                  },
                  child: Text(
                    'Show More',
                    style: textTheme.body2.copyWith(
                        color: theme.primaryColorLight,
                        fontSize: ScreenUtil().setSp(14)),
                  ),
                )

*/
