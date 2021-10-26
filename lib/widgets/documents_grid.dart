import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/documents.dart';
import './documents_grid_item.dart';

class DocumentsGrid extends StatelessWidget {
  final bool showSaves;

  DocumentsGrid(this.showSaves);

  @override
  Widget build(BuildContext context) {
    final docsData = Provider.of<Documents>(context);
    final documents = showSaves ? docsData.savedItems : docsData.files;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: documents.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: documents[i],
        child: DocumentItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
