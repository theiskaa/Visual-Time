import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/utils/widgets.dart';

class SaveButton extends VTStatelessWidget {
  final String title;
  final Function onTap;

  SaveButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: FractionallySizedBox(
          widthFactor: .8,
          child: ElevatedButton(
            onPressed: () => onTap(),
            child: Text(
              title,
              style: BlocProvider.of<PreferenceCubit>(context)
                  .state
                  .theme!
                  .textTheme
                  .button,
            ),
          ),
        ),
      ),
    );
  }
}
