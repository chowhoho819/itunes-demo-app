import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itune_test_app/bloc/home_bloc/bloc.dart';

import '../model/music.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScafford(child: BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return switch (state.status) {
          HomeStatus.success => HomeSuccessView(
              count: state.recordCount,
              items: state.musics,
            ),
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
        return Text(items[index].artistName ?? "");
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
          CircularProgressIndicator(),
          Text("提取數據中"),
        ],
      ),
    );
  }
}

class HomeFailureView extends StatelessWidget {
  const HomeFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class HomeEmptyView extends StatelessWidget {
  const HomeEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
