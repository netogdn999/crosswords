import 'package:crosswords/core/constants/colors.dart';
import 'package:crosswords/core/constants/sizes.dart';
import 'package:crosswords/core/constants/strings.dart';
import 'package:crosswords/core/navigation/base_routes.dart';
import 'package:crosswords/core/navigation/navigation_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presenter/level_presenter.dart';
import 'presenter/level_view_model.dart';
import 'widgets/level_card.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  @override
  void didPopNext() {
    super.didPopNext();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LevelPresenter>().loadLevels();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationAction.of(context).subscribe(this, ModalRoute.of(context)!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: AppColors.appBar.background,
        foregroundColor: AppColors.appBar.foreground,
      ),
      body: Stack(children: [
        Image.asset(
          'assets/background/levels_background.jpg',
          fit: BoxFit.cover,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
        ),
        BlocConsumer<LevelPresenter, LevelViewModel>(
          listener: (context, viewModel) {
            if(viewModel.state == LevelStates.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(viewModel.failure!.message))
              );
            }
            
            if(viewModel.state == LevelStates.emptyLevels) {
              context.read<LevelPresenter>().generateLevels();
            }
      
            if(viewModel.state == LevelStates.generated) {
              context.read<LevelPresenter>().loadLevels();
            }
          },
          builder: (_, viewModel) {
            return Column(
              children: [
                ListView.builder(
                  itemCount: (viewModel.levels.length / 5).ceil(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    final rowLevel = (index)*5;
                    final widgets = <Widget>[];
                    for (int i=rowLevel; i < rowLevel + 5 && i <= viewModel.levels.length; i++) {
                      widgets.add(Expanded(
                        child: LevelCard(
                          level: viewModel.levels[i],
                          onClick: () {
                            NavigationAction.of(context).navigate(BaseRoutes.crossword, params: {
                              'id': viewModel.levels[i].id,
                            });
                          },
                        ),
                      ));
                    }
                    return Row(
                      children: widgets,
                    );
                  },
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: AppSizes.button.verticalResetButton,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<LevelPresenter>()
                        ..deleteAllLevels()
                        ..loadLevels();
                    },
                    child: Text(AppStrings.button.resetButton),
                  ),
                ),
              ],
            );
          },
        ),
      ]),
    );
  }
}
