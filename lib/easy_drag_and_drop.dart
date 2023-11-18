library easy_drag_and_drop;

import 'package:flutter/material.dart';

class EasyDragAndDrop extends StatefulWidget {
  const EasyDragAndDrop({
    required this.items,
    required this.height,
    required this.width,
    this.initialPositions,
    this.onDragUpdate,
    this.onDragCompleted,
    this.onDragEnd,
    this.onDragStarted,
    this.onDraggableCanceled,
    super.key,
  });
  final List<Widget> items;

  /// Width of draggable area
  final double width;

  /// Height of draggable area
  final double height;

  /// Initial offsets of draggable items
  final List<Offset>? initialPositions;
  final void Function(int index, DragUpdateDetails details)? onDragUpdate;
  final void Function(int index)? onDragCompleted;
  final void Function(int index, DraggableDetails details)? onDragEnd;
  final void Function(int index)? onDragStarted;
  final void Function(int index, Velocity velocity, Offset offset)?
      onDraggableCanceled;

  @override
  State<EasyDragAndDrop> createState() => _EasyDragAndDropState();
}

class _EasyDragAndDropState extends State<EasyDragAndDrop> {
  List<Widget> get _items => widget.items;
  List<Offset> _positions = [];

  final _key = GlobalKey();

  @override
  void initState() {
    final initialPositions = widget.initialPositions;
    assert(
        initialPositions == null || initialPositions.length == _items.length);
    if (initialPositions != null) {
      _positions = [...initialPositions];
    } else {
      _positions = List.filled(_items.length, Offset.zero);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: _key,
      width: widget.width,
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var i = 0; i < _items.length; i++)
            Transform.translate(
              offset: _positions[i],
              child: Draggable<Widget>(
                childWhenDragging: Container(),
                feedback: _items[i],
                onDragCompleted: () => widget.onDragCompleted?.call(i),
                onDragEnd: (details) => widget.onDragEnd?.call(i, details),
                onDragUpdate: (details) => _onDragUpdate(details, i),
                onDragStarted: () => widget.onDragStarted?.call(i),
                onDraggableCanceled: (velocity, offset) =>
                    widget.onDraggableCanceled?.call(i, velocity, offset),
                child: _items[i],
              ),
            ),
        ],
      ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details, int i) {
    final newPos = details.localPosition.real(
      widget.width,
      widget.height,
      _key.getPosition(),
    );
    if (newPos == null) {
      return;
    }
    widget.onDragUpdate?.call(i, details);
    setState(
      () {
        _positions[i] = newPos;
      },
    );
  }
}

extension _OffsetAddition on Offset {
  Offset? real(final double width, final double height, Offset pos) {
    final newPosY = dy - pos.dy - height / 2;
    final newPosX = dx - pos.dx - width / 2;

    final maxX = width / 2;
    final minX = -width / 2;
    final maxY = height / 2;
    final minY = -height / 2;
    final isOutOfX = newPosX < minX || newPosX > maxX;
    final isOutOfY = newPosY < minY || newPosY > maxY;
    if (isOutOfX || isOutOfY) {
      return null;
    }
    return Offset(
      newPosX,
      newPosY,
    );
  }
}

extension _GlobalKeyAddition on GlobalKey {
  Offset getPosition() {
    RenderBox box = currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    return position;
  }
}
