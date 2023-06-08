import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../service/add_meal_service.dart';

class YemeklerSayfasi extends StatelessWidget {
    final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemekler'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getMealStream(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Hata: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Text('Gösterilecek yemek bulunamadı.');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> meals =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              return Card(
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(meals['imageUrl'])),
                  title: Text(meals['mealName']),
                  subtitle: Text(meals['protein']),
                  onTap: () {
                    // Kart tıklandığında yapılacak işlemler
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
