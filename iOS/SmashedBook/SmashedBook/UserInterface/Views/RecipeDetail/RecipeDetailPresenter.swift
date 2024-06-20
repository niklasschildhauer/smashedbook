//
//  RecipeDetailPresenter.swift
//  SmashedBook
//
//  Created by Niklas Schildhauer on 28.12.23.
//

import Foundation

protocol RecipeDetailPresenterDelegate: AnyObject {
    func didTapShowAttachment(attachment: ImageResourceModel, in presenter: RecipeDetailPresenting)
}

protocol RecipeDetailViewing: AnyObject {
    var presenter: RecipeDetailPresenting? { get set }
}

protocol RecipeDetailPresenting {
    var view: RecipeDetailViewing? { get set }
    var numberOfAttachments: Int { get }
    func didSelectAttachment(at indexPath: IndexPath)
    func attachment(at indexPath: IndexPath) -> ImageResourceModel
}

class RecipeDetailPresenter: RecipeDetailPresenting {
    weak var view: RecipeDetailViewing?
    var delegate: RecipeDetailPresenterDelegate?
    
    let recipe : RecipeModel
    
    var numberOfAttachments: Int {
        recipe.attachments.count
    }
    
    init(recipe: RecipeModel) {
        self.recipe = recipe
    }
    
    func didSelectAttachment(at indexPath: IndexPath) {
        //let selectedAttachment = attachment(at: indexPath)
        delegate?.didTapShowAttachment(attachment: ImageResourceModel(fileName: "Test"), in: self)
        print("We tapepd")
    }
    
    func attachment(at indexPath: IndexPath) -> ImageResourceModel {
        let index = indexPath.row
        return recipe.attachments[index]
    }
}
