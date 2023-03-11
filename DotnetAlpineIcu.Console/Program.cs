using System.Globalization;

var cultureName = args.Length is 0 ? "de" : args[0];
var culture = CultureInfo.CreateSpecificCulture(cultureName);

var numberString = 1.5.ToString(culture);

Console.WriteLine($"{cultureName} ➡ {numberString}");
