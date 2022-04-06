import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_search/firestore_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Shared/constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: FirestoreSearchBar(
          tag: 'users',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore
            .collection('users')
            .where('name', isEqualTo: 'ahmed')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text('no data yet'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${snapshot.data.docs[index]['name']}'),
              );
            },
          );
        },
      ),
      // body: Column(
      //   children: [
      //     FirestoreSearchResults.builder(
      //       tag :Fir,
      //       firestoreCollectionName: 'users',
      //       searchBy: 'name',
      //       initialBody: const Center(child: Text('Initial body'),),
      //       dataListFromSnapshot: UserModel().dataListFromSnapshot,
      //       builder: (context, snapshot) {
      //      return Container(child: Text('${snapshot}'),);
      //         final List<UserModel> dataList = snapshot.data??[];
      //
      //
      //         return ListView.builder(
      //               itemCount: dataList.length,
      //               itemBuilder: (context, index) {
      //                 final UserModel data = dataList[index];
      //
      //                 return Column(
      //                   mainAxisSize: MainAxisSize.min,
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.all(8.0),
      //                       child: Text(
      //                         '${data.name}',
      //                         style: Theme.of(context).textTheme.headline6,
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.only(
      //                           bottom: 8.0, left: 8.0, right: 8.0),
      //                       child: Text('${data.email}',
      //                           style: Theme.of(context).textTheme.bodyText1),
      //                     )
      //                   ],
      //                 );
      //               });
      //
      //
      //
      //       },
      //     ),
      //
      //   ],
      // ),
    );
  }
}
