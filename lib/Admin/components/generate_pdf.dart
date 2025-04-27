import 'dart:io';
import 'package:edu_mate/service/app_logger.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> generatePDF(List<Map<String, dynamic>> data) async {
  final pdf = pw.Document();

  // Load custom font
  final font = await rootBundle.load("assets/fonts/NotoSans-Regular.ttf");
  final ttf = pw.Font.ttf(font);

  // Get current date for header and filename
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(now);
  String formattedMonth = DateFormat('yyyy-MM').format(now);
  final fileName = "${formattedMonth}_Fee_Report.pdf";

  // Build the PDF
  pdf.addPage(
    pw.MultiPage(
      theme: pw.ThemeData.withFont(base: ttf),
      header: (pw.Context context) => pw.Column(
        children: [
          pw.Text(
            'CLASS FEE REPORT',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Generated on $formattedDate',
            style: const pw.TextStyle(fontSize: 10),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 16),
          pw.Divider(thickness: 1),
          pw.SizedBox(height: 16),
        ],
      ),
      footer: (pw.Context context) => pw.Column(
        children: [
          pw.Divider(thickness: 1),
          pw.SizedBox(height: 8),
          pw.Text(
            'Page ${context.pageNumber} of ${context.pagesCount}',
            style: const pw.TextStyle(fontSize: 10),
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
      build: (pw.Context context) => [
        pw.Table.fromTextArray(
          border: pw.TableBorder.all(width: 0.5),
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          headers: ['Student ID', 'Subject', 'Status'],
          data: data
              .map((item) => [
                    item['studentId'].toString(),
                    item['subject'],
                    item['isPaid'] ? 'PAID' : 'PENDING',
                  ])
              .toList(),
        ),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              'Total Students: ${data.length}',
              style: const pw.TextStyle(fontSize: 12),
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              'Paid Students: ${data.where((item) => item['isPaid']).length}',
              style: const pw.TextStyle(fontSize: 12),
            ),
          ],
        ),
        pw.SizedBox(height: 20),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              'Non Paid Students: ${data.where((item) => !item['isPaid']).length}',
              style: const pw.TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    ),
  );

  // Request storage permission and save the file
  if (await Permission.storage.request().isGranted) {
    final bytes = await pdf.save();

    String filePath;
    if (Platform.isAndroid) {
      final directory = Directory('/storage/emulated/0/Download');
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      filePath = '${directory.path}/$fileName';
    } else {
      final directory = await getApplicationDocumentsDirectory();
      filePath = '${directory.path}/$fileName';
    }

    final file = File(filePath);
    await file.writeAsBytes(bytes);
    AppLogger().i("PDF saved: $filePath");
  } else {
    AppLogger().w("Storage permission denied.");
  }
}
