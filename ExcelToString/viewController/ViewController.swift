//
//  ViewController.swift
//  ExcelToString
//
//  Created by Yeongeun Song on 2021/09/27.
//

import UIKit
import SwiftyXMLParser

class ViewController: UIViewController {

    /* Config */
    private let excelTxtName = Config.excelTxtName
    private let separateChar = Config.separateChar
    private let originKoiOSTxtName = Config.originKoiOSTxtName
    private let originEniOSTxtName = Config.originEniOSTxtName
    private let originKoAndTxtName = Config.originKoAndTxtName
    private let originEnAndTxtName = Config.originEnAndTxtName
    
    private var arrayUpdateItem = [EachLocale]()
    
    /* iOS */
    private var arrayOriginFilterKoiOS = [EachLocale]()
    private var arrayOriginFilterEngiOS = [EachLocale]()
    private var arrayFilterMergeIOS = [EachLocale]()
    @IBOutlet weak var btnOriginKoCheckiOS: UIButton!
    @IBOutlet weak var btnOriginEnCheckiOS: UIButton!
    @IBOutlet weak var btnExportKoiOS: UIButton!
    @IBOutlet weak var btnExportEngiOS: UIButton!
    @IBOutlet weak var btnFilterMergeIOS: UIButton!
    @IBOutlet weak var btnFilterExportIOS: UIButton!
    
    /* Android */
    private var arrayOriginFilterKoAnd = [EachLocale]()
    private var arrayOriginFilterEngAnd = [EachLocale]()
    private var arrayFilterMergeAnd = [EachLocale]()
    @IBOutlet weak var btnOriginKoCheckAnd: UIButton!
    @IBOutlet weak var btnOriginEnCheckAnd: UIButton!
    @IBOutlet weak var btnExportKoAnd: UIButton!
    @IBOutlet weak var btnExportEngAnd: UIButton!
    @IBOutlet weak var btnFilterMergeAnd: UIButton!
    @IBOutlet weak var btnFilterExportAnd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBAction
    @IBAction func tapBtnTranslate(_ sender: Any) {
        translateExcelFileData()
    }
    
    //MARK: - IBAction iOS
    @IBAction func tapAutoiOS(_ sender: Any) {
        workAll(osType: .ios)
    }
    
    @IBAction func tapBtnExportKoiOS(_ sender: Any) {
        if arrayUpdateItem.count == 0 {
            return
        }
        
        printExportFormat(array: arrayUpdateItem, type: .kor, osType: .ios)
    }
    
    @IBAction func tapBtnExportEngiOS(_ sender: Any) {
        if arrayUpdateItem.count == 0 {
            return
        }
        
        printExportFormat(array: arrayUpdateItem, type: .eng, osType: .ios)
    }
    
    @IBAction func tapBtnOriginKoiOSCheck(_ sender: Any) {
        if let array = arrayFromString(fileName: originKoiOSTxtName, type: .kor) {
            if let filterArray = filterDifference(arrayEntire: arrayUpdateItem,
                                                  arrayEach: array) {
                arrayOriginFilterKoiOS = filterArray
            }
        }
        
        printfilterSortedArray(arry: arrayOriginFilterKoiOS, type: .kor)
        checkEnableFilterMerge(arrFilterKo: arrayOriginFilterKoiOS,
                               arrFilterEng: arrayOriginFilterEngiOS,
                               osType: .ios)
    }
    
    @IBAction func tapBtnOriginEniOSCheck(_ sender: Any) {
        if let array = arrayFromString(fileName: originEniOSTxtName, type: .eng) {
            if let filterArray = filterDifference(arrayEntire: arrayUpdateItem,
                                                  arrayEach: array) {
                arrayOriginFilterEngiOS = filterArray
            }
        }
        
        printfilterSortedArray(arry: arrayOriginFilterEngiOS, type: .eng)
        checkEnableFilterMerge(arrFilterKo: arrayOriginFilterKoiOS,
                               arrFilterEng: arrayOriginFilterEngiOS,
                               osType: .ios)
    }
    
    @IBAction func tapBtnMergeFilterIOS(_ sender: Any) {
        filterDataMergeIOS()
    }
    
    @IBAction func tapExportFilterIOS(_ sender: Any) {
        printExportFormat(array: arrayFilterMergeIOS, type: .kor, osType: .ios)
        printExportFormat(array: arrayFilterMergeIOS, type: .eng, osType: .ios)
    }
    
    //MARK: - IBAction Android
    @IBAction func tapAutoAndroid(_ sender: Any) {
        workAll(osType: .android)
    }
    
    @IBAction func tapBtnOriginKoAndCheck(_ sender: Any) {
        if let array = arrayFromXml(fileName: originKoAndTxtName, type: .kor) {
            if let filterArray = filterDifference(arrayEntire: arrayUpdateItem,
                                                  arrayEach: array) {
                arrayOriginFilterKoAnd = filterArray
            }
        }
        
        printfilterSortedArray(arry: arrayOriginFilterKoAnd, type: .kor)
        checkEnableFilterMerge(arrFilterKo: arrayOriginFilterKoAnd,
                               arrFilterEng: arrayOriginFilterEngAnd,
                               osType: .android)
    }
    
    @IBAction func tapBtnOriginEnAndCheck(_ sender: Any) {
        if let array = arrayFromXml(fileName: originEnAndTxtName, type: .eng) {
            if let filterArray = filterDifference(arrayEntire: arrayUpdateItem,
                                                  arrayEach: array) {
                arrayOriginFilterEngAnd = filterArray
            }
        }
        
        printfilterSortedArray(arry: arrayOriginFilterEngAnd, type: .eng)
        checkEnableFilterMerge(arrFilterKo: arrayOriginFilterKoAnd,
                               arrFilterEng: arrayOriginFilterEngAnd,
                               osType: .android)
    }
    
    @IBAction func tapBtnMergeFilterAnd(_ sender: Any) {
        filterDataMergeAndroid()
    }
    
    @IBAction func tapExportFilterAndroid(_ sender: Any) {
        printExportFormat(array: arrayFilterMergeAnd, type: .kor, osType: .android)
        printExportFormat(array: arrayFilterMergeAnd, type: .eng, osType: .android)
    }
    
    @IBAction func tapBtnExportKoAnd(_ sender: Any) {
        if arrayUpdateItem.count == 0 {
            return
        }
        
        printExportFormat(array: arrayUpdateItem, type: .kor, osType: .android)
    }
    
    @IBAction func tapBtnExportEngAnd(_ sender: Any) {
        if arrayUpdateItem.count == 0 {
            return
        }
        
        printExportFormat(array: arrayUpdateItem, type: .eng, osType: .android)
    }
    
    
    private func workAll(osType:OSType) {
        translateExcelFileData() /* excel 데이터 가져와 obj Array 전환 */
        if arrayUpdateItem.count == 0 {
            return
        }
        
        printExportFormat(array: arrayUpdateItem, type: .kor, osType: osType) /* iOS 복붙용 한글 print */
        printExportFormat(array: arrayUpdateItem, type: .eng, osType: osType) /* iOS 복붙용 영문 print */
        
        
        switch osType {
        case .android:
            if let array = arrayFromXml(fileName: originKoAndTxtName, type: .kor) {
                if let filterArray = filterDifference(arrayEntire: arrayUpdateItem,
                                                      arrayEach: array) {
                    arrayOriginFilterKoAnd = filterArray /* 한글 코드와 다른부분 필터 */
                }
            }
            
            if let array = arrayFromXml(fileName: originEnAndTxtName, type: .eng) {
                if let filterArray = filterDifference(arrayEntire: arrayUpdateItem,
                                                      arrayEach: array) {
                    arrayOriginFilterEngAnd = filterArray /* 영문 코드와 다른부분 필터 */
                }
            }
            
            printfilterSortedArray(arry: arrayOriginFilterKoAnd, type: .kor) /* 한글 필터 print */
            printfilterSortedArray(arry: arrayOriginFilterEngAnd, type: .eng) /* 영문 필터 print */
            checkEnableFilterMerge(arrFilterKo: arrayOriginFilterKoAnd,
                                   arrFilterEng: arrayOriginFilterEngAnd,
                                   osType: .android) /* merge버튼 활성화 */
            
            filterDataMergeAndroid() /* 한글, 영문 합치기 */
            
            printExportFormat(array: arrayFilterMergeAnd, type: .kor, osType: osType) /* 필터값 복붙용 한글 print */
            printExportFormat(array: arrayFilterMergeAnd, type: .eng, osType: osType) /* 필터값 복붙용 영문 print */
        case .ios:
            if let array = arrayFromString(fileName: originKoiOSTxtName, type: .kor) {
                if let filterArray = filterDifference(arrayEntire: arrayUpdateItem,
                                                      arrayEach: array) {
                    arrayOriginFilterKoiOS = filterArray /* 한글 코드와 다른부분 필터 */
                }
            }
            
            if let array = arrayFromString(fileName: originEniOSTxtName, type: .eng) {
                if let filterArray = filterDifference(arrayEntire: arrayUpdateItem,
                                                      arrayEach: array) {
                    arrayOriginFilterEngiOS = filterArray /* 영문 코드와 다른부분 필터 */
                }
            }
            
            printfilterSortedArray(arry: arrayOriginFilterKoiOS, type: .kor) /* 한글 필터 print */
            printfilterSortedArray(arry: arrayOriginFilterEngiOS, type: .eng) /* 영문 필터 print */
            checkEnableFilterMerge(arrFilterKo: arrayOriginFilterKoiOS,
                                   arrFilterEng: arrayOriginFilterEngiOS,
                                   osType: .ios) /* merge버튼 활성화 */
            
            filterDataMergeIOS() /* 한글, 영문 합치기 */
            
            printExportFormat(array: arrayFilterMergeIOS, type: .kor, osType: osType) /* 필터값 복붙용 한글 print */
            printExportFormat(array: arrayFilterMergeIOS, type: .eng, osType: osType) /* 필터값 복붙용 영문 print */
        }
        
        
    }

    private func translateExcelFileData() {
        arrayUpdateItem.removeAll()
        let path = Bundle.main.path(forResource: excelTxtName, ofType: "txt")
        
        do{
            let fileString = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            let arryString = fileString.components(separatedBy: "\n")
        
            print("")
            print("***** 엑셀 데이터 갯수 *****")
            print("\(arryString.count)")
            print("************************")
            print("")
            for each in arryString {
                let strEach = each.components(separatedBy: separateChar)
                if strEach.count == 3 {
                    let strId = strEach[0].replacingOccurrences(of: "\t", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                    let strKor = strEach[1].replacingOccurrences(of: "\t", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                    let strEng = strEach[2].replacingOccurrences(of: "\t", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                    let eachItem:EachLocale = EachLocale(strId: strId, kor: strKor, eng: strEng)
                    arrayUpdateItem.append(eachItem)
                } else {
                }
            }
            
            arrayUpdateItem.sort { $0.strId < $1.strId }
        
            if arrayUpdateItem.count != 0 {
                activeButtons()
            }
        } catch {
            
        }
    }
    
    private func arrayFromXml(fileName:String,
                              type:LanguageType) -> [EachLocale]? {
    
        var resultArray = [EachLocale]()
        let path = Bundle.main.path(forResource: fileName, ofType: "xml")
        do {
            let fileString = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            let xml = try XML.parse(fileString)
            let element = xml["resources","string"]
            if let strings = element.all {
                for each in strings {
                    var eachId = ""
                    var eachValue = ""
                    if let id = each.attributes["name"] {
                        eachId = id
                    }
                    
                    if let value = each.text {
                        eachValue = value
                    }
                    
                    switch type {
                    case .none:
                        return nil
                    case .kor:
                        resultArray.append(EachLocale(strId: eachId, kor: eachValue, eng: ""))
                    case .eng:
                        resultArray.append(EachLocale(strId: eachId, kor: "", eng: eachValue))
                    }
                }
            }
        } catch {
            print("Error encoding!!")
        }
        
        return resultArray
    }
    
    private func arrayFromString(fileName:String,
                                 type:LanguageType) -> [EachLocale]? {
        var resultArray = [EachLocale]()
        let path = Bundle.main.path(forResource: fileName, ofType: "txt")
        do{
            let fileString = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            let arryString = fileString.components(separatedBy: ";")
            
            print("")
            print("***** iOS 코드에 사용중인 \(type.rawValue) String 갯수 *****")
            print(arryString.count)
            print("*****************************************")
            print("")
            
            for each in arryString {
                let strEach = each.components(separatedBy: "=")
                if strEach.count == 2 {
                    let id = strEach[0].replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "\n", with: "")
                    var lang = strEach[1].replacingOccurrences(of: "\"", with: "")
                    /* 첫번째 글자가 공백 이면 remove */
                    if lang.count != 0 {
                        if lang.first == " " {
                            lang.removeFirst()
                        }
                    }
                    
                    switch type {
                    case .none:
                        return nil
                    case .kor:
                        resultArray.append(EachLocale(strId: id, kor: lang, eng: ""))
                    case .eng:
                        resultArray.append(EachLocale(strId: id, kor: "", eng: lang))
                    }
                } else {
                    let errEach = each.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\n", with: "")
                    if !errEach.isEmpty {
                        print("error \(each)")
                    }
                }
            }
        } catch {
            print("Error encoding!!")
        }
        return resultArray
    }
    
    private func filterDifference(arrayEntire:[EachLocale],
                                  arrayEach:[EachLocale]) -> [EachLocale]? {
        let filter = arrayEach.filter { origin in
            let originId = origin.strId
            return !arrayEntire.contains(where: { each in
                each.strId == originId
            })
        }
        let filterSorted = filter.sorted { $0.strId < $1.strId }
        return filterSorted
    }
    
    private func filterDataMergeIOS() {
        btnFilterExportIOS.isEnabled = true
        arrayFilterMergeIOS.removeAll()
        var mergeLanType:LanguageType = .none
        var count = 0
        if arrayOriginFilterKoiOS.count > arrayOriginFilterEngiOS.count {
            count = arrayOriginFilterKoiOS.count
            arrayFilterMergeIOS.append(contentsOf: arrayOriginFilterKoiOS)
            mergeLanType = .kor
        } else {
            count = arrayOriginFilterEngiOS.count
            arrayFilterMergeIOS.append(contentsOf: arrayOriginFilterEngiOS)
            mergeLanType = .eng
        }
        
        var tempArray = [EachLocale]()
        if mergeLanType == .kor {
            /* merge에 KO가 설정되어있음 */
            tempArray.append(contentsOf: arrayOriginFilterEngiOS)
            for index in 0..<count {
                for each in tempArray {
                    if arrayFilterMergeIOS[index].strId == each.strId {
                        arrayFilterMergeIOS[index].eng = each.eng
                    } else {
                        if !arrayFilterMergeIOS.contains(where: { $0.strId == each.strId }) {
                            print(each)
                            arrayFilterMergeIOS.append(each)
                        }
                    }
                }
            }
        } else {
            /* merge에 ENG 가 설정되어있음 */
            tempArray.append(contentsOf: arrayOriginFilterKoiOS)
            for index in 0..<count {
                for each in tempArray {
                    if arrayFilterMergeIOS[index].strId == each.strId {
                        arrayFilterMergeIOS[index].kor = each.kor
                    } else {
                        if !arrayFilterMergeIOS.contains(where: { $0.strId == each.strId }) {
                            print(each)
                            arrayFilterMergeIOS.append(each)
                        }
                    }
                }
            }
        }
        printfilterSortedAll(arry: arrayFilterMergeIOS)
    }
    
    private func filterDataMergeAndroid() {
        btnFilterExportAnd.isEnabled = true
        arrayFilterMergeAnd.removeAll()
        var mergeLanType:LanguageType = .none
        var count = 0
        if arrayOriginFilterKoAnd.count > arrayOriginFilterEngAnd.count {
            count = arrayOriginFilterKoAnd.count
            arrayFilterMergeAnd.append(contentsOf: arrayOriginFilterKoAnd)
            mergeLanType = .kor
        } else {
            count = arrayOriginFilterEngAnd.count
            arrayFilterMergeAnd.append(contentsOf: arrayOriginFilterEngAnd)
            mergeLanType = .eng
        }
        
        var tempArray = [EachLocale]()
        if mergeLanType == .kor {
            /* merge에 KO가 설정되어있음 */
            tempArray.append(contentsOf: arrayOriginFilterEngAnd)
            for index in 0..<count {
                for each in tempArray {
                    if arrayFilterMergeAnd[index].strId == each.strId {
                        arrayFilterMergeAnd[index].eng = each.eng
                    } else {
                        if !arrayFilterMergeAnd.contains(where: { $0.strId == each.strId }) {
                            arrayFilterMergeAnd.append(each)
                        }
                    }
                }
            }
        } else {
            /* merge에 ENG 가 설정되어있음 */
            tempArray.append(contentsOf: arrayOriginFilterKoAnd)
            for index in 0..<count {
                for each in tempArray {
                    if arrayFilterMergeAnd[index].strId == each.strId {
                        arrayFilterMergeAnd[index].kor = each.kor
                    } else {
                        if !arrayFilterMergeAnd.contains(where: { $0.strId == each.strId }) {
                            arrayFilterMergeAnd.append(each)
                        }
                    }
                }
            }
        }
        printfilterSortedAll(arry: arrayFilterMergeAnd)
    }
    
    private func printExportFormat(array:[EachLocale],
                                   type:LanguageType,
                                   osType:OSType) {

        print("")
        print("******************** \(osType.rawValue) 복사 붙여넣기용 \(type.rawValue) EXPORT ********************")
        if array.count == 0 {
            return
        }
        
        switch osType {
        case .android:
            let space = "    "
            print("<resources>")
            for each in array {
                switch type {
                case .kor:
                    print("\(space)<string name=\"\(each.strId)\">\(each.kor)</string>")
                case .eng:
                    print("\(space)<string name=\"\(each.strId)\">\(each.eng)</string>")
                default:
                    break
                }
            }
            print("</resources>")
        case .ios:
            for each in array {
                switch type {
                case .kor:
                    print("\"\(each.strId)\" = \"\(each.kor)\"")
                case .eng:
                    print("\"\(each.strId)\" = \"\(each.eng)\"")
                case .none:
                    return
                }
            }
        }
        
        print("************ Count = \(array.count) ************")
        print("")
    }
    
    private func printfilterSortedArray(arry:[EachLocale], type:LanguageType) {
        print("")
        print("***** \(type.rawValue) 기존 코드에 사용중인 값이지만 신규 Excel에 없는 값 *****")
        for index in 0..<arry.count {
            let each = arry[index]
            var trans = ""
            switch type {
            case .none:
                continue
            case .kor:
                trans = each.kor
            case .eng:
                trans = each.eng
            }
                        
            print("(\(String(format: "%02d", index)))  ID : \(each.strId)      \(type.rawValue) 번역 : \(trans)")
        }
        print("******************** Count = \(arry.count) **********************")
        print("")
    }
    
    
    private func printfilterSortedAll(arry:[EachLocale]) {
        print("")
        print("***** 한글, 영문 통합 기존 코드에 사용중인 값이지만 신규 Excel에 없는 값 *****")
        for each in arry {
            print("ID : \(each.strId)\n한글 변역:\"\(each.kor)\"\n영문 번역:\"\(each.eng)\"")
            print("")
        }
        print("******************************************")
        print("")
    }
    
    
    private func checkEnableFilterMerge(arrFilterKo:[EachLocale],
                                        arrFilterEng:[EachLocale],
                                        osType:OSType) {
        switch osType {
        case .android:
            btnFilterMergeAnd.isEnabled = arrFilterKo.count != 0 && arrFilterEng.count != 0
        case .ios:
            btnFilterMergeIOS.isEnabled = arrFilterKo.count != 0 && arrFilterEng.count != 0
        }
        
    }
    
    private func activeButtons() {
        btnOriginEnCheckiOS.isEnabled = true
        btnOriginKoCheckiOS.isEnabled = true
        btnExportKoiOS.isEnabled = true
        btnExportEngiOS.isEnabled = true
        
        
        btnOriginEnCheckAnd.isEnabled = true
        btnOriginKoCheckAnd.isEnabled = true
        btnExportKoAnd.isEnabled = true
        btnExportEngAnd.isEnabled = true
    }
    
}

