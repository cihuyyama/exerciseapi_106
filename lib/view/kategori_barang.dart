import 'package:flutter/material.dart';
import 'package:materiapi/controller/kategori_barang_controller.dart';
import 'package:materiapi/model/kategori_barang_model.dart';
import 'package:materiapi/view/add_kategori_barang.dart';
import 'package:materiapi/view/edit_kategori_barang.dart';

class KategoriBarang extends StatefulWidget {
  const KategoriBarang({super.key});

  @override
  State<KategoriBarang> createState() => _KategoriBarangState();
}

class _KategoriBarangState extends State<KategoriBarang> {
  final kategoriBarangController = KategoriBarangController();
  List<KategoriBarangModel> listKategoriBarang = [];
  String? nama;

  @override
  void initState() {
    super.initState();
    getKategoriBarang();
  }

  void getKategoriBarang() async {
    final kategoriBarang = await kategoriBarangController.getKategoriBarang();
    setState(() {
      listKategoriBarang = kategoriBarang;
    });
  }

  void deleteKategoriBarang(int id) async {
    await kategoriBarangController.deleteKategoriBarang(id);
    setState(() {
      getKategoriBarang();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Barang'),
      ),
      body: SafeArea(
          child: ListView.builder(
        itemCount: listKategoriBarang.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(listKategoriBarang[index].nama),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditKategoriBarang(
                            nama: listKategoriBarang[index].nama,
                            id: listKategoriBarang[index].id,
                          ),
                        )
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                      onPressed: () {
                        deleteKategoriBarang(listKategoriBarang[index].id);
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddKategoriBarang()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}