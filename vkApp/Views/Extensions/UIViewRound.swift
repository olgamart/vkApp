//
//  UIViewRound.swift
//  vkApp
//
//  Created by Olga Martyanova on 04/08/2018.
//  Copyright © 2018 olgamart. All rights reserved.
//

import UIKit

extension UIView {
    func circle(){
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
