using System.Globalization;

CheckGlobalization("en", 1.5, "1.5");
CheckGlobalization("de", 1.5, "1,5");

void CheckGlobalization(string cultureName, double number, string expectedGlobalizedNumberRepresentation)
{
    var numberRepresentation = number.ToString(CultureInfo.CreateSpecificCulture(cultureName));
    var successIndicator = numberRepresentation == expectedGlobalizedNumberRepresentation ? "✅" : "❌";
    Console.WriteLine($"{cultureName} - {numberRepresentation} - {successIndicator}");
}
