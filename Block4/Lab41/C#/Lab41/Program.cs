using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using static Lab41.Program;

namespace Lab41
{
    internal class Program
    {
        public enum ERRORS_CODE
        {
            CORRECT,
            INCORRECT_CHOICE,
            INCORRECT_NAME,
            INCORRECT_AUTHOR,
            INCORRECT_DIRECTOR,
            INCORRECT_DATE,
            INCORRECT_TIME,
            INCORRECT_DATE_TIME,
            IS_NOT_TXT,
            IS_NOT_EXIST,
            IS_NOT_READABLE,
            IS_NOT_WRITEABLE,
            EXTRA_DATA
        }

        static readonly string[] ERRORS = new string[]
        {
            "",
            "Incorrect choice!",
            "Incorrect name!",
            "Incorrect author name!",
            "Incorrect director name!",
            "Incorrect date!",
            "Incorrect time!",
            "Incorrect date and time!",
            "The file extension is not .txt!",
            "Incorrect file path!",
            "The file is closed for reading!",
            "The file is closed for writing",
            "Extra data in the file!"
        };

        public struct Show
        {
            public int ShowNumber;
            public string ShowName;
            public string ShowAuthor;
            public string ShowDirector;
            public DateTime ShowDate;
            public DateTime ShowTime;
        }

        public enum Actions
        {
            Exit,
            AddShow,
            DeleteShow,
            EditShow,
            SearchShow,
            WriteFile,
            ShowShows,
        }



        static void WriteError(ERRORS_CODE error)
        {
            Console.Error.WriteLine(ERRORS[(int)error]);
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
                {
                    WriteError(error);
                    Console.Write("Try again: ");
                }
            } while (error != ERRORS_CODE.CORRECT);
            return option;
        }

        

        static ERRORS_CODE ReadStringTypeShow(string message, ref string tempString, ERRORS_CODE probableError)
        {
            const int MAX_STRING_LEN = 20;
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            if (tempString == "")
            {
                Console.Write(message + $" [1..{MAX_STRING_LEN}]: ");
                tempString = Console.ReadLine();
                if (tempString == "" || tempString.Length > MAX_STRING_LEN)
                {
                    error = probableError;
                    tempString = "";
                }
            }
            return error;
        }

        static ERRORS_CODE ReadDateTimeTypeShow(string message, ref DateTime tempDateTime, string format, ERRORS_CODE probableError)
        {
            ERRORS_CODE error = ERRORS_CODE.CORRECT;
            if (tempDateTime == DateTime.MinValue)
            {
                Console.Write(message);
                try
                {
                    tempDateTime = DateTime.ParseExact(Console.ReadLine(), format, CultureInfo.InvariantCulture);
                }
                catch
                {
                    error = ERRORS_CODE.INCORRECT_DATE;
                }
            }
            return error;
        }

        static Show ReadShow()
        {
            ERRORS_CODE error;
            Show show = new Show { ShowName = "", ShowAuthor = "", ShowDirector = "", ShowDate = DateTime.MinValue, ShowTime = DateTime.MinValue };
            do
            {
                error = ReadStringTypeShow("Enter the title", ref show.ShowName, ERRORS_CODE.INCORRECT_NAME);
                if (error == ERRORS_CODE.CORRECT)
                    error = ReadStringTypeShow("Enter the author's name", ref show.ShowAuthor, ERRORS_CODE.INCORRECT_AUTHOR);
                if (error == ERRORS_CODE.CORRECT)
                    error = ReadStringTypeShow("Enter director's name", ref show.ShowDirector, ERRORS_CODE.INCORRECT_DIRECTOR);
                if (error == ERRORS_CODE.CORRECT)
                    error = ReadDateTimeTypeShow("Enter date(dd.mm.yyyy): ", ref show.ShowDate, "dd.MM.yyyy", ERRORS_CODE.INCORRECT_DATE);
                if (error == ERRORS_CODE.CORRECT)
                    error = ReadDateTimeTypeShow("Enter time (hh:mm): ", ref show.ShowTime, "HH:mm", ERRORS_CODE.INCORRECT_TIME);
                if (error != ERRORS_CODE.CORRECT)
                    WriteError(error);
            } while (error != ERRORS_CODE.CORRECT);
            return show;
        }

        static void SortShows(List<Show> showsList)
        {
            Show tempShow1;
            int j;
            for (int i = 1; i < showsList.Count; i++)
            {
                tempShow1 = showsList[i];
                j = i - 1;
                while (j >= 0 && showsList[j].ShowName.CompareTo(tempShow1.ShowName) > 0)
                {
                    showsList[j + 1] = showsList[j];
                    j--;
                }
                showsList[j + 1] = tempShow1;
            }
        }

        static void FillShowsNumber(List<Show> showsList)
        {
            Show tempShow;
            for (int i = 0; i < showsList.Count; i++)
            {
                tempShow = showsList[i];
                tempShow.ShowNumber = i + 1;
                showsList[i] = tempShow;
            }
        }

        static DateTime ReadСlosestShowDateTime()
        {
            ERRORS_CODE error;
            DateTime closestShowDateTime = DateTime.MinValue;
            do
            {
                error = ERRORS_CODE.CORRECT;
                try
                {
                    closestShowDateTime = DateTime.ParseExact(Console.ReadLine(), "dd.MM.yyyy HH:mm", CultureInfo.InvariantCulture);
                }
                catch
                {
                    error = ERRORS_CODE.INCORRECT_DATE_TIME;
                }
                if (error != ERRORS_CODE.CORRECT)
                {
                    WriteError(error);
                    Console.Write("Try again: ");
                }
            } while (error != ERRORS_CODE.CORRECT);
            return closestShowDateTime;
        }

        static int FindNumberOfClosestShowDateTime(List<Show> showsList)
        {
            int numberOfClosestShowDateTime = -1;
            TimeSpan difference, minDifference = TimeSpan.MaxValue;
            DateTime closestShowDateTime = ReadСlosestShowDateTime();
            for (int i = 0; i < showsList.Count; i++)
            {
                difference = showsList[i].ShowDate.Date + showsList[i].ShowTime.TimeOfDay - closestShowDateTime;
                if (difference >= TimeSpan.FromMinutes(0) && difference < minDifference)
                {
                    minDifference = difference;
                    numberOfClosestShowDateTime = i;
                }
            }
            return numberOfClosestShowDateTime;
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
                Console.Write("Write path to file: ");
                filePath = Console.ReadLine();

                if (Path.GetExtension(filePath) != ".txt")
                    error = ERRORS_CODE.IS_NOT_TXT;
                if (error == ERRORS_CODE.CORRECT && !File.Exists(filePath))
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

        static void WriteTable(StreamWriter writer, List<Show> showsList)
        {
            Show show;
            using (writer)
            {
                writer.WriteLine("Shows:");
                for (int j = 0; j < 90; j++) writer.Write("-");
                writer.WriteLine("\r\n| {0, 2}| {1, 20}| {2, 20}| {3, 20}| {4, 10}| {5, 5}|", "#", "Name", "Author", "Director", "Date", "Time");
                for (int i = 0; i < showsList.Count; i++)
                {
                    for (int j = 0; j < 90; j++) writer.Write("-");
                    show = showsList[i];
                    writer.WriteLine("\r\n| {0, 2}| {1, 20}| {2, 20}| {3, 20}| {4, 10}| {5, 5}|", show.ShowNumber, show.ShowName, show.ShowAuthor, show.ShowDirector, show.ShowDate.ToString("dd.MM.yyyy"), show.ShowTime.ToString("HH:mm"));
                }
                for (int j = 0; j < 90; j++) writer.Write("-");
                writer.WriteLine();
            }
        }

        static void WriteCFData(char cfMode, List<Show> showsList)
        {
            StreamWriter writer = null;

            if (showsList.Count == 0)
                Console.WriteLine("You haven't added any shows yet!");
            else
            {
                switch (cfMode)
                {
                    case 'c':
                        writer = new StreamWriter(Console.OpenStandardOutput());
                        break;
                    case 'f':
                        writer = new StreamWriter(ReadIOFilePath('o'));
                        break;
                }
                WriteTable(writer, showsList);
            }
        }



        static void AddShow(List<Show> showsList, ref bool isSaved)
        {
            Show tempShow;
            tempShow = ReadShow();
            tempShow.ShowNumber = showsList.Count + 1;
            showsList.Add(tempShow);
            SortShows(showsList);
            FillShowsNumber(showsList);
            isSaved = false;
        }

        static void DeleteShow(List<Show> showsList, ref bool isSaved)
        {
            int numberOfDeletedShow;
            if (showsList.Count == 0)
                Console.WriteLine("You haven't added any shows yet!");
            else
            {
                WriteCFData('c', showsList);
                Console.Write("Enter the number of the show to be deleted: ");
                numberOfDeletedShow = ChooseOptionWithinRange(1, showsList.Count);
                Console.Write("Are you sure you want to delete the show?:\r\n" +
                              "1 - yes\r\n" +
                              "2 - no\r\n" +
                              "Your choice: ");
                if (ChooseOptionWithinRange(1, 2) == 1)
                {
                    showsList.Remove(showsList[numberOfDeletedShow - 1]);
                    FillShowsNumber(showsList);
                    isSaved = showsList.Count == 0;
                }
            }
        }

        static void EditShow(List<Show> showsList, ref bool isSaved)
        {
            int numberOfEditedShow;
            if (showsList.Count == 0)
                Console.WriteLine("You haven't added any shows yet!");
            else
            {
                WriteCFData('c', showsList);
                Console.Write("Enter the number of the show to be edited: ");
                numberOfEditedShow = ChooseOptionWithinRange(1, showsList.Count);
                showsList[numberOfEditedShow] = ReadShow();
                SortShows(showsList);
                FillShowsNumber(showsList);
                isSaved = false;
            }
        }

        static void SearchShow(List<Show> showsList)
        {
            int numberOfClosestShowDateTime;
            if (showsList.Count == 0)
                Console.WriteLine("You haven't added any shows yet!");
            else
            {
                Console.Write("Enter the date and time of the show you are interested in (dd.mm.yyyy hh:mm): ");
                numberOfClosestShowDateTime = FindNumberOfClosestShowDateTime(showsList);
                if (numberOfClosestShowDateTime == -1)
                    Console.WriteLine("Alas, there are no upcoming show(");
                else
                    Console.WriteLine($"Name: {showsList[numberOfClosestShowDateTime].ShowName}\r\n" +
                                      $"Author: {showsList[numberOfClosestShowDateTime].ShowAuthor}\r\n" +
                                      $"Director: {showsList[numberOfClosestShowDateTime].ShowDirector}\r\n" +
                                      $"Date: {showsList[numberOfClosestShowDateTime].ShowDate.Date}\r\n" +
                                      $"Time: {showsList[numberOfClosestShowDateTime].ShowTime.TimeOfDay}");
            }
        }

        static void WriteFile(List<Show> showsList, ref bool isSaved)
        {
            WriteCFData('f', showsList);
            isSaved = true;
        }

        static void ShowShows(List<Show> showsList)
        {
            WriteCFData('c', showsList);
        }

        static void Exit(List<Show> showsList, bool isSaved)
        {
            if (!isSaved)
            {
                Console.Write("You didn't save the file, do you want to save the file before exiting?\r\n" +
                              "1 - yes\r\n" +
                              "2 - no\r\n" +
                              "Your choice: ");
                if (ChooseOptionWithinRange(1, 2) == 1)
                    WriteFile(showsList, ref isSaved);
            }
        }



        static void ChooseAction(List<Show> showsList)
        {
            Actions action;
            bool isSaved = false;
            do
            {
                Console.Write("Choose one of the following actions:\r\n" +
                              "1 - add show(max 100)\r\n" +
                              "2 - delete show\r\n" +
                              "3 - edit show\r\n" +
                              "4 - search closest show\r\n" +
                              "5 - save file\r\n" +
                              "6 - show shows\r\n" +
                              "0 - exit\r\n" +
                              "Your choice: ");
                action = (Actions)ChooseOptionWithinRange(0, Enum.GetValues(typeof(Actions)).Length - 1);
                switch (action)
                {
                    case Actions.AddShow:
                        AddShow(showsList, ref isSaved);
                        break;
                    case Actions.DeleteShow:
                        DeleteShow(showsList, ref isSaved);
                        break;
                    case Actions.EditShow:
                        EditShow(showsList, ref isSaved);
                        break;
                    case Actions.SearchShow:
                        SearchShow(showsList);
                        break;
                    case Actions.WriteFile:
                        WriteFile(showsList, ref isSaved);
                        break;
                    case Actions.ShowShows:
                        ShowShows(showsList);
                        break;
                    case Actions.Exit:
                        Exit(showsList, isSaved);
                        break;
                }
            } while (action != Actions.Exit);
        }

        static void Main(string[] args)
        {
            List<Show> showsList = new List<Show>();
            ChooseAction(showsList);
        }
    }
}