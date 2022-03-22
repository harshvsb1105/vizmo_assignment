import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  const ListItem({Key key,  this.image,  this.title,  this.subTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    alignment: Alignment.centerLeft,
                      image: NetworkImage(image),
                      fit: BoxFit.cover
                  )
              ),
            ),
            // leading: CircleAvatar(
            //   child: Image.asset(image, fit: BoxFit.cover,),
            //   radius: 20,
            // ),
            title: Text(
              title, style: TextStyle(fontSize: 18, color: const Color(0xff000000)),
            ),
            subtitle: Text(
              subTitle, style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(35, 0, 10,0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1.5)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
