import 'package:bandapp/appstyle/app_colors.dart';
import 'package:bandapp/utility/custom_UI.dart';
import 'package:flutter/material.dart';


class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    this.size = 20,
    this.onPressed,
    required this.selected,
    this.isGradient = true,
    this.color = Colors.white,
  }) : super(key: key);

  final double size;
  final VoidCallback? onPressed;
  final bool selected;
  final bool isGradient;
  final Color color;
  @override
  Widget build(BuildContext context) {
    var icon = Icon(
      Icons.check_box_outlined,
      size: size,
      color: color,
    );
    var icon2 = Icon(
      Icons.check_box_outline_blank_rounded,
      size: size,
      color: color,
    );
    return GestureDetector(
      onTap: onPressed,
      child:LinearGradientMask(
              primary:AppColors. checkBoxBorderColor,
              secondary:AppColors. checkBoxBorderColor,
              child: selected ? icon : icon2,
            )
          
    );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({super.key, 
    required Widget title,
    required FormFieldSetter<bool> onSaved,
    required FormFieldValidator<bool> validator,
    bool initialValue = false,
    bool autovalidate = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          builder: (state) {
            return CheckboxListTile(
              dense: state.hasError,
              title: title,
              value: state.value,
              onChanged: state.didChange,
              subtitle: state.hasError
                  ? Builder(
                      builder: (context) => Text(
                        state.errorText ?? "",
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  : null,
              controlAffinity: ListTileControlAffinity.leading,
            );
          },
        );
}
