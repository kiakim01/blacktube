//
//  MainTableViewCellDelegate.swift
//  blacktube
//
//  Created by 조규연 on 2023/09/06.
//

import Foundation

protocol MainTableViewCellDelegate: AnyObject {
    func heartButtonTapped(for cell: MainTableViewCell)
}
