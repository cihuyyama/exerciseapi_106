import 'package:flutter/material.dart';
import 'package:materiapi/controller/kategori_barang_controller.dart';
import 'package:materiapi/view/kategori_barang.dart';

class EditKategoriBarang extends StatefulWidget {
  final String? nama;
  final int? id;
  const EditKategoriBarang({
    Key? key,
    this.nama,
    this.id
  }) : super(key: key);

  @override
  State<EditKategoriBarang> createState() => _EditKategoriBarangState();
}

class _EditKategoriBarangState extends State<EditKategoriBarang> {
  final kategoriBarangController = KategoriBarangController();
  String? name;

  void editKategoriBarang(String nama, int id) async{
    await kategoriBarangController.updateKategoriBarang(id,nama);
  }

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kategori Barang'),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nama Kategori Barang',
                labelText: 'Nama Kategori Barang',
              ),
              onChanged: (value) {
                name = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Kategori is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  formkey.currentState!.save();
                  editKategoriBarang(
                    name!,widget.id!
                  );
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const KategoriBarang()));

                  var snackBar =
                      const SnackBar(content: Text('Data Berhasil Disimpan'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}