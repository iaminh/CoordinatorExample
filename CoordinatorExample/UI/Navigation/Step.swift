//
//  Step.swift
//  CoordinatorExample
//
//  Created by minh on 07/07/2022.
//  Copyright © 2022 MinhChu. All rights reserved.
//

import Foundation

enum Step {
    //base
    
    case popRequired
    case popToRootRequired
    case dismissRequired // dismiss presented viewcontroller in coordinator, handled by base coordinator
    case closeRequired // to handle by inherited module, for passing close action from child coordinator to parent coordinator.
    case dismissChildRequired(coordinator: Coordinator)
    case copyClipboardRequired(text: String)
    case browserRequired(url: String)
    case phoneRequired(phone: String)
    
    // login
    
    case loginRequired
    case registerRequired
    case homeRequired
}
