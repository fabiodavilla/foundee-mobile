import 'dart:async';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:foundee_mobile/config/constants/assets_path.dart';
import 'package:foundee_mobile/utils/services/map/map_functions.dart';
import 'package:foundee_mobile/common/components/create_field.dart';
import 'package:foundee_mobile/application/repositories/place_repository.dart';
import 'package:foundee_mobile/application/entities/place.dart';
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
  final MapFunctions _mapFunctions = MapFunctions();
  final List<XFile> _imageFiles = [];
  LatLng? _center;
  Timer? _debounce;

  final TextEditingController localNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final placeRepository = PlaceRepository();

  @override
  void initState() {
    super.initState();
    _imageList.add(addImage(false));
  }

  void _onMapChanged(MapPosition position) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _center = position.center;
        _mapFunctions.loadPoints(position.bounds!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _center = ModalRoute.of(context)?.settings.arguments as LatLng;
    });

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
                            center: _center,
                            zoom: 15.0,
                            onPositionChanged: (position, _hasGesture) {
                              _onMapChanged(position);
                            },
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Image(image: AssetImage(AssetsPath.Pin)),
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
    List<XFile>? photos;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () async {
          photos = await _picker.pickMultiImage();

          if (photos != null) {
            setState(() {
              if (photos!.isNotEmpty) {
                for (XFile photo in photos!) {
                  _imageFiles.add(photo);
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
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(Icons.clear),
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

  void _addNewPoint() async {
    List<Image> images = [];

    final Place place = Place(
        name: localNameController.text,
        description: descriptionController.text,
        status: 1,
        placeType: 1);

    final Place placeResponse = await placeRepository.createPlace(place);

    for (XFile file in _imageFiles) {
      images.add(Image.file(File(file.path)));
      var aaa = 1;
    }

    var b = _center;

    var z = 1;
  }
}
