import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: FiyatEkrani()));

class FiyatEkrani extends StatefulWidget {
  const FiyatEkrani({super.key});
  @override
  State<FiyatEkrani> createState() => _FiyatEkraniState();
}

class _FiyatEkraniState extends State<FiyatEkrani> {
  final adCtrl = TextEditingController();
  final linkCtrl = TextEditingController();
  final eskiCtrl = TextEditingController();
  final yeniCtrl = TextEditingController();

  void kontrolEt() {
    final eski = double.tryParse(eskiCtrl.text.replaceAll(',', '.')) ?? 0;
    final yeni = double.tryParse(yeniCtrl.text.replaceAll(',', '.')) ?? 0;
    if (eski <= 0) return;

    final degisim = ((yeni - eski) / eski) * 100;
    if (degisim <= -90.0) {
      Share.share('%%%${degisim.abs().toStringAsFixed(1)} INDIRIM!\n${adCtrl.text}\n${linkCtrl.text}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Degisim: %${degisim.toStringAsFixed(1)} (%90 altinda)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fiyat Avcisi (%90+)')),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextField(controller: adCtrl, decoration: const InputDecoration(labelText: 'Urun Adi')),
            TextField(controller: linkCtrl, decoration: const InputDecoration(labelText: 'Link (https://...)')),
            TextField(controller: eskiCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Eski Fiyat')),
            TextField(controller: yeniCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Yeni Fiyat')),
            const SizedBox(height: 14),
            ElevatedButton(onPressed: kontrolEt, child: const Text('Kontrol Et ve Paylas')),
          ],
        ),
      ),
    );
  }
}
