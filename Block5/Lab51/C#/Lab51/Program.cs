using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Runtime.Remoting.Messaging;

namespace Lab51
{
    public class Node<T>
    {
        public T Data { get; set; }

        public Node<T> Next { get; set; }
    }

    public class LinkedList<T>
    {
        private Node<T> head = new Node<T>()
        {
            Data = default(T),
            Next = null
        };
        int count = 1;

        public void Add(T data)
        {
            Node<T> newNode = new Node<T>()
            {
                Data = data,
                Next = null
            };

            Node<T> current = head;
            while (current.Next != null)
                current = current.Next;
            current.Next = newNode;
            count++;
        }

        public void Remove(int number)
        {
            Node<T> current = head;
            for (int i = 1; i < number; i++) 
                current = current.Next;
            current.Next = current.Next.Next;
            count--;
        }

        public void Reverse()
        {
            Node<T> current = head.Next, previos = null, follow;
            while (current != null)
            {
                follow = current.Next;
                current.Next = previos;
                previos = current;
                current = follow;
            }
            head.Next = previos;
        }

        public int Count()
        {
            return count;
        }

        public void Clear()
        {
            head = null;
            count = 0;
        }

        public T Meaning(int number)
        {
            Node<T> current = head;
            for (int i = 1; i <= number; i++)
                current = current.Next;
            return current.Data;
        }

        public void WriteLinkedList(StreamWriter writer)
        {
            Node<T> current = head;
            while (current != null)
            {
                writer.WriteLine(current.Data);
                current = current.Next;
            }               
        }
    }


    internal class Program
    {
        public enum ERRORS_CODE
        {
            CORRECT,
            INCORRECT_CHOICE,
            INCORRECT_LASTNAME,
            IS_NOT_TXT,
            IS_NOT_EXIST,
            IS_NOT_READABLE,
            IS_NOT_WRITEABLE,
            EXTRA_DATA
        }
        
        static readonly string[] ERRORS = new string[]
        {
            "",
            "Некорректный выбор!",
            "Некорректная фамилия!",
            "Файл не .txt!",
            "Файл не существует!",
            "Файл не доступен для чтения!",
            "Файл не доступен для записи",
            "Лишние данные!",
        };


        public enum Actions
        {
            Add = 1,
            Delete,
            Reverse,
            Open,
            Save, 
            Exit,
        }


        const int MAX_LASTNAME_LENGTH = 20,
                  MIN_LASTNAME_LENGTH = 1,
                  MAX_LASTNAMES = 99;
        static void WriteTask()
        {
            Console.WriteLine("Выберите одно из следующих действий:");
            Console.WriteLine("Добавить фамилию   - 1");
            Console.WriteLine("Удалить фамилию    - 2");
            Console.WriteLine("Перевернуть список - 3");
            Console.WriteLine("Открыть файл       - 4");
            Console.WriteLine("Сохранить файл     - 5");
            Console.WriteLine("Выйти              - 6");
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


        static int ChooseOptionWithinRange(int borderBottom, int borderTop)
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
                    error = ERRORS_CODE.INCORRECT_CHOICE;
                }
                if ((error == ERRORS_CODE.CORRECT) && ((option < borderBottom) || (option > borderTop)))
                    error = ERRORS_CODE.INCORRECT_CHOICE;
                if (error != ERRORS_CODE.CORRECT)
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT);
            return option;
        }

        
        static void WriteTable(LinkedList<string> numberList)
        {
            for (int j = 1; j < 30; j++) Console.Write("-");
            Console.WriteLine("\r\n| {0, 2} | {1, 20} |", "#", "Фамилия");
            for (int i = 1; i < numberList.Count(); i++)
            {
                for (int j = 1; j < 30; j++) Console.Write("-");
                Console.WriteLine("\r\n| {0, 2} | {1, 20} |", i, numberList.Meaning(i));
            }
            for (int j = 1; j < 30; j++) Console.Write("-");
            Console.WriteLine();
        }


        static void AddLastName(LinkedList<string> numberList, ref bool isSaved)
        {
            ERRORS_CODE error;
            string temp;
            if (numberList.Count() <= MAX_LASTNAMES)
            {
                Console.Write($"Введите фамилию (макс {MAX_LASTNAME_LENGTH} символов): ");
                do
                {
                    error = ERRORS_CODE.CORRECT;
                    temp = Console.ReadLine();
                    if (temp.Length < MIN_LASTNAME_LENGTH || temp.Length > MAX_LASTNAME_LENGTH)
                        error = ERRORS_CODE.INCORRECT_LASTNAME;
                    if (error != ERRORS_CODE.CORRECT)
                        WriteError(error);
                } while (error != ERRORS_CODE.CORRECT);
                numberList.Add(temp);
                isSaved = false;
            }
            else
                Console.WriteLine("Слишком большой список!");
        }

        static void DeleteLastName(LinkedList<string> numberList, ref bool isSaved)
        {
            if (numberList.Count() > 1)
            {
                Console.Write("Введите номер фамилии в списке: ");
                numberList.Remove(ChooseOptionWithinRange(1, numberList.Count() - 1));
                if (numberList.Count() > 1)
                    isSaved = false;
            }
            else
                Console.WriteLine("Вы ещё не добавили фамилий!");
        }

        static void ReverseLastNames(LinkedList<string> numberList, ref bool isSaved)
        {
            if (numberList.Count() > 1)
            {
                numberList.Reverse();
                isSaved = false;
            }
            else
                Console.WriteLine("Вы ещё не добавили фамилий!");
        }

        static ERRORS_CODE IsReadable(string filePath)
        {
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            try
            {
                using (StreamReader reader = new StreamReader(filePath)) { }
            }
            catch
            {
                error = ERRORS_CODE.IS_NOT_READABLE;
            }
            return error;
        }

        static ERRORS_CODE IsWriteable(string filePath)
        {
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            try
            {
                using (StreamWriter writer = new StreamWriter(filePath)) { }
            }
            catch
            {
                error = ERRORS_CODE.IS_NOT_WRITEABLE;
            }
            return error;
        }

        static string ReadIOFilePath(char ioMode)
        {
            ERRORS_CODE error;
            string filePath;
            do
            {
                error = ERRORS_CODE.CORRECT;
                Console.Write("Введите путь к файлу: ");
                filePath = Console.ReadLine();

                if (Path.GetExtension(filePath) != ".txt")
                    error = ERRORS_CODE.IS_NOT_TXT;
                if (error == ERRORS_CODE.CORRECT && !File.Exists(filePath) && ioMode == 'i')
                    error = ERRORS_CODE.IS_NOT_EXIST;
                if (error == ERRORS_CODE.CORRECT)
                    switch (ioMode)
                    {
                        case 'i':
                            error = IsReadable(filePath);
                            break;
                        case 'o':
                            error = IsWriteable(filePath);
                            break;
                    }
                if (error != ERRORS_CODE.CORRECT)
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT);
            return filePath;
        }

        static void ReadFile(LinkedList<string> numberList)
        {
            string filePath = ReadIOFilePath('i');
            StreamReader reader = new StreamReader(filePath);
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            string temp;
            using (reader)
            {
                do
                {
                    temp = reader.ReadLine();
                    if (temp.Length < MIN_LASTNAME_LENGTH || temp.Length > MAX_LASTNAME_LENGTH)
                        error = ERRORS_CODE.INCORRECT_LASTNAME;
                    if (error == ERRORS_CODE.CORRECT && numberList.Count() > MAX_LASTNAMES)
                        error = ERRORS_CODE.EXTRA_DATA;
                    if (error == ERRORS_CODE.CORRECT)
                        numberList.Add(temp);
                    else
                        WriteError(error);
                } while (error != ERRORS_CODE.CORRECT || !reader.EndOfStream);
            }
            if (error != ERRORS_CODE.CORRECT)
                numberList.Clear();
        }

        static void WriteFile(LinkedList<string> numberList, ref bool isSaved)
        {
            string filePath = ReadIOFilePath('o');
            StreamWriter writer = new StreamWriter(filePath);
            if (numberList.Count() > 1)
            {
                using (writer)
                {
                    for (int i = 1; i < numberList.Count(); i++)
                    {
                        writer.WriteLine(numberList.Meaning(i));
                    }
                }
                isSaved = true;
            }
            else
                Console.WriteLine("Вы ещё не добавили фамилий!");
        }

        static void Exit(LinkedList<string> numberList, bool isSaved)
        {
            if (!isSaved)
            {
                Console.Write("Вы не сохранили файл, хотите ли сохранить перед выходом?\r\n" +
                              "да  - 1\r\n" +
                              "нет - 2\r\n" +
                              "Ваш выбор: ");
                if (ChooseOptionWithinRange(1, 2) == 1)
                    WriteFile(numberList, ref isSaved);
            }
        }


        static void Main(string[] args)
        {
            LinkedList<string> numberList = new LinkedList<string>();
            Actions action;
            bool isSaved = true;
            do
            {
                WriteTable(numberList);
                WriteTask();
                action = (Actions)ChooseOptionWithinRange(1, Enum.GetValues(typeof(Actions)).Length);
                switch (action)
                {
                    case Actions.Add:
                        AddLastName(numberList, ref isSaved);
                        break;
                    case Actions.Delete:
                        DeleteLastName(numberList, ref isSaved);
                        break;
                    case Actions.Reverse:
                        ReverseLastNames(numberList, ref isSaved);
                        break;
                    case Actions.Open:
                        ReadFile(numberList);
                        break;
                    case Actions.Save:
                        WriteFile(numberList, ref isSaved);
                        break;
                    case Actions.Exit:
                        Exit(numberList, isSaved);
                        break;
                }
                if (action != Actions.Exit)
                    WriteContinue();
            } while (action != Actions.Exit);
        }
    }
}
