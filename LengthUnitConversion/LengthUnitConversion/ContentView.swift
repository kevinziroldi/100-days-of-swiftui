//
//  ContentView.swift
//  LengthUnitConversion
//
//  Created by Kevin Ziroldi on 15/09/24.
//

import SwiftUI

enum LengthUnit: CaseIterable {
    case meters
    case kilometers
    case feet
    case yards
    case miles
    
    func unitName() -> String {
        switch self {
            case .meters:
                return "meters"
            case .kilometers:
                return "kilometers"
            case .feet :
                return "feet"
            case .yards:
                return "yards"
            case .miles:
                return "miles"
        }
    }
}

struct ContentView: View {
    @State private var length = 0.0
    @State private var inputUnit = LengthUnit.miles
    @State private var outputUnit = LengthUnit.kilometers
    
    @FocusState private var lengthIsFocused: Bool
    
    var convertedLength: Double {
        if inputUnit == outputUnit {
            return length
        }
        
        // convert to meters
        let lengthMeters: Double
        
        switch inputUnit {
        case .meters:
            lengthMeters = length
        case .kilometers:
            lengthMeters = length * 1000
        case .feet:
            lengthMeters = length * 0.3048
        case .yards:
            lengthMeters = length * 0.9144
        case .miles:
            lengthMeters = length * 1609.34
        }
        
        // convert from meters to output unit
        let outputLength: Double
        switch outputUnit {
        case .meters:
            outputLength = lengthMeters
        case .kilometers:
            outputLength = lengthMeters * 0.001
        case .feet:
            outputLength = lengthMeters * 3.28084
        case .yards:
            outputLength = lengthMeters * 1.09361
        case .miles:
            outputLength = lengthMeters * 0.000621371
        }
        
        return outputLength
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Conversion data") {
                    TextField("Length", value: $length, format: .number) .keyboardType(.decimalPad)
                        .focused($lengthIsFocused)
                    
                    
                    
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) {
                            Text(($0).unitName())
                        }
                    }
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(LengthUnit.allCases, id: \.self) {
                            Text(($0).unitName())
                        }
                    }
                }
                
                Section("Converted length") {
                    Text(convertedLength, format: .number)
                }
            }
            .navigationTitle("LengthConversion")
            .toolbar {
                if lengthIsFocused {
                    Button("Done") {
                        lengthIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
