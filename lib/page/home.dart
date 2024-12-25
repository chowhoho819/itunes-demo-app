import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itune_test_app/bloc/home_bloc/bloc.dart';
import 'package:itune_test_app/component/generic_button.dart';
import 'package:itune_test_app/component/network_image.dart';

import '../component/warning_container.dart';
import '../model/music.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScafford(child: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return switch (state.status) {
          HomeStatus.success => HomeSuccessView(count: state.recordCount, items: state.musics),
          HomeStatus.loading => HomeLoadingView(),
          HomeStatus.empty => HomeEmptyView(),
          HomeStatus.failure => HomeFailureView(),
        };
      },
    ));
  }
}

class HomeScafford extends StatelessWidget {
  final Widget child;
  const HomeScafford({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: child,
    );
  }
}

class HomeSuccessView extends StatelessWidget {
  final int count;
  final List<Music> items;
  const HomeSuccessView({super.key, required this.items, required this.count});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: count,
      itemBuilder: (context, index) {
        final Music item = items[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          leading: CachedImage(imageUrl: item.getImageUrl),
          title: Text(item.trackName ?? "不詳"),
          subtitle: Text(item.artistName ?? "不詳"),
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
          GenericButton(
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
          GenericButton(
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
