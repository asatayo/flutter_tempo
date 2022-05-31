import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/adapters/houses_adapter.dart';
import 'package:tempo/adapters/service_adapter.dart';
import 'package:tempo/builders/http/houses_builder.dart';
import 'package:tempo/builders/prefs/regions_bulder.dart';
import 'package:tempo/http/rentals_http.dart';
import 'package:tempo/http/services_http.dart';
import 'package:tempo/list_init.dart';
import 'package:tempo/models/house_model.dart';
import 'package:tempo/models/rental_model.dart';
import 'package:tempo/models/services.dart';
import 'package:tempo/pages/dashboard/category/item_category.dart';
import 'package:get/get.dart';
import 'package:tempo/pages/regions/regions_page.dart';
import 'package:tempo/widgets/stateless/waveshimmer.dart';

import '../../../adapters/rental_adabpter.dart';
import '../../../builders/http/rentals_builder.dart';
import '../../../preferences/shared_preferences.dart';

bool isLoadingHttp = true;
RentalModel? selectedModel;

class MenuTab extends StatefulWidget {
  final Function notifyParent;
  const MenuTab({Key? key, required this.notifyParent}) : super(key: key);

  @override
  MenuTabState createState() => MenuTabState();
}

class MenuTabState extends State<MenuTab> {
  List<ServiceModel> seachildList = [];
  bool isSeaching = false;
  bool _isLoadingServices = true;
  bool _isLoadingRentals = true;
  String serviceSearchKey = '';
  late Future<bool> futureIsHouse;
  late Future<List<HouseModel>> futureHousesList;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    _initLoading();
    searchController.addListener(_textEditingCOntroller);
    super.initState();
  }

  @override
  void dispose() {
    searchController.removeListener(_textEditingCOntroller);
    super.dispose();
  }

  Future<void> assignChanges() async {
    isHouse = await AppData().getBool("ISHOUSE");
    isRental = await AppData().getBool("ISRENTAL");
    selectedService = await AppData().getString("NAME");
    setState(() {
      _initLoading();
    });
  }

  _initLoading() {
    if (isHouse) {
      futureHousesList = fetchFutureHouses(serviceSearchKey);
    } else {
      if (isRental) {
        _isLoadingRentals = true;
        httpLoadRentals(0, serviceSearchKey, _finishedLoading);
      } else {
        _isLoadingServices = false;
        httpLoadServices(0, serviceSearchKey, _finishedLoading);
      }
    }
  }

  _finishedLoading(bool isSuccess, String message) {
    setState(() {
      print("Done...");
      isLoadingHttp = false;
      _isLoadingRentals = false;
      _isLoadingServices = false;
    });
    // notifyChild();
    // widget.notifyParent();
  }

  void _textEditingCOntroller() {
    if (searchController.text.isNotEmpty) {
      setState(() {
        serviceSearchKey = searchController.text;
      });
      // widget.notifyParent();
      notifyChild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _searchCategory(context, widget.reactive),
        _verticalSpace(),
        _categoryText(context),
        _verticalSpace(),
        ServiceCategories(
            notifyParent: widget.notifyParent, notifyChild: notifyChild),
        _verticalSpace(),
        _recommendedServices(context),
        _verticalSpace(),
        _loadService()
      ],
    );
  }

  Widget _loadService() {
    return isHouse
        ? _housesList()
        : isRental
            ? _rentalList()
            : _servicesList();
  }

  Widget _rentalList() {
    // print("...Rental");
    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: rentalsList.isNotEmpty && !_isLoadingRentals
            ? _showRentals()
            : _isLoadingRentals
                ? _shimmerLoading(20)
                : _noData(isSeaching));
  }

  _showRentals() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        crossAxisSpacing: 2,
      ),
      itemCount: rentalsList.length,
      itemBuilder: (context, index) {
        return RentalAdapter(
          rentalModel: rentalsList[index],
        );
      },
    );
  }

  Widget _servicesList() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: servicesList.isNotEmpty && !_isLoadingServices
            ? _showServices()
            : _isLoadingServices
                ? _shimmerLoading(20)
                : _noData(isSeaching));
  }

  _showServices() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        crossAxisSpacing: 2,
      ),
      itemCount: servicesList.length,
      itemBuilder: (context, index) {
        return ServiceAdapter(
          serviceModel: servicesList[index],
        );
      },
    );
  }

  Widget _housesList() {
    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: FutureBuilder<List<HouseModel>>(
          future: futureHousesList,
          builder: (context, snapshort) {
            if (snapshort.hasData) {
              if (snapshort.data != null && snapshort.data!.isNotEmpty) {
                var houses = snapshort.data;
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                    crossAxisSpacing: 2,
                  ),
                  itemCount: snapshort.data == null ? 0 : houses!.length,
                  itemBuilder: (context, index) {
                    return HouseAdapter(
                      houseModel: houses![index],
                    );
                  },
                );
              } else {
                return _noData(isSeaching);
              }
            } else {
              return _shimmerLoading(20);
            }
          },
        ));
  }

  Widget _shimmerLoading(int count) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
        crossAxisSpacing: 2,
      ),
      itemCount: count,
      itemBuilder: (context, index) {
        return const ShimmerLoading();
      },
    );
  }

  Future<bool> _someDelay() {
    isSeaching = serviceSearchKey.isNotEmpty;
    Future.delayed(const Duration(seconds: 4));
    return Future.value(isSeaching);
  }

  Widget _noData(bool isSearch) {
    String title = 'no_service_found_for'.tr;
    String category = 'category_two'.tr;
    String selectedTransilation =
        selectedService != null ? selectedService!.tr : "Item not selected";
    return FutureBuilder<bool>(
        future: _someDelay(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (isSearch) {
              return _noDataFound();
            } else {
              if (isLoadingHttp) {
                return _shimmerLoading(10);
              } else {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const FaIcon(
                        // ignore: deprecated_member_use
                        FontAwesomeIcons.sadCry,
                        size: 60,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            '$title $selectedTransilation $category',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            'no_service_found_description'.tr,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
                );
              }
            }
          } else {
            return _shimmerLoading(10);
          }
        });
  }

  Widget _noDataFound() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 60,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    'no_results_found_for'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    serviceSearchKey,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                ],
              )),
          const SizedBox(
            width: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'no_service_found_description_search'.tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  Widget _searchCategory(BuildContext context, Function notifyCategoryChanged) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          padding: const EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
          height: 40,
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  child: _dropDown(context),
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegionsPage()))
                        .then(onGoBack);
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: _searchField(context),
              )
            ],
          ),
        ));
  }

  FutureOr onGoBack(dynamic value) {
    widget.notifyParent();
    setState(() {});
  }

  void notifyChild() {
    assignChanges();
  }

  Widget _searchField(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: TextField(
        autocorrect: false,
        controller: searchController,
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          hintText: 'seach_by_name_region_district'.tr,
          suffixIcon: const Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
          hintMaxLines: 1,
        ),
      ),
    );
  }

  Widget _dropDown(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
      ),
      child: FutureBuilder<String?>(
        builder: (context, snapshort) {
          String region = 'region'.tr;
          if (snapshort.hasData && snapshort.data != null) {
            region = snapshort.data!;
          }
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 7,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              child: Text(region,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ))),
                          const FaIcon(
                            FontAwesomeIcons.caretDown,
                            size: 15,
                            color: Colors.black,
                          )
                        ])),
              ]);
        },
        future: selectedRegion(),
      ),
    );
  }

  Widget _categoryText(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 30),
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Text(
          'categories'.tr,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  Widget _recommendedServices(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'recommended'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'all'.tr,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent),
            )
          ],
        ));
  }

  Widget _verticalSpace() {
    return const SizedBox(height: 10);
  }
}
