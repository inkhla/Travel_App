import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/app_cubit_states.dart';
import 'package:travel_app/cubit/app_cubits.dart';
import 'package:travel_app/misc/colors.dart';
import 'package:travel_app/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  var images = {
    'img/balloning.png': 'Balloning',
    'img/hiking.png': 'Hiking',
    'img/kayaking.png': 'Kayaking',
    'img/snorkling.png': 'Snorkling',
  };

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context, state) {
          if (state is LoadedState) {
            var info = state.places;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row that contains menu and profile Icon
                Container(
                  padding: const EdgeInsets.only(top: 70, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.menu,
                        color: Colors.black54,
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // Discover Text
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: AppLargeText(text: 'Discover'),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Tap bar
                DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TabBar(
                            padding: const EdgeInsets.all(0),
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: CircleTabIndicator(
                                color: AppColors.mainColor, radius: 4),
                            tabs: const [
                              Tab(
                                text: 'Places',
                              ),
                              Tab(
                                text: 'Inspiration',
                              ),
                              Tab(
                                text: 'Emotions',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20),
                        height: 300,
                        width: double.maxFinite,
                        child: TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: info.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: (){
                                    BlocProvider.of<AppCubits>(context).detailPage(info[index]);
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(right: 15, top: 10),
                                    width: 200,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              'http://mark.bslmeiyu.com/uploads/' +
                                                  info[index].img!),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              },
                            ),
                            const Text('hello'),
                            const Text('there'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                // This container contains two texts explore more and see all
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(
                        text: 'Explore more',
                        size: 22,
                      ),
                      AppText(
                        text: 'See all',
                        color: AppColors.textColor1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Contains list of activities user can do
                Container(
                  height: 120,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 30),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        images.keys.elementAt(index),
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: AppText(
                                  text: images.values.elementAt(index),
                                  color: AppColors.textColor2,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}

// dot circle indicator of tab bar selected item
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
      configuration.size!.width / 2 - radius / 2,
      configuration.size!.height - radius,
    );
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
