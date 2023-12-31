import 'dart:typed_data';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/test.dart';
import 'package:printing/printing.dart';
// import 'package:printing/printing.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
import 'home_page.dart';

class FatoraDesign extends StatelessWidget {
  const FatoraDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(
        builder: (context, state) {
          // print("dasklasdsdasadhasdds ${cubit.get(context).billList[0][cubit.get(context).billList.length-1]["total"].toString()}");

          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (route) => false);
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                elevation: 0,
                title: Text("Fatora"),
                backgroundColor: primaryColor,
              ),
              body: ConditionalBuilder(
                  condition: state is SuccessfullyGetDetailsData,
                  builder: (context) => buildDesign(context),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator())));
        },
        listener: (context, state) {});
  }

  Widget buildDesign(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Name of Cafe',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '${cubit.get(context).billList[0][cubit.get(context).billList[0].length - 1]["date"].toString()}',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Number of Receipt : ${cubit.get(context).detailsList[0][0]['details_id'].toString()}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(
                  'Cashier name : ${cubit.get(context).billList[0][cubit.get(context).billList[0].length - 1]["name"].toString()}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              children: [
                Expanded(child: Text('Name')),
                Expanded(child: Text('Qantity')),
                Expanded(child: Text('Price')),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  '${cubit.get(context).detailsList[0][index]["item"]}')),
                          Expanded(
                              child: Text(
                                  '${cubit.get(context).detailsList[0][index]["quantity"].toString()}')),
                          Expanded(
                              child: Text(
                                  '${cubit.get(context).detailsList[0][index]["price"]}')),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => Container(
                      color: Colors.black,
                      height: 1,
                    ),
                itemCount: cubit.get(context).detailsList[0].length),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Row(
              children: [
                Text(
                  'Total:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${cubit.get(context).billList[0][cubit.get(context).billList[0].length - 1]["total"].toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Spacer(),
                      button(
                          context: context,
                          text: "Print",
                          color: primaryColor,
                          minWidth: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.height / 10,
                          function: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>test("Mostafa")));
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  //   final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  //   final font = await PdfGoogleFonts.nunitoExtraLight();
  //
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: format,
  //       build: (context) {
  //         return pw.Column(
  //           children: [
  //             pw.Text('8:10',style:pw.TextStyle(fontSize: 20,fontWeight: pw.FontWeight.bold)),
  //
  //             pw.Text('27/7/2023',style:pw.TextStyle(fontSize: 20,fontWeight: pw.FontWeight.bold)),
  //
  //             pw.SizedBox(height: 20),
  //
  //             pw.Row(
  //
  //               children: [
  //                 pw.Text('number of fatora:  15')
  //               ],
  //             ),
  //             pw.Row(
  //               children: [
  //                 pw.Text('cashir name: mahmoud')
  //               ],
  //             ),
  //
  //             pw.SizedBox(height: 20),
  //
  //             pw.Row(
  //               children:[
  //                 pw.Expanded(
  //                   child: pw.Text('Id'),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('name'),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('quantity'),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('price'),
  //                 ),
  //               ],
  //             ),
  //
  //             pw.SizedBox(height: 40),
  //
  //             pw.Row(
  //               children:[
  //                 pw.Expanded(
  //                   child: pw.Text('1'),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('pepsi'),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('10'),
  //                 ),
  //                 pw.Expanded(
  //                   child: pw.Text('100'),
  //                 ),
  //               ],
  //             ),
  //
  //             pw.SizedBox(height: 20),
  //             pw.Text('Total : 100',style:pw.TextStyle(fontSize: 20,fontWeight: pw.FontWeight.bold)),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  //
  //   return pdf.save();
  // }
}
