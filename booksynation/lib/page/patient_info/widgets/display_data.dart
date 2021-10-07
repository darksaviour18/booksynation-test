import 'package:booksynation/page/patient_info/widgets/infoData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayData extends StatelessWidget {
  const DisplayData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: 250,
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: users,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }

                final data = snapshot.requireData;

                return ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              'My name is ${data.docs[index]['firstname']} ${data.docs[index]['middlename']} ${data.docs[index]['lastname']} ${data.docs[index]['suffix']}'),
                          Text('Gender: ${data.docs[index]['gender']}'),
                          Text('Bdate: ${data.docs[index]['bday']}'),
                          Text(
                              'Civil Status:${data.docs[index]['civstatus']} '),
                          Text('Philhealth:${data.docs[index]['philhealth']}'),
                        ],
                      );
                    });
              },
            )),
      ),
    );
  }
}
