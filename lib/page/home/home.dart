import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itune_test_app/bloc/home_bloc/bloc.dart';
import 'package:itune_test_app/component/generic_button.dart';
import 'package:itune_test_app/component/network_image.dart';
import 'package:itune_test_app/theme/font_style.dart';

import 'components/search_app_bar.dart';
import '../../component/warning_container.dart';
import '../../model/music.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Scroll Controller for background access;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScafford(
      scrollController: _scrollController,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return switch (state.status) {
            HomeStatus.success => HomeSuccessView(
                count: state.recordCount,
                items: state.musics,
                scrollController: _scrollController,
              ),
            HomeStatus.loading => HomeLoadingView(),
            HomeStatus.empty => HomeEmptyView(),
            HomeStatus.failure => HomeFailureView(),
          };
        },
      ),
    );
  }
}

class HomeScafford extends StatelessWidget {
  final Widget child;
  final ScrollController scrollController;
  const HomeScafford({super.key, required this.child, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(),
      body: child,
      floatingActionButton: HomeFABView(scrollController: scrollController),
    );
  }
}

class HomeSuccessView extends StatelessWidget {
  final int count;
  final List<Music> items;
  final ScrollController scrollController;
  const HomeSuccessView({super.key, required this.items, required this.count, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      itemCount: count,
      itemBuilder: (context, index) {
        final Music item = items[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          leading: CachedImage(imageUrl: item.getImageUrl),
          title: Text(item.trackName ?? "不詳"),
          subtitle: Text("${item.collectionName ?? ""} - ${item.artistName ?? "不詳"}"),
          trailing: Icon(Icons.play_arrow),
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.blueAccent),
          Text("請求數據中"),
        ],
      ),
    );
  }
}

class HomeFailureView extends StatelessWidget {
  const HomeFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Warning(warningText: "數據請求失敗，\n請確保網絡處在穩定環境中。"),
          GenericButton.text(
            onTap: () {
              context.read<HomeBloc>().add(HomeFetchEvent(limit: 200));
            },
            backgroundColor: Colors.blueAccent,
            fontColor: Colors.white,
            text: "重新請求",
          )
        ],
      ),
    );
  }
}

class HomeEmptyView extends StatelessWidget {
  const HomeEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Warning(warningText: "沒有相關資料", warningIcon: Icons.question_mark_rounded),
        ],
      ),
    );
  }
}

class HomeFABView extends StatefulWidget {
  final ScrollController scrollController;
  const HomeFABView({super.key, required this.scrollController});

  @override
  State<HomeFABView> createState() => _HomeFABViewState();
}

class _HomeFABViewState extends State<HomeFABView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // avoid rebuild with setstate.
  final ValueNotifier<bool> _expandNotifier = ValueNotifier(false);
  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _expandedChildBuilder(),
        SizedBox(height: 20),
        GenericButton.expandAble(
          shrink: true,
          onTap: () {
            if (_expandNotifier.value == false) {
              _expandNotifier.value = true;
              _animationController.forward();
            } else {
              _expandNotifier.value = false;
              _animationController.reverse();
            }
          },
          backgroundColor: Colors.blueGrey,
          icon: Icons.sort,
          expandedIcon: Icons.close,
        ),
        SizedBox(height: 10),
        GenericButton.icon(
          shrink: true,
          onTap: () {
            widget.scrollController.jumpTo(0);
          },
          backgroundColor: Colors.blueGrey,
          icon: Icons.arrow_circle_up,
        )
      ],
    );
  }

  Widget _expandedChildBuilder() {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      return SizeTransition(
        sizeFactor: _animation,
        axis: Axis.horizontal,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(color: Colors.blueGrey, borderRadius: BorderRadius.circular(10)),
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SortButton(
                icon: state.sortIndicator.song.icon,
                text: "歌曲名稱",
                state: state,
                onTap: () {
                  context.read<HomeBloc>().add(HomeSortEvent(sortState: state.sortIndicator.toggleSongSort()));
                },
              ),
              SortButton(
                icon: state.sortIndicator.album.icon,
                text: "專輯名稱",
                state: state,
                onTap: () {
                  context.read<HomeBloc>().add(HomeSortEvent(sortState: state.sortIndicator.toggleAlbumSort()));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class SortButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;
  final HomeState state;
  const SortButton({
    super.key,
    required this.icon,
    required this.text,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text, style: AppText.jfR18White),
          Icon(icon, color: Colors.white),
        ],
      ),
    );
  }
}
