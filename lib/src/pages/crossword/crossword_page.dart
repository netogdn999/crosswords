import 'package:crosswords/core/constants/colors.dart';
import 'package:crosswords/core/data/level/model/position.dart';
import 'package:crosswords/core/extension/extension.dart';
import 'package:crosswords/src/pages/crossword/presenter/crossword_presenter.dart';
import 'package:crosswords/src/pages/crossword/presenter/crossword_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/blank_word.dart';
import 'widgets/empty_word.dart';
import 'widgets/message_dialog.dart';

class CrosswordPage extends StatefulWidget {
  final String title;
  final int id;
  const CrosswordPage({super.key, required this.title, required this.id});

  @override
  State<CrosswordPage> createState() => _CrosswordPageState();
}

class _CrosswordPageState extends State<CrosswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("${widget.title} ${widget.id}"),
        centerTitle: true,
        backgroundColor: AppColors.appBar.background,
        foregroundColor: AppColors.appBar.foreground,
      ),
      body: BlocConsumer<CrosswordPresenter, CrosswordViewModel>(
        listener: (_, viewModel) {
          final level = viewModel.level;
          if(viewModel.state == CrosswordState.success && level != null && level.rating == 3) {
            showDialog(
              context: context,
              builder: (_) {
                return MessageDialog(level: level);
              },
            );
          }
        },
        builder: (_, viewModel) {
          return Stack(children: [
            if(viewModel.state == CrosswordState.loading) ... [
              const Center(
                child: CircularProgressIndicator(),
              )
            ],
            Image.asset(
              'assets/background/crosswords_background.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
            ),
            Center(
              child: ListView.builder(
                itemCount: viewModel.height + 1,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final Map<Position, Widget> widgets = <Position, Widget>{};
            
                  for(int i=0; i<=viewModel.width; i++) {
                    final position = Position(i, index);
                    final char = viewModel.level?.words.getCharByPosition(position);
                    if(char != null) {
                      widgets[position] = Expanded(
                        child: BlankWord(position: Position(i, index), char: char),
                      );
                      continue;
                    }
          
                    widgets[position] = const Expanded(child: EmptyWord());
                  }
                  return Row(children: widgets.values.toList());
                },
              ),
            ),
          ]);
        },
      ),
    );
  }
}
