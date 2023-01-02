

import 'package:flutter/material.dart';

Color getColor(int percentage){
  if(percentage>=80){
    return Colors.pink;
  }else if(percentage>=30 && percentage<=79){
    return Colors.orange;
  }else{
    return Colors.red;
  }
}