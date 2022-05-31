import 'package:tempo/adapters/regions_adapter.dart';
import 'package:tempo/builders/prefs/regions_bulder.dart';
import 'package:tempo/models/regions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

String searchText = '';

class RegionsPage extends StatefulWidget {
   const RegionsPage({Key? key}) : super(key: key);
  @override
  RegionsPageState createState() => RegionsPageState();
}

class RegionsPageState extends State<RegionsPage> {
  final TextEditingController _filter = TextEditingController();

  @override
  initState() {
    //  print(isSearching);
    _filter.addListener(_filderSearch);
    super.initState();
  }

  @override
  dispose() {
    _filter.removeListener(_filderSearch);
    super.dispose();
  }

  _filderSearch() {
    setState(() {
      searchText = _filter.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(isEnglish);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined,
                color: Theme.of(context).textTheme.bodyText2!.color),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: _searchView(),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
            padding:  const EdgeInsets.all(10),
            child: FutureBuilder(
                future: loadRegions(searchText),
                builder: (context, data) {
                  if (data.hasError) {
                    //in case if error found
                    return Center(child: Text("${data.error}"));
                  } else if (data.hasData) {
                    
                    var regions = data.data as List<Regions>;
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: regions.length,
                      itemBuilder: (context, index) {
                        return RegionAdapter(name: regions[index].name);
                      },
                    );
                  } else {
                    return  const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ),
    );
  }

  Widget _searchView() {
    return TextField(
        controller: _filter,
        decoration: InputDecoration(
            prefixIcon:  const Icon(Icons.search),
            hintText: 'search_regions'.tr));
  }
}
