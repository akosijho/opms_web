import 'package:opmswebstaff/extensions/string_extension.dart';
import 'package:opmswebstaff/ui/views/numeric_report/numericReportViewModel.dart';
import 'package:opmswebstaff/ui/widgets/sales_date_card/sales_date_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../../constants/styles/palette_color.dart';

class NumericReport extends StatelessWidget {
  const NumericReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NumericReportViewModel>.reactive(
      viewModelBuilder: () => NumericReportViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          title: Text('Reports'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: 10),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                          color: Colors.grey.shade900,
                          width: 6,
                        ))),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Clinic's revenue",
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 1.4,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'All Time',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 20,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${model.totalRevenue}'.toCurrency!,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        letterSpacing: 1.4,
                        color: Colors.deepOrange,
                      ),
                    ),
                    SalesDateCard(
                      amount: model.revYear,
                      title: 'This Year',
                      borderColor: Colors.orange.shade900,
                      onTap: () {},
                    ),
                    SalesDateCard(
                      amount: model.revMonth,
                      title: 'This Month',
                      borderColor: Colors.deepOrangeAccent.shade700,
                      onTap: () {},
                    ),
                    SalesDateCard(
                      amount: model.revDay,
                      title: 'Today',
                      borderColor: Colors.brown,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                left: BorderSide(
                          color: Colors.blueGrey.shade900,
                          width: 6,
                        ))),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Clinic's expenses",
                          style: GoogleFonts.robotoCondensed(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 1.4,
                            color: Colors.blueGrey.shade900,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'All Time',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 20,
                          color: Colors.grey.shade900,
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${model.totalExpenses}'.toCurrency!,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        letterSpacing: 1.4,
                        color: Palettes.kcNeutral1,
                      ),
                    ),
                    SalesDateCard(
                      amount: model.expYear,
                      title: 'This Year',
                      borderColor: Palettes.kcBlueDark,
                      onTap: () {},
                    ),
                    SalesDateCard(
                      amount: model.expMonth,
                      title: 'This Month',
                      borderColor: Palettes.kcDarkerBlueMain1,
                      onTap: () {},
                    ),
                    SalesDateCard(
                      amount: model.expDay,
                      title: 'Today',
                      borderColor: Colors.blueGrey.shade800,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
