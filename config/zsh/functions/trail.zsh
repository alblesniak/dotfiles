# Wypisuje zawartość zmiennej PATH w formie jednej ścieżki na linię
function trail() {
  print -l ${(s/:/)PATH}
}

