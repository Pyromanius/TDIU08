//Antgu873: Arbetat enskilt

//Flyttal avrundas till heltal i Del 3

//static_cast<double>(VARIABEL)/static_cast<double>(VARIABEL)

#include <iostream>
#include <iomanip>
#include <cmath>
#include <cctype>

using namespace std;

int main()
{
  // DEL 1 ---------------------------------------------------------------

  int startvarde;
  int slutvarde;

  cout << "Del 1: Temperaturtabell" << endl;
  cout << "Ange startvärde: ";
  cin >> startvarde;

  while (startvarde < -60)
    {
      cout << "Felaktigt startvärde!" << '\n';
      cout << "Ange startvärde: ";
      cin >> startvarde;
    }

  cout << "Ange slutvärde: ";
  cin >> slutvarde;

  while (slutvarde <= startvarde)
    {
      cout << "Felaktigt slutvärde!" << '\n';
      cout << "Ange slutvärde: ";
      cin >> slutvarde;
    }

  cout << "Celsius   Kelvin   Fahrenheit   Reaumur" << endl;
  cout << "---------------------------------------" << endl;

  for (int i {startvarde}; i <= slutvarde; ++i)
    {
      cout << setw(7)  << i ;
      cout << setw(11) << fixed << setprecision(2) << i+273.15 ;
      cout << setw(11) << fixed << setprecision(2) << (i*1.8)+32 ;
      cout << setw(10) << fixed << setprecision(2) << i*0.8  << endl;
    }
  cout << endl;

  cin.ignore(1000, '\n');
  

  // DEL 2 ---------------------------------------------------------------

  string teckenstrang;
  char tecken;
  int antalbokstavar = 0, antalmellanslag = 0, antalsiffror = 0, check;

  cout << "Del 2: Teckenhantering" << endl;
  getline(cin, teckenstrang);

  for (int i{0}; i < 10; ++i)
    {
      tecken = teckenstrang[i];
      check = isalpha(tecken);
      if (check)
  	{
  	  ++antalbokstavar;
  	}
      check = isspace(tecken);
      if (check)
  	{
  	  ++antalmellanslag;
  	}
      check = isdigit(tecken);
      if (check)
  	{
  	  ++antalsiffror;
  	}
    }
  
  cout << "Texten innehöll:" << endl;
  cout << "Alfabetiska tecken:" << antalbokstavar << endl;
  cout << "Siffertecken......:" << antalsiffror << endl;
  cout << "Vita tecken.......:" << antalmellanslag << endl;
  cout << "Texten var: " << teckenstrang << endl;
  cout << endl;


  //DEL 3 ---------------------------------------------------------------

  string Textstrang, Langst_Ord, Kortast_Ord;
  int Mest_Bokstavar = 0, Minst_Bokstavar = 28, Antal_Ord = 0, Antal_Bokstavar = 0;

  cout << "Del 3: Ordhantering" << endl;
  cout << "Mata in text:" << endl;

  while (cin >> Textstrang)
    {
      
      if (Textstrang.length() < Minst_Bokstavar)
	{
	  Kortast_Ord = Textstrang;
	  Minst_Bokstavar = Textstrang.length();
	}
      if (Textstrang.length() > Mest_Bokstavar)
	{
	  Langst_Ord = Textstrang;
	  Mest_Bokstavar = Textstrang.length();
	}

      Antal_Bokstavar += Textstrang.length();
      ++Antal_Ord;
      
    }

  if (Textstrang.length() == 0)
    {
      cout << "Inget ord inmatat";
    }
  
  else
    {
      cout << endl;
      cout << "Texten innehöll " << Antal_Ord << " ord." << endl;
      cout << "Det kortaste ordet var " << '"' << Kortast_Ord << '"' << " med " << Minst_Bokstavar << " tecken." << endl;
      cout << "Det längsta ordet var " << '"' << Langst_Ord << '"' << " med " << Mest_Bokstavar << " tecken." << endl;
      cout << "Medelordlängden var ";
      cout << fixed << setprecision(1) << static_cast<double>(Antal_Bokstavar)/static_cast<double>(Antal_Ord);
      cout << " bokstäver." << endl;
    }

  
  return 0;
}