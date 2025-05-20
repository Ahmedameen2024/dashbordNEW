import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Tixt extends StatefulWidget {
  static const String routeName = 'tixt';

  const Tixt({super.key});

  @override
  State<Tixt> createState() => _TixtState();
}

class _TixtState extends State<Tixt> {
  CollectionReference usersRef = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text('جدول بيانات المستخدمين'),
      ),
      drawer: Drawer(),
      body: StreamBuilder(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final userData =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Table(
                    children: [
                      TableRow(
                        children: [
                          Text("name: ${userData['UserName'] ?? 'No Name'}"),
                          Text("email : ${userData['email'] ?? 'No Email'}"),
                          Text(
                              "password : ${userData['password'] ?? 'No Password'}"),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No data found"));
          }
        },
      ),
    );
  }
}

// class Tixt extends StatefulWidget {
//   static const String routeName = 'tixt';

//   const Tixt({super.key});

//   @override
//   State<Tixt> createState() => _TixtState();
// }

// class _TixtState extends State<Tixt> {
//   final CollectionReference usersRef =
//       FirebaseFirestore.instance.collection("users");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         centerTitle: true,
//         title: const Text('جدول بيانات المستخدمين'),
//       ),
//       drawer: Drawer(),
//       body: FutureBuilder<QuerySnapshot>(
//         future: usersRef.get(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return const Center(child: Text("No users found."));
//           }

//           final docs = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final userData = docs[index].data() as Map<String, dynamic>;

//               // return ListTile(
//               //   title: Text(userData['userName'] ?? 'No Name'),
//               //   subtitle: Text("email : ${userData['email']}"),
//               //   trailing: Text("password : ${userData['password']}"),
//               // );

//               return ListTile(
//                   title: Table(
//                 // defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//                 children: [
//                   TableRow(
//                     children: [
//                       Text("name: ${userData['name'] ?? 'No Name'}"),
//                       Text("email : ${userData['email'] ?? 'No Email'}"),
//                       Text("password : ${userData['password'] ?? 'No Password'}"),
//                     ],
//                   ),
//                 ],
//               ));
//             },
//           );
//         },
//       ),
//     );
//   }
// }
