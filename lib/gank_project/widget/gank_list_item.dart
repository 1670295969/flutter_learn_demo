
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/bean/gank_item.dart';
import 'package:flutter_app/gank_project/utils/time_utils.dart';
class GankListItem extends StatefulWidget{

  final GankItem gankItem;

  GankListItem(this.gankItem);


  @override
  State<StatefulWidget> createState() {
    return _GankListItem();
  }

}

class _GankListItem extends State<GankListItem>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
//        Navigator.of(context).push(
//          MaterialPageRoute(
//            builder: (context){
//
//            }
//          )
//        );
      },

      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          border: Border(
            bottom: BorderSide(width: 0.0,color: Theme.of(context).dividerColor),
          )
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildGankListItem(context),
          ),
        ),

      ),
    );
  }

  List<Widget> _buildGankListItem(BuildContext context){
    var contentWidgets = <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 16,bottom: 16,left: 16,right: 10),
              child: Text(
                widget.gankItem.desc,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.body1,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 8,bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        widget.gankItem.who.startsWith("lijinsan")? IconData(0xe846, fontFamily: "IconFont"):Icons.person_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: SizedBox(
                          width: 75,
                          child: Text(
                            widget.gankItem.who,
                            maxLines: 1,
                            style: Theme.of(context).textTheme.body2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.access_time,color: Theme.of(context).primaryColor,),
                        Padding(
                          padding: const EdgeInsets.only(left: 1.0),
                          child: Text(
                              TimeUtils.formatDateStr(widget.gankItem.publishedAt),
                            style: Theme.of(context).textTheme.body2,
                          ),
                        )

                      ],
                    ),
                  )

                ],
              ),
            ),
          ],
        ),
      )
    ];

    if(widget.gankItem.images!=null && widget.gankItem.images.isNotEmpty){
      var imageUrl = widget.gankItem.images[0];
      contentWidgets.add(
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){

            }),
            );
          },
          child: Container(
            margin: EdgeInsets.only(right: 16,top:20,bottom: 20),
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  imageUrl.replaceAll("large", "thumbnail")
                )
              )
            ),
          ),

        )
      );


    }


    return contentWidgets;



  }




}

