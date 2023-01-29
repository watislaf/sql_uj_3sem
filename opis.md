tutaj moze byc nasz opis
http://34.125.149.136/

## Jak działa rekrutacja w naszej szkole?
Każdy kandydat ma wpisane następujące rzeczy w tabeli *candidates*:
 * *pl_exam_result* - wynik egzaminu (po zakończeniu szkoły podstawowej) z języka polskiego
 * *math_exam_result* - wynik egzaminu z matematyki
 * *science_exam_result* - wynik egzaminu z przedmiotów ścisłych (chemia, biologia itp.)
 * *extracurlicural_act* - wyrażona przez true lub false informacja o tym, czy kandydat bierze udział w wolontariatach, udziela się społecznie itp.
 * *choosed_class_symbol* - preferowana przez kandydata specializacja klasy licealnej (p - polonistyczna, m - matematyczna, s - biologiczno-chemiczna (science))
 * *filling_date* - data i godzina zgłoszenia się do rekrutacji

Każdy kandydat ma na podstawie powyższych danych wyliczną liczbę punktów wzorem:

    pl_exam_result * 30% + math_exam_result * 30% + science_exam_result * 30% + extracurlicural_act * 10%

Do szkoły przyjmowani są wyłącznie uczniowie, których liczba punktów jest >= 50. Dodatkowo, szkoła przyjmuje wyłącznie 6 najlepszych uczniów (po 2 na klasę).

#### Jak uczniowie są przydzielani do klas?
Uczniowie przyjęci do szkoły są ustawiani w kolejności względem ilości punktów uzyskanych przez nich na rekrutacji. Następnie każdy z nich, po kolei, jest przypisywany do klasy o takiej specializacji jaka jest określona w *choosed_class_symbol*.
Jeśli klasa z wybraną przez ucznia specializacją została już zapełniona (ma 2 osoby), to uczeń zostaje przypisany do kolejnej, najbliższej mu specializacji, według schematu:
* Jeśli kandydat wybrał klasę polonistyczną ('p'):
  * p > s > m
* Jeśli kandydat wybrał klase matematyczną ('m'):
  * m > s > p
* Jeśli kandydat wybrał klasę biol-chem ('s'): 
  * s > m > p

W przypadku gdy w klasie o specializacji *x* zostało jedno miejsce, dwaj następni w kolejności mają tę samą liczbę punktów oraz oboje chcą trafić do klasy o specializacji *x*, miejsce w klasie dostanie ten kandydat który miał lepszy wynik z egzaminu który odpowiada danej specializacji. Jeśli nadal nie pozwala to wyłonić który kandydat powinien dostać to miejsce (oboje mają taki sam wynik z egzaminu *x*), o przyznaniu miejsca decyduje kolejność zgłoszenia zapisana w kolumnie *filling_date*.