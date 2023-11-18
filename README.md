## Overview

The package make easier drag and drop of widgets list puted in stack

## Features



## Getting started



## Usage

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


