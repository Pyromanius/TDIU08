//Antgu873: Arbetat enskilt

#include <iostream>
#include <iomanip>
#include <string>
using namespace std;

int main()
{
  int heltal;
  double flyttal;
  char tecken;
  string ord;

  cout << "Skriv in ett heltal: ";
  cin >> heltal;
  cout << "Du skrev in heltalet: " << heltal;
  cout << endl << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in fem heltal: ";
  cin >> heltal;
  cout << "Du skrev in heltalen: ";
  cout << heltal << " ";
  cin >> heltal;
  cout << heltal << " ";
  cin >> heltal;
  cout << heltal << " ";
  cin >> heltal;
  cout << heltal << " ";
  cin >> heltal;
  cout << heltal << "\n" << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in ett flyttal: ";
  cin >> flyttal;
  cout << "Du skrev in flyttalet: ";
  cout << fixed << setprecision(3) << flyttal << "\n" << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in ett heltal och ett flyttal: ";
  cin >> heltal >> flyttal;
  cout << "Du skrev in heltalet: " << setw(10) <<  heltal << "\n";
  cout << "Du skrev in flyttalet: " << fixed << setprecision(4) << setw(9) << flyttal << "\n" << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in ett flyttal och ett heltal: ";
  cin >> flyttal >> heltal;
  cout << setfill('-');
  cout << "Du skrev in heltalet:" << setw(9) << heltal << "\n";
  cout << "Du skrev in flyttalet:" << setw(8) << fixed << setprecision(4) << flyttal << "\n" << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in ett tecken: ";
  cin >> tecken;
  cout << "Du skrev in tecknet: " << tecken << "\n" << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in ett ord: ";
  cin >> ord;
  cout << "Du skrev in ordet: " << ord << "\n" << endl;


  cin.ignore(1000,'\n');

  cout << "Skriv in ett heltal och ett ord: ";
  cin >> heltal >> ord;
  cout << "Du skrev in heltalet |" << heltal << "| och ordet |" << ord << "|." << "\n" << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in ett tecken och ett ord: ";
  cin >> tecken >> ord;
  cout << "Du skrev in " << '"' << ord << '"' << " och " << '"' << tecken << '"' << "." << "\n" << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in ett ord och ett tecken: ";
  cin >> ord >> tecken;
  cout << "Du skrev in "<< '"' << ord << '"' << " och " << '"' << tecken << '"' << "." << "\n" << endl;

  cin.ignore(1000,'\n');

  cout << "Skriv in en textrad: ";
  getline(cin, ord);
  cout << "Du skrev in "<< '"' << ord << '"' << ".\n" << endl;

  
  cout << "Skriv in en till rad text: ";
  getline(cin, ord);
  cout << "Du skrev in "<< '"' << ord << '"' << "." << "\n" << endl;

  
  cout << "Skriv in en rad med tre ord: ";
  cin >> ord;
  cout << "Du skrev in: " << '"' << ord << '"' << ", ";
  cin >> ord;
  cout << '"' << ord << '"' << " och ";
  cin >> ord;
  cout << '"' << ord << '"' << "." << endl;
  
  return 0;

}