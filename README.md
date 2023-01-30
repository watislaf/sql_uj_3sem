# sql_uj_3sem
## WIP/uwagi (Marcin):
1. widok *Journal* nie dziala, trzeba pomyslec czy na pewno chcemy taki widok w naszej bazie
2. tabela *amount_of_students_on_the_course* i odpowiadajace jej triggery sa wykomentowane, bo wg mnie to jest strasznie na sile zrobione i Byrskiemu sie to nie spodoba
## Zadanie

Baza danych szkoly. Baza powinna przechowywac informacje o przedmiotach, nauczycielach,
uczniach i ich stopniach oraz klasach i lekcjach.

### Kompletny projekt powinien zawierać  (❌/✅)

* diagram relacji (schemat bazy danych) ✅
* skrypty SQL tworzące wszystkie obiekty bazy danych ✅
* słowny opis projektu (cel, możliwości, główne założenia). Format opisu: plik PDF lub RTF (opis.md). ❌

### Minimalne wymagania dotyczące bazy danych:
#### 19/24 tabele

1. Michal - 3/8 tabel
2. Marcin - 8/8 tabel ✅
3. Vlad - 8/8 tabel ✅
--- 

1. Michal - 0/4 widoków lub funkcji
2. Marcin - 5/3 widoków lub funkcji ✅ (niektóre z nich są dość mało znaczące i nie wiem czy je wliczać)
3. Vlad - 3/3 widoków lub funkcji ✅
--- 
1. Michal - 0/1 procedur.
2. Marcin - 3/2 procedur ✅
3. Vlad - 2/2 procedur ✅
--- 
1. Michal - 0/1 wyzwalaczy.
2. Marcin - 2/2 wyzwalaczy ✅
3. Vlad - 2/2  wyzwalaczy ❌ (zmienimy to, te wyzwalacze sa strasznie na sile zrobione)

   
*???? Vlad - baza powinna zawierać dane dotyczące atrybutów, których wartość zmienia się w czasie ❌
* Marcin - baza powinna zawierać tabele realizujące jeden ze schematów dziedziczenia ✅
* Michal - należy zaprojektować strategii pielęgnacji bazy danych (kopie zapasowe) ❌
* Vlad - UI ✅

Plik z opisem powinien zawierać:
```
* podstawowe założenia projektu (cel, główne założenia, możliwości, ograniczenia przyjęte przy projektowaniu),
* diagram ER,
* schemat bazy danych (diagram relacji),
* dodatkowe wiezy integralności danych (nie zapisane w schemacie),
* utworzone indeksy,
* opis stworzonych widoków,
* opis procedur składowanych,
* opis wyzwalaczy,
* skrypt tworzący bazę danych,
* typowe zapytania.
``` 
