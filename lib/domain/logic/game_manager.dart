import 'dart:math';
import 'package:tetris/domain/entities/piece.dart';
import 'package:tetris/domain/entities/values.dart';
import 'package:tetris/domain/logic/board_service.dart';
import 'package:tetris/domain/logic/game_loop.dart';
import 'package:tetris/domain/usecases/landing_usecase.dart';
import 'package:tetris/domain/usecases/rotate_piece_usecase.dart';

class GameManager {
  List<List<String?>> gameBoard = List.generate(
    colLength,
    (i) => List.generate(rowLength, (i) => null),
  );

  Piece currentPiece = Piece(type: Tetromino.O);
  Piece? nextPiece;
  int currentScore = 0;
  bool gameOver = false;
  bool isPaused = false;

  void Function()? onTick;
  void Function()? onGameOver;

  Map<String, Piece> allPieces = {};
  String currentPieceId = '';

  void _setCurrentPiece(Piece piece) {
    currentPiece = piece;
    currentPiece.initializePiece();
    currentPieceId = DateTime.now().millisecondsSinceEpoch.toString();
    allPieces[currentPieceId] = piece;
  }

  void _generateNextPiece() {
    nextPiece = _generateRandomPiece();
  }

  GameLoop? _loop;

  void reStartGame() {
    gameBoard = List.generate(
      colLength,
      (i) => List.generate(rowLength, (i) => null),
    );
    currentScore = 0;
    allPieces = {};
    gameOver = false;
    isPaused = false;

    _setCurrentPiece(_generateRandomPiece());
    _generateNextPiece();

    _loop ??= GameLoop(this);
    _loop!.start(const Duration(milliseconds: 800));
  }

  void startGame() {
    allPieces = {};
    _setCurrentPiece(_generateRandomPiece());
    _generateNextPiece();
    _loop = GameLoop(this);
    _loop!.start(const Duration(milliseconds: 800));
  }

  bool checkCollision(Direction direction) {
    return BoardService.checkCollision(
      board: gameBoard,
      piecePosition: currentPiece.position,
      direction: direction,
      rowLength: rowLength,
      colLength: colLength,
    );
  }

  bool isTopRowOccupied() {
    return BoardService.isTopRowOccupied(board: gameBoard);
  }

  void checkLanding() {
    LandingUseCase(
      board: gameBoard,
      rowLength: rowLength,
      colLength: colLength,
      createNewPiece: createNewPiece,
    ).execute(currentPiece, allPieces, currentPieceId);
  }

  void createNewPiece() {
    _setCurrentPiece(nextPiece!);
    _generateNextPiece();
    if (isTopRowOccupied()) {
      gameOver = true;
    }
  }

  Piece _generateRandomPiece() {
    final rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    return Piece(type: randomType);
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      currentPiece.movePiece(Direction.right);
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      currentPiece.movePiece(Direction.left);
    }
  }

  void rotatePiece() {
    RotatePieceUseCase(
      board: gameBoard,
      rowLength: rowLength,
    ).execute(currentPiece);
  }
}
