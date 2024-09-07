import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String data = "";
  @override
  void initState() {
    super.initState();
    loadData().then((value) {
      data = value;
      setState(() {});
    });
  }

  Future<String> loadData() async {
    String data = await getData();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("next page"),
      ),
      body: Center(
        child: Text(data),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async {
          await FirebaseAuth.instance.signOut();
        },
        child: const Icon(Icons.logout),
      ),
    );
  }

  Future<String> getData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String uid = pref.getString("uid") ?? "";
      if (uid != "") {
        final FirebaseFirestore store = FirebaseFirestore.instance;
        final data = await store
            .collection('user')
            .doc(uid)
            .get()
            .then((data) => data.data()!.values.first);
        return data;
      } else {
        print("something went wrong");
        return "fucked up";
      }
    } catch (err) {
      print(err);
      return err.toString();
    }
  }
}
