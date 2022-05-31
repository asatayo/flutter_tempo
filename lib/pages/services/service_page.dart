import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempo/models/thumbnail_model.dart';
import 'package:tempo/pages/rooms/roms_page.dart';
import 'package:tempo/models/services.dart';
import 'package:tempo/pages/signin/sign_in_page.dart';
import 'package:tempo/preferences/shared_preferences.dart';
import 'package:tempo/widgets/stateless/photo_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ServicePage extends StatefulWidget {
  final ServiceModel serviceModel;
  const ServicePage({
    Key? key,
    required this.serviceModel,
  }) : super(key: key);

  @override
  ServicePageState createState() => ServicePageState();
}

class ServicePageState extends State<ServicePage> {
  late ScrollController _scrollController;
  Color appbarTextColor = Colors.white;
  bool _isAuthenticated = false;

  late double width, height;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _checkIfAuth();
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

  Future<void> _checkIfAuth() async {
     await AppData().storeValue('OPTION_ID', widget.serviceModel.serviceId);
    _isAuthenticated = await AppData().getBool('isAuthenticated');
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
                title: Text(widget.serviceModel.name,
                    style: TextStyle(color: appbarTextColor)),
                background: Image.network(
                  widget.serviceModel.bannerThumbNail,
                  fit: BoxFit.cover,
                ),
              ),
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
              child: Column(
                children: [
                  
                  widget.serviceModel.description!=null?  _serviceDescriptions(widget.serviceModel.description!,
                      widget.serviceModel.name): const SizedBox(height: 0),
                  _loadThumbnails(context, widget.serviceModel.thumbnails),
                ],
              ),
            ),
          ],
          //   //  _loadThumbnails(context, widget.serviceModel.servic
        ),
      ),
      bottomSheet: confirmButton(),
    ));
  }

  confirmButton() {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 10, bottom: 20, right: 20),
        child: InkWell(
            onTap: ()  {
               if(_isAuthenticated){
                 
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RoomsPage(serviceModel: widget.serviceModel)));
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
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('choose_room'.tr,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 16)),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                ],
              ),
            )));
  }

  Widget _serviceDescriptions(String description, String name) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          // Text(name,
          //     style: TextStyle(
          //         fontSize: 30,
          //         color: Theme.of(context).textTheme.bodyText2.color)),
          // const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer__literals_to_create_immutables
            children: [
              // ignore: deprecated_member_use
              const FaIcon(FontAwesomeIcons.mapMarkerAlt,
                  color: Colors.amber, size: 16),
              const SizedBox(width: 10),
              Text(widget.serviceModel.region,
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 10),
              Text(widget.serviceModel.district,
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(description,
              style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _loadThumbnails(
      BuildContext context, List<ThumbnailModel> thumbnails) {
    // String name;
    // int price;
    String thumbnail;
    // String description;
    return Container(
      color: Theme.of(context).primaryColor,
      height: MediaQuery.of(context).size.height / 5,
      child: thumbnails.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: thumbnails.length,
              itemBuilder: (BuildContext context, int index) {
                thumbnail = thumbnails[index].imageuUrl;
                return PhotoThumbnailAdapter(imageUrl: thumbnail);
              })
          : Center(
              child: Text(
              'no_thumbnails'.tr,
              style: const TextStyle(fontSize: 18),
            )),
    );
  }
}
