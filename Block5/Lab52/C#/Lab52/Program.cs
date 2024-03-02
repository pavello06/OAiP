using System;
using System.Security.Policy;

namespace Lab52
{
    internal class Node<Int32>
    {
        public int Data { get; set; }
        public Node<Int32> Left { get; set; }
        public Node<Int32> Right { get; set; }
    }
    internal class BinaarySearchTree<Int32>
    {
        private Node<Int32> rootNode = new Node<Int32>()
        {
            Data = 0,
            Left = null,
            Right = null,
        };

        internal const int MAX_DEPTH = 7;
        private int depth = 0;
        private int[] singleParentLevels = new int[MAX_DEPTH];

        private void PrintTree(Node<Int32> currentNode, string indent = "", char side = ' ')
        {
            if (currentNode != null)
            {
                char nodeSide = side == ' ' ? '+' : side == 'L' ? 'L' : 'R';
                Console.WriteLine($"{indent} [{nodeSide}]- {currentNode.Data}");
                indent += new string(' ', 3);
                PrintTree(currentNode.Left, indent, 'L');
                PrintTree(currentNode.Right, indent, 'R');
            }
        }

        private int FindDepth(Node<Int32> currentNode)
        {
            int leftDepth, rightDepth;
            if (currentNode == null)
                return 0;
            else
            {
                leftDepth = FindDepth(currentNode.Left);
                rightDepth = FindDepth(currentNode.Right);
                if (leftDepth > rightDepth)
                    return leftDepth + 1;
                else
                    return rightDepth + 1;
            }
        }

        private Node<Int32> FindNode(Node<Int32> currentNode, int data)
        {
            if (currentNode == null || currentNode.Data == data)
                return currentNode;
            else if (data < currentNode.Data)
                return FindNode(currentNode.Left, data);
            else
                return FindNode(currentNode.Right, data);
        }
        private Node<Int32> Find(int data)
        {
            return FindNode(rootNode, data);
        }

        private int FindMinNode(Node<Int32> currentNode)
        {
            if (currentNode.Left == null)
                return currentNode.Data;
            else
                return FindMinNode(currentNode.Left);
        }
        private Node<Int32> RemoveNode(Node<Int32> currentNode, int data)
        {
            if (currentNode != null)
            {
                if (data < currentNode.Data)
                    currentNode.Left = RemoveNode(currentNode.Left, data);
                else if (data > currentNode.Data)
                    currentNode.Right = RemoveNode(currentNode.Right, data);
                else if (currentNode.Left != null && currentNode.Right != null)
                {
                    currentNode.Data = FindMinNode(currentNode.Right);
                    currentNode.Right = RemoveNode(currentNode.Right, currentNode.Data);
                }
                else
                {
                    if (currentNode.Left != null)
                        currentNode = currentNode.Left;
                    else if (currentNode.Right != null)
                        currentNode = currentNode.Right;
                    else
                        currentNode = null;
                }
            }
            return currentNode;
        }
        internal void Remove(int data)
        {
            if (Find(data) == null)
                Console.WriteLine("Узел не существует!");
            else
            {
                rootNode = RemoveNode(rootNode, data);
                PrintTree(rootNode, "", ' ');
                depth = FindDepth(rootNode);
            }               
        }

        private Node<Int32> InsertNode(Node<Int32> currentNode, int data)
        {
            if (currentNode == null || currentNode.Data == 0)
            {
                Node<Int32> newNode = new Node<Int32>()
                {
                    Data = data,
                    Left = null,
                    Right = null,
                };
                return newNode;
            }
            else if (data < currentNode.Data)
                currentNode.Left = InsertNode(currentNode.Left, data);
            else
                currentNode.Right = InsertNode(currentNode.Right, data);
            return currentNode;
        }
        internal void Insert(int data)
        {
            if (Find(data) != null)
                Console.WriteLine("Узел уже существует!");
            else
            {
                rootNode = InsertNode(rootNode, data);
                if (FindDepth(rootNode) > MAX_DEPTH)
                {
                    Console.WriteLine("Слишком большая глубина!");
                    Remove(data);
                }
                else
                    PrintTree(rootNode, "", ' ');
                depth = FindDepth(rootNode);
            }            
        }

        private void FindSingleParentLevels(Node<Int32> currentNode, int level)
        {
            if (currentNode != null)
            {
                FindSingleParentLevels(currentNode.Left, level + 1);
                FindSingleParentLevels(currentNode.Right, level + 1);
                if (currentNode.Left != null || currentNode.Right != null)
                    singleParentLevels[level]++;
            }           
        }
        internal void WriteSingleParentLevels()
        {
            for (int level = 0; level < singleParentLevels.Length; level++)
                singleParentLevels[level] = 0;
            FindSingleParentLevels(rootNode, 0);
            Console.Write("Уровни: ");
            for (int level = 0; level < singleParentLevels.Length; level++)
                if (singleParentLevels[level] == 1)
                    Console.Write($"{level + 1}; ");
        }
    }
    internal class Program
    {
        public enum ERRORS_CODE
        {
            CORRECT,
            INCORRECT_CHOICE,
            INCORRECT_NUM
        }
        static readonly string[] ERRORS = new string[]
        {
            "",
            "Некорректный выбор!",
            "Некорректные данные!",
        };
        public enum Actions
        {
            Insert = 1,
            Remove,
            Calc,
            Exit,
        }
        const int MIN_NUM = 1,
                  MAX_NUM = 999;
        static void WriteTask()
        {
            Console.WriteLine("Выберите одно из следующих действий:");
            Console.WriteLine("1 - Вставить узел");
            Console.WriteLine("2 - Удалить узел");
            Console.WriteLine("3 - Подсчитать уровни, на которых имеются листья только у одного потомка.");
            Console.WriteLine("4 - Выйти");
            Console.Write("Ваш выбор: ");
        }
        static void WriteContinue()
        {
            Console.Write("Нажмите любую клавишу для продолжения: ");
            Console.ReadKey();
            Console.WriteLine();
        }
        static void WriteError(ERRORS_CODE error)
        {
            Console.Error.WriteLine(ERRORS[(int)error]);
            Console.Write("Попробуйте снова: ");
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
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT);
            return option;
        }
        static void Main(string[] args)
        {
            BinaarySearchTree<Int32> tree = new BinaarySearchTree<Int32>();
            Actions action;
            int data = 0;
            do
            {
                WriteTask();
                action = (Actions)ReadNumWithinRange(1, Enum.GetValues(typeof(Actions)).Length, ERRORS_CODE.INCORRECT_CHOICE);
                switch (action)
                {
                    case Actions.Insert:
                        Console.Write("Введите значение узла: ");
                        data = ReadNumWithinRange(1, 999, ERRORS_CODE.INCORRECT_NUM);
                        tree.Insert(data);
                        break;
                    case Actions.Remove:
                        Console.Write("Введите значение удаляемого узла: ");
                        data = ReadNumWithinRange(1, 999, ERRORS_CODE.INCORRECT_NUM);
                        tree.Remove(data);
                        break;
                    case Actions.Calc:
                        tree.WriteSingleParentLevels();
                        break;
                    case Actions.Exit:
                        break;
                }
                if (action != Actions.Exit)
                    WriteContinue();
            } while (action != Actions.Exit);
        }
    }
}