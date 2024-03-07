//Antgu873: Arbetat enskilt
#include <iostream>
#include <iomanip>
#include <cmath>
#include <cctype>

using namespace std;

int main()
{

// O
  // -------------
  // **         /---------
  // **   DEL  /        **
  // **       /   1     **
  // --------/          **
  //        --------------
  //
  //

    int initValue;
    int finValue;

  cout << "Del 1: Temperaturtabell" << '\n'
      << "Ange startvärde: ";
  cin >> initValue;

  while (initValue < -60)
  {
    cout << "Felaktigt startvärde!" << '\n'
        << "Ange startvärde: ";
    cin >> initValue;
  }

  cout << "Ange slutvärde: ";
  cin >> finValue;

  while (finValue <= initValue)
  {
    cout << "Felaktigt slutvärde!" << '\n'
        << "Ange slutvärde: ";
    cin >> finValue;
  }

  cout << "Celsius   Kelvin   Fahrenheit   Reaumur" << '\n'
      << "---------------------------------------" << '\n';

  for (int i {initValue}; i <= finValue; ++i)
  {
    cout << setw(7)  << i 
        << setw(11) << fixed << setprecision(2) << i+273.15 
        << setw(11) << fixed << setprecision(2) << (i*1.8)+32 
        << setw(10) << fixed << setprecision(2) << i*0.8  << '\n';
  }
  cout << '\n';

  cin.ignore(1000, '\n');

// O
  // -------------
  // **         /---------
  // **   DEL  /        **
  // **       /   2     **
  // --------/          **
  //        --------------
  //
  //
  
    string str1;
    char tecken;
    int noLett = 0, noSpace = 0, noNumb = 0;

  cout << "Del 2: Teckenhantering" << '\n';

  for (int i{0}; i < 10; ++i)
  {
      cin >> noskipws >> tecken;
      str1 += tecken;

      if (isalpha(tecken))
      {
          ++noLett;
      }
      else if (isdigit(tecken))
      {
          ++noNumb;
      }
      else if (isspace(tecken))
      {
          ++noSpace;
      }
  }
  
  cout << "Texten innehöll:" << '\n'
       << "Alfabetiska tecken:" << noLett << '\n'
       << "Siffertecken......:" << noNumb << '\n'
       << "Vita tecken.......:" << noSpace << "\n\n";

   cin.ignore(1000, '\n');

// O
  // -------------
  // **         /---------
  // **   DEL  /        **
  // **       /   3     **
  // --------/          **
  //        --------------
  //
  //

    string str2, str3, shortWord, longWord;
    int lettCount = 0, wordCount = 0;

  cout << "Del 3: Ordhantering" << '\n';
  cout << "Mata in text:" << '\n';

  while (cin >> skipws >> str3)
  {
    str2.append(str3+" ");

    if (str3.length() < shortWord.length() || shortWord.length() == 0)
    {
        shortWord = str3;
    }

    if (str3.length() > longWord.length())
    {
        longWord = str3;
    }

    lettCount += str3.length();
    ++wordCount;
  }

  if (str2.length() == 0)
  {
    cout << "Inget ord inmatat";
  } 
  else
  {
    cout << '\n'
        << "Texten innehöll " << wordCount << " ord." << '\n'
        << "Det kortaste ordet var " << '"' << shortWord << '"' << " med " << shortWord.length() << " tecken." << '\n'
        << "Det längsta ordet var " << '"' << longWord << '"' << " med " << longWord.length() << " tecken." << '\n'
        << "Medelordlängden var "
        << fixed << setprecision(1) << static_cast<double>(lettCount)/static_cast<double>(wordCount)
        << " bokstäver." << '\n';
  }

  return 0;
}