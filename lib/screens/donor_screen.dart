import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_project/screens/location_input.dart';
import 'package:new_project/service/data_service.dart';
import 'package:new_project/shared/colors.dart';

class DonorScreen extends StatefulWidget {
  const DonorScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DonorScreen();
  }
}

class _DonorScreen extends State<DonorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bloodController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DataService dataService = DataService();
  void _onsubmit() async{
    if (_formKey.currentState!.validate()) {
      Map<String, String> data = {
        'name': _nameController.text,
        'bloodgroup': _bloodController.text,
        'phoneno': _phoneController.text
      };
      var response = await dataService.becomedonor('/becomedonor', data);
      if(response!=null){
          Map<String, dynamic> jsonResponse = json.decode(response);
        // if (jsonResponse.containsKey('success') &&
        //     jsonResponse['success'] == false) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(jsonResponse['error'])),
        //   );
        // } 
         if (jsonResponse.containsKey('success') &&
            jsonResponse['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Successfully submitted')),
          );
        } 
      }
       
        
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.secondaryColor,
        title: const Text(
          'Blood Donor',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  cursorHeight: 20,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                    labelText: 'Blood group',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your blood group';
                    }

                    return null;
                  },
                  controller: _bloodController,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: TextFormField(
                    cursorHeight: 20,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please phone number';
                      }
                      return null;
                    },
                    controller: _phoneController,
                  ),
                ),
                const SizedBox(height: 10),
                const LocationInput(),
                GestureDetector(
                  onTap: _onsubmit,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.secondaryColor),
                    child: const Text(
                      'Become Donor',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
