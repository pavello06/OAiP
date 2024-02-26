using System;
using System.IO;

namespace Lab42
{
    class Program
    {
        public enum ERRORS_CODE
        {
            CORRECT,
            INCORRECT_CHOICE,
            INCORRECT_NUM,
            INCORRECT_RANGE,
            IS_NOT_DIFFERENT,
            IS_NOT_TXT,
            IS_NOT_EXIST,
            IS_NOT_READABLE,
            IS_NOT_WRITEABLE,
            INCORRECT_NUMS_AMOUNT,
            EXTRA_DATA
        }

        static readonly string[] ERRORS = new string[] 
        {
            "",
            "Некорректный выбор!",
            "Некорректное число!",
            "Значение не попадает в диапазон!",
            "Значения не различны!",
            "Расширение файла не .txt!",
            "Некорректный путь к файлу!",
            "Файл закрыт для чтения!",
            "Файл закрыт для записи!",
            "Неправильное количество чисел в файле!",
            "Лишние данные в файле!"
        };


        const int MIN_NUM_AMOUNT = 1,
                  MAX_NUM_AMOUNT = 10,
                  MIN_NUM = 1,
                  MAX_NUM = 10000;


        static void WriteTask()
        {
            Console.WriteLine("Данная программа делает всевозможные перестановки различных натуральных чисел.");
        }


        static void WriteError(ERRORS_CODE error)
        {
            Console.Error.WriteLine(ERRORS[(int)error]);
        }


        static int ChooseOption(int amount)
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
                if ((error == ERRORS_CODE.CORRECT) && ((option < 1) || (option > amount)))
                    error = ERRORS_CODE.INCORRECT_CHOICE;
                if (error != ERRORS_CODE.CORRECT)
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT);
            return option;
        }


        static ERRORS_CODE IsValidRange(int num, in int MIN, in int MAX)
        {
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            if ((num < MIN) || (num > MAX))
                error = ERRORS_CODE.INCORRECT_RANGE;
            return error;
        }
        static ERRORS_CODE AreNumsDifferent(int[] numsArr, int lastIndex)
        {
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            for (int i = 0; i < lastIndex; i++)
                if (numsArr[i] == numsArr[lastIndex])
                    error = ERRORS_CODE.IS_NOT_DIFFERENT;
            return error;
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
        static StreamReader ReadPathToReadingFile()
        {
            ERRORS_CODE error;
            string filePath;
            do
            {
                error = ERRORS_CODE.CORRECT;
                filePath = Console.ReadLine();
                if (Path.GetExtension(filePath) != ".txt")
                    error = ERRORS_CODE.IS_NOT_TXT;
                if (error == ERRORS_CODE.CORRECT && !File.Exists(filePath))
                    error = ERRORS_CODE.IS_NOT_EXIST;
                if (error == ERRORS_CODE.CORRECT)
                    error = IsReadable(filePath);
                if (error != ERRORS_CODE.CORRECT)
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT); 
            return new StreamReader(filePath);
        }
        static ERRORS_CODE ReadFileNum(StreamReader reader, out int num, in int MIN, in int MAX)
        {
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            string snum = "";
            char ch;
            while (reader.Peek() != -1 && reader.Peek() != '\r' && reader.Peek() != ' ')
            {
                ch = Convert.ToChar(reader.Read());
                snum = snum + ch;
            }
            if (reader.Peek() == ' ')
                Convert.ToChar(reader.Read());
            num = 1;
            try
            {
                num = Int32.Parse(snum);
            }
            catch
            {
                error = ERRORS_CODE.INCORRECT_NUM;
            }
            if (error == ERRORS_CODE.CORRECT)
                error = IsValidRange(num, MIN, MAX);
            return error;
        }
        static ERRORS_CODE ReadFileNumsAmount(StreamReader reader, out int numsAmount)
        {
            ERRORS_CODE error;
            error = ReadFileNum(reader, out numsAmount, MIN_NUM_AMOUNT, MAX_NUM_AMOUNT);
            if ((error == ERRORS_CODE.CORRECT) && reader.Peek() != '\r')
                error = ERRORS_CODE.EXTRA_DATA;
            return error;
        }
        static ERRORS_CODE ReadFileNums(StreamReader reader, ref int[] numsArr, int numsAmount)
        {
            ERRORS_CODE error;
            error = ERRORS_CODE.CORRECT;
            numsArr = new int[numsAmount];
            int i = 0;
            while ((error == ERRORS_CODE.CORRECT) && (reader.Peek() != -1))
            {
                if (i < numsAmount)
                {
                    error = ReadFileNum(reader, out numsArr[i], MIN_NUM, MAX_NUM);
                    if (error == ERRORS_CODE.CORRECT)
                        error = AreNumsDifferent(numsArr, i);
                }
                else
                    error = ERRORS_CODE.INCORRECT_NUMS_AMOUNT;
                i++;
            }
            if ((error == ERRORS_CODE.CORRECT) && (i != numsAmount))
                error = ERRORS_CODE.INCORRECT_NUMS_AMOUNT;
            if ((error == ERRORS_CODE.CORRECT) && !reader.EndOfStream)
                error = ERRORS_CODE.EXTRA_DATA;
            return error;
        }
        static ERRORS_CODE ReadFileData(StreamReader reader, ref int[] numsArr)
        {
            ERRORS_CODE error;
            int numsAmount;
            using (reader)
            {
                error = ReadFileNumsAmount(reader, out numsAmount);
                if (error == ERRORS_CODE.CORRECT)
                {
                    reader.ReadLine();
                    error = ReadFileNums(reader, ref numsArr, numsAmount);
                }
            }
            return error;
        }
        static void ReadFile(ref int[] numsArr)
        {
            StreamReader reader;
            ERRORS_CODE error;
            Console.WriteLine("Введите путь к файлу с расширением .txt.");
            Console.WriteLine($"Содержимое: \nКоличество чисел целое в диапазоне[{MIN_NUM_AMOUNT}; {MAX_NUM_AMOUNT}]; \nЧисла различные натуральные в диапазоне[{MIN_NUM}; {MAX_NUM}]");
            do
            {
                reader = ReadPathToReadingFile();
                using (reader)
                { 
                    error = ReadFileData(reader, ref numsArr);
                }
                if (error != ERRORS_CODE.CORRECT)
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT);
        }


        static ERRORS_CODE ReadConsoleNum(out int num, in int MIN, in int MAX)
        {
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            num = 1;
            try
            {
                num = int.Parse(Console.ReadLine());
            }
            catch
            {
                error = ERRORS_CODE.INCORRECT_NUM;
            }
            if (error == ERRORS_CODE.CORRECT)
                error = IsValidRange(num, MIN, MAX);
            return error;
        }
        static int ReadConsoleNumsAmount()
        {
            ERRORS_CODE error;
            int numsAmount;
            do
            {
                Console.WriteLine($"Введите целое количество чисел в диапазоне[{MIN_NUM_AMOUNT}; {MAX_NUM_AMOUNT}]:");
                error = ReadConsoleNum(out numsAmount, MIN_NUM_AMOUNT, MAX_NUM_AMOUNT);
                if (error != ERRORS_CODE.CORRECT)
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT);
            return numsAmount;
        }
        static void ReadConsoleNums(ref int[] numsArr, int numsAmount)
        {
            ERRORS_CODE error;
            numsArr = new int[numsAmount];
            Console.WriteLine($"Введите числа:");
            int i = 0;
            do
            {
                Console.WriteLine($"Введите {i + 1} натуральное уникальное число в диапазоне[{MIN_NUM}; {MAX_NUM}]:");
                error = ReadConsoleNum(out numsArr[i], MIN_NUM, MAX_NUM);
                if (error == ERRORS_CODE.CORRECT)
                    error = AreNumsDifferent(numsArr, i);
                if (error == ERRORS_CODE.CORRECT)
                    i++;
                else
                    WriteError(error);
            } while (i < numsAmount);
        }
        static void ReadConsoleData(ref int[] numsArr)
        {
            int numsAmount;
            numsAmount = ReadConsoleNumsAmount();
            ReadConsoleNums(ref numsArr, numsAmount);
        }
        static void ReadConsole(ref int[] numsArr)
        {
            ReadConsoleData(ref numsArr);
        }


        static void ReadNums(ref int[] numsArr)
        {
            Console.WriteLine("Вы хотите: \nВводить числа через файл - 1 \nВводить числа через консоль - 2");
            if (ChooseOption(2) == 1)
                ReadFile(ref numsArr);
            else
                ReadConsole(ref numsArr);
        }


        static void SwapNums(ref int num1, ref int num2)
        {
            int temp = num1;
            num1 = num2;
            num2 = temp;
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
        static StreamWriter ReadPathToWritingFile()
        {
            ERRORS_CODE error;
            string filePath;
            StreamWriter writer;
            do
            {
                error = ERRORS_CODE.CORRECT;
                Console.WriteLine("Введите путь к файлу с расширением .txt.");
                filePath = Console.ReadLine();
                if (Path.GetExtension(filePath) != ".txt")
                    error = ERRORS_CODE.IS_NOT_TXT;
                if ((error == ERRORS_CODE.CORRECT) && !File.Exists(filePath))
                    error = ERRORS_CODE.IS_NOT_EXIST;
                if (error == ERRORS_CODE.CORRECT)
                    error = IsWriteable(filePath);
                if (error != ERRORS_CODE.CORRECT)
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT);
            writer = new StreamWriter(filePath);
            return writer;
        }
        static void WriteFileData(StreamWriter writer, int[] numsArr)
        {
            for (int i = 0; i < numsArr.Length; i++)
                writer.Write("{0, 5} ", numsArr[i]);
            writer.WriteLine();
        }
        static void MakeFilePermuntations(StreamWriter writer, int[] numsArr, int startIndex)
        {
            if (startIndex == numsArr.Length - 1)
                WriteFileData(writer, numsArr);
            else
                for (int i = startIndex; i < numsArr.Length; i++)
                {
                    SwapNums(ref numsArr[startIndex], ref numsArr[i]);
                    MakeFilePermuntations(writer, numsArr, startIndex + 1);
                    SwapNums(ref numsArr[startIndex], ref numsArr[i]);
                }
        }
        static void WriteFile(int[] numsArr)
        {
            StreamWriter writer = ReadPathToWritingFile();
            using (writer)
            {
                writer.WriteLine("Перестановки:");
                MakeFilePermuntations(writer, numsArr, 0);
            }
        }


        static void WriteConsoleData(int[] numsArr)
        {
            for (int i = 0; i < numsArr.Length; i++)
                Console.Write("{0, 5} ", numsArr[i]);
            Console.WriteLine();
        }
        static void MakeConsolePermuntations(int[] numsArr, int startIndex)
        {
            if (startIndex == numsArr.Length - 1)
                WriteConsoleData(numsArr);
            else
                for (int i = startIndex; i < numsArr.Length; i++)
                {
                    SwapNums(ref numsArr[startIndex], ref numsArr[i]);
                    MakeConsolePermuntations(numsArr, startIndex + 1);
                    SwapNums(ref numsArr[startIndex], ref numsArr[i]);
                }
        }
        static void WriteConsole(int[] numsArr)
        {
            Console.WriteLine("Перестановки:");
            MakeConsolePermuntations(numsArr, 0);
        }


        static void MakePermuntations(int[] numsArr)
        {
            Console.WriteLine("Вы хотите: \nВыводить перестановки через файл - 1 \nВыводить перестановки через консоль - 2");
            if (ChooseOption(2) == 1)
                WriteFile(numsArr);
            else
                WriteConsole(numsArr); 
        }


        static void Main(string[] args)
        {
            int[] numsArr = null;
            WriteTask();
            ReadNums(ref numsArr);
            MakePermuntations(numsArr);
            Console.ReadLine();
        }
    }
}