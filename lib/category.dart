import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';

import 'package:hello_rectangle/converter_route.dart';
import 'package:hello_rectangle/unit.dart';

final _rowHeight = 100.0;
final _rowPadding = 8.0;
final _iconPadding = 16.0;
final _iconSize = 60.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

/// A custom [Category] widget.
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;
  final List<Unit> units;

  /// creates a [Category].
  /// A [Category] saves the name of the category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. ruler).
  /// While the @required checks for whether a named parameter is passed in,
  /// it doesn't check whether the object passed in is null; We check that
  /// in the assert statement.
  const Category({
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        assert(units != null),
        super(key: key);

  /// Navigates to the [ConverterRoute].
  void _navigateToConveter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            centerTitle: true,
            backgroundColor: color,
            title: Text(
              name,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          body: ConverterRoute(
            color: color,
            name: name,
            units: units,
          ),
        );
      },
    ));
  }

  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: color,
          splashColor: color,
          // We can use either the `() => function()` or the ` () { function(); }`
          // syntax in onTap property.
          onTap: () {
            _navigateToConveter(context);
          },
          child: Padding(
            padding: EdgeInsets.all(_rowPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              // There are 2 ways to denote a list: `[]` and `List()`.
              // Prefer to use the literal syntax, i.e. `[]`, instead of `List()`.
              // You can add the type argument if you'd like, i.e. <Widget>[].
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(_iconPadding),
                  child: Icon(
                    iconLocation,
                    size: _iconSize,
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
