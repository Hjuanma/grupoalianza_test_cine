enum Categories<String> {
  recomended(value: "0"),
  upcoming(value: "1"),
  popular(value: "2"),
  topRate(value: "3");

  final String value;
  const Categories({required this.value});
}
