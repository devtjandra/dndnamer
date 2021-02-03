import 'package:dndnamer/app/game_creator/view/game_creator.dart';
import 'package:dndnamer/app/game_list/logic/game_list_view_model.dart';
import 'package:dndnamer/app/game_details/view/game_details.dart';
import 'package:dndnamer/app/game_list/view/game_item.dart';
import 'package:dndnamer/values/values.dart';
import 'package:dndnamer/widgets/custom_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

final gameListViewModel =
    StateNotifierProvider<GameListViewModel>((ref) => GameListViewModel(ref));
final isWaitingGameRefresh = StateProvider<bool>((ref) => false);
final isWaitingGameDelete = StateProvider<String>((ref) => null);

class GameList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final games = watch(gameListViewModel.state);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read(gameCreatorTitleTextController).text = "";
            context.read(gameCreatorDescriptionTextController).text = "";
            context.read(editGameUuid).state = null;
            Navigator.of(context).pushNamed(Routes.gameCreator);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Stack(
          children: [
            background(),
            ListView.builder(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, bottom: 24.0, top: 4.0),
                itemBuilder: (context, index) => GameItem(
                      game: games[index],
                      onTap: () {
                        context
                            .read(gameDetailsViewModel)
                            .getGame(games[index].uuid);
                        Navigator.of(context).pushNamed(Routes.gameDetails);
                      },
                      onEdit: () {
                        context.read(gameCreatorTitleTextController).text =
                            games[index].title;
                        context
                            .read(gameCreatorDescriptionTextController)
                            .text = games[index].description;
                        context.read(editGameUuid).state = games[index].uuid;
                        Navigator.of(context).pushNamed(Routes.gameCreator);
                      },
                      onDelete: () => context
                          .read(gameListViewModel)
                          .deleteGame(games[index].uuid),
                    ),
                itemCount: games.length)
          ],
        ));
  }
}
