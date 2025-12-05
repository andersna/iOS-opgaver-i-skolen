import Foundation

var sange = ["Nothing else matters",
            "Stairway to heaven",
            "I want a new drug",
            "I want to break free"]

sange.append("Sommmer i Europa")
let tilfældigsang = sange.randomElement()

//Optional unwrapping
//Model 1
if let sang = tilfældigsang {
    print(sang)
}

//Model 1.1
if let tilfældigsang {
    print(tilfældigsang)
}

//Model 2
guard let sang = tilfældigsang else {
    fatalError( "Der er ingen sang")
}

print(sang)

//Model 3
let song = tilfældigsang ?? "Der er ingen sang"

let førsteI = sange.first(where: {sang in
    return sang.hasPrefix("I")
})
print(førsteI ?? "Ingen")

let førsteISang = sange.first{ $0.hasPrefix("I") }
print(førsteISang)


//Opgaver

//opgave 1
func CelsiusTilFahrenheit(_ celsius: Double) -> Double {
    return (celsius * 9.0 / 5.0) + 32.0
}

//opgave 2
func FahrenheitTilCelsius(_ fahrenheit: Double) -> Double {
    return (fahrenheit - 32.0) * 5.0 / 9.0
}

//opgave 3
func CelsiusTilKelvin(_ celsius: Double) -> Double {
    return celsius + 273.15
}

//opgave 4

enum Measurement{
    case Celsius(Double)
    case Fahrenheit(Double)
    case Kelvin(Double)
    
    func toCelsius() -> Double {
        switch self {
        case .Celsius(let value):
            return value
        case .Fahrenheit(let value):
            return (value - 32.0) * 5.0 / 9.0
        case .Kelvin(let value):
            return value - 273.15
        }
    }

    func toFahrenheit() -> Double {
        switch self {
        case .Celsius(let value):
            return (value * 9.0 / 5.0) + 32.0
        case .Fahrenheit(let value):
            return value
        case .Kelvin(let value):
            return (value - 273.15) * 9.0 / 5.0 + 32.0
        }
    }

    func toKelvin() -> Double {
        switch self {
        case .Celsius(let value):
            return value + 273.15
        case .Fahrenheit(let value):
            return (value - 32.0) * 5.0 / 9.0 + 273.15
        case .Kelvin(let value):
            return value
        }
    }
}

let celsius = Measurement.Celsius(22)

print("Celsius: \(celsius.toCelsius())")
print("Fahrenheit: \(celsius.toFahrenheit())")
print("Kelvin: \(celsius.toKelvin())")


import SwiftUI

struct ContentView: View {
    @State private var rating = 5
    var body: some View {
        HStack {
            Button("Decrease", systemImage: "minus.circle"){
                rating = rating - 1
            }
            Text("\(rating)").font(.system(size: 80))
            
        }
    }
}

#Preview {
    ContentView()
}
