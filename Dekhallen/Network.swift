



import UIKit
import Alamofire
import SwiftyJSON

class NetworkManager: NSObject {
    
    class var sharedInstance : NetworkManager {
        struct Singleton {
            static let instance : NetworkManager  = NetworkManager()
        }
        return Singleton.instance
    }
    
    func getPriorityDetail(_ handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/getpriorityDetail"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getHallDetail(_ handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/gethallDetail"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getStatusDetail(_ handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/getstatusDetail"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
                
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getUserDetail(_ handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/getuserDetail"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                //print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getYearDetail(_ handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/getyearDetail"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getCarTypeDetail(_ handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/getcartypeDetail"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getLevelOne(_ handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/leveloneData"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getLevelTwo(levelOneId:Int, handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/leveltwoData/\(levelOneId)"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getLevelThree(levelTwoId:Int, handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/levelthreeData/\(levelTwoId)"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getSlotForSelectedDate(date: String, hallId: String, handler:@escaping(DataResponse<Any>)->())
    {
        let url = "http://pmrescue.no/pmtasks/Api/gettimeslotbyavailbleHall/\(hallId)/\(date)"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                //print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func getAllData(_ handler:@escaping(DataResponse<Any>) -> ())
    {
        let url = "http://pmrescue.no/pmtasks/Api/commonapiData"
        Alamofire.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                handler(response)
                break
            case .failure(_):
                print(response.result.error!)
                break
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    func postAllData(selectedData: NSMutableDictionary, handler:@escaping(DataResponse<Any>) -> ())
    {
        let params:[String:String] = [
            "billnr": selectedData.value(forKey: "BilNumber") != nil ?(selectedData.value(forKey: "BilNumber") as! String):"0",
            "name": selectedData.value(forKey: "Name") != nil ? (selectedData.value(forKey: "Name") as! String):"",
            "sel_users_id": selectedData.value(forKey: "AssignedTo") != nil ?((selectedData["AssignedTo"]) as! JSON)["username"].stringValue:"Ronny",
            "sel_status_id":selectedData.value(forKey: "Status") != nil ?((selectedData["Status"]) as! JSON)["status_name"].stringValue:"REGISTERED" ,
            "levelthreeid": selectedData.value(forKey: "LevelThree") != nil ?((selectedData["LevelThree"]) as! JSON)["id"].stringValue:"0",
            "cus_car_des": selectedData.value(forKey: "Description") != nil ?(selectedData.value(forKey: "Description") as! String):"Description",
            "priorityid": selectedData.value(forKey: "Priority") != nil ?((selectedData["Priority"]) as! JSON)["priority_id"].stringValue:"3",
            "number": selectedData.value(forKey: "Number") != nil ? (selectedData.value(forKey: "Number") as! String):"",
            "arsmodid": selectedData.value(forKey: "Year") != nil ?((selectedData["Year"]) as! JSON)["car_year"].stringValue:"0",
            "leveltwoid": selectedData.value(forKey: "LevelTwo") != nil ?((selectedData["LevelTwo"]) as! JSON)["leveltwo_id"].stringValue:"0",
            "leveloneid": selectedData.value(forKey: "LevelOne") != nil ?((selectedData["LevelOne"]) as! JSON)["levelone_id"].stringValue:"21",
            "hallid": selectedData.value(forKey: "Hall") != nil ?((selectedData["Hall"]) as! JSON)["hall_id"].stringValue:"1",
            "billtypeid": selectedData.value(forKey: "CarType") != nil ?((selectedData["CarType"]) as! JSON)["id"].stringValue:"0",
            "slot_id": selectedData.value(forKey: "TimeSlot") != nil ?((selectedData["TimeSlot"]) as! JSON)["id"].stringValue:"1",
            "time": selectedData.value(forKey: "Date") != nil ? (selectedData.value(forKey: "Date") as! String):"",
            "notes": selectedData.value(forKey: "BilNote") != nil ?(selectedData.value(forKey: "BilNote") as! String):"Bil Note",
            "systemdateTime":selectedData.value(forKey: "systemdateTime") as! String
        ]
        
        print(params)
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            if (selectedData.value(forKey: "Images") != nil)
            {
            for (index,imgObj) in (selectedData.value(forKey: "Images") as! Array<Any>).enumerated()
            {
                let imgData = UIImageJPEGRepresentation(imgObj as! UIImage, 0.2)!
                multipartFormData.append(imgData, withName: "workshop_user_images_"+"\(index)", fileName: self.randomString(length: 3), mimeType: "image/jpg")
                }}
            for (key, value) in params {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        },
                         to:"http://pmrescue.no/pmtasks/Api/insertcustomerdetailiPhone")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print(response.result.value as Any)
                    handler(response)
                }
            case .failure(let encodingError):
                print(encodingError)
            }
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "enableUI"), object: nil)
        }
    }
    
    
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        var randomString = ""
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        print(randomString+".jpg")
        return randomString+".jpg"
    }
}

