import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/doc_item.dart';

import 'flutter_icons.dart';

class DocumentItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<Auth>(context, listen: false);
    final file = Provider.of<Document>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(
            //   ProductDetailScreen.routeName,
            //   arguments: product.id,
            // );
          },
          child: Hero(
            tag: file.id,
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/images/image-placeholder.jpg'),
              image: NetworkImage(file.img[0]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          title: Text(
            file.title,
            textAlign: TextAlign.left,
          ),
          trailing: Consumer<Document>(
            builder: (ctx, document, _) => IconButton(
              icon: Icon(
                // document.inBriefcase ? Icons.favorite : Icons.favorite_border,
                document.inBriefcase
                    ? MyFlutterApp.iconmonstr_briefcase_15
                    : MyFlutterApp.iconmonstr_briefcase_16,
              ),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                document.toggleSaveStatus(
                  authData.token.toString(),
                  authData.userId.toString(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
