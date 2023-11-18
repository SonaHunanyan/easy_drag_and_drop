## Overview

The package make easier drag and drop of widgets list puted in stack


![Screen Recording 2023-11-18 at 22 14 15](https://github.com/SonaHunanyan/easy_drag_and_drop/assets/62184420/cbe61064-ef6f-4da7-b73a-ff9147130f1d)



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

