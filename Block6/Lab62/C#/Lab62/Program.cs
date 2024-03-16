using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace Lab62
{
    internal class Program
    {
        internal const int BOARD_SIZE = 8;

        internal struct Position
        {
            internal int col, row;
        }

        internal static readonly Position[] MOVES = {
            new Position {col = -2, row = -1},
            new Position {col = -2, row = 1},
            new Position {col = -1, row = -2},
            new Position {col = -1, row = 2},
            new Position {col = 1, row = -2},
            new Position {col = 1, row = 2},
            new Position {col = 2, row = -1},
            new Position {col = 2, row = 1}
        };

        internal static int[,] board = new int[BOARD_SIZE, BOARD_SIZE];

        public enum ERRORS_CODE
        {
            CORRECT,
            INCORRECT_NUM
        }

        static readonly string[] ERRORS = new string[]
        {
            "",
            "Некорректное число!",
        };

        static void InitializeBoard()
        {
            for (int col = 0; col < BOARD_SIZE; col++)
                for (int row = 0; row < BOARD_SIZE; row++)
                    board[col, row] = 0; 
        }

        static bool isInsideBoard(int col, int row)
        {
            return col >= 0 && col < BOARD_SIZE && row >= 0 && row < BOARD_SIZE;
        }

        static bool isNotVisited(int col, int row)
        {
            return board[col, row] == 0;
        }

        static int CountAvailableMoves(int col, int row)
        {
            int nextCol, nextRow, count = 0;
            for (int moveIndex = 0; moveIndex < MOVES.Length; moveIndex++)
            {
                nextCol = col + MOVES[moveIndex].col;
                nextRow = row + MOVES[moveIndex].row;
                if (isInsideBoard(nextCol, nextRow) && isNotVisited(nextCol, nextRow))
                    count++;
            }
            return count;
        }

        static Position FindNextOptimalMove(int col, int row)
        {
            int nextCol, nextRow, minMoves = MOVES.Length + 1, minMovesIndex = -1;
            Position optimalMove;
            for (int moveIndex = 0; moveIndex < MOVES.Length; moveIndex++)
            {
                nextCol = col + MOVES[moveIndex].col;
                nextRow = row + MOVES[moveIndex].row;
                if (isInsideBoard(nextCol, nextRow) && isNotVisited(nextCol, nextRow))
                    if (CountAvailableMoves(nextCol, nextRow) < minMoves)
                    {
                        minMoves = CountAvailableMoves(nextCol, nextRow);
                        minMovesIndex = moveIndex;
                    }
            }

            nextCol = col + MOVES[minMovesIndex].col;
            nextRow = row + MOVES[minMovesIndex].row;
            optimalMove.col = nextCol;
            optimalMove.row = nextRow;

            return optimalMove;
        }

        static void PrintBoard()
        {
            Console.Clear();

            for (int i = 0; i < 41;  i++) 
                Console.Write("-");
            Console.WriteLine();
            for (int col = 0; col < BOARD_SIZE; col++)
            {
                for (int row = 0; row < BOARD_SIZE; row++)
                    if (board[row, col] == 0) Console.Write("|    ");
                    else Console.Write("| {0, 2} ", board[row, col]);
                Console.WriteLine("|");
                for (int i = 0; i < 41; i++)
                    Console.Write("-");
                Console.WriteLine();
            }

            Thread.Sleep(500);
        }

        static void KnightTour(int col, int row, int moveCount) 
        {
            Position nextPosition;
            int nextCol, nextRow;

            board[col, row] = moveCount;

            if (moveCount != BOARD_SIZE * BOARD_SIZE)
            {
                nextPosition = FindNextOptimalMove(col, row);
                nextCol = nextPosition.col;
                nextRow = nextPosition.row;

                PrintBoard();

                KnightTour(nextCol, nextRow, moveCount + 1);   
            }
            else
                PrintBoard();
        }


        static void PrintTask()
        {
            Console.WriteLine("Данная программа обходит конём все клетки шахматной доски 8x8.");
        }

        static int ReadNumWithinRange(int borderBottom, int borderTop, ERRORS_CODE patentialError)
        {
            ERRORS_CODE error;
            int option = 1;
            do
            {
                error = ERRORS_CODE.CORRECT;
                try
                {
                    option = int.Parse(Console.ReadLine());
                }
                catch
                {
                    error = patentialError;
                }
                if ((error == ERRORS_CODE.CORRECT) && ((option < borderBottom) || (option > borderTop)))
                    error = patentialError;
                if (error != ERRORS_CODE.CORRECT)
                {
                    Console.Error.WriteLine(ERRORS[(int)error]);
                    Console.Write("Попробуйте снова: ");
                }
            } while (error != ERRORS_CODE.CORRECT);
            return option;
        }

        static void Main(string[] args)
        {
            PrintTask();

            Console.Write("Введите колонку, в которой вы хотите разместить коня[1..8]: ");
            int currentCol = ReadNumWithinRange(1, 8, ERRORS_CODE.INCORRECT_NUM);
            Console.Write("Введите ряд, в который вы хотите разместить коня[1..8]: ");
            int currentRow = ReadNumWithinRange(1, 8, ERRORS_CODE.INCORRECT_NUM);

            InitializeBoard();
            KnightTour(currentCol - 1, currentRow - 1, 1);
            Console.ReadLine();
        }
    }
}
