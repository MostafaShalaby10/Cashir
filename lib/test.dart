// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/pages/home_page.dart';
import 'package:lastcashir/widgets/center_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';


class test extends StatelessWidget {
  const test(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit , States>(builder: (context , state){
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          elevation: 0,
          title: Text(title),
          backgroundColor: primaryColor,
        ),
        body: PdfPreview(

          onPrinted: (value){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomePage()));
          },

          build: (format) => cubit.get(context).generatePdf(format, title),

        ),
      ) ;
    }, listener: (context , state){});
  }



}