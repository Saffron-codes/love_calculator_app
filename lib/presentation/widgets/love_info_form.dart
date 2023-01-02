import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:love_calculator/core/utils/liner_progress_bar_color_checker.dart';
import 'package:love_calculator/presentation/bloc/love_info_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LoveInfoForm extends StatelessWidget {
  const LoveInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController secondNameController = TextEditingController();
    return Form(
      key: formKey,
      
      child: Column(
        children: [
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(hintText: "First Name"),
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
            decoration: InputDecoration(hintText: "Second Name"),
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
            height: 100,
            child: BlocBuilder<LoveInfoBloc, LoveInfoState>(
              builder: (context, state) {
                if (state is Empty) {
                  return Text("Start Typing");
                } else if (state is Loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is Loaded) {
                  int percentage = int.parse(state.loveInfo.percentage);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width*0.9,
                        lineHeight: 14.0,
                        percent: percentage/100,
                        backgroundColor: Colors.grey,
                        progressColor: getColor(percentage),
                        animation: true,
                        barRadius: Radius.circular(10),
                      ),
                      SizedBox(height: 10,),
                      Text("${state.loveInfo.percentage}%"),
                      SizedBox(height: 10,),
                      Text(state.loveInfo.result),
                    ],
                  );
                } else if (state is Error) {
                  return Text(state.message);
                } else {
                  return Text('Unknown state');
                }
              },
            ),
          ),
          ElevatedButton(
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
          ),
        ],
      ),
    );
  }
}
