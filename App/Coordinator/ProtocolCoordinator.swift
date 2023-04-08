//
//  ProtocolCoordinator.swift
//  App
//
//  Created by Эля Корельская on 22.03.2023.
//

import UIKit

protocol Coordinatble: AnyObject {
    var childCoordinators: [Coordinatble] { get }
    func start() -> UIViewController
    func addChildCoordinator(_ coordinator: Coordinatble)
    func removeChildCoordinator(_ coordinator: Coordinatble)
}

