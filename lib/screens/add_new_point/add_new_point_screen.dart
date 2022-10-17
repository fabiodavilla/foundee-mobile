import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:foundee_mobile/components/create_field.dart';
import 'package:latlong2/latlong.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPointScreen extends StatefulWidget {
  const AddNewPointScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPointScreen> createState() => _AddNewPointScreenState();
}

class _AddNewPointScreenState extends State<AddNewPointScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Widget> _imageList = [];
  final ImagePicker _picker = ImagePicker();
  List<XFile>? photos;

  final TextEditingController localNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _imageList.add(addImage(false));
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)?.settings.arguments as LatLng;
    final arguments = LatLng(-21.129602, -47.832861);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Point"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FlutterMap(
                          options: MapOptions(
                            center: arguments,
                            zoom: 15.0,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              // subdomains: ['a', 'b', 'c'],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Image(image: AssetImage("assets/pin.png")),
                      ),
                    ],
                  ),
                ),
              ),
              createField("Novo local", localNameController),
              _imageList.length > 1
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // itemCount: _imageList.length,
                        itemCount: _imageList.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: _imageList[index],
                          );
                        },
                      ),
                    )
                  : addImage(true),
              createField("Description", descriptionController, false, true),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  onPressed: _addNewPoint,
                  child: const Text("Adicionar"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget addImage([bool expanded = false]) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () async {
          photos = await _picker.pickMultiImage();

          if (photos != null) {
            String message = "Selecionado: ";

            for (XFile element in photos!) {
              message += element.name + " ";
            }

            setState(() {
              if (photos!.isNotEmpty) {
                for (XFile photo in photos!) {
                  _imageList.insert(
                    _imageList.length - 1,
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        children: [
                          Image.file(
                            File(photo.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Icon(Icons.clear),
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
            });
          }
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: DottedBorder(
          strokeWidth: 1,
          dashPattern: const [5],
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          padding: const EdgeInsets.all(6),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.add),
                  if (expanded)
                    const Text("Toque para adicionar uma nova foto"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addNewPoint() async {}
}
