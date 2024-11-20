import 'package:flutter/material.dart';
import 'package:mc656finalproject/components/ods_icon.dart';
import 'package:mc656finalproject/services/ods.dart';
import 'package:mc656finalproject/utils/colors.dart';
import 'package:mc656finalproject/utils/ods.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});
  
  @override
  _PreferenceScreen createState() => _PreferenceScreen();
}

class _PreferenceScreen extends State<PreferenceScreen>{
  List<String> chosen_ods_components = [];
  List<OdsIcon> available_ods_components = []
  List<OdsIcon> available_ods = Ods.ods;

  for(var ods in available_ods){
    OdsIcon ods_icon = OdsIcon(ods: ods);
    available_ods_components.add(ods_icon);
  }

  @override
  Widget build(BuildContext context){

  }
}
