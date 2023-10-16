import 'package:crosswords/core/constants/colors.dart';
import 'package:crosswords/core/data/level/model/position.dart';
import 'package:crosswords/core/data/level/model/word.dart';
import 'package:crosswords/src/pages/crossword/presenter/crossword_presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlankWord extends StatefulWidget {
  final Position position;
  final Char char;

  const BlankWord({
    super.key,
    required this.position,
    required this.char,
  });

  @override
  State<BlankWord> createState() => _BlankWordState();
}

class _BlankWordState extends State<BlankWord> {
  late final TextEditingController _controller;
  late Color borderColor;
  late final CrosswordPresenter presenter;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.char.isVisible ? widget.char.value.toUpperCase() : "");
    borderColor = AppColors.crossword.border;
    presenter = context.read<CrosswordPresenter>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.crossword.backgroundBlank,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: Center(
        child: TextField(
          controller: _controller,
          enabled: !widget.char.isVisible,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.all(0)
          ),
          onChanged: (value) async {
            if(value.isEmpty) {
              setState(() {
                borderColor = AppColors.crossword.border;
              });
              return;
            }
            if(value != widget.char.value.toUpperCase()) {
              setState(() {
                borderColor = AppColors.crossword.wrong;
              });
              return;
            }
            setState(() {
              borderColor = AppColors.crossword.border;
            });
            await presenter.updateLevel(widget.char.copyWith(isVisible: value == widget.char.value.toUpperCase()));
            await presenter.increasePontuation();
          },
        ),
      ),
    );
  }
}