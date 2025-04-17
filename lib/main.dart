import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TicTacToeGamePage(),
    );
  }
}

class TicTacToeGamePage extends StatefulWidget {
  const TicTacToeGamePage({super.key});

  @override
  State<TicTacToeGamePage> createState() => _TicTacToeGamePageState();
}

class _TicTacToeGamePageState extends State<TicTacToeGamePage> {
  List<String> board = List.filled(9, "");
  String currentPlayer = "X";
  String winner = "";

  void _handleTap(int index) {
    if (board[index] != "" || winner != "") return;

    setState(() {
      board[index] = currentPlayer;
      if (_checkWinner()) {
        winner = "$currentPlayer wins!";
      } else if (!board.contains("")) {
        winner = "It's a draw!";
      } else {
        currentPlayer = currentPlayer == "X" ? "O" : "X";
      }
    });
  }

  bool _checkWinner() {
    const List<List<int>> winPatterns = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // columns
      [0, 4, 8], [2, 4, 6],            // diagonals
    ];

    for (var pattern in winPatterns) {
      String a = board[pattern[0]];
      String b = board[pattern[1]];
      String c = board[pattern[2]];
      if (a != "" && a == b && b == c) return true;
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      board = List.filled(9, "");
      currentPlayer = "X";
      winner = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            winner.isNotEmpty ? winner : "Current Player: $currentPlayer",
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          _buildBoard(),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: _resetGame,
              child: Text("Restart Game"),
          ),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return Container(
      padding: EdgeInsets.all(20),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 9,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _handleTap(index),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
              ),
              child: Center(
                child: Text(
                  board[index],
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
