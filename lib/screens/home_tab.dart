import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
//   var donor;

//   @override
//   void initState() {
//     super.initState();
//     donorData();
//   }

//   Future<void> donorData() async {
//     final response = await http.post(
//       Uri.parse('http://localhost:5000/api/donordata'),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       setState(() {
//          donor = data[0];
        
//       });
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
  List<Map<String, dynamic>> donorData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDonorData();
  }

  Future<void> fetchDonorData() async {
    final response = await http.post(
      Uri.parse('http://localhost:5000/api/donordata'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        donorData = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load donor data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Donor Data'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : donorData.isEmpty
              ? Center(child: Text('No donor data available'))
              : ListView.builder(
                  itemCount: donorData.length,
                  itemBuilder: (context, index) {
                    final donor = donorData[index];
                    return ListTile(
                      title: Text(donor['name'] ?? 'N/A'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Blood Group: ${donor['bloodgroup'] ?? 'N/A'}'),
                          Text('Phone No: ${donor['phoneno'] ?? 'N/A'}'),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}


