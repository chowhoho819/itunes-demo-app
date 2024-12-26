import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itune_test_app/bloc/home_bloc/bloc.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize {
    double screenHeight = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size.height;
    return Size(double.infinity, screenHeight * 0.07);
  }
}

class _SearchAppBarState extends State<SearchAppBar> {
  late TextEditingController _searchTextController;
  @override
  void initState() {
    _searchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: widget.preferredSize.height,
        width: widget.preferredSize.width,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _searchTextController,
                onChanged: (value) {
                  context.read<HomeBloc>().add(HomeSearchEvent(searchText: value.toLowerCase()));
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  hintText: "請輸入歌曲/專輯名稱",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
