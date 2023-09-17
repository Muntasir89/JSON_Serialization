import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:staggered_grid_view/RemoteService.dart';
import 'package:staggered_grid_view/post.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();

    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter REST API'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        posts![index].title ?? " ",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        posts![index].body ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          itemCount: posts?.length,
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
