//
//  ContentView.swift
//  BetterRest
//
//  Created by Kevin Ziroldi on 21/09/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    private var sleepTime: Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount - 1))
            
            return wakeUp - prediction.actualSleep
        } catch {
            // error
            return Date.now
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up?") {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                Section("Desired amount of sleep") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection:$coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0 - 1)")
                        }
                    }
                }
                
                Section("Ideal bed time") {
                    Text("Your ideal bedtime is " + sleepTime.formatted(date: .omitted, time: .shortened))
                }
            }.navigationTitle("BetterRest")
        }
    }
}

#Preview {
    ContentView()
}
