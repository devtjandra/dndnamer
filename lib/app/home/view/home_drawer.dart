import 'package:dndnamer/app/home/logic/home_drawer_view_model.dart';
import 'package:dndnamer/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:dndnamer/values/values.dart';
import 'package:flutter_riverpod/all.dart';

final _viewModel =
    Provider<HomeDrawerViewModel>((ref) => HomeDrawerViewModel(ref));
final _userName =
    FutureProvider<String>((ref) => ref.read(_viewModel).getName());

final isWaitingLogout = StateProvider<bool>((ref) => false);

class HomeDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Column(children: [
      DrawerHeader(
        // decoration: BoxDecoration(color: Colors.black87),
        child: Text(
          "Welcome, ${watch(_userName).data?.value ?? ""}!",
          // style: TextStyle(color: Colors.white),
        ),
      ),
      ListTile(
        title: const Text(Strings.home),
        onTap: () => context.read(_viewModel).nameGenerator(context),
      ),
      ListTile(
        title: const Text(Strings.games),
        onTap: () => context.read(_viewModel).games(context),
      ),
      ListTile(
        title: const Text(Strings.logOut),
        onTap: () => context.read(_viewModel).signOut(context),
      ),
      if (watch(isWaitingLogout).state) const ProgressBar()
    ]);
  }
}
