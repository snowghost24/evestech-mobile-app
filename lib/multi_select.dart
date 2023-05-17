import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Animal {
  final int? id;
  final String? name;

  Animal({
    this.id,
    this.name,
  });
}

class MultiSelectBottomSheetWidget extends StatefulWidget {
  final String? title;
  const MultiSelectBottomSheetWidget({super.key, this.title});

  @override
  State<MultiSelectBottomSheetWidget> createState() =>
      _MultiSelectBottomSheetWidgetState();
}

class _MultiSelectBottomSheetWidgetState
    extends State<MultiSelectBottomSheetWidget> {
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
    Animal(id: 11, name: "Cat"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "Rabbit"),
    Animal(id: 14, name: "Mouse"),
    Animal(id: 15, name: "Dog"),
    Animal(id: 16, name: "Zebra"),
    Animal(id: 17, name: "Cow"),
    Animal(id: 18, name: "Frog"),
    Animal(id: 19, name: "Blue Jay"),
    Animal(id: 20, name: "Moose"),
    Animal(id: 21, name: "Gecko"),
    Animal(id: 22, name: "Kangaroo"),
    Animal(id: 23, name: "Shark"),
    Animal(id: 24, name: "Crocodile"),
    Animal(id: 25, name: "Owl"),
    Animal(id: 26, name: "Dragonfly"),
    Animal(id: 27, name: "Dolphin"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name!))
      .toList();

  List<Animal> _selectedAnimals2 = [_animals[4]];

  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    // _selectedAnimals2 = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(_selectedAnimals);
    return MultiSelectBottomSheetField(
      key: _multiSelectKey,
      initialValue: _selectedAnimals2,
      initialChildSize: 0.4,
      onSaved: (values) {
        print('onsaved was clided');
        return;
      },
      onSelectionChanged: (values) {
        print('on selection changed');
        return;
      },
      listType: MultiSelectListType.LIST,
      searchable: true,
      searchHint: 'Search for user or group',
      // buttonText: const Text("Favorite Animals"),
      title: const Text("Select Recipients  and more",
          style: TextStyle(fontSize: 16)),
      items: _items,
      selectedColor: Theme.of(context).colorScheme.primary,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      buttonIcon: Icon(
        Icons.group,
        color: Theme.of(context).colorScheme.primary,
      ),
      // barrierColor: Theme.of(context).colorScheme.primary,
      buttonText: Text(
        "Select Recipients",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
        ),
      ),
      onConfirm: (values) {
        print('confirm ran');
        setState(() {
          _selectedAnimals2 = List<Animal>.from(values);
          // values.map((e) => e).toList() as List<Animal>;
        });
        // _selectedAnimals2 = values;
      },
      // onSelectionChanged: (){
      //   print('on selection hcage')
      //   return _selectedAnimals2
      // },
      chipDisplay: MultiSelectChipDisplay(
        onTap: (value) {
          setState(() {
            _selectedAnimals2.remove(value);
          });
        },
        chipColor: Theme.of(context).colorScheme.primary,
        textStyle: const TextStyle(
          color: Colors.white,
        ),
        icon: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
