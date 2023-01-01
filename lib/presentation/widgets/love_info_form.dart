import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:love_calculator/presentation/bloc/love_info_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LoveInfoForm extends StatelessWidget {
  const LoveInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _firstNameController = TextEditingController();
    TextEditingController _secondNameController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(hintText: "First Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _secondNameController,
            decoration: InputDecoration(hintText: "Second Name"),
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
                  return Text("Start Playing");
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
                        progressColor: percentage>80?Colors.red:Colors.blue,
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
              if (_formKey.currentState!.validate()) {
                BlocProvider.of<LoveInfoBloc>(context).add(
                  GetLoveInfoEvent(
                    firstName: _firstNameController.text,
                    secondName: _secondNameController.text,
                  ),
                );
              }
            },
            child: Text('Check'),
          ),
        ],
      ),
    );
  }
}
