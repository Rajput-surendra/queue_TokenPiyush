import 'package:booknplay/Constants.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/material.dart';

class DrawerIconTab extends StatefulWidget {
  final String? icon;
  final String? titlee;
  final int? tabb;
  final int? indexx;

  DrawerIconTab({Key? key, this.icon, this.titlee, this.tabb, this.indexx})
      : super(key: key);

  @override
  State<DrawerIconTab> createState() => _DrawerIconTabState();
}

class _DrawerIconTabState extends State<DrawerIconTab> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          gradient: widget.indexx == widget.tabb
              ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.secondary])
              : null),
      // color:
      //     widget.indexx == widget.tabb ? colors.secondary : Colors.transparent,
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Container(
            decoration:  BoxDecoration(
                color: widget.indexx == widget.tabb ? AppColors.whit : AppColors.secondary , borderRadius: BorderRadius.circular(5)),
            height: 30,
            width: 30,
            child: Center(
                child: ImageIcon(
                  AssetImage(widget.icon ?? ''),
                  color: widget.indexx == widget.tabb ? AppColors.secondary : AppColors.whit,
                  size: 20,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            '${widget.titlee}',
            style: TextStyle(
                fontSize: 15,
                fontWeight: widget.indexx == widget.tabb
                    ? FontWeight.normal
                    : FontWeight.bold,
                color:
                widget.indexx == widget.tabb ? AppColors.whit : AppColors.fntClr),
          ),
        ],
      ),
    );
  }
}

