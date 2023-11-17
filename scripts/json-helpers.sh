uncomment() {
  grep -v '//' | sed 's/\/\*.*\*\///g'
}
