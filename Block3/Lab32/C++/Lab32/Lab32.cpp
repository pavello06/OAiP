﻿#include <iostream>
#include <set>
#include <string>
#include <fstream>
enum ErrorsCode
{
    CORRECT,
    INCORRECT_SET_LENGTH,
    INCORRECT_SET_El,
    INCORRECT_CHOICE,
    IS_NOT_TXT,
    IS_NOT_EXIST,
    IS_NOT_READABLE,
    IS_NOT_WRITEABLE,
    INCORRECT_SET_AMOUNT,
};
const int
    MIN_S = 1,
    MAX_S = 85;
const std::string 
    ERRORS[] = { "",
                 "Длина множества не попадает в диапазон!",
                 "Элементы множества разделяются пробелом!",
                 "Некорректный выбор!",
                 "Расширение файла не .txt!",
                 "Проверьте корректность ввода пути к файлу!",
                 "Файл закрыт для чтения!",
                 "Файл закрыт для записи!",
                 "Неправильное число множеств в файле" };    
void printTask()
{
    std::cout << "Данная программа формирует множество из трёх множеств и находит числа в этом множестве.\n";
}
ErrorsCode isCorrectSetLen(std::string sSetEl)
{
    ErrorsCode error;
    int setLen;
    error = CORRECT;
    setLen = ((int)sSetEl.length() + 1) / 2;
    if (setLen < MIN_S || setLen > MAX_S)
        error = INCORRECT_SET_LENGTH;
    return error;
}
ErrorsCode isCorrectSetEl(std::string sSetEl)
{
    ErrorsCode error;
    int i;
    error = CORRECT;
    i = 1;
    while (error == CORRECT && i < sSetEl.length())
    {
        if (sSetEl[i] != ' ')
            error = INCORRECT_SET_El;
        i += 2;
    }
    return error;
}
ErrorsCode isCorrectSet(std::string sSetEl)
{
    ErrorsCode error;
    error = isCorrectSetLen(sSetEl);
    if (error == CORRECT)
        error = isCorrectSetEl(sSetEl);
    return error;
}
void fillSet(std::string sSetEl, std::set<char>& setEl)
{
    int i;
    for (i = 0; i < sSetEl.length(); i += 2)
        setEl.insert(sSetEl[i]);
}
int chooseOption(int amount)
{
    ErrorsCode error;
    int option;
    option = 1;
    do {
        error = CORRECT;
        std::cin >> option;
        if (std::cin.fail())
        {
            error = INCORRECT_CHOICE;
            std::cin.clear();
            while (std::cin.get() != '\n');
        }
        if (error == CORRECT && std::cin.get() != '\n')
        {
            error = INCORRECT_CHOICE;
            while (std::cin.get() != '\n');
        }
        if (error == CORRECT && (option < 1 || option > amount))
            error = INCORRECT_CHOICE;
        if (error != CORRECT)
            std::cout << ERRORS[error] << "\nПовторите попытку: \n";
    } while (error != CORRECT);
    return option;
}
std::string getPartStr(std::string str, int posStart, int posEnd)
{
    std::string partStr;
    int i;
    partStr = "";
    for (i = posStart; i <= posEnd; i++)
        partStr = partStr + str[i];
    return partStr;
}
ErrorsCode isFileTXT(std::string pathToFile)
{
    ErrorsCode error;
    error = CORRECT;
    if (pathToFile.length() < 5 || getPartStr(pathToFile, (int)pathToFile.length() - 4, (int)pathToFile.length() - 1) != ".txt")
        error = IS_NOT_TXT;
    return error;
}
ErrorsCode isExist(std::string pathToFile)
{
    ErrorsCode error;
    error = CORRECT;
    std::ifstream file(pathToFile);
    if (!file.good())
        error = IS_NOT_EXIST;
    file.close();
    return error;
}
ErrorsCode isReadable(std::string pathToFile)
{
    ErrorsCode error;
    error = CORRECT;
    std::ifstream file(pathToFile);
    if (!file.is_open())
        error = IS_NOT_READABLE;
    file.close();
    return error;
}
ErrorsCode isWriteable(std::string pathToFile)
{
    ErrorsCode error;
    error = CORRECT;
    std::ofstream file(pathToFile, std::ios::app);
    if (!file.is_open())
        error = IS_NOT_WRITEABLE;
    file.close();
    return error;
}
void getFileNormalReading(std::string& pathToFile)
{
    ErrorsCode error;
    do
    {
        std::getline(std::cin, pathToFile);
        error = isFileTXT(pathToFile);
        if (error == CORRECT)
            error = isExist(pathToFile);
        if (error == CORRECT)
            error = isReadable(pathToFile);
        if (error != CORRECT)
            std::cout << ERRORS[error] << "\nПовторите попытку: \n";
    } while (error != CORRECT);
}
void getFileNormalWriting(std::string& pathToFile)
{
    ErrorsCode error;
    do
    {
        std::getline(std::cin, pathToFile);
        error = isFileTXT(pathToFile);
        if (error == CORRECT)
            error = isExist(pathToFile);
        if (error == CORRECT)
            error = isWriteable(pathToFile);
        if (error != CORRECT)
            std::cout << ERRORS[error] << "\nПовторите попытку: \n";
    } while (error != CORRECT);
}
ErrorsCode readFileSet(std::ifstream& file, std::set<char>& setEl)
{
    ErrorsCode error;
    std::string sSetEl;
    std::getline(file, sSetEl);
    error = isCorrectSet(sSetEl);
    fillSet(sSetEl, setEl);
    return error;
}
void readFileSets(std::set<char>& x1, std::set<char>& x2, std::set<char>& x3)
{
    ErrorsCode error;
    std::string pathToFile;
    pathToFile = "";
    std::cout << "Введите путь к файлу с расширением .txt с тремя множествами, с длинами[" << MIN_S << "; " << MAX_S << "]: \n";
    do
    {
        getFileNormalReading(pathToFile);
        error = CORRECT;
        std::ifstream file(pathToFile);
        error = readFileSet(file, x1);
        if (!file.eof()) 
            error = readFileSet(file, x1);
        else
            error = INCORRECT_SET_AMOUNT;
        if (!file.eof()) {
            if (error == CORRECT) error = readFileSet(file, x2);
        }
        else
            error = INCORRECT_SET_AMOUNT;
        if (!file.eof()) {
            if (error == CORRECT) error = readFileSet(file, x3);
        }
        else
            error = INCORRECT_SET_AMOUNT;
        if (error == CORRECT && !file.eof())
            error = INCORRECT_SET_AMOUNT;
        file.close();
        if (error != CORRECT)
            std::cout << ERRORS[error] << "\nПовторите попытку: \n";
    } while (error != CORRECT);
}
void readConsoleSet(int num, std::set<char>& setEl)
{
    ErrorsCode error;
    std::string sSetEl;
    std::cout << "Введите множество Х" << num << " через пробелы : ";
    do
    {
        std::getline(std::cin, sSetEl);
        error = isCorrectSet(sSetEl);
        if (error != CORRECT)
            std::cout << ERRORS[error] << "\nПовторите попытку: ";
    } while (error != CORRECT);
    fillSet(sSetEl, setEl);
}
void readConsoleSets(std::set<char>& x1, std::set<char>& x2, std::set<char>& x3)
{
    readConsoleSet(1, x1);
    readConsoleSet(2, x2);
    readConsoleSet(3, x3);
}
void readSets(std::set<char>& x1, std::set<char>& x2, std::set<char>& x3)
{
    int option;
    std::cout << "Вы хотите: \n";
    std::cout << "Вводить множества через файл - 1\n";
    std::cout << "Вводить множества через консоль - 2\n";
    option = chooseOption(2);
    if (option == 1)
        readFileSets(x1, x2, x3);
    else
        readConsoleSets(x1, x2, x3);
}
void uniteSets(std::set<char>& y, std::set<char> x1, std::set<char> x2, std::set<char> x3)
{
    for (char element : x1)
        y.insert(element);
    for (char element : x2)
        y.insert(element);
    for (char element : x3)
        y.insert(element);
}
void findNums(std::set<char>& y1, std::set<char> y)
{
    for (char element : y)
        if (element >= '0' && element <= '9')
            y1.insert(element);
}
void printConsoleResult(std::set<char> y1, std::set<char> y)
{
    std::cout << "\nМножество Y = {X1 U X2 U X3}: ";
    for (char element : y)
        std::cout << "'" << element << "'; ";
    std::cout << "\nЦифры в множестве: ";
    if (y1.empty())
        std::cout << "цифр в множестве нет";
    else
        for (char element : y1)
            std::cout << "'" << element << "'; ";
}
void printFileResult(std::set<char> y1, std::set<char> y)
{
    std::string pathToFile;
    pathToFile = "";
    std::cout << "Введите путь к файлу с расширением .txt для получения результата: \n";
    getFileNormalWriting(pathToFile);
    std::ofstream file(pathToFile, std::ios::app);
    file << "\nМножество Y = {X1 U X2 U X3}: ";
    for (char element : y)
        file << "'" << element << "'; ";
    file << "\nЦифры в множестве: ";
    if (y1.empty())
        file << "цифр в множестве нет";
    else
        for (char element : y1)
            file << "'" << element << "'; ";
    file.close();
}
void printResult(std::set<char> y1, std::set<char> y)
{
    int option;
    std::cout << "Вы хотите: \n";
    std::cout << "Выводить множеста через файл - 1\n";
    std::cout << "Выводить множеста через консоль - 2\n";
    option = chooseOption(2);
    if (option == 1)
        printFileResult(y1, y);
    else
        printConsoleResult(y1, y);
}
int main()
{
    setlocale(LC_ALL, "RU");
    std::set<char> x1, x2, x3, y, y1;
    printTask();
    readSets(x1, x2, x3);
    uniteSets(y, x1, x2, x3);
    findNums(y1, y);
    printResult(y1, y);
    return 0;
}
