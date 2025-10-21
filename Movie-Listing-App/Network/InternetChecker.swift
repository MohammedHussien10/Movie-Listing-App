//
//  InternetChecker.swift
//  Movie-Listing-App
//
//  Created by Macos on 18/10/2025.
//

import Foundation
import Network



final class InternetChecker {
    
    static let shared = InternetChecker()
    
    private let checker = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetChecker")
    
    private(set) var isConnected: Bool = false
    private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case unknown
    }
    
    private init() {
        checker.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            let isCurrentlyConnected = (path.status == .satisfied)
            self.isConnected = isCurrentlyConnected
            self.getConnectionType(path)
            
            // إذا كان هناك تغيير في الاتصال، سيتم إعلام المتابعين
            if isCurrentlyConnected {
                print("We're online via \(self.connectionType)")
            } else {
                print("No connection")
            }
            
            // نشر إشعار للإعلام عن التغيير في حالة الاتصال
            NotificationCenter.default.post(name: .internetConnectionChanged, object: nil)
        }
        
        checker.start(queue: queue)
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else {
            connectionType = .unknown
        }
    }
    
    // إضافة دالة للاستماع لحالة الاتصال من أي مكان في التطبيق
    func isConnectedToInternet() -> Bool {
        return isConnected
    }
}

// إضافة إشعار للإعلام بتغيير الاتصال
extension Notification.Name {
    static let internetConnectionChanged = Notification.Name("internetConnectionChanged")
}



//final class InternetChecker{
//    
//    static let shared = InternetChecker()
//    
//    private let checker = NWPathMonitor()
//    
//    private let queue = DispatchQueue(label:"InternetChecker")
//    
//    private(set) var isConnected: Bool = false
//    private(set) var connectionType: ConnectionType = .unknown
//    
//    enum ConnectionType {
//           case wifi
//           case cellular
//           case unknown
//    }
//    
//    private init(){
//        
//        checker.pathUpdateHandler = { [weak self] path in
//            self?.isConnected = (path.status == .satisfied)
//            self?.getConnectionType(path)
//            
//            if path.status == .satisfied{
//                print("We're online via \(self?.connectionType ?? .unknown)")
//                
//            }else{
//                print("No connection")
//            }
//            
//        }
//        
//        checker.start(queue: queue)
//        
//    }
//    
//    private func getConnectionType(_ path:NWPath){
//
//        if path.usesInterfaceType(.wifi){
//            connectionType = .wifi
//        } else if path.usesInterfaceType(.cellular){
//            connectionType = .cellular
//        } else {
//            connectionType = .unknown
//        }
//        
//        
//        
//    }
//    
//    
//       
//}
