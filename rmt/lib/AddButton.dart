import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressedTime;
  final VoidCallback onPressedLocation;
  const AddButton(
      {super.key,
      required this.onPressedTime,
      required this.onPressedLocation});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () => showPopover(
        context: context,
        bodyBuilder: (context) => Column(
          children: [
            GestureDetector(
              onTap: onPressedTime,
              child: Container(
                height: 50,
                color: Colors.white,
                child: const Center(child: Text("Time")),
              ),
            ),
            const Divider(),
            GestureDetector(
              onTap: onPressedLocation,
              child: Container(
                height: 50,
                color: Colors.white,
                child: const Center(child: Text("Location")),
              ),
            ),
          ],
        ),
        width: 200,
        height: 116,
        radius: 20,
        direction: PopoverDirection.top,
      ),
      constraints: const BoxConstraints(minWidth: 50, minHeight: 50),
      fillColor: const Color(0xFF956DEB),
      shape: CircleBorder(side: BorderSide(color: Colors.white,width: 1.0,),),
      child: const Icon(Icons.add,color: Colors.white, size:34)
    );
  }
}
