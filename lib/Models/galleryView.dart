import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryView extends StatefulWidget {

  final PageController pageController;
  final imagePath;
  final int index;

  GalleryView({required this.index,required this.imagePath,super.key}) : pageController = PageController(initialPage: index);

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(onPressed: ()=>Navigator.pop(context), icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,))
          ,
        ),
        body: PhotoViewGallery.builder(
          pageController: widget.pageController,
          itemCount: widget.imagePath.length,
          builder: (context , index){
            QueryDocumentSnapshot x = widget.imagePath[index];

            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(x['Url'])
            );
          },
        ),
      ),
    );
  }
}
