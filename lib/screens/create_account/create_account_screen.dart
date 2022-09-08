import 'package:flutter/material.dart';
import 'package:foundee/components/create_field.dart';
import 'package:foundee/screens/create_account/create_request.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              createField("Email", emailController),
              createField("Password", passwordController, true),
              createField("Name", nameController),
              createField("Lastame", lastNameController),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: DateTimeField(
                  controller: dateController,
                  format: DateFormat("yyyy-MM-dd"),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                  },
                  decoration: const InputDecoration(
                    label: Text("Date"),
                    border: OutlineInputBorder(),
                    helperText: "Enter your date",
                  ),
                ),
              ),
              createField("Address", addressController),
              createField("District", districtController),
              createField("City", cityController),
              createField("State", stateController),
              createField("Country", countryController),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        onPressed: () {
                          _createUser();
                        },
                        child: const Text("CRIAR CONTA"),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createUser() async {
    if (_formKey.currentState!.validate()) {
      await createUser({
        "email": emailController.text,
        "password": passwordController.text,
        "name": nameController.text,
        "lastName": lastNameController.text,
        "dateBirth": dateController.text,
        "address": addressController.text,
        "district": districtController.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "userType": "1",
        "status": "1"
      });
    } else {
      Fluttertoast.showToast(
          msg: "Failed to create the user!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
