// import 'package:tempo/models/rental_model.dart';
// import 'package:tempo/models/thumbnail_model.dart';
// import 'package:tempo/widgets/stateless/image.dart';
// import 'package:tempo/widgets/stateless/photo_thumbnail.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';

// class ViewRentalPage extends StatefulWidget {
//   final RentalModel rentalModel;
//   const ViewRentalPage({
//     Key key,
//     this.rentalModel,
//   }) : super(key: key);

//   @override
//   _ViewRentalPage createState() => _ViewRentalPage();
// }

// class _ViewRentalPage extends State<ViewRentalPage> {
//   ScrollController _scrollController;
//   Color appbarTextColor = Colors.white;

//   @override
//   void initState() {
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_scrollListener);
//     super.dispose();
//   }

//   _scrollListener() {
//     if (_scrollController.hasClients && _scrollController.offset > 150) {
//       setState(() {
//         appbarTextColor = Theme.of(context).textTheme.bodyText2.color;
//       });
//     } else {
//       setState(() {
//         appbarTextColor = Colors.white;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             backgroundColor: Theme.of(context).primaryColor,
//             body: NestedScrollView(
//               controller: _scrollController,
//               headerSliverBuilder:
//                   (BuildContext context, bool innerBoxIsScrolled) {
//                 return <Widget>[
//                   SliverAppBar(
//                     backgroundColor: Theme.of(context).primaryColor,
//                     flexibleSpace: FlexibleSpaceBar(
//                         centerTitle: false,
//                         title: Text(widget.rentalModel.name,
//                             style: TextStyle(color: appbarTextColor)),
//                         background: ImageData(
//                             imageUrl: widget.rentalModel.bannerThumbNail)),
//                     elevation: 2,
//                     leading: Container(
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: const BorderRadius.only(
//                                 topRight: Radius.circular(50),
//                                 bottomRight: Radius.circular(50))),
//                         child: ClipRRect(
//                             child: IconButton(
//                           icon: Icon(Icons.arrow_back_ios_outlined,
//                               color:
//                                   Theme.of(context).textTheme.bodyText2.color),
//                           onPressed: () => Navigator.of(context).pop(),
//                         ))),
//                     expandedHeight: 250.0,
//                     floating: false,
//                     pinned: true,
//                   )
//                 ];
//               },
//               body: CustomScrollView(
//                 slivers: [
//                   SliverToBoxAdapter(
//                     child: SizedBox(
//                       child: Column(
//                         children: const [
//                           //  Text('Hello this is not UKRAINE'), 
//                           // _serviceDescriptions(widget.rentalModel.description,
//                           //     widget.rentalModel.name),
//                           // _loadThumbnails(
//                           //     context, widget.rentalModel.thumbnails),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverFillRemaining(
//                       hasScrollBody: false,
//                       fillOverscroll: true,
//                       child: Align(
//                           alignment: Alignment.bottomCenter,
//                           child: Container(
//                             padding: const EdgeInsets.only(
//                                 left: 30, right: 30, bottom: 10, top: 30),
//                             child: Column(children: [
//                               InkWell(
//                                 onTap: () {
//                                   // Navigator.push(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) => RoomsPage(
//                                   //             rentalModel:
//                                   //                 widget.rentalModel)));
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).backgroundColor,
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(20)),
//                                   ),
//                                   padding: const EdgeInsets.only(
//                                       left: 20, right: 20),
//                                   height: 50,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text('choose_room'.tr,
//                                           style: const TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 20)),
//                                       const SizedBox(width: 10),
//                                       const Icon(
//                                           Icons.arrow_forward_ios_outlined,
//                                           color: Colors.black),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ]),
//                           )))
//                 ],
//                 // children: [

//                 //   //  _loadThumbnails(context, widget.rentalModel.service)
//                 // ],
//               ),
//             )));
//   }

//   Widget _serviceDescriptions(String description, String name) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           // Text(name,
//           //     style: TextStyle(
//           //         fontSize: 30,
//           //         color: Theme.of(context).textTheme.bodyText2.color)),
//           // const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             // ignore: prefer__literals_to_create_immutables
//             children: [
//               const FaIcon(FontAwesomeIcons.mapMarkerAlt,
//                   color: Colors.amber, size: 16),
//               const SizedBox(width: 10),
//               Text(widget.rentalModel.region,
//                   style: const TextStyle(fontSize: 16)),
//               const SizedBox(width: 10),
//               Text(widget.rentalModel.district,
//                   style: const TextStyle(fontSize: 16)),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Text(description ?? 'no_description'.tr,
//               style: const TextStyle(fontSize: 18)),
//         ],
//       ),
//     );
//   }

//   Widget _loadThumbnails(
//       BuildContext context, List<ThumbnailModel> thumbnails) {
//     // String name;
//     // int price;
//     String thumbnail;
//     // String description;
//     return Container(
//       color: Theme.of(context).primaryColor,
//       height: MediaQuery.of(context).size.height / 5,
//       child: thumbnails.isNotEmpty
//           ? ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: thumbnails.length,
//               itemBuilder: (BuildContext context, int index) {
//                 thumbnail = thumbnails[index].imageuUrl;
//                 return PhotoThumbnailAdapter(imageUrl: thumbnail);
//               })
//           : Center(
//               child: Text(
//               'no_thumbnails'.tr,
//               style: const TextStyle(fontSize: 18),
//             )),
//     );
//   }
// }
