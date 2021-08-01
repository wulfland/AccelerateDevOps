function toRomanNumerals(num) {
  return num;
}

var numbers = [3,4,5,13,42,2021];

for ( i in numbers ) {
    number = numbers[i]
    console.log(`Roman for ${number} is ${toRomanNumerals(number)}`);
}
