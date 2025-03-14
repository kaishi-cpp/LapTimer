//
//  ContentView.swift
//  LapTimer
//
//  Created by Chiba Kaishi on 2024/09/22.
//

import SwiftUI
import Charts

struct ResultView: View {
    var vehicleGTimeData: [VehicleGTimeData]
    var velocityTimeData: [VelocityTimeData]
    var coordinateTimeData: [CoordinateTimeData]
    
    var gpsVelocityData = GpsVelocityData()
    var motionViewModel = MotionViewModel()
    var locationCoordinateData = LocationCoordinateData()
    
    @State private var velocityCsvData: Data = Data()
    @State private var vehicleGCsvData: Data = Data()
    @State private var coordinateCsvData: Data = Data()
    
    var body: some View {
        GeometryReader { geometry in
//            let outerCircleSize = geometry.size.width * 0.9
            ZStack {
                // Background Color
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    Text("RESULT")
                        .foregroundColor(.white)
                        .font(.largeTitle)
//                        .font(.title)
                        .frame(width: 280, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 3)
                        )
                    
//                    Text("LAP TIME")
//                        .foregroundColor(.white)
//                        .font(.title)
                    // show list
                    
                    Text("TIME vs G(Lateral)")
                        .foregroundColor(.white)
                        .font(.title)
                    // show 2 graphs
                    
                    // Display chart with Time vs Lateral Accerelation
                    Chart(vehicleGTimeData) { dataPoint in
                        PointMark(
                            x: .value("Time", dataPoint.time),  // 経度をX軸にプロット
                            y: .value("G (Lateral)", dataPoint.acceleration.y)  // 緯度をY軸にプロット
                        )
                        .foregroundStyle(.blue)  // 点の色を設定
                        .symbolSize(5)  // 点の大きさ
                    }
//                    .chartYAxis {
//                        AxisMarks(position: .leading, values: .automatic)
//                    }
//                    .chartYScale(range: -1.0...1.0) // Y-axis range
//                    .frame(width: geometry.size.width * 0.9, height: 300)  // Chartのサイズ調整
//                    .padding()
                    
                    Text("TIME vs Velocity")
                        .foregroundColor(.white)
                        .font(.title)
                    // Display chart with Time vs Velocity
                    Chart(velocityTimeData) { dataPoint in
                        PointMark(
                            x: .value("Time", dataPoint.time),  // X軸にプロット
                            y: .value("Velocity", dataPoint.velocity)  // Y軸にプロット
                        )
                        .foregroundStyle(.blue)  // 点の色を設定
                        .symbolSize(5)  // 点の大きさ
                    }
                    
                    // Display chart with latitude vs longitude
//                    Chart(coordinateTimeData) { dataPoint in
//                        PointMark(
//                            x: .value("Longitude", dataPoint.longitude),  // 経度をX軸にプロット
//                            y: .value("Latitude", dataPoint.latitude)  // 緯度をY軸にプロット
//                        )
//                        .foregroundStyle(.blue)  // 点の色を設定
//                        .symbolSize(5)  // 点の大きさ
//                    }
//                    .frame(width: geometry.size.width * 0.9, height: 300)  // Chartのサイズ調整
//                    .padding()
                    
                    Spacer()
                    
                    Button("Mail") {
                        if let velocityData = gpsVelocityData.saveVelocityTimeDataToCSV(data: velocityTimeData),
                           let vehicleGData = motionViewModel.saveVehicleGTimeDataToCSV(data: vehicleGTimeData),
                           let coordinateData = locationCoordinateData.saveCoordinateTimeDataToCSV(data: coordinateTimeData)                      {
                            
                            velocityCsvData = velocityData
                            vehicleGCsvData = vehicleGData
                            coordinateCsvData = coordinateData
                            
                            // デバッグ用の出力
                            print("Vehicle CSV Data: \(String(data: velocityCsvData, encoding: .utf8) ?? "No Data")")
                            print("G CSV Data: \(String(data: vehicleGCsvData, encoding: .utf8) ?? "No Data")")
                            print("Coordinate CSV Data: \(String(data: coordinateCsvData, encoding: .utf8) ?? "No Data")")
                        }
                    }
                    .background(MailSender(velocityCsvData: $velocityCsvData, vehicleGCsvData: $vehicleGCsvData, coordinateCsvData: $coordinateCsvData))
                    
                } // End of VStack
            } // End of ZStack
        } // End of GeometryReader
        
    } // End of body
    
}

//#Preview {
//    ResultView(coordinateTimeData: [CoordinateTimeData])
//}

// Preview
//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView(coordinateTimeData: [
//            CoordinateTimeData(time: 0.0, latitude: 37.7749, longitude: -122.4194),
//            CoordinateTimeData(time: 1.0, latitude: 37.7750, longitude: -122.4195),
//            CoordinateTimeData(time: 2.0, latitude: 37.7751, longitude: -122.4196)
//        ])
//    }
//}
