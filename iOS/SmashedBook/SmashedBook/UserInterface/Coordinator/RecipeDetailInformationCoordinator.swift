//
//  RecipeDetailInformationCoordinator.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 25.12.23.
//

import UIKit

protocol RecipeDetailInformationCoordinatorDelegate: AnyObject {
    func didTapShowAttachment(attachment: RecipeAttachmentModel, in coordinator: RecipeDetailInformationCoordinator)
}

class RecipeDetailInformationCoordinator: UIKitCoordinator {
    lazy var rootViewController: UIViewController = {
        let viewController = RecipeDetailViewController()
        viewController.presenter = recipeDetailPresenter
        
        return viewController
    }()
    
    var recipeDetailPresenter: RecipeDetailPresenter
    // TODO: Too much delegate methods here! Maybe implement a similiar mechanism as navigaitonLink
    weak var delegate: RecipeDetailInformationCoordinatorDelegate?
    let recipe: RecipeModel
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
        recipeDetailPresenter = RecipeDetailPresenter(recipe: recipe)
        recipeDetailPresenter.delegate = self
    }
    
    var fullScreenImageViewController = ImageFullScreenViewController()
}

extension RecipeDetailInformationCoordinator: RecipeDetailPresenterDelegate {
    func didTapShowAttachment(attachment: RecipeAttachmentModel, in presenter: RecipeDetailPresenting) {
        delegate?.didTapShowAttachment(attachment: attachment, in: self)
    }
}
