void main(){
  checkWinner();
}

String? checkWinner() {
  List<String?> board = List.filled(9, null);

  List<List<int>> winningCombinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6] // Diagonals
  ];

  for (var combo in winningCombinations) {
    if (board[combo[0]] != null &&
        board[combo[0]] == board[combo[1]] &&
        board[combo[1]] == board[combo[2]]) {
          print(combo[0]);
          print(combo);
      return board[combo[0]];
    }
  }

  if (board.every((element) => element != null)) return 'Draw';
  return null;
}
