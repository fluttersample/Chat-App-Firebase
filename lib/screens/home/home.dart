

import 'package:fiirebasee/screens/home/home_controller.dart';
import 'package:fiirebasee/screens/search/search.dart';
import 'package:fiirebasee/screens/widgets/reusable_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeSc extends StatefulWidget {
  const HomeSc({Key? key}) : super(key: key);

  @override
  State<HomeSc> createState() => _HomeScState();
}

class _HomeScState extends State<HomeSc> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context,listen: false);

    return Scaffold(
     appBar: const AppbarWidget(text: 'Flutter + Firebase'),
      body: ListView(

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
            SearchSc(),));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
