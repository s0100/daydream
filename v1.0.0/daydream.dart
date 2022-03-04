//
//  Daydream v4.0
//  February 23, 2022
//
//  Synopsis
//    A command-line program for figuring out the day.

//  Gratitudes
//    - Ilham Daiee Muntahi
//    - Afia Farzana Priontee
//  
//  Changelog
//    I don't know if this was the best algorithm.
//    But I'm happy that it works! 😁
//

import "dart:io";

const days = [
  "Saturday",
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday"
];

void newline() {
  stdout.write("\n");
}

void fence(int size) {
  for (int i = 0; i <= size; i++) {
    stdout.write("-");
  }
}

String? getStringValue(String? forWhat) {
  String? result = "";

  newline();
  stdout.write("Enter ${forWhat}\n> ");
  result = stdin.readLineSync();

  return result;
}

int getNumericValue(String? forWhat) {
  int number = 0;

  while (true) {
    try {
      number = int.parse(getStringValue(forWhat) ?? "");

      if (forWhat == "date") {
        if (!(number >= 1 && number <= 31)) {
          print("That was unexpected. Try again.");
          continue;
        }
      } else if (forWhat == "month") {
        if (!(number >= 1 && number <= 12)) {
          print("That was unexpected. Try again.");
          continue;
        }
      } else if (forWhat == "year") {
        if (!(number >= 1600 && number <= 2199)) {
          print(
              "You cannot enter anything below 1600 or above 2199. Try again.");
          continue;
        }
      }
      break;
    } on FormatException {
      print("Please enter a valid number.");
    }
  }

  return number;
}

int isLeapYear(int year) {
  var bool;
  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0) {
        bool = 1;
      } else {
        bool = 0;
      }
    }
  } else {
    bool = 0;
  }
  return bool;
}

int getDayCodeFor(int date, int month, int year) {
  int monthCode = 0;
  int yearCode = 0;

  switch (month) {
    case 1:
    case 10:
      monthCode = 0;
      break;
    case 5:
      monthCode = 1;
      break;
    case 8:
      monthCode = 2;
      break;
    case 2:
    case 3:
    case 11:
      monthCode = 3;
      break;
    case 6:
      monthCode = 4;
      break;
    case 9:
    case 12:
      monthCode = 5;
      break;
    case 4:
    case 7:
      monthCode = 6;
      break;
    default:
      print("Something went wrong.");
      break;
  }

  if (year >= 1600 && year < 1700)
    yearCode = year - 1600;
  else if (year >= 1700 && year < 1800)
    yearCode = year - 1700;
  else if (year >= 1800 && year < 1900)
    yearCode = year - 1800;
  else if (year >= 1900 && year < 2000)
    yearCode = year - 1900;
  else if (year >= 2000 && year < 2100)
    yearCode = year - 2000;
  else if (year >= 2100 && year < 2200)
    yearCode = year - 2100;
  else
    print("Something went wrong.");

  int dayCode = (date + monthCode + yearCode + (yearCode ~/ 4)) % 7;

  return dayCode;
}

void getDay(dayCode, List dayCodes) {
  if (dayCode == dayCodes[0])
    print(days[0]);
  else if (dayCode == dayCodes[1])
    print(days[1]);
  else if (dayCode == dayCodes[2])
    print(days[2]);
  else if (dayCode == dayCodes[3])
    print(days[3]);
  else if (dayCode == dayCodes[4])
    print(days[4]);
  else if (dayCode == dayCodes[5])
    print(days[5]);
  else if (dayCode == dayCodes[6])
    print(days[6]);
  else
    print("Somethng went wrong!");
}

int main() {
  while (true) {
    int year = getNumericValue("year");
    int month = getNumericValue("month");
    int date = getNumericValue("date");

    switch (month) {
      case 2:
        if (isLeapYear(year) == 1) {
          while (!(date >= 1 && date <= 29)) {
            stdout.write("Hey! That was a leap year. Try again. ");
            date = getNumericValue("date");
          }
        } else if (isLeapYear(year) == 0) {
          while (!(date >= 1 && date <= 28)) {
            stdout.write("Hey! That was not a leap year. Try again.");
            date = getNumericValue("date");
          }
        }
        break;
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        while (!(date >= 1 && date <= 31)) {
          stdout.write("The month consists of 31 days. Try again.\n> ");
          date = getNumericValue("date");
        }
        break;
      case 4:
      case 6:
      case 9:
      case 11:
        while (!(date >= 1 && date <= 30)) {
          stdout.write("The month consists of 30 days. Try again\n> ");
          date = getNumericValue("date");
        }
        break;
      default:
        print("Error! Something went wrong.");
        break;
    }

    var dayCode = getDayCodeFor(date, month, year);

    newline();
    fence(40);
    newline();

    if (year >= 1600 && year < 1700)
      getDay(dayCode, [3, 4, 5, 6, 0, 1, 2]);
    else if (year >= 1700 && year < 1800)
      getDay(dayCode, [4, 5, 6, 0, 1, 2, 3]);
    else if (year >= 1800 && year < 1900)
      getDay(dayCode, [5, 6, 0, 1, 2, 3]);
    else if (year >= 1900 && year < 2000)
      getDay(dayCode, [6, 0, 1, 2, 3, 4, 5]);
    else if (year >= 2000 && year < 2100)
      getDay(dayCode, [0, 1, 2, 3, 4, 5, 6]);
    else if (year >= 2100 && year < 2200)
      getDay(dayCode, [1, 2, 3, 4, 5, 6, 0]);
    else
      print("Something went wrong.");

    fence(40);
    newline();
    newline();

    stdout.write("Press any key to exit or 'c' to continue.\n> ");
    String? exit = stdin.readLineSync()?.toLowerCase();

    if (exit == "c") {
      continue;
    } else {
      break;
    }
  }
  return 0;
}
