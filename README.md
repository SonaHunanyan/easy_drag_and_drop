## Overview

The package make easier drag and drop of widgets list puted in stack



https://github.com/SonaHunanyan/easy_drag_and_drop/assets/62184420/7e96c64c-b608-41bc-a415-196be9abbc3b





## Usage
```
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: EasyDragAndDrop(
          initialPositions: [
            Offset(-100, 0),
            Offset(0, -100),
          ],
          width: 300,
          height: 300,
          items: [
            FlutterLogo(),
            FlutterLogo(),
          ],
        ),
      ),
    );
  }
```

