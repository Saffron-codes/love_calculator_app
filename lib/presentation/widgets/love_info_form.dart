import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:love_calculator/core/utils/liner_progress_bar_color_checker.dart';
import 'package:love_calculator/presentation/bloc/love_info_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class LoveInfoForm extends StatelessWidget {
  const LoveInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController secondNameController = TextEditingController();
    ScreenshotController screenshotController = ScreenshotController();
    void resetForm() {
      formKey.currentState!.reset();
    }

    void takeScreenshot() async {
      String releaseUrl = "https://github.com/Saffron-codes/love_calculator_app/releases";
      screenshotController
          .capture(delay: Duration(seconds: 1))
          .then((image) async {
        final tempDir = await getTemporaryDirectory();
        final file = await File('${tempDir.path}/image.jpg').create();
        file.writeAsBytesSync(image!.toList());
        await Share.shareXFiles([XFile(file.path)],
            text: 'Get this app 🚀 \n$releaseUrl');
      });
    }

    return Screenshot(
      controller: screenshotController,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: const InputDecoration(hintText: "First Name"),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            TextFormField(
              controller: secondNameController,
              decoration: const InputDecoration(hintText: "Second Name"),
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              height: 80,
              child: BlocBuilder<LoveInfoBloc, LoveInfoState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is Loaded) {
                    int percentage = int.parse(state.loveInfo.percentage);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width * 0.9,
                          lineHeight: 14.0,
                          percent: percentage / 100,
                          backgroundColor: Colors.grey,
                          progressColor: getColor(percentage),
                          animation: true,
                          barRadius: Radius.circular(10),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${state.loveInfo.percentage}%"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(state.loveInfo.result),
                      ],
                    );
                  } else if (state is Error) {
                    return Text(state.message);
                  } else if (state is Empty) {
                    // resetForm();
                    return Text('Start by typing the first name..');
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            BlocBuilder<LoveInfoBloc, LoveInfoState>(
              builder: (context, state) {
                if (state is Loaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: ()=>takeScreenshot(),
                        child: const Text('Share this'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          resetForm();
                          BlocProvider.of<LoveInfoBloc>(context).add(Reset());
                        },
                        child: const Text('Reset'),
                      ),
                    ],
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<LoveInfoBloc>(context).add(
                        GetLoveInfoEvent(
                          firstName: firstNameController.text,
                          secondName: secondNameController.text,
                        ),
                      );
                    }
                  },
                  child: const Text('Check'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
