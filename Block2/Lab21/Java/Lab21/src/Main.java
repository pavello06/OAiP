import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int length = 0, i, countOfOdd;
        boolean isIncorrect;
        final int MIN_L = 1, MAX_L = 10000, MIN_ARR_EL = -1000000, MAX_ARR_EL = 1000000;
        System.out.println("Данная программа подсчитывает число нечётных чисел в масссиве с чётными порядковыми номерами.\n");
        do {
            isIncorrect = false;
            System.out.print("Введите число элементов в массиве[1; 10000]: ");
            try {
                length = Integer.parseInt(scanner.nextLine());
            } catch (NumberFormatException e) {
                System.out.println("Проверьте корректность ввода данных!");
                isIncorrect = true;
            }
            if (!isIncorrect && ((length < MIN_L) || (length > MAX_L))) {
                isIncorrect = true;
                System.out.println("Значение не попадает в диапазон!");
            }
        } while (isIncorrect);
        int arr[] = new int[length];
        for (i = 0; i < length; i++) {
            do {
                isIncorrect = false;
                System.out.print("Введите " + (i + 1) + " элемент массива[-1000000; 1000000]: ");
                try {
                    arr[i] = Integer.parseInt(scanner.nextLine());
                } catch (NumberFormatException e) {
                    System.out.println("Проверьте корректность ввода данных!");
                    isIncorrect = true;
                }
                if (!isIncorrect && ((arr[i] < MIN_ARR_EL) || (arr[i] > MAX_ARR_EL))) {
                    isIncorrect = true;
                    System.out.println("Значение не попадает в диапазон!");
                }
            } while (isIncorrect);
        }
        scanner.close();
        i = 1;
        countOfOdd = 0;
        while (i < length) {
            if (arr[i] % 2 == 1)
                countOfOdd++;
            i += 2;
        }
        System.out.print("\nЧисло нечётных чисел в массиве с чётными порядковыми номерами: " + countOfOdd);
    }
}
