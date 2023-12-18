import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:help_me_store/Widgets/font.dart';

class InputField<T> extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? hint;
  final Widget? widget;
  final List<T>? dropdownItems;
  final ValueChanged<T?>? onDropdownChanged;
  final ValueChanged<List<T>>? onMultiDropdownChanged;
  final String Function(T)? itemToString;
  final bool isDropdown;
  final bool isMultiSelect;
  final bool isReadOnly;
  final FormFieldValidator<T>? isvalidator;
  final FormFieldValidator<List<T>>? multiValidator;
  final bool isBooleanDropdown;
  final T? booleanDropdownValue;
  final ValueChanged<T?>? onBooleanDropdownChanged;

  const InputField({
    Key? key,
    required this.title,
    this.controller,
    this.hint,
    this.widget,
    this.dropdownItems,
    this.onDropdownChanged,
    this.onMultiDropdownChanged,
    this.itemToString,
    this.isDropdown = false,
    this.isMultiSelect = false,
    this.isReadOnly = false,
    this.isvalidator,
    this.multiValidator,
    this.isBooleanDropdown = false,
    this.booleanDropdownValue,
    this.onBooleanDropdownChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleTextStle,
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.only(left: 14.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: isBooleanDropdown
                      ? DropdownButtonFormField<T>(
                          isExpanded: true,
                          hint: Text(hint ?? 'Select $title'),
                          value: booleanDropdownValue,
                          items: [
                            DropdownMenuItem<T>(
                              value: true as T,
                              child: Text('Normal'),
                            ),
                            DropdownMenuItem<T>(
                              value: false as T,
                              child: Text('Faulty'),
                            ),
                          ],
                          onChanged: onBooleanDropdownChanged,
                          validator: isvalidator,
                        )
                      : isDropdown
                          ? isMultiSelect
                              ? MultiSelectDialogField<T>(
                                  items: dropdownItems?.map((T value) {
                                        return MultiSelectItem<T>(
                                            value,
                                            itemToString != null
                                                ? itemToString!(value)
                                                : value.toString());
                                      }).toList() ??
                                      [],
                                  title: Text('Select $title'),
                                  selectedColor: Theme.of(context).primaryColor,
                                  buttonIcon: Icon(
                                    Icons.arrow_drop_down,
                                  ),
                                  buttonText: Text(
                                    hint ?? 'Select $title',
                                  ),
                                  onConfirm: onMultiDropdownChanged!,
                                  validator: multiValidator,
                                )
                              : DropdownButtonFormField<T>(
                                  isExpanded: true,
                                  hint: Text(hint ?? 'Select $title'),
                                  value: dropdownItems
                                              ?.contains(controller?.text) ??
                                          false
                                      ? controller?.text as T
                                      : null,
                                  items: dropdownItems?.map((T value) {
                                    return DropdownMenuItem<T>(
                                      value: value,
                                      child: Text(itemToString != null
                                          ? itemToString!(value)
                                          : value.toString()),
                                    );
                                  }).toList(),
                                  onChanged: onDropdownChanged,
                                  validator: isvalidator,
                                )
                          : TextFormField(
                              controller: controller,
                              decoration: InputDecoration(
                                hintText: hint,
                                border: InputBorder.none,
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              validator:
                                  isvalidator as String? Function(String?)?,
                            ),
                ),
                if (widget != null) widget!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
