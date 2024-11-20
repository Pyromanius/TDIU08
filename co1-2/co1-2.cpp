//Antgu873: Arbetat enskilt

#include <string>
#include <iostream>
#include <iomanip>
#include <cmath>
#include <cctype>

using namespace std;

int main()
{
  int initValue{}, finValue{}, lettCount{}, wordCount{}, noLett{}, noSpace{}, noNumb{};
  double kelvLow{-273.15};
  char tecken{};
  string str1{}, str2{}, str3{}, shortWord{}, longWord{};

  cout << "Del 1: Temperaturtabell\n"
      << "Ange startvärde: ";
  do
  {
    cin >> initValue;
    if (static_cast<double>(initValue) < kelvLow)
    {
      cout << "Felaktigt startvärde!\n"
          << "Ange startvärde: ";
    }
    else
    {
      break;
    }
  }
  while (true);

  cout << "Ange slutvärde: ";
  do
  {
    cin >> finValue;
    if (finValue < initValue)
    {
      cout << "Felaktigt slutvärde!\n"
          << "Ange slutvärde: ";
    }
    else
    {
      break;
    }
  }
  while (true);

  cout << "Celsius   Kelvin   Fahrenheit   Reaumur\n"
      << "---------------------------------------\n"
      << fixed << setprecision(2);
  for (int c {initValue}; c <= finValue; ++c)
  {
    double kelv = static_cast<double>(c)+273.15;
    double fahr = (static_cast<double>(c)*1.8)+32;
    double reau = static_cast<double>(c)*0.8;

    cout << setw(7)  << c 
        << setw(9) << kelv
        << setw(13) <<  fahr
        << setw(10) << reau << '\n';
  }
  cout << "---------------------------------------\n\n"
      << endl
      << "Del 2: Teckenhantering" << endl;

  for (int i{}; i < 10; ++i)
  {
    tecken = cin.get();
    str1 += tecken;
    if (isalpha(tecken))
    {
        ++noLett;
    }
    else if (isdigit(tecken))
    {
        ++noNumb;
    }
    else if (tecken == ' ')
    {
        ++noSpace;
    }
  }
  
  cout << "Texten innehöll:\n"
      << "Alfabetiska tecken:" << noLett << '\n'
      << "Siffertecken......:" << noNumb << '\n'
      << "Vita tecken.......:" << noSpace << "\n\n";
  cin.ignore(1000, '\n');

  cout << "Del 3: Ordhantering\n"
      << "Mata in en text:" 
      << endl;

  do 
  {
    if (cin >> str3)
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
    else
    {
      break;
    }
  }
  while (true);

  if (str2.length() == 0)
  {
    cout << "\nInga ord matades in.";
  } 
  else
  {
    cout << '\n'
        << "Texten innehöll " << wordCount << " ord.\n"
        << "Det kortaste ordet var " << '"' << shortWord << '"' << " med " << shortWord.length() << " tecken.\n"
        << "Det längsta ordet var " << '"' << longWord << '"' << " med " << longWord.length() << " tecken.\n"
        << "Medelordlängden var "
        << fixed << setprecision(1) << static_cast<double>(lettCount)/static_cast<double>(wordCount)
        << " tecken." << endl;
  }
  return 0;
}