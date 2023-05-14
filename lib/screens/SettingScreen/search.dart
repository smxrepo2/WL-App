import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_loser/Component/DDText.dart';
import 'package:weight_loser/CustomWidgets/SizeConfig.dart';
import 'package:weight_loser/Provider/UserDataProvider.dart';
import 'package:weight_loser/Service/Responsive.dart';
import 'package:weight_loser/Service/Setting_screen_api.dart';
import 'package:weight_loser/constants/constant.dart';
import 'package:weight_loser/models/BarcodeSearchedFoodModel.dart';
import 'package:weight_loser/models/food_model.dart';
import 'package:weight_loser/models/search_model.dart';
import 'package:weight_loser/models/user_food_items_model.dart';
import 'package:weight_loser/screens/SettingScreen/searchlist.dart';
import 'package:weight_loser/screens/food_screens/searchedFoodList.dart';
import 'package:weight_loser/utils/AppConfig.dart';
import 'package:http/http.dart' as http;
import 'package:weight_loser/widget/AppBarView.dart';
import 'package:weight_loser/widget/CustomDrawer.dart';

import 'SearchFoodListDiet.dart';

class SearchFoodData extends StatefulWidget {
  bool fromPlanSearch;
  SearchFoodData(this.fromPlanSearch);

  @override
  _SearchFoodDataState createState() => _SearchFoodDataState();
}

class _SearchFoodDataState extends State<SearchFoodData> {
  String dropDownValue = 'Recently Eaten';
  int dropDownIndex = 0;
  var items = [
    'Recently Eaten',
    'Frequently Eaten',
    'Recently Viewed',
    'Favourites'
  ];

  List<String> eatingTime = ['Morning', 'Lunch', 'Dinner', 'Snacks'];
  List<String> types = [
    'All Cuisines',
    'Indians',
    'Thai',
    'Italian',
    'Mexican',
  ];
  List<String> effect = [
    'keto Grade: Avoid',
    'Vegan: Friendly',
    'Ketan: Friendly',
    'Vegan: Friendly',
    'Kernal: Friendly',
    'Ketan: Friendly',
  ];
  int selectedIndex = 0;
  int selectedIndex1 = 0;
  int selectedEatingTime = 0;
  int ingredientOrProcedure = 0;

  int userid;

  List<dynamic> allCuisines = [];
  Future<dynamic> getCuisines() async {
    final response = await http.get(Uri.parse("$apiUrl/api/cuisine"));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        allCuisines = json.decode(response.body);
      });
      // return json.decode(response.body);
    } else {
      throw Exception('Failed to load Cuisines');
    }
  }

  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageFileList;
  set _imageFile(XFile value) {
    _imageFileList = value == null ? null : [value];
  }

  String _scanBarcode = 'Unknown';
  TextEditingController _searchController = TextEditingController();
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
      searchFoodViaBarcode(_scanBarcode.toString());
    });
  }

  Future<SearchFoodModel> searchFoodViaBarcode(String barcode) async {
    final response = await http.get(
      Uri.parse('https://world.openfoodfacts.org/api/v0/product/$barcode.json'),
    );
    if (response.statusCode == 200) {
      BarcodeSearchedFoodModel model =
          BarcodeSearchedFoodModel.fromJson(jsonDecode(response.body));
      double protein = model.product.nutriments.proteins.toDouble();
      double fat = model.product.nutriments.fat.toDouble();
      double carbs = model.product.nutriments.carbohydrates.toDouble();
      int calories = model.product.nutriments.energyKcal;
      FoodModel _food = new FoodModel();
      _food.id = 0;
      _food.foodId = "";
      _food.fileName = "";

      double servingDouble = double.parse(model.product.servingQuantity);
      int serving = servingDouble.toInt();
      _food.name = model.product.brands;
      _food.description = model.product.brands;
      _food.servingSize = int.parse(model.product.servingQuantity);
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
              "ServingSize": serving,
              "HouseHoldServing": serving,
              "fat": fat,
              "Protein": protein,
              "Carbs": carbs,
              "Calories": calories
            }),
          )
          .then((value) => print("res after save food   ${value.statusCode}"));
      // Navigator.pop(context,true);
      //  print("Hello"+_food.name.toString());
      _searchController.text = _food.name.toString();
      print(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              SearchedFoodListDiet(_searchController.text),
        ),
      );
      //  Navigator.push(context, MaterialPageRoute(builder: (context) {
      //    return AddSearchedFoodScreen(_food,model.code);
      //  }));

    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Responsive1.isMobile(context)
            ? customAppBar(
                context,
                elevation: 0.0,
              )
            : Padding(padding: EdgeInsets.only(top: 5)),
      ),
      // appBar: customAppBar(
      //   context,
      //   elevation: 0.0,
      // ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: const [
            //       Icon(
            //         Icons.menu,
            //         size: 30,
            //         color: Color(0xFF797A7A),
            //       ),
            //       Icon(
            //         Icons.notifications,
            //         size: 30,
            //         color: Color(0xFF797A7A),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.02,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text(
            //       'Today',
            //       style: GoogleFonts.openSans(
            //           fontWeight: FontWeight.w600, fontSize: 12),
            //     ),
            //     Text(
            //       'Diet',
            //       style: GoogleFonts.openSans(
            //           fontWeight: FontWeight.w600, fontSize: 12),
            //     ),
            //     Text(
            //       'Exercise',
            //       style: GoogleFonts.openSans(
            //           fontWeight: FontWeight.w600, fontSize: 12),
            //     ),
            //     Text(
            //       'Mind',
            //       style: GoogleFonts.openSans(
            //           fontWeight: FontWeight.w600, fontSize: 12),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.01,
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 20, right: 20),
            //   child: Divider(
            //     thickness: 1,
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: .2)),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: Colors.grey, width: .5)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              const Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 20,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 5),
                                  child: TextField(
                                    controller: _searchController,
                                    maxLines: 1,
                                    onSubmitted: (value) {
                                      print("search ${_searchController.text}");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              SearchedFoodListDiet(
                                                  _searchController.text),
                                        ),
                                      );
                                    },
                                    decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Search From the list',
                                        hintStyle: GoogleFonts.openSans(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              // GestureDetector(
                              //     onTap: () {
                              //       dialogForCamera();
                              //     },
                              //     child: Image.asset(
                              //         'assets/icons/camera_icon.png')),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.02,
                              // )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     scanBarcodeNormal();
                    //   },
                    //   child: Image.asset(
                    //     "assets/icons/barcode-scanner.png",
                    //     width: MySize.size30,
                    //     height: MySize.size30,
                    //   ),
                    // ),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * 0.03,
                    // )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: FutureBuilder(
                  future: getMealData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      var Cuisine = snapshot.data['FavCuisine'].split(",");
                      print(Cuisine.length);
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: Cuisine.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    Responsive1.isMobile(context)
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchCuisines(
                                                      type: Cuisine[index]
                                                          .replaceAll("[", " ")
                                                          .replaceAll("]", " "),
                                                    )))
                                        : showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 350,
                                                            right: 350,
                                                            bottom: 50,
                                                            top: 50),
                                                    child: SearchCuisines(
                                                        type: Cuisine[index]
                                                            .replaceAll(
                                                                "[", " ")
                                                            .replaceAll(
                                                                "]", " "))));
                                  });
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 13),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: selectedIndex == index
                                            ? Color(0xff4885ED)
                                            : Colors.white,
                                        border: Border.all(
                                            color: Colors.grey, width: .3)),
                                    child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            vertical: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: Text(
                                          Cuisine[index]
                                              .replaceAll("[", " ")
                                              .replaceAll("]", " "),
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13,
                                              color: selectedIndex == index
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Center(
                        child: Text('unable to load data'),
                      );
                    }

                    // By default, show a loading spinner.
                    return Center(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      color: Colors.grey, width: .3)),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      vertical:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  child: Text(
                                    "indian",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ));
                  }),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 60,
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemCount: allCuisines.length,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Padding(
            //         padding: const EdgeInsets.only(left: 20),
            //         child: GestureDetector(
            //           onTap: () {
            //             setState(() {
            //               selectedIndex = index;
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => SearchCuisines(
            //                             type: allCuisines[index]['CuisineName'],
            //                           )));
            //             });
            //           },
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(vertical: 13),
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(100),
            //                   color: selectedIndex == index
            //                       ? Color(0xff4885ED)
            //                       : Colors.white,
            //                   border:
            //                       Border.all(color: Colors.grey, width: .3)),
            //               child: Center(
            //                 child: Padding(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal:
            //                           MediaQuery.of(context).size.width * 0.03,
            //                       vertical:
            //                           MediaQuery.of(context).size.width * 0.02),
            //                   child: Text(
            //                     allCuisines[index]['CuisineName'],
            //                     style: GoogleFonts.montserrat(
            //                         fontSize: 13,
            //                         color: selectedIndex == index
            //                             ? Colors.white
            //                             : Colors.black,
            //                         fontWeight: FontWeight.w500),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: PopupMenuButton(
                    initialValue: dropDownIndex,
                    onSelected: (int index) {
                      dropDownIndex = index;
                      dropDownValue = items[dropDownIndex];
                      setState(() {});
                    },
                    child: Center(
                        child: Image.asset('assets/icons/sort_icon.png')),
                    itemBuilder: (context) {
                      return List.generate(items.length, (index) {
                        return PopupMenuItem(
                          value: index,
                          child: Text(items[index]),
                        );
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.02,
                ),
                Text(
                  dropDownValue,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

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
            height: MySize.size250,
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

  showFoodDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    right: MediaQuery.of(context).size.width * 0.05,
                    left: MediaQuery.of(context).size.width * 0.05,
                    bottom: MediaQuery.of(context).size.width * 0.05),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: Image.network(
                                                'https://media.istockphoto.com/photos/table-top-view-of-spicy-food-picture-id1316145932?b=1&k=20&m=1316145932&s=170667a&w=0&h=feyrNSTglzksHoEDSsnrG47UoY_XX4PtayUPpSMunQI=')
                                            .image,
                                        fit: BoxFit.cover)),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Text(
                                    'Palak Paneer',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.002,
                                  ),
                                  Text(
                                    '1 Serving, 250 grams',
                                    style: GoogleFonts.openSans(
                                        fontSize: 11, color: Colors.grey),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            types[selectedIndex],
                                            style: GoogleFonts.montserrat(
                                                fontSize: 9,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red[100],
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 10),
                                          child: Text(
                                            'Keton: Avoid',
                                            style: GoogleFonts.montserrat(
                                                fontSize: 9, color: Colors.red),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Expanded(child: SizedBox()),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        color: Colors.grey, width: .5)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cals',
                                      style: GoogleFonts.openSans(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                    Text(
                                      '320',
                                      style: GoogleFonts.openSans(
                                          color: Colors.black, fontSize: 24),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.01,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Carb',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.002,
                                      ),
                                      Text(
                                        '250g',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '17g left',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Fat',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.002,
                                      ),
                                      Text(
                                        '250g',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '17g left',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Protein',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.002,
                                      ),
                                      Text(
                                        '250g',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '17g left',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Other',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.002,
                                      ),
                                      Text(
                                        '250g',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '17g left',
                                    style: GoogleFonts.montserrat(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedEatingTime = 0;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: selectedEatingTime == 0
                                          ? Color(0xff4885ED)
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: .5)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    child: Text(
                                      'Morning',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: selectedEatingTime == 0
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedEatingTime = 1;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: selectedEatingTime == 1
                                          ? Color(0xff4885ED)
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: .5)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    child: Text(
                                      'Lunch',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: selectedEatingTime == 1
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedEatingTime = 2;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: selectedEatingTime == 2
                                          ? Color(0xff4885ED)
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: .5)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    child: Text(
                                      'Dinner',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: selectedEatingTime == 2
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedEatingTime = 3;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: selectedEatingTime == 3
                                          ? Color(0xff4885ED)
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: .5)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        vertical:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    child: Text(
                                      'Snack',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 13,
                                        color: selectedEatingTime == 3
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: Text(
                            'Serving Size',
                            style: GoogleFonts.montserrat(
                                fontSize: 13, color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '250',
                                style: GoogleFonts.montserrat(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Grams',
                                style: GoogleFonts.montserrat(
                                    fontSize: 13, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ingredientOrProcedure = 0;
                                      });
                                    },
                                    child: Text(
                                      'Ingredients',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: ingredientOrProcedure == 0
                                              ? Colors.black
                                              : Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.001,
                                  ),
                                  ingredientOrProcedure == 0
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.002,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xff4885ED)),
                                        )
                                      : Container()
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        ingredientOrProcedure = 1;
                                      });
                                    },
                                    child: Text(
                                      'Procedure',
                                      style: GoogleFonts.montserrat(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: ingredientOrProcedure == 1
                                              ? Colors.black
                                              : Colors.grey),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.001,
                                  ),
                                  ingredientOrProcedure == 1
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.002,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xff4885ED)),
                                        )
                                      : Container()
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05,
                              right: MediaQuery.of(context).size.width * 0.05),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: .5)),
                            child: ingredientOrProcedure == 0
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          '1 bone-in, skin-on chicken thighs (2 oz. each)',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          '1 bone-in, skin-on chicken thighs (2 oz. each)',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          '1 bone-in, skin-on chicken thighs (2 oz. each)',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          '1 bone-in, skin-on chicken thighs (2 oz. each)',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        child: Text(
                                          '1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '1 bone-in, skin-on chicken thighs (2 oz. each)',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.grey),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '1 bone-in, skin-on chicken thighs (2 oz. each)',
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '1 bone-in, skin-on chicken thighs (2 oz. each)1  bone-in, skin-on chicken thighs (2 oz. each)1ne-in, skin-on chicken thighs (2 oz. each)1  bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)1 bone-in, skin-on chicken thighs (2 oz. each)',
                                                  maxLines: 5,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xff4885ED)),
                              child: Center(
                                child: Text(
                                  'Log Food',
                                  style: GoogleFonts.openSans(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ));
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    getCuisines();
    if (!widget.fromPlanSearch) provider.setCustomPlanStatusCode(0);
    setState(() {});
  }
}

Widget ListViewPage(BuildContext context, name, serving, cal) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: GestureDetector(
      onTap: () {
        //showFoodDialog(context);
      },
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: .2)),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Text(
                        '${serving} Serving, 250 grams',
                        style: GoogleFonts.openSans(
                            fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cals',
                        style: GoogleFonts.openSans(
                            color: Colors.grey, fontSize: 11),
                      ),
                      Text(
                        cal,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        types[selectedIndex],
                        style: GoogleFonts.montserrat(
                            fontSize: 11, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          // color: effect[index].contains('Avoid')
                          //     ? Colors.red[100]
                          //     : Colors.green[100],
                          borderRadius: BorderRadius.circular(100)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        child: Text(
                          "",
                          // effect[index],
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            // color: effect[index].contains('Avoid')
                            //     ? Colors.red
                            //     : Colors.green),
                          ),
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
