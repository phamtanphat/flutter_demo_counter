import 'package:flutter/material.dart';

class DemoInheritedWidget extends StatefulWidget {
  const DemoInheritedWidget({Key? key}) : super(key: key);

  @override
  State<DemoInheritedWidget> createState() => _DemoInheritedWidgetState();
}

class _DemoInheritedWidgetState extends State<DemoInheritedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo InheritedWidget"),
      ),
      body: Container(
        child: InheritedWrapper(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [DecreaseWidget(), IncreaseWidget(), ResetWidget()],
        )),
      ),
    );
  }
}

class InheritedWrapper extends StatefulWidget {
  Widget child;

  InheritedWrapper({required this.child});

  @override
  State<InheritedWrapper> createState() => _InheritedWrapperState();
}

class _InheritedWrapperState extends State<InheritedWrapper> {
  int count = 0;

  void inCrease() {
    setState(() {
      count += 1;
    });
  }

  void deCrease() {
    setState(() {
      count -= 1;
    });
  }

  void reset() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Wrapper build");
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Count : $count", style: TextStyle(fontSize: 30)),
          InheritedCounter(
            child: widget.child,
            count: count,
            deCrease: deCrease,
            inCrease: inCrease,
            reset: reset,
          )
        ],
      ),
    );
  }
}

class InheritedCounter extends InheritedWidget {
  int count;
  Widget child;
  Function inCrease;
  Function deCrease;
  Function reset;

  InheritedCounter(
      {required this.child,
      required this.count,
      required this.inCrease,
      required this.deCrease,
      required this.reset})
      : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedCounter oldWidget) {
    return false;
  }

  static InheritedCounter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}

class IncreaseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("IncreaseWidget build");
    return ElevatedButton(
        onPressed: () {
          InheritedCounter.of(context)?.inCrease();
        },
        child: Text("+"));
  }
}

class DecreaseWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("DecreaseWidget build");
    return ElevatedButton(onPressed: () {InheritedCounter.of(context)?.deCrease();}, child: Text("-"));
  }
}

class ResetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("ResetWidget build");
    return ElevatedButton(onPressed: () {InheritedCounter.of(context)?.reset();}, child: Text("Reset"));
  }
}
