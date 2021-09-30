//
//  ViewController.swift
//  ExcelToString
//
//  Created by Yeongeun Song on 2021/09/27.
//

import UIKit
import SwiftyXMLParser

class ViewController: UIViewController {

    private var transModelIOS:iOSTransModel?
    private var transModelAnd:AndTransModel?
    
    /* Config */
    private let excelTxtName = Config.excelTxtName
    private let separateChar = Config.separateChar
    private let originKoiOSTxtName = Config.originKoiOSTxtName
    private let originEniOSTxtName = Config.originEniOSTxtName
    private let originKoAndTxtName = Config.originKoAndTxtName
    private let originEnAndTxtName = Config.originEnAndTxtName
    
    /* iOS */
    @IBOutlet weak var btnOriginKoCheckiOS: UIButton!
    @IBOutlet weak var btnOriginEnCheckiOS: UIButton!
    @IBOutlet weak var btnExportKoiOS: UIButton!
    @IBOutlet weak var btnExportEngiOS: UIButton!
    @IBOutlet weak var btnFilterMergeIOS: UIButton!
    @IBOutlet weak var btnFilterExportIOS: UIButton!
    
    /* Android */
    @IBOutlet weak var btnOriginKoCheckAnd: UIButton!
    @IBOutlet weak var btnOriginEnCheckAnd: UIButton!
    @IBOutlet weak var btnExportKoAnd: UIButton!
    @IBOutlet weak var btnExportEngAnd: UIButton!
    @IBOutlet weak var btnFilterMergeAnd: UIButton!
    @IBOutlet weak var btnFilterExportAnd: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setUpModel() {
        let datas = translateExcelFileData()
        if datas.count != 0 {
            activeButtons()
        }
        
        if transModelIOS == nil {
            transModelIOS = iOSTransModel(excelItem: datas)
            transModelIOS?.iosTransDelegate = self
            transModelIOS?.transModelDelegate = self
        }
        
        if transModelAnd == nil {
            transModelAnd = AndTransModel(excelItem: datas)
            transModelAnd?.andTransDelegate = self
            transModelAnd?.transModelDelegate = self
        }
    }
    
    //MARK: - IBAction
    @IBAction func tapBtnTranslate(_ sender: Any) {
        setUpModel()
    }
    
    //MARK: - IBAction iOS
    @IBAction func tapAutoiOS(_ sender: Any) {
        setUpModel()
        transModelIOS?.workAuto(txtNameKo: originKoiOSTxtName,
                                txtNameEn: originEniOSTxtName)
    }
    
    @IBAction func tapBtnExportKoiOS(_ sender: Any) {
        if let allItems = transModelIOS?.arrayAllExcelItem {
            transModelIOS?.printExportFormat(array: allItems, type: .kor)
        }
    }
    
    @IBAction func tapBtnExportEngiOS(_ sender: Any) {
        if let allItems = transModelIOS?.arrayAllExcelItem {
            transModelIOS?.printExportFormat(array: allItems, type: .eng)
        }
    }
    
    @IBAction func tapBtnOriginKoiOSCheck(_ sender: Any) {
        transModelIOS?.originCheck(originFileName: originKoiOSTxtName, langType: .kor)
    }
    
    @IBAction func tapBtnOriginEniOSCheck(_ sender: Any) {
        transModelIOS?.originCheck(originFileName: originEniOSTxtName, langType: .eng)
    }
    
    @IBAction func tapBtnMergeFilterIOS(_ sender: Any) {
        transModelIOS?.filterMerge()
    }
    
    @IBAction func tapExportFilterIOS(_ sender: Any) {
        if let array = transModelIOS?.arrayFilterMerge {
            transModelIOS?.printExportFormat(array: array, type: .kor)
            transModelIOS?.printExportFormat(array: array, type: .eng)
        }
    }
    
    //MARK: - IBAction Android
    @IBAction func tapAutoAndroid(_ sender: Any) {
        setUpModel()
        transModelAnd?.workAuto(txtNameKo: originKoAndTxtName,
                                txtNameEn: originEnAndTxtName)
    }
    
    @IBAction func tapBtnExportKoAnd(_ sender: Any) {
        if let allTiems = transModelAnd?.arrayAllExcelItem {
            transModelAnd?.printExportFormat(array: allTiems, type: .kor)
        }
    }
    
    @IBAction func tapBtnExportEngAnd(_ sender: Any) {
        if let allTiems = transModelAnd?.arrayAllExcelItem {
            transModelAnd?.printExportFormat(array: allTiems, type: .eng)
        }
    }
    
    @IBAction func tapBtnOriginKoAndCheck(_ sender: Any) {
        transModelAnd?.originCheck(originFileName: originKoAndTxtName, langType: .kor)
    }
    
    @IBAction func tapBtnOriginEnAndCheck(_ sender: Any) {
        transModelAnd?.originCheck(originFileName: originEnAndTxtName, langType: .eng)
    }
    
    @IBAction func tapBtnMergeFilterAnd(_ sender: Any) {
        transModelAnd?.filterMerge()
    }
    
    @IBAction func tapExportFilterAndroid(_ sender: Any) {
        if let array = transModelAnd?.arrayFilterMerge {
            transModelAnd?.printExportFormat(array: array, type: .kor)
            transModelAnd?.printExportFormat(array: array, type: .eng)
        }
    }
    
    //MARK: - Common
    private func translateExcelFileData() -> [EachLocale] {
        var resultArray = [EachLocale]()
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
                    resultArray.append(eachItem)
                } else {
                }
            }
            
            resultArray.sort { $0.strId < $1.strId }
            return resultArray
        } catch {
            return []
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

extension ViewController:TransModelDelegate {
    func enableBtnExportMerge(isOn: Bool, osType: OSType) {
        switch osType {
        case .android:
            btnFilterExportAnd.isEnabled = isOn
        case .ios:
            btnFilterExportIOS.isEnabled = isOn
        }
    }
}

extension ViewController:iOSTransDelegate {
    func enableBtnMergeIOS(isOn: Bool) {
        btnFilterMergeIOS.isEnabled = isOn
    }
}

extension ViewController:AndTransDelegate {
    func enableBtnMergeAnd(isOn: Bool) {
        btnFilterMergeAnd.isEnabled = isOn
    }
}
