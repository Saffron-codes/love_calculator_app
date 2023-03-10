import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:love_calculator/injection_container.dart';
import 'package:love_calculator/presentation/bloc/love_info_bloc.dart';
import 'package:love_calculator/presentation/widgets/love_info_form.dart';
import 'package:share_plus/share_plus.dart';

class LoveInfoPage extends StatelessWidget {
  const LoveInfoPage({super.key});

  void shareApp()async{
    String releaseUrl = "https://github.com/Saffron-codes/love_calculator_app/releases";
    await Share.share('Calculate your love percentage \nGet this app 🚀 \n$releaseUrl');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Love Calculator'),
        actions: [
          IconButton(
            onPressed: ()=>shareApp(),
            tooltip: "Share App",
            icon: const Icon(Icons.share),
          )
        ],
      ),
      body: BlocProvider<LoveInfoBloc>(
        create: (_) => sl<LoveInfoBloc>(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: LoveInfoBody(),
        ),
      ),
    );
  }
}

class LoveInfoBody extends StatelessWidget {
  const LoveInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.24,
        ),
        const LoveInfoForm(),
        // SizedBox(height: MediaQuery.of(context).size.height*0.9,),
        // Spacer(flex: 2,)
      ],
    );
  }
}
