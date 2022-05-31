import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/models/rental_model.dart';
import 'package:tempo/pages/rental/rental_details/rental_details_page.dart';
import 'package:tempo/pages/signin/sign_in_page.dart';
import 'package:tempo/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../rentalrooms/rental_roms_page.dart';

class RentalPage extends StatefulWidget {
  final RentalModel rentalModel;
  final bool isAuthenticated;
  const RentalPage({
    Key? key,
    required this.rentalModel,
    required this.isAuthenticated,
  }) : super(key: key);

  @override
  RentalPageState createState() => RentalPageState();
}

class RentalPageState extends State<RentalPage> {
  late ScrollController _scrollController;
  Color appbarTextColor = Colors.white;
  late double width, height;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.hasClients && _scrollController.offset > 150) {
      setState(() {
        appbarTextColor = Theme.of(context).textTheme.bodyText2!.color!;
      });
    } else {
      setState(() {
        appbarTextColor = Colors.white;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text(widget.rentalModel.name,
                        style: TextStyle(color: appbarTextColor)),
                    background:Image.network(widget.rentalModel.bannerThumbNail,fit: BoxFit.cover, )),
                elevation: 2,
                leading: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: ClipRRect(
                        child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_outlined,
                          color: Theme.of(context).textTheme.bodyText2!.color),
                      onPressed: () => Navigator.of(context).pop(),
                    ))),
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
              )
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  child: Column(
                    children: [
                       _serviceIntro(),
                    
                      _loadThumbnails(),
                        _serviceDescriptions(),
                    ],
                  ),
                ),
              ),
              // SliverFillRemaining(
              //     hasScrollBody: false,
              //     fillOverscroll: true,
              //     child: _bottomButton()
              //     )
            ],
          ),
        ),
        bottomSheet: _bottomButton(),
      ),
    );
  }

 

  _bottomButton() {
    return   Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
      height: 50,
      width: width,
      child: widget.rentalModel.hasRoom
          ?  Row(children: [
                 Flexible(flex: 1,
                  child: InkWell( 
                      onTap: (){

                         if( widget.isAuthenticated){
                 
                                  Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => RentalDetailsPage(
                                                  isAuthenticated: widget.isAuthenticated,
                                                    rentalModel: widget.rentalModel)));
                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Signin(shouldAutheticate: true,)));
                              }

                           
                      },
                      child: Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
         
                ),
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.info_rounded,
                                color: Colors.black, size:20),
                    const SizedBox(width: 5),
                    Text('view_details'.tr,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15)),
                    
                    
                  ],
                ),
              ),
                  )
                 ), 

                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {

                          if( widget.isAuthenticated){
                 
                                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RentalRoomsPage(
                                    rentalModel: widget.rentalModel)));
                              }else{
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Signin(shouldAutheticate: true,)));
                              }

                       
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                        ),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('view_rooms'.tr,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15)),
                            const SizedBox(width: 10),
                            const Icon(Icons.business,
                                color: Colors.white,size: 18 ),
                          ],
                        ),
                      ),
                    )), 
              ],
            )
          : widget.isAuthenticated
              ? InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RentalDetailsPage(
                              isAuthenticated: widget.isAuthenticated,
                                rentalModel: widget.rentalModel)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      // borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    // padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('see_more'.tr,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18)),
                        const SizedBox(width: 10),
                        const Icon(Icons.info,
                            color: Colors.black, size: 18,),
                      ],
                    ),
                  ),
                )
              : InkWell(
                  onTap: () async {
                    await AppData().storeValue('hasValue', true);

                    await AppData().storeValue(
                        'selectedRental', widget.rentalModel.houseId);

                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signin(shouldAutheticate: true)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      // borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    // padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('sign_in_to_see'.tr,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20)),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_forward_ios_outlined,
                            color: Colors.black),
                      ],
                    ),
                  ),
                ),
    ));
  }

  Widget _serviceDescriptions() {
    return Container(
      padding: const EdgeInsets.all(10),
      child:  Text(widget.rentalModel.description,
              style: const TextStyle(fontSize: 18)),
      
    );
  }

   Widget _serviceIntro() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // ignore: deprecated_member_use
          const FaIcon(FontAwesomeIcons.mapMarkerAlt,
              color: Colors.amber, size: 16),
          const SizedBox(width: 10),
          Text(widget.rentalModel.region, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Text(widget.rentalModel.district,
              style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _loadThumbnails() {
    return CarouselSlider.builder(
                      itemCount: widget.rentalModel.thumbnails.length,
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: 250,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        reverse: false,
                        aspectRatio: 5.0,
                      ),
                      itemBuilder: (context, i, id) {
                        //for onTap to redirect to another screen
                        return Image.network(
                                widget.rentalModel.thumbnails[i].imageuUrl,
                                width: width,
                                fit: BoxFit.cover,
                              );
                            
                      },
                
                  );
  }
}
