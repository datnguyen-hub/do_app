import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class PickerColorButton extends StatelessWidget {
  final Color? currentColor;
  final Function? onChange;

  const PickerColorButton({
    Key? key,
    this.currentColor,
    this.onChange,
  }) : super(key: key);

  //PickerColorButton({this.currentColor, this.onChange});

  // changeColor(Color color) => setState(() => currentColor = color);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0.0),
              contentPadding: const EdgeInsets.all(0.0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: currentColor!,
                  onColorChanged: onChange as void Function(Color),
                  colorPickerWidth: 300.0,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: false,
                  displayThumbColor: false,
                  showLabel: false,
                  portraitOnly: false,
                  paletteType: PaletteType.hsv,
                  pickerAreaBorderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(2.0),
                    topRight: const Radius.circular(2.0),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentColor
        ),
        child:  Text(
          'Chọn màu',
          style: TextStyle(
            color: currentColor!.computeLuminance() <
                0.5
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
