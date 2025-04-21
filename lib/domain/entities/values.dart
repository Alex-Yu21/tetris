// grid dimensions
final int rowLength = 10;
final int colLength = 15;

enum Direction { left, right, down }

enum Tetromino {
  L,
  /*
  O
  O
  O O
  */
  G,
  /*
    O
    O
  O O
  */
  I,
  /*
  O
  O
  O 
  O
  */
  O,
  /*
  O O
  O O
  */
  S,
  /*
    O O
  O O
  */
  Z,
  /*
  O O
    O O
  */
  T,
  /*
  O
  O O 
  O
  */
}
