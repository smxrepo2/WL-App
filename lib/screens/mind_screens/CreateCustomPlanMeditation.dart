import 'package:flutter/material.dart';
import 'package:weight_loser/theme/TextStyles.dart';

int meditationSelected = 0;

class CreateMeditationCustomPlan extends StatefulWidget {
  const CreateMeditationCustomPlan({Key key}) : super(key: key);

  @override
  State<CreateMeditationCustomPlan> createState() =>
      _CreateMeditationCustomPlanState();
}

class _CreateMeditationCustomPlanState
    extends State<CreateMeditationCustomPlan> {
  int day = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Custom Plan',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      day--;
                      if (day < 1) {
                        day = 1;
                      }
                    });
                  },
                  icon: Icon(Icons.arrow_back_ios, size: 12.5),
                ),
                Text(
                  'Day $day',
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 12,
                    color: Color(0xcc1e1e1e),
                    fontWeight: FontWeight.w600,
                  ),
                  softWrap: false,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      day++;
                      if (day > 7) {
                        day = 7;
                      }
                    });
                  },
                  icon: Icon(Icons.arrow_forward_ios, size: 12.5),
                ),
                const Spacer(),
                Text(
                  'Meditation Selected: $meditationSelected',
                  style: const TextStyle(
                    fontFamily: 'Open Sans',
                    fontSize: 10,
                    color: Color(0x991e1e1e),
                  ),
                  softWrap: false,
                )
              ],
            ),
            SizedBox(height: 10),
            const Center(
              child: Text(
                'Select Custom Meditation',
                style: TextStyle(
                  fontFamily: 'Open Sans',
                  fontSize: 10,
                  color: const Color(0x991e1e1e),
                ),
                softWrap: false,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  border:
                      Border.all(width: 1, color: Colors.grey.withOpacity(0.1)),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchMeditations(),
                          ),
                        );
                      },
                      child: TextField(
                        style: lightText12Px,
                        enabled: false,
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                    color: Colors.black45, width: 0.1)),
                            prefixIcon: const Icon(
                              Icons.search,
                              size: 20,
                              color: Colors.black45,
                            ),
                            hintText: "Search"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.open_in_browser_outlined,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(indent: 50, endIndent: 50, thickness: 2, height: 10),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return MeditationTile(notifyParent: () => setState(() {}));
                  }),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding:
            const EdgeInsets.symmetric(horizontal: 22.5, vertical: 0),
        label: const Text('Save Meditation'),
        extendedTextStyle: const TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 15,
          color: Color(0xffffffff),
          height: 0.9333333333333333,
        ),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

class MeditationTile extends StatefulWidget {
  MeditationTile({
    Key key,
    this.notifyParent,
  }) : super(key: key);

  final Function() notifyParent;

  @override
  State<MeditationTile> createState() => _MeditationTileState();
}

class _MeditationTileState extends State<MeditationTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: Image.network(
                                  'https://i1.sndcdn.com/avatars-anvyGyI8SV6Z4iVm-KNavQA-t240x240.jpg')
                              .image,
                          fit: BoxFit.cover)),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      const Text(
                        'Mediation',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 15,
                          color: const Color(0xff2b2b2b),
                          fontWeight: FontWeight.w300,
                        ),
                        softWrap: false,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.002,
                      ),
                      const Text(
                        '10 mins',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 11,
                          color: const Color(0xffafafaf),
                        ),
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Column(
                    children: [
                      const Text(
                        '320 kcal',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: 15,
                          color: const Color(0xff2b2b2b),
                        ),
                        softWrap: false,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isSelected = !isSelected;
                            if (isSelected) {
                              meditationSelected++;
                            } else {
                              meditationSelected--;
                            }
                            widget.notifyParent();
                          });
                        },
                        icon: isSelected
                            ? const Icon(Icons.check, color: Colors.blueAccent)
                            : const Icon(Icons.add, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(
              indent: 20,
              endIndent: 20,
              thickness: 2,
              height: 20,
              color: Colors.grey.shade200),
        ],
      ),
    );
  }
}

class SearchMeditations extends StatefulWidget {
  SearchMeditations({Key key, this.notifyParent}) : super(key: key);

  final Function() notifyParent;

  @override
  State<SearchMeditations> createState() => _SearchMeditationsState();
}

class _SearchMeditationsState extends State<SearchMeditations> {
  TextEditingController searchTextController = TextEditingController();

  bool searchable = false;
  bool isLoading = false;

  List<String> resultMeditations = ['2'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.only(top: 5, left: 10),
          child: TextField(
            controller: searchTextController,
            decoration: InputDecoration(
              hintText: 'Search for Meditations',
              hintStyle: TextStyle(color: Colors.grey[600].withOpacity(0.5)),
              border: InputBorder.none,
              prefixIcon: Transform.translate(
                offset: Offset(-20, 0),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: searchable ? Colors.blue : Colors.black,
                ),
                onPressed: () {
                  // setState(() {
                  //   isLoading = true;
                  // });
                  // SearchRecipeData(searchTextController.text.trim().toString())
                  //     .then((value) {
                  //   if (value.length == 0) {
                  //     setState(() {
                  //       isLoading = false;
                  //     });

                  //     resultMeditations.clear();
                  //     searchTextController.text = '';
                  //   } else {
                  //     setState(() {
                  //       resultMeditations = value;

                  //       isLoading = false;
                  //     });
                  //   }
                  // });
                },
              ),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {
                  searchable = false;
                });
              } else {
                setState(() {
                  searchable = true;
                });
              }
            },
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : resultMeditations.length == 0
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: Text("No Search Results")),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            itemBuilder: (context, index) {
                              return MeditationTile(
                                notifyParent: () => widget.notifyParent(),
                              );
                            },
                            itemCount: 20,
                            //resultMeditations.length < 5 ? resultMeditations.length : 5,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics()),
                      ],
                    ),
                  ),
                ),
    );
  }
}
