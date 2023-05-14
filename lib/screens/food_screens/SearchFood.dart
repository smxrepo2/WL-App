import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uiblock/uiblock.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Diet_api.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/BarcodeSearchedFoodModel.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/search_model.dart';
import 'package:weight_loser/models/user_food_items_model.dart';
import 'package:weight_loser/screens/SettingScreen/NewAddFoodScreen.dart';

import 'package:weight_loser/screens/food_screens/searchedFoodList.dart';
import 'package:weight_loser/theme/TextStyles.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:weight_loser/widget/AppBarView.dart';

import 'NewAddFood.dart';

class SearchFood extends StatefulWidget {
  bool fromPlanSearch;

  SearchFood(this.fromPlanSearch);

  @override
  _SearchFoodState createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  Future<SearchFoodModel> getFood() async {
    final response =
        await http.get(Uri.parse('https://foodsc.herokuapp.com/foodscan'));
    if (response.statusCode == 200) {
      return SearchFoodModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('no any avaliable item of this type');
    }
  }

  Future<SearchFoodModel> searchFood(String foodName) async {
    final response = await http.get(
      Uri.parse(
          'https://api.nal.usda.gov/fdc/v1/foods/search?query=$foodName&pageSize=2&api_key=IaCUAbCKvabTmfqvw2BuZtPxP6EjW8hxzG8Ng0fl'),
    );

    if (response.statusCode == 200) {
      print(foodName.toString());
      print("barcode search Result ${response.statusCode} ${response.body}");
      return SearchFoodModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load dairy');
    }
  }

  Future<SearchFoodModel> searchFoodViaBarcode(String barcode) async {
    UIBlock.block(context);
    final response = await http.get(
      Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'),
    );
    if (response.statusCode == 200) {
      print("barcode search response:" + response.body);
      BarcodeSearchedFoodModel model =
          BarcodeSearchedFoodModel.fromJson(jsonDecode(response.body));
      //var data = json.decode(response.body);
      //print("serving:" + model.product.servingQuantity);

      if (model.status == 1) {
        double protein = model.product.nutriments.proteins.toDouble();
        double fat = model.product.nutriments.fat.toDouble();
        double carbs = model.product.nutriments.carbohydrates.toDouble();
        double calories = model.product.nutriments.energyKcal.toDouble();
        FoodModel _food = new FoodModel();
        _food.id = 0;
        _food.foodId = "";
        _food.fileName = "";

        //double servingDouble = double.parse(model.product.servingQuantity);
        //int serving = servingDouble.toInt();
        _food.name = model.product.brands ?? "Not Available";
        _food.description = model.product.brands ?? "Not Available";
        //print("Products:" + model.product.servingQuantity);
        _food.servingSize = int.parse(model.product.servingQuantity ?? '0');
        //print("servingsize:" + _food.servingSize);
        _food.fat = fat;
        _food.protein = protein;
        _food.carbs = carbs;
        _food.calories = calories;
        http
            .post(
          Uri.parse('$apiUrl/api/food'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "Name": model.product.brands,
            "Description": model.product.brands,
            "FoodId": model.code,
            "FileName": "",
            "ServingSize": _food.servingSize,
            "HouseHoldServing": _food.servingSize,
            "fat": fat,
            "Protein": protein,
            "Carbs": carbs,
            "Calories": calories,
            "Cuisine": "yes",
            "Unit": "yes",
            "Category": "yes"
          }),
        )
            .then((value) {
          print("res after save food   ${value.statusCode}");
          print("response after save:" + value.body.toString());
          UIBlock.unblock(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    NewAddFood(json.decode(value.body)["foodId"])
                //SearchedFoodList(_searchController.text),
                ),
          );
        });

        // Navigator.pop(context,true);
        //  print("Hello"+_food.name.toString());
        _searchController.text = _food.name.toString();

        //  Navigator.push(context, MaterialPageRoute(builder: (context) {
        //    return AddSearchedFoodScreen(_food,model.code);
        //  }));

      } else {
        UIBlock.unblock(context);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Can Not Find Product")));
      }
    } else if (json.decode(response.body)) {
      throw Exception('Failed to load data');
    }
  }

  final ImagePicker _picker = ImagePicker();

  // ignore: unused_field
  String _scanBarcode = 'Unknown';
  // ignore: unused_field
  TextEditingController _searchController = TextEditingController();
  int userid;
  // ignore: unused_field
  List<XFile> _imageFileList;
  dynamic _pickImageError;
// #################################### SETTER FOR IMAGE  ################################
  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  // ignore: unused_field

// #################################### GETTING IMAGE FROM GALLERY ################################

  Future getImageFromGallery() async {
    var pickedFile;
    try {
      pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    return pickedFile;
  }

// #################################### GETTING IMAGE FROM CAMERA ################################

  Future getImageFromCamera() async {
    var pickedFile;
    try {
      pickedFile = await _picker.pickImage(source: ImageSource.camera);

      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
    return pickedFile;
  }
// #################################### DIALOGUE FOR CHOOSING GALLERY OR CAMERA ################################

  Future<Response> upload(var imageFile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid = prefs.getInt('userid');
    Dio dio = new Dio();
    FormData formdata = new FormData();
    String fileName = imageFile.path.split('/').last;

    formdata = FormData.fromMap({
      "UserId": userid,
      "ImageFile": await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      )
    });
    return dio.post('$apiUrl/api/foodscan',
        onSendProgress: (int sent, int total) {
      print('$sent $total');
    },
        data: formdata,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
            ));
  }

  Future postImage(var image) async {
    String fileName = image.path.split('/').last;
    print(fileName);

    try {
      Dio dio = new Dio();
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: new MediaType("image", "jpeg"),
        )
      });
      Map<String, String> headers = <String, String>{
        'Content-Type': 'multipart/form-data'
      };
      print('https://weightchoper.somee.com/staticfiles/images/${image.name}');
      //Response response = await dio.post('https://foodscan.s3.amazonaws.com/Apple_pie_resized.jpg');
      Response response = await dio.post(
          'https://foodscan.s3.amazonaws.com/${image.name}?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEBQaDGV1LWNlbnRyYWwtMSJHMEUCIQDBTV2KBdaVOWgxjSEcoJ6q%2Fma2OwBnTUP%2B6DtaykCShwIgZx%2BU4UgB4bJQNTVQfe4wtzpkJ671Ky9YdsGXtZUiNRQq%2FwIIvf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARAAGgwyODkwOTk4MjYwMzYiDKqZbUIl8b32XNPTQSrTArDO7iflQlOZnLxsmxj45aglmjNgq%2FGBrkOYpkM8JpsnDi%2FQOpoS7id%2BVeNEn13htbJIjiD3ipyeugYfsJ%2BT7dZt2tjLQZVO7B0VaRxGnl99jB1BkqNJ6ZhWNg1qFaQz75ZkN3BO25HHDJDRGoC3PQbDoMX2t20KrQoJhJRVPD%2BG5F22d5IOGwZMqI3GqW4lBRTvQEVu3kAedv4AZg%2FjXX%2ByTyKcLe2lCLwyl1RIG0lJllY8Ni5eo3Xz059HI4Zr42If6m3d7%2BFQpIGp8RCwQ4j5F%2BSFYE4HNFLSDTdfuy2ynnNYn7bNBtkvwGVjPotTJRMi491sG1nz5pTIWaMq5iuzNB6dMnWh2IEl11tN1bi6IKhKRpn582Wj%2FfTz7drvQ8E0YDbB%2BpStVp%2BJ9Ct8Iu4dmj3pW%2ByxcojWxeb1vOqCuNe%2BV8uASySWumZIEa9t%2F720OzCIq6SMBjqzAnsyLpNlotG4dNB6A0JunTzRgep9VKgDrO6MPXsDWSGc6jtt43SjLf0HrIrRdHJfTFqqJcCAB%2Fn0ZYz51Mz1EKSRiUDC3bmWLxoEA0QWw82I08huUEAgu%2F1P86nggUqQdbG3BZ6LJFbfEFBqWlBTCpq7cTiYOKwiZI0vDM9ZlFl4W0f2P1W1iD7jI979%2FKaYOzevjExp5oBgZn8mfDrdrdwe5m1HV5qzbdIM%2BgBfnDXr3CCpgn2gT%2BrWeM%2F1bsgIO2Xvr1QO4xTaeDCNwU%2BuV0Gyaw68O2wGlBrCIaNXDSg8izL8W3uS1iPJSJ11CKzBzdhggo5ocYNP8y44Y6i23gT7C6bc6c0hl%2BLrPNILEnDJj1I7sBf%2B5XLr4YUDZjUAjwPgEy0StzhSQ%2BRdpzizIOj8XSM%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20211108T122024Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAUGT5RIN2FAYDNB5N%2F20211108%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=cdf236e27353652b8832aec1888b228c78aa31a9ef2a28fff9204f07aa943baa',
          data: formData);
      if (response.statusCode == 200) {
        print("Uploaded");
      } else {
        print(response.data);
        print(formData);
      }
      print('Out');
    } catch (e) {
      print(e);
    }
  }

  dialogForCamera() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: MySize.size240,
            child: SizedBox.expand(
                child: Column(
              children: [
                SizedBox(
                  height: MySize.size20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DDText(
                      title: "Choose an Action",
                      size: MySize.size16,
                      weight: FontWeight.w500,
                      color: primaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: MySize.size10,
                ),
                Divider(
                  color: primaryColor,
                  thickness: 2,
                ),
                Container(
                  child: Row(
                    children: [
                      TextButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(20)
                              // primary: Colors.transparent,

                              ),
                          icon: Icon(FontAwesomeIcons.images),
                          onPressed: () async {
                            getImageFromGallery().then((value) {
                              upload(File(value.path));
                              postImage(value);
                              Navigator.pop(context);
                            });
                          },
                          label: DDText(
                            title: "Choose From Gallery",
                          )),
                    ],
                  ),
                ),
                Divider(),
                Row(
                  children: [
                    TextButton.icon(
                        style:
                            ElevatedButton.styleFrom(padding: EdgeInsets.all(20)
                                // primary: Colors.transparent,

                                ),
                        icon: Icon(FontAwesomeIcons.camera),
                        onPressed: () async {
                          Navigator.pop(context);
                          getImageFromCamera().then((value) {
                            upload(File(value.path));
                            postImage(value);
                          });
                        },
                        label: DDText(
                          title: "Capture From Camera",
                        )),
                  ],
                ),

                // Divider(),
              ],
            )),
            margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

// #################################### FUNCTION FOR BARCODE ################################

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      print("BarCode Scan Result" + barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      if (_scanBarcode != '-1')
        searchFoodViaBarcode(_scanBarcode.toString());
      else
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Can Not Find Food"),
          backgroundColor: Colors.red,
        ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar(context: context, title: "Search Food"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FutureBuilder<UserFoodItems>(
          future: getFoodItems(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 60,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(6),
                            border:
                                Border.all(color: darkGrey.withOpacity(0.1))),
                        child: headerView(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(left: 10),
                      //       child: Row(
                      //         children: [
                      //           Image.asset(
                      //             "assets/icons/catering.png",
                      //             width: MySize.size20,
                      //             height: MySize.size20,
                      //           ),
                      //           DDText(
                      //             title: " Custom Food",
                      //             weight: FontWeight.w500,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: (){
                      //       },
                      //       child: Container(
                      //         padding: EdgeInsets.only(right: 10),
                      //         child: DDText(
                      //           title: "Add Food",
                      //           color: primaryColor,
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: MySize.size20,
                      // ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   itemCount: snapshot.data.customFood.length,
                      //   itemBuilder: (BuildContext context,int index){
                      //     return listItemView(context,
                      //       snapshot.data.customFood[index].name??"Not Specified",
                      //       snapshot.data.customFood[index].description??"Not Specified",
                      //       snapshot.data.customFood[index].calories??"Not Specified",
                      //       snapshot.data.customFood[index].servingSize??"Not Specified",
                      //       snapshot.data.customFood[index].foodId??"Not Specified",
                      //     );
                      //   },
                      // ),
                      // SizedBox(
                      //   height: MySize.size20,
                      // ),
                      // Divider(),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/recent.png",
                              width: MySize.size20,
                              height: MySize.size20,
                            ),
                            DDText(
                              title: " Recent",
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MySize.size20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.foodHistory.length,
                        itemBuilder: (BuildContext context, int index) {
                          return listItemView(
                            context,
                            snapshot.data.foodHistory[index].fName == null
                                ? "Not Specified"
                                : snapshot.data.foodHistory[index].fName,
                            snapshot.data.foodHistory[index].fName == null
                                ? "Not Specified"
                                : snapshot.data.foodHistory[index].fName,
                            snapshot.data.foodHistory[index].consCalories ??
                                "Not Specified",
                            snapshot.data.foodHistory[index].servingSize ??
                                "Not Specified",
                            snapshot.data.foodHistory[index].foodId ?? "0",
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('No Internet Connectivity'),
              );
            }

            // By default, show a loading spinner.
            return Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: darkGrey.withOpacity(0.1))),
                    child: headerView(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/catering.png",
                              width: MySize.size20,
                              height: MySize.size20,
                            ),
                            DDText(
                              title: " Custom Food",
                              weight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: DDText(
                            title: "Add Food",
                            color: primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MySize.size20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return listItemView(
                        context,
                        "Not Specified",
                        "Not Specified",
                        "Not Specified",
                        "Not Specified",
                        "Not Specified",
                      );
                    },
                  ),
                  SizedBox(
                    height: MySize.size20,
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/recent.png",
                          width: MySize.size20,
                          height: MySize.size20,
                        ),
                        DDText(
                          title: " Recent",
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MySize.size20,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return listItemView(
                        context,
                        "Not Specified",
                        "Not Specified",
                        "Not Specified",
                        "Not Specified",
                        "Not Specified",
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget listItemView(
      BuildContext context, name, description, calorie, serving, foodId) {
    return GestureDetector(
      onTap: () {
        Responsive1.isMobile(context)
            ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewAddFood(foodId.toString());
              }))
            : showDialog(
                context: context,
                builder: (context) => Padding(
                    padding: const EdgeInsets.only(
                        left: 400, right: 400, bottom: 50, top: 50),
                    child: NewAddFood(foodId.toString())));
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: MySize.size10, right: MySize.size10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style:
                            darkText14Px.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "${description} ,${serving} grams",
                        style: lightText12Px.copyWith(color: Colors.black45),
                      ),
                    ],
                  ),
                ),
                Text(
                  "$calorie",
                  style: darkText14Px.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: MySize.size10,
              right: MySize.size10,
            ),
            child: Divider(),
          ),
        ],
      ),
    );
  }

// ############################ BODY VIEW ################################

// ################################# HEADER VIEW ############################

  Row headerView() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              print("search ${_searchController.text}");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      SearchedFoodList(_searchController.text),
                ),
              );
            },
            style: lightText12Px,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black45, width: 0.1)),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black45, width: 0.1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black45, width: 0.1)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.black45, width: 0.1)),
                // suffixIcon: IconButton(
                //   onPressed: () async {
                //     // Obtain a list of the available cameras on the device.
                //      dialogForCamera();
                //
                //   },
                //   icon: Icon(
                //     Icons.camera_alt,
                //     size: 25,
                //   ),
                //   color: Colors.black45,
                // ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 18,
                  color: Colors.black45,
                ),
                hintText: "Search for food"),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () {
            scanBarcodeNormal();
          },
          child: Image.asset(
            "assets/icons/barcode-scanner.png",
            width: MySize.size30,
            height: MySize.size30,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    if (!widget.fromPlanSearch) provider.setCustomPlanStatusCode(0);
    if (!mounted) setState(() {});
  }
}
