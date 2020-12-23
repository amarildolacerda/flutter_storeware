/// Example of a time series chart using a bar renderer.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashTimeSeriesBar extends StatelessWidget {
  final List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
  final bool animate;
  final bool showSeriesNames;
  final List<charts.SeriesRendererConfig<DateTime>> customSeriesRenderers;

  DashTimeSeriesBar(this.seriesList,
      {this.animate, this.showSeriesNames = false, this.customSeriesRenderers});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory DashTimeSeriesBar.withSampleData() {
    return new DashTimeSeriesBar(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      customSeriesRenderers: customSeriesRenderers,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [
        new charts.SelectNearest(),
        new charts.DomainHighlighter(),
        if (showSeriesNames)
          charts.SeriesLegend(position: charts.BehaviorPosition.bottom)
      ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    return createSerie(id: 'vendas', data: [
      new TimeSeriesSales(new DateTime(2017, 9, 1), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 2), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 3), 25),
      new TimeSeriesSales(new DateTime(2017, 9, 4), 100),
      new TimeSeriesSales(new DateTime(2017, 9, 5), 75),
      new TimeSeriesSales(new DateTime(2017, 9, 6), 88),
      new TimeSeriesSales(new DateTime(2017, 9, 7), 65),
      new TimeSeriesSales(new DateTime(2017, 9, 8), 91),
      new TimeSeriesSales(new DateTime(2017, 9, 9), 100),
      new TimeSeriesSales(new DateTime(2017, 9, 10), 111),
      new TimeSeriesSales(new DateTime(2017, 9, 11), 90),
      new TimeSeriesSales(new DateTime(2017, 9, 12), 50),
      new TimeSeriesSales(new DateTime(2017, 9, 13), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 14), 30),
      new TimeSeriesSales(new DateTime(2017, 9, 15), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 16), 50),
      new TimeSeriesSales(new DateTime(2017, 9, 17), 30),
      new TimeSeriesSales(new DateTime(2017, 9, 18), 35),
      new TimeSeriesSales(new DateTime(2017, 9, 19), 40),
      new TimeSeriesSales(new DateTime(2017, 9, 20), 32),
      new TimeSeriesSales(new DateTime(2017, 9, 21), 31),
    ]);
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> createSerie(
      {String id, List<TimeSeriesSales> data}) {
    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: id,
        colorFn: (TimeSeriesSales sales, __) =>
            sales.color ?? charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class TimeSeriesSales {
  final DateTime time;
  final num sales;
  final charts.Color color;

  TimeSeriesSales(this.time, this.sales, {this.color});
}

class DashTimeSeriesLine extends StatelessWidget {
  final List<charts.Series<TimeSeriesSales, DateTime>> seriesList;
  final bool animate;
  final bool showSeriesNames;
  final List<charts.SeriesRendererConfig<DateTime>> customSeriesRenderers;
  final bool includeArea;
  final bool stacked;
  final String dateFormat;
  final int labelRotation;
  final bool includeLine;
  DashTimeSeriesLine(this.seriesList,
      {this.animate,
      this.customSeriesRenderers,
      this.includeArea = false,
      this.stacked = false,
      this.dateFormat = 'dd/MMM',
      this.labelRotation = 0,
      this.includeLine = true,
      this.showSeriesNames = false});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Set the default renderer to a bar renderer.
      // This can also be one of the custom renderers of the time series chart.
      defaultRenderer: new charts.LineRendererConfig<DateTime>(
        includeArea: includeArea,
        stacked: stacked,
        includeLine: includeLine,
      ),
      customSeriesRenderers: customSeriesRenderers,
      // It is recommended that default interactions be turned off if using bar
      // renderer, because the line point highlighter is the default for time
      // series chart.
      defaultInteractions: false,
      // If default interactions were removed, optionally add select nearest
      // and the domain highlighter that are typical for bar charts.
      behaviors: [
        new charts.SelectNearest(),
        new charts.DomainHighlighter(),
        if (showSeriesNames)
          charts.SeriesLegend(
            position: charts.BehaviorPosition.bottom,
          ),
      ],
      dateTimeFactory:
          LocalizedDateTimeFactory(Localizations.localeOf(context)),
      primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(zeroBound: false)),
      domainAxis: charts.DateTimeAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
              minimumPaddingBetweenLabelsPx: 4,
              labelAnchor: charts.TickLabelAnchor.centered,
              labelStyle: charts.TextStyleSpec(
                fontSize: 10,
                color: charts.MaterialPalette.black,
              ),
              labelRotation: labelRotation,
              // Change the line colors to match text color.
              lineStyle:
                  charts.LineStyleSpec(color: charts.MaterialPalette.white)),
          tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
              day: charts.TimeFormatterSpec(
            format: dateFormat,
            transitionFormat: dateFormat,
          ))),
    );
  }

  static List<charts.Series<TimeSeriesSales, DateTime>> createSerie(
      {String id, List<TimeSeriesSales> data, num strokeWidth = 1}) {
    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: id,
        colorFn: (TimeSeriesSales sales, __) =>
            sales.color ?? charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        strokeWidthPxFn: (sales, idx) => strokeWidth,
        data: data,
      )
    ];
  }
}

class LocalizedDateTimeFactory extends charts.LocalDateTimeFactory {
  final Locale locale;

  @override
  DateFormat createDateFormat(String pattern) {
    return DateFormat(pattern, locale.languageCode);
  }

  LocalizedDateTimeFactory(this.locale);
}
