//
//  BrowseViewController.swift
//  FaceChecker_UPD
//
//  Created by Systems
//

import UIKit

final class BrowseViewController_FaceChecker_UPD:
    UIImagePickerController,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
    convenience init(type: BrowseType) {
        self.init()
        self.sourceType = type.sourceType
        self.delegate = self
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage {
            Log_FaceChecker_UPD.global.info("Image picked. \(image.size.debugDescription)")
            AppRouter_FaceChecker_UPD.shared.move(to: .check(image: image), type: .push(animated: true))
        } else {
            Log_FaceChecker_UPD.global.error("No image found")
        }
    }
}
