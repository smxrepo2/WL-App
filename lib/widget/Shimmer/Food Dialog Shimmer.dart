import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class FoodDialogShimmer extends StatelessWidget {

  int ingredientOrProcedure=0;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child:Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      child: Text(
                        'Ingredients',
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ingredientOrProcedure == 0 ? Colors.black : Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.001,
                    ),
                    ingredientOrProcedure == 0
                        ? Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.002,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          color: Color(0xff4885ED)),
                    ) : Container()
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Procedure',
                        style: GoogleFonts.montserrat(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: ingredientOrProcedure == 1 ? Colors.black : Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.001,
                    ),
                    ingredientOrProcedure == 1
                        ? Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.002,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(10),
                          color: Color(0xff4885ED)),
                    ) : Container()
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height:
            MediaQuery.of(context).size.height * 0.01,
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
                  border: Border.all(color: Colors.grey, width: .5)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 10),
                child: Text(
                  "how to make food",
                  style: GoogleFonts.montserrat(
                      fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
