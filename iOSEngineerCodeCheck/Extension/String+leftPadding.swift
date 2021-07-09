//
//  String+leftPadding.swift
//  iOSEngineerCodeCheck
//
//  Created by craptone on 2021/07/09.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

extension String {
      func leftPadding(toLength: Int, withPad: String) -> String {
        let stringLength = self.count
        if stringLength < toLength {
            return String(repeating:withPad, count: toLength - stringLength) + self
        } else {
            return String(self.suffix(toLength))
        }
    }
}
