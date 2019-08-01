//
//  itemDetailViewController.swift
//  classproject
//
//  Created by rchapell on 11/12/18.
//  Copyright © 2018 rchapell. All rights reserved.
//

import UIKit

class itemDetailViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var quantlabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var imageSource: UISegmentedControl!
    var quant:Int?
    var name:String?
    var selectedIndex:Int?
    var selectedImage:UIImage?
    let picker = UIImagePickerController()
    
    
    @IBAction func decQuant(_ sender: Any) {
        if(quant!>0){
            quant! = quant! - 1
            quantlabel.text = String(quant!)
        }
    }
    
    @IBAction func incQuant(_ sender: Any) {
        quant! = quant! + 1
        quantlabel.text = String(quant!)
    }
    
    
    @IBAction func changeImg(_ sender: Any) {
        if imageSource.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerControllerSourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker,animated: true,completion: nil)
            } else {
                print("No camera")
            }
            
        }else{
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            picker.popoverPresentationController?.sourceView = self.view
            picker.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 2, height: 2)
            self.present(picker, animated: true, completion: nil)
        }
    
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        picker.dismiss(animated: true, completion: nil)
       imageview.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        print("finished adding picture")
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        quantlabel.text = String(quant!)
        namelabel.text = name
        imageview.image = selectedImage!
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
