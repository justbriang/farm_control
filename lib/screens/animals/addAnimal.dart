import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_works1/Widgets/Textfield.dart';
import 'package:flutter_works1/Widgets/show_message.dart';
import 'package:flutter_works1/models/animal.dart';
import 'package:flutter_works1/models/animalBreed.dart';

class AddAnimalPage extends StatefulWidget {
  final Map<String, dynamic> farmCredentials;

  AddAnimalPage(this.farmCredentials, {Key key}) : super(key: key);

  @override
  _AddAnimalPageState createState() => _AddAnimalPageState(farmCredentials);
}

class _AddAnimalPageState extends State<AddAnimalPage> {
  final Map<String, dynamic> farmCredentials;
  var selectedbreed;
  final _formKey = GlobalKey<FormState>();
  String breed = 'breed';
  final animalCountController = new TextEditingController();
  final breedNameController = new TextEditingController();
  final globalKey = GlobalKey<ScaffoldState>();
  _AddAnimalPageState(this.farmCredentials);

  Widget _addBreedbtn(breedNameController, ctx) => Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Map<String, dynamic> breedCredentials = {
                "breed": breedNameController.text.toString().trim()
              };
              AnimalBreed breed = new AnimalBreed();

              breed.addAnimal(breedCredentials);
             // final snackBar = SnackBar(
                 // content: Text('breed Successfully Updated'),
                  //backgroundColor: Colors.green);
             // globalKey.currentState.showSnackBar(snackBar);
              Navigator.of(context).pop();
            }
          },
          color: Colors.blue,
          focusColor: Colors.blue,
          disabledColor: Colors.blue,
          padding: const EdgeInsets.all(13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Add Farmer',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
  Widget _buildDialogContents() => Container(
        color: Color(0xFF737373),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            // padding: EdgeInsets.only(
            //     bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      'Add Farm',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                entryField("Farm Name", breedNameController),
                              ],
                            )),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        _addBreedbtn(breedNameController, context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void _addBreedWidget() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return _buildDialogContents();
        }).whenComplete(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.lightBlue,
            size: 24.0,
            semanticLabel: 'Go to settings',
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        title: const Text(
          "Farmer Detail",
          style: TextStyle(color: Colors.lightBlue),
        ),
      ),
      body: _buildContents(animalCountController, farmCredentials),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addBreedWidget();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildContents(
    TextEditingController animalCountController,
    Map<String, dynamic> farmCredentials,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Form(
                key: _formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("animalBreed")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData)
                              return Text("Loading.....");
                            else {
                              List<DropdownMenuItem> breedItems = [];
                              for (int i = 0;
                                  i < snapshot.data.docs.length;
                                  i++) {
                                DocumentSnapshot snap = snapshot.data.docs[i];
                                breedItems.add(
                                  DropdownMenuItem(
                                    child: Text(
                                      snap.data()['breed'],
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                    value: "${snap.data()['breed']}",
                                  ),
                                );
                              }
                              return DropdownButton(
                                items: breedItems,
                                onChanged: (currencyValue) {
                                  final snackBar = SnackBar(
                                    content: Text(
                                      'Selected breed value is $currencyValue',
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                    ),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  setState(() {
                                    selectedbreed = currencyValue;
                                  });
                                },
                                value: selectedbreed,
                                isExpanded: false,
                                hint: new Text(
                                  "Choose Breed",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              );
                            }
                          }),
                    )),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.only(left: 15, right: 10),
                            child: entryField(
                                'Breed Count', animalCountController))),
                  ],
                )),
            _addAnimalbtn(
                animalCountController, farmCredentials, selectedbreed, context),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _addAnimalbtn(
          animalCountController, farmCredentials, selectedbreed, ctx) =>
      Padding(
        padding: const EdgeInsets.only(top: 25),
        child: RaisedButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              if (selectedbreed == null) {
                ShowMessage(
                    context: ctx, message: 'You have to select a breed');
              }
              Map<String, dynamic> breedCredentials = {
                "breed": selectedbreed,
                'Animal Count': animalCountController.text.trim(),
                'farmerId': farmCredentials['farmerId'],
                'farmId': farmCredentials['farmId']
              };
              Animal breed = new Animal();

              breed.addAnimal(breedCredentials);

              Navigator.of(context).pop();
            }
          },
          color: Colors.blue,
          focusColor: Colors.blue,
          disabledColor: Colors.blue,
          padding: const EdgeInsets.all(13),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(
            'Add Farmer',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
