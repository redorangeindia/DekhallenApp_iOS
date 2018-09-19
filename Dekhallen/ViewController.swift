




import UIKit
import SwiftyJSON
import BSImagePicker
import BSImageView
import BSGridCollectionViewLayout
import Photos
import Alamofire


enum VC_API_CALL
{
    case zdefault
    case zgetYearDetail
    case zgetHallDetail
    case zgetStatusDetail
    case zgetCarTypeDetail
    case zgetPrioritydetail
    case zgetLevel_1_Detail
    case zgetLevel_2_Detail
    case zgetLevel_3_Detail
    case zAssignedTo
    case zgetTimeSlot
}

class ViewController: UIViewController {
    //MARK: -
    @IBOutlet weak var txtPhoneNUmber: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDescription: PaddingTextView!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var btnBillType: UIButton!
    @IBOutlet weak var btnHall: UIButton!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnLevel_1: UIButton!
    @IBOutlet weak var btnLevel_2: UIButton!
    @IBOutlet weak var btnLevel_3: UIButton!
    @IBOutlet weak var txtBillNumber: UITextField!
    @IBOutlet weak var btnPriority: UIButton!
    @IBOutlet weak var txtDescHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAssignedTo: UIButton!
    @IBOutlet weak var txtScheduleDate: UITextField!
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var txtBilNote: PaddingTextView!
    @IBOutlet weak var btnReportDate: UIButton!
    @IBOutlet weak var numberBG: UILabel!
    @IBOutlet weak var nameBG: UILabel!
    
    
    //MARK: -
    var tableView = UITableView()
    var headerView = UIView()
    var headerTitle = UILabel()
    var btnCancel = UIButton()
    var objectArray = NSMutableArray()
    var responseJSONArray = NSMutableArray()
    var coverView = UIView()
    var alert = UIAlertController()
    var alert1 = UIAlertController()
    var enumAPI = VC_API_CALL.zdefault
    var datePicker : UIDatePicker!
    var selectedFields = NSMutableDictionary()
    var actIndicator = UIActivityIndicatorView()
    
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prefillInitialValues()
        self.roundedCorners()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableUI), name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(disableUI), name: NSNotification.Name(rawValue: "disableUI"), object: nil)
    }
    
    //MARK: -
    @IBAction func btnYearTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getYearDetail({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["yeardetail"].arrayValue.reversed())
            self.enumAPI = .zgetYearDetail
            self.showSelectionPopup("Select Arsmod")
        })
    }
    
    @IBAction func btnBillTypeTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getCarTypeDetail({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["cartypedetail"].arrayValue)
            self.enumAPI = .zgetCarTypeDetail
            self.showSelectionPopup("Select Bil Type")
        })
    }
    
    @IBAction func btnHallTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getHallDetail({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["halldetail"].arrayValue)
            self.enumAPI = .zgetHallDetail
            self.showSelectionPopup("Select Hall")
        })
    }
    
    @IBAction func btnStatusTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getStatusDetail({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["statusdetail"].arrayValue)
            self.enumAPI = .zgetStatusDetail
            self.showSelectionPopup("Status")
        })
    }
    
    @IBAction func btnPriorityTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getPriorityDetail({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["prioritydetail"].arrayValue)
            self.enumAPI = .zgetPrioritydetail
            self.showSelectionPopup("Select Priority")
        })
    }
    
    @IBAction func btnAssignedTapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getAllData({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["wshopuserdetail"].arrayValue)
            self.enumAPI = .zAssignedTo
            self.showSelectionPopup("Assigned To")
        })
    }
    
    @IBAction func btnLevel_1_Tapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getLevelOne({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["levelonedata"]["level_one_name"].arrayValue)
            self.enumAPI = .zgetLevel_1_Detail
            self.showSelectionPopup("Select Level I")
        })
    }
    
    @IBAction func btnLevel_2_Tapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getLevelTwo(levelOneId: btnLevel_1.tag, handler: {
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["leveltwodata"].arrayValue)
            self.btnLevel_3.setTitle("", for: .normal)
            self.enumAPI = .zgetLevel_2_Detail
            self.showSelectionPopup("Select Level II")
        })
    }
    
    @IBAction func btnLevel_3_Tapped(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getLevelThree(levelTwoId: btnLevel_2.tag, handler: {
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["levelthreedata"].arrayValue)
            self.enumAPI = .zgetLevel_3_Detail
            self.showSelectionPopup("Select Level III")
            
        })
    }
    
    @IBAction func btnAddImageTapped(_ sender: Any) {
        let vc = BSImagePickerViewController()
        
        bs_presentImagePickerController(vc, animated: true,
                                        select: { (asset: PHAsset) -> Void in
                                            // User selected an asset.
                                            // Do something with it, start upload perhaps?
        }, deselect: { (asset: PHAsset) -> Void in
            // User deselected an assets.
            // Do something, cancel upload?
        }, cancel: { (assets: [PHAsset]) -> Void in
            // User cancelled. And this where the assets currently selected.
        }, finish: { (assets: [PHAsset]) -> Void in
            print(assets.count)
            self.selectedFields.setValue(self.getAssetThumbnails(assets: assets), forKey: "Images")
        }, completion: nil)
    }
    
    @IBAction func btnAddDetailsTapped(_ sender: Any) {
        selectedFields.setValue(txtDescription.text, forKey: "Description")
        selectedFields.setValue(txtBilNote.text, forKey: "BilNote")
        
        let list:Array<String> = selectedFields.allKeys as! Array<String>
        let findList:Array<String> = ["Name","Number","Date"]
        let listSet = NSSet(array: list)
        let findListSet = NSSet(array: findList)
        
        if findListSet.isSubset(of: listSet as! Set<AnyHashable>) == true{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
            NetworkManager.sharedInstance.postAllData(selectedData: selectedFields, handler:{
                response in
                let responseJSON = JSON(response.result.value!)
                print(responseJSON)
                self.clearAllFields()
                let alert = UIAlertController(title: nil, message: "Data added succesfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            })
        }
        else
        {
            let alert = UIAlertController(title: nil, message: "Name, Number and Schedule Date are mandatory", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //MARK: -
    func getAssetThumbnails(assets: [PHAsset]) -> [UIImage] {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        var imgArray = [UIImage]()
        for asset in assets {
            manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                imgArray.append(result!)
            })
        }
        return imgArray
    }
    
    func prefillInitialValues() {
        
        NetworkManager.sharedInstance.getLevelOne({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["levelonedata"]["level_one_name"].arrayValue)
            
            for indexObj in (self.objectArray){
                if (indexObj as! JSON)["levelone_name"] == "Ring opp"{
                    self.btnLevel_1.setTitle((indexObj as! JSON)["levelone_name"].stringValue, for: .normal)
                    self.btnLevel_1.tag = Int((indexObj as! JSON)["levelone_id"].stringValue)!
                    self.btnLevel_1.setTitleColor(UIColor.black, for: .normal)
                    self.selectedFields.setValue((indexObj as! JSON), forKey: "LevelOne")
                    break
                }
            }
        })
        
        NetworkManager.sharedInstance.getHallDetail({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["halldetail"].arrayValue)
            for indexObj in (self.objectArray){
                if (indexObj as! JSON)["hall_number"] == "1"{
                    self.btnHall.setTitle((indexObj as! JSON)["hall_number"].stringValue, for: .normal)
                    self.btnHall.tag = Int((indexObj as! JSON)["hall_id"].stringValue)!
                    self.btnHall.setTitleColor(UIColor.black, for: .normal)
                    self.selectedFields.setValue((indexObj as! JSON), forKey: "Hall")
                    break
                }
            }
        })
        
        NetworkManager.sharedInstance.getPriorityDetail({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["prioritydetail"].arrayValue)
            for indexObj in (self.objectArray){
                if (indexObj as! JSON)["priority_number"] == "3"{
                    self.btnPriority.setTitle((indexObj as! JSON)["priority_number"].stringValue, for: .normal)
                    self.btnPriority.setTitleColor(UIColor.black, for: .normal)
                    self.selectedFields.setValue((indexObj as! JSON), forKey: "Priority")
                    break
                }
            }
        })
        
        NetworkManager.sharedInstance.getStatusDetail({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["statusdetail"].arrayValue)
            for indexObj in (self.objectArray){
                if (indexObj as! JSON)["status_name"] == "REGISTERED"{
                    self.btnStatus.setTitle((indexObj as! JSON)["status_name"].stringValue, for: .normal)
                    self.btnStatus.setTitleColor(UIColor.black, for: .normal)
                    self.selectedFields.setValue((indexObj as! JSON), forKey: "Status")
                    break
                }
            }
        })
        
        NetworkManager.sharedInstance.getAllData({
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["wshopuserdetail"].arrayValue)
            for indexObj in (self.objectArray){
                if (indexObj as! JSON)["username"] == "Ronny"{
                    self.btnAssignedTo.setTitle((indexObj as! JSON)["username"].stringValue, for: .normal)
                    self.btnAssignedTo.setTitleColor(UIColor.black, for: .normal)
                    self.selectedFields.setValue((indexObj as! JSON), forKey: "AssignedTo")
                    break
                }
            }
        })
        
    }
    
    func clearAllFields() {
        txtBilNote.text = "Bil Note"
        txtDescription.text = "Description"
        
        txtPhoneNUmber.text = ""
        txtName.text = ""
        btnYear.setTitle("Arsmod", for: .normal)
        btnYear.setTitleColor(UIColor.lightGray, for: .normal)

        btnBillType.setTitle("Bil Type", for: .normal)
        btnBillType.setTitleColor(UIColor.lightGray, for: .normal)
        
        btnHall.setTitle("Hall", for: .normal)
        btnHall.setTitleColor(UIColor.lightGray, for: .normal)
        
        btnStatus.setTitle("Status", for: .normal)
        btnStatus.setTitleColor(UIColor.lightGray, for: .normal)
        
        btnLevel_1.setTitle("Level I", for: .normal)
        btnLevel_1.setTitleColor(UIColor.lightGray, for: .normal)
        
        btnLevel_2.setTitle("Level II", for: .normal)
        btnLevel_2.setTitleColor(UIColor.lightGray, for: .normal)
        
        btnLevel_3.setTitle("Level III", for: .normal)
        btnLevel_3.setTitleColor(UIColor.lightGray, for: .normal)
        
        txtBillNumber.text = ""
       
        btnPriority.setTitle("Priority", for: .normal)
        btnPriority.setTitleColor(UIColor.lightGray, for: .normal)
        
        btnAssignedTo.setTitle("Assigned To", for: .normal)
        btnAssignedTo.setTitleColor(UIColor.lightGray, for: .normal)
        
        txtScheduleDate.text = ""
        
        btnReportDate.setTitle("Assigned To", for: .normal)
        btnReportDate.setTitleColor(UIColor.lightGray, for: .normal)
        selectedFields.removeAllObjects()
        self.prefillInitialValues()
    }
    
    func roundedCorners()  {
        
        txtDescription.delegate = self
        framePopupView()
        
        alert = UIAlertController(title: "No Data Found", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert1 = UIAlertController(title: nil, message: "Select Hall", preferredStyle: .alert)
        alert1.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        txtScheduleDate.tintColor = UIColor.clear
        txtBilNote.text = "Bil Note"
        txtDescription.text = "Description"
        
        actIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        actIndicator.center = view.center
        view.addSubview(actIndicator)
        
        txtPhoneNUmber.layer.borderWidth = 1.0
        txtPhoneNUmber.layer.cornerRadius = 10.0
        txtPhoneNUmber.layer.borderColor = UIColor.clear.cgColor

        nameBG.layer.masksToBounds = true
        nameBG.layer.cornerRadius = 5.0
        nameBG.layer.borderColor = UIColor.clear.cgColor

        numberBG.layer.masksToBounds = true
        numberBG.layer.cornerRadius = 5.0
        numberBG.layer.borderColor = UIColor.clear.cgColor

        
        txtName.layer.borderWidth = 1.0
        txtName.layer.cornerRadius = 5.0
        txtName.layer.borderColor = UIColor.clear.cgColor
        
        txtDescription.layer.borderWidth = 1.0
        txtDescription.layer.cornerRadius = 5.0
        txtDescription.layer.borderColor = UIColor.clear.cgColor
        
        btnYear.layer.borderWidth = 1.0
        btnYear.layer.cornerRadius = 5.0
        btnYear.layer.borderColor = UIColor.clear.cgColor
        
        btnBillType.layer.borderWidth = 1.0
        btnBillType.layer.cornerRadius = 5.0
        btnBillType.layer.borderColor = UIColor.clear.cgColor
        
        btnHall.layer.borderWidth = 1.0
        btnHall.layer.cornerRadius = 5.0
        btnHall.layer.borderColor = UIColor.clear.cgColor
        
        btnStatus.layer.borderWidth = 1.0
        btnStatus.layer.cornerRadius = 5.0
        btnStatus.layer.borderColor = UIColor.clear.cgColor
        
        btnLevel_1.layer.borderWidth = 1.0
        btnLevel_1.layer.cornerRadius = 5.0
        btnLevel_1.layer.borderColor = UIColor.clear.cgColor
        
        btnLevel_2.layer.borderWidth = 1.0
        btnLevel_2.layer.cornerRadius = 5.0
        btnLevel_2.layer.borderColor = UIColor.clear.cgColor
        
        
        btnLevel_3.layer.borderWidth = 1.0
        btnLevel_3.layer.cornerRadius = 5.0
        btnLevel_3.layer.borderColor = UIColor.clear.cgColor
        
        txtBillNumber.layer.borderWidth = 1.0
        txtBillNumber.layer.cornerRadius = 5.0
        txtBillNumber.layer.borderColor = UIColor.clear.cgColor
        
        btnPriority.layer.borderWidth = 1.0
        btnPriority.layer.cornerRadius = 5.0
        btnPriority.layer.borderColor = UIColor.clear.cgColor
        
        btnAssignedTo.layer.borderWidth = 1.0
        btnAssignedTo.layer.cornerRadius = 5.0
        btnAssignedTo.layer.borderColor = UIColor.clear.cgColor
        
        
        txtScheduleDate.layer.borderWidth = 1.0
        txtScheduleDate.layer.cornerRadius = 5.0
        txtScheduleDate.layer.borderColor = UIColor.clear.cgColor
        
        
        txtBilNote.layer.borderWidth = 1.0
        txtBilNote.layer.cornerRadius = 5.0
        txtBilNote.layer.borderColor = UIColor.clear.cgColor
        
        
        btnReportDate.layer.borderWidth = 1.0
        btnReportDate.layer.cornerRadius = 5.0
        btnReportDate.layer.borderColor = UIColor.clear.cgColor
    }
    
    @objc func btnCancelTapped(_ sender: Any) {
        coverView.removeFromSuperview()
        headerView.removeFromSuperview()
    }
    
    func framePopupView() {
        
        // Following code places headerTitle + tableView + btnCancel on headerView in given sequence
        
        headerView = UIView(frame: CGRect.zero)
        headerView.backgroundColor = UIColor.white
        headerView.frame.size.width = view.bounds.size.width/6*5.5
        headerView.frame.size.height = view.bounds.size.height/8*6
        headerView.center = view.center
        
        headerTitle = UILabel(frame: CGRect(x:10, y:0, width:headerView.frame.size.width-10, height:50))
        headerTitle.backgroundColor = UIColor.white
        headerTitle.font = UIFont.boldSystemFont(ofSize: 25.0)
        headerTitle.text = "Sample"
        headerView.addSubview(headerTitle)
        
        tableView = UITableView.init(frame:CGRect(x:0, y:50, width:headerView.frame.size.width, height:0), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        headerView.addSubview(tableView)
        
        btnCancel = UIButton(frame: CGRect(x:0, y:tableView.frame.size.height, width:headerView.frame.size.width, height:50))
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(UIColor.orange, for: .normal)
        btnCancel.backgroundColor = UIColor.clear
        btnCancel.addTarget(self, action: #selector(ViewController.btnCancelTapped(_:)), for: .touchUpInside)
        headerView.addSubview(btnCancel)
        
        let seperator = UILabel(frame: CGRect(x:0, y:0, width:headerView.frame.size.width, height:1))
        seperator.backgroundColor = UIColor.lightGray
        btnCancel.addSubview(seperator)
        headerView.bringSubview(toFront: seperator)
        
        let screenRect = UIScreen.main.bounds
        coverView = UIView(frame: screenRect)
        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
    }
    
    func showSelectionPopup(_ title: String) {
        self.view.endEditing(true)
        if objectArray.count > 0 {
            tableView.frame.size.height = objectArray.count>=9 ?(view.bounds.size.height/8*6)/8*6:CGFloat(objectArray.count * 48)
            headerTitle.text = title
            btnCancel.frame.origin.y = tableView.frame.size.height + 50         // 50 = headerTitle
            headerView.frame.size.height = tableView.frame.size.height + 100        //100=(50=headerTitle)+(50=btnCancel)
            headerView.center = view.center
            tableView.reloadData()
            self.view.addSubview(coverView)
            self.view.addSubview(self.headerView)
        }
        else
        {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func removeSelectionPopup() {
        actIndicator.stopAnimating()
        coverView.removeFromSuperview()
        headerView.removeFromSuperview()
    }
    
    //MARK:-
    @objc func keyboardWillShow(notification:NSNotification){
        
        guard let keyboardFrame = notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        scrlView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height + 100
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        scrlView.contentInset.bottom = 0
    }
    
    @objc func enableUI(notification:NSNotification){
        self.view.isUserInteractionEnabled = true
        actIndicator.stopAnimating()
        print("ui ENABLED")
    }
    @objc func disableUI(notification:NSNotification){
        self.view.isUserInteractionEnabled = false
        self.view.endEditing(true)
        txtPhoneNUmber.resignFirstResponder()
        txtName.resignFirstResponder()
        txtBillNumber.resignFirstResponder()
        txtDescription.resignFirstResponder()
        txtBilNote.resignFirstResponder()
        actIndicator.startAnimating()
        print("ui DISABLED")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        if Int(textView.contentSize.height / (textView.font?.lineHeight)!) > 3 {
            let fixedWidth = textView.frame.size.width
            textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
            var newFrame = textView.frame
            newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
            textView.frame = newFrame
            txtDescHeight.constant = newFrame.size.height + 20
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtDescription.text.isEmpty {
            textView.text = "Description"
            textView.textColor = UIColor.lightGray
        }
        if txtBilNote.text.isEmpty {
            textView.text = "Bil Note"
            textView.textColor = UIColor.lightGray
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        let currentText:String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        if updatedText.isEmpty {
            if textView == txtDescription{
                textView.text = "Description"
            }
            if textView == txtBilNote{
                textView.text = "Bil Note"
            }
            textView.textColor = UIColor.lightGray
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        }
            
        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
            textView.textColor = UIColor.black
            textView.text = text
        }
        else {
            return true
        }
        return false
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        switch enumAPI {
        case .zdefault:
            cell.textLabel!.text = "\(indexPath.row)"
            break
            
        case .zgetYearDetail:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["car_year"].stringValue
            break
            
        case .zgetHallDetail:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["hall_number"].stringValue
            break
            
        case .zgetStatusDetail:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["status_name"].stringValue
            break
            
        case .zgetCarTypeDetail:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["car_name"].stringValue
            break
            
        case .zgetLevel_1_Detail:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["levelone_name"].stringValue
            break
            
        case .zgetLevel_2_Detail:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["leveltwo_name"].stringValue
            break
            
        case .zgetLevel_3_Detail:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["levelthree_name"].stringValue
            break
            
        case .zgetPrioritydetail:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["priority_number"].stringValue
            break
            
        case .zAssignedTo:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["username"].stringValue
            break
            
        case .zgetTimeSlot:
            cell.textLabel!.text = (objectArray.object(at: indexPath.row) as! JSON)["time_slot"].stringValue
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch enumAPI {
        case .zdefault:
            break
            
        case .zgetYearDetail:
            btnYear.setTitle((objectArray.object(at: indexPath.row) as! JSON)["car_year"].stringValue, for: .normal)
            btnYear.setTitleColor(UIColor.black, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "Year")
            self.removeSelectionPopup()
            break
            
        case .zgetHallDetail:
            btnHall.setTitle((objectArray.object(at: indexPath.row) as! JSON)["hall_number"].stringValue, for: .normal)
            btnHall.setTitleColor(UIColor.black, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "Hall")
            self.removeSelectionPopup()
            selectedFields.removeObject(forKey: "Date")
            txtScheduleDate.text = ""
            btnReportDate.setTitle("Reporting Date", for: .normal)
            btnReportDate.setTitleColor(UIColor.lightGray, for: .normal)
            break
            
        case .zgetStatusDetail:
            btnStatus.setTitle((objectArray.object(at: indexPath.row) as! JSON)["status_name"].stringValue, for: .normal)
            btnStatus.setTitleColor(UIColor.black, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "Status")
            self.removeSelectionPopup()
            
        case .zgetCarTypeDetail:
            btnBillType.setTitle((objectArray.object(at: indexPath.row) as! JSON)["car_name"].stringValue, for: .normal)
            btnBillType.setTitleColor(UIColor.black, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "CarType")
            self.removeSelectionPopup()
            
        case .zgetPrioritydetail:
            self.btnPriority.setTitle((objectArray.object(at: indexPath.row) as! JSON)["priority_number"].stringValue, for: .normal)
            self.btnPriority.setTitleColor(UIColor.black, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "Priority")
            self.removeSelectionPopup()
            break
            
        case .zgetLevel_1_Detail:
            btnLevel_1.setTitle((objectArray.object(at: indexPath.row) as! JSON)["levelone_name"].stringValue, for: .normal)
            btnLevel_1.tag = Int((objectArray.object(at: indexPath.row) as! JSON)["levelone_id"].stringValue)!
            btnLevel_1.setTitleColor(UIColor.black, for: .normal)
            self.btnLevel_2.setTitle("Level II", for: .normal)
            btnLevel_2.setTitleColor(UIColor.lightGray, for: .normal)
            self.btnLevel_3.setTitle("Level III", for: .normal)
            btnLevel_3.setTitleColor(UIColor.lightGray, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "LevelOne")
            self.removeSelectionPopup()
            
        case .zgetLevel_2_Detail:
            btnLevel_2.setTitle((objectArray.object(at: indexPath.row) as! JSON)["leveltwo_name"].stringValue, for: .normal)
            btnLevel_2.tag = Int((objectArray.object(at: indexPath.row) as! JSON)["leveltwo_id"].stringValue)!
            btnLevel_2.setTitleColor(UIColor.black, for: .normal)
            self.btnLevel_3.setTitle("Level III", for: .normal)
            btnLevel_3.setTitleColor(UIColor.lightGray, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "LevelTwo")
            self.removeSelectionPopup()
            break
            
        case .zgetLevel_3_Detail:
            btnLevel_3.setTitle((objectArray.object(at: indexPath.row) as! JSON)["levelthree_name"].stringValue, for: .normal)
            btnLevel_3.setTitleColor(UIColor.black, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "LevelThree")
            self.removeSelectionPopup()
            break
            
        case .zAssignedTo:
            btnAssignedTo.setTitle((objectArray.object(at: indexPath.row) as! JSON)["username"].stringValue, for: .normal)
            btnAssignedTo.setTitleColor(UIColor.black, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "AssignedTo")
            self.removeSelectionPopup()
            break
            
        case .zgetTimeSlot:
            txtScheduleDate.text = txtScheduleDate.text! + " " + "\((objectArray.object(at: indexPath.row) as! JSON)["time_slot"])"
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateStyle = .medium
            dateFormatter1.timeStyle = .none
            dateFormatter1.dateFormat = "dd.MM.yyyy hh:mm a"
            btnReportDate.setTitle(dateFormatter1.string(from: datePicker.date), for: .normal)
            btnReportDate.setTitleColor(UIColor.black, for: .normal)
            selectedFields.setValue((objectArray.object(at: indexPath.row) as! JSON), forKey: "TimeSlot")
            self.removeSelectionPopup()
            break
        }
        print(selectedFields)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case txtBillNumber:
            selectedFields.setValue(txtBillNumber.text, forKey: "BilNumber")
            break
        case txtName:
            selectedFields.setValue(txtName.text, forKey: "Name")
            break
        case txtPhoneNUmber:
            selectedFields.setValue(txtPhoneNUmber.text, forKey: "Number")
            break
        default:
            break
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtScheduleDate{
            if (selectedFields.value(forKey: "Hall") != nil){
                self.pickUpDate(self.txtScheduleDate)
            }
            else{
                txtScheduleDate.resignFirstResponder()
                self.present(alert1, animated: true, completion: nil)
            }
        }
    }
    
    func pickUpDate(_ textField : UITextField){
        
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        dateFormatter1.dateFormat = "dd.MM.yyyy"
        txtScheduleDate.text = dateFormatter1.string(from: datePicker.date)
        txtScheduleDate.resignFirstResponder()
        selectedFields.setValue(txtScheduleDate.text, forKey: "Date")
        
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "disableUI"), object: nil)
        
        NetworkManager.sharedInstance.getSlotForSelectedDate(date: txtScheduleDate.text!, hallId: ((selectedFields["Hall"]) as! JSON)["hall_id"].stringValue, handler: {
            response in
            let responseJSON = JSON(response.result.value!)
            self.objectArray.removeAllObjects()
            self.objectArray.addObjects(from: responseJSON["hallwithavailableSlots"].arrayValue)
            self.btnLevel_3.setTitle("", for: .normal)
            self.enumAPI = .zgetTimeSlot
            self.showSelectionPopup("Select Time Slot")
        })
        
    }
    @objc func cancelClick() {
        txtScheduleDate.resignFirstResponder()
    }
}


class PaddingTextView: UITextView, UITextViewDelegate{
    override func draw(_ rect: CGRect) {
        self.textColor = UIColor.lightGray
        self.textContainerInset = UIEdgeInsetsMake(0, 2, 0, 0)
    }
}





