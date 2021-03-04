class B {
  fun() => print('B');
}

mixin A1 on B {
  fun() {
    print('A1');
    super.fun();
  }
}
mixin A2 on B {
  fun() {
    print('A2');
    super.fun();
  }
}

class C extends B with A1, A2 {
  fun() {
    print('C');
  }
}