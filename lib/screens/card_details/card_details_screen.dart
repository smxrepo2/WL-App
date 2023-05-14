import 'package:flutter/material.dart';
import 'package:weight_loser/utils/validation.dart';
import 'package:weight_loser/widget/custom_form_fields.dart';

import '../../theme/TextStyles.dart';

class CardDetailScreen extends StatefulWidget {
  CardDetailScreen();

  @override
  _CardDetailScreenState createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  final form = GlobalKey<FormState>();
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Card',
                  style: lightText18Px.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: form,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          child: DropdownButton<String>(
                            hint: Text("Country"),
                            isExpanded: true,
                            items: <String>[
                              'Pakistan',
                              'India',
                              'America',
                              'Canada'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (_) {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomFormFields.simpleFormField(
                            hint: 'Credit card number',
                            validator: (value) {
                              print(value);
                              return Validation.validateValue(
                                  value, 'Credit card number', true);
                            },
                            onChange: (val) {},
                            onSaved: (val) {},
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Expires',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: darkText12Px,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 16),
                                    child: CustomFormFields.simpleFormField(
                                      hint: 'dd/mm/yy',
                                      validator: (value) {
                                        print(value);
                                        return Validation.validateValue(
                                            value, 'Date', true);
                                      },
                                      onChange: (val) {},
                                      onSaved: (val) {},
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'CCV',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: darkText12Px,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, bottom: 16),
                                    child: CustomFormFields.simpleFormField(
                                      hint: '123',
                                      validator: (value) {
                                        print(value);
                                        return Validation.validateValue(
                                            value, 'CCV', true);
                                      },
                                      onChange: (val) {},
                                      onSaved: (val) {},
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomFormFields.simpleFormField(
                            hint: 'Name on card',
                            validator: (value) {
                              print(value);
                              return Validation.validateValue(
                                  value, 'Name on card', true);
                            },
                            onChange: (val) {},
                            onSaved: (val) {},
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomFormFields.simpleFormField(
                            hint: 'Street address',
                            validator: (value) {
                              print(value);
                              return Validation.validateValue(
                                  value, 'Street address', true);
                            },
                            onChange: (val) {},
                            onSaved: (val) {},
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomFormFields.simpleFormField(
                            hint: 'Zip Code',
                            validator: (value) {
                              print(value);
                              return Validation.validateValue(
                                  value, 'Zip Code', true);
                            },
                            onChange: (val) {},
                            onSaved: (val) {},
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Leave',
                                style: darkText12Px,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Container(
                                  height: 30,
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                    child: Text(
                                      'Save',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
