import 'package:flutter/material.dart';
import 'package:foundee_mobile/application/entities/user.dart';
import 'package:foundee_mobile/application/repositories/user_repository.dart';
import 'package:foundee_mobile/common/components/create_field.dart';
import 'package:foundee_mobile/utils/extensions/format_date.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateController = TextEditingController();
  final addressController = TextEditingController();
  final districtController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  final userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      dateController.text = ""; //set the initial value of text field
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              createField("Email", emailController),
              createField("Password", passwordController, true),
              createField("Confirm password", confirmPasswordController, true),
              createField("Name", nameController),
              createField("Last name", lastNameController),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Enter Date",
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      setState(() {
                        dateController.text =
                            DateFormat('dd/MM/yyyy').format(pickedDate);
                      });
                    } else {}
                  },
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
      final user = User(
          name: nameController.text,
          lastName: lastNameController.text,
          date: DateTime.parse(dateController.text.invertDate('/')),
          address: addressController.text,
          district: districtController.text,
          city: cityController.text,
          state: stateController.text,
          country: countryController.text,
          userType: 1,
          status: 1,
          email: emailController.text,
          password: passwordController.text);

      final userResponse = await userRepository.createUser(user);

      if (userResponse != null) {
        Navigator.pushNamed(context, '/login');

        Fluttertoast.showToast(
            msg: "Successfully created user!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
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
