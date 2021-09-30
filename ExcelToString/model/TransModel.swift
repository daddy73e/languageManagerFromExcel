//
//  TransModel.swift
//  ExcelToString
//
//  Created by Yeongeun Song on 2021/09/30.
//

import UIKit

protocol TransModelDelegate:AnyObject {
    func enableBtnExportMerge(isOn:Bool, osType:OSType)
}

class TransModel: NSObject {
    
    public var arrayAllExcelItem = [EachLocale]()
    
    public var arrayOriginFilterKo = [EachLocale]()
    public var arrayOriginFilterEng = [EachLocale]()
    public var arrayFilterMerge = [EachLocale]()
    public weak var transModelDelegate:TransModelDelegate?
    
    init(excelItem:[EachLocale]) {
        self.arrayAllExcelItem = excelItem
    }
    
    public func filterDifference(arrayEntire:[EachLocale],
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
    
    public func filterMerge(osType:OSType) {
        arrayFilterMerge.removeAll()
        var mergeLanType:LanguageType = .none
        var count = 0
        
        if arrayOriginFilterKo.count > arrayOriginFilterEng.count {
            count = arrayOriginFilterKo.count
            arrayFilterMerge.append(contentsOf: arrayOriginFilterKo)
            mergeLanType = .kor
        } else {
            count = arrayOriginFilterEng.count
            arrayFilterMerge.append(contentsOf: arrayOriginFilterEng)
            mergeLanType = .eng
        }
        
        var tempArray = [EachLocale]()
        if mergeLanType == .kor {
            /* merge에 KO가 설정되어있음 */
            tempArray.append(contentsOf: arrayOriginFilterEng)
            for index in 0..<count {
                for each in tempArray {
                    if arrayFilterMerge[index].strId == each.strId {
                        arrayFilterMerge[index].eng = each.eng
                    } else {
                        if !arrayFilterMerge.contains(where: { $0.strId == each.strId }) {
//                            print(each)
                            arrayFilterMerge.append(each)
                        }
                    }
                }
            }
        } else {
            /* merge에 ENG 가 설정되어있음 */
            tempArray.append(contentsOf: arrayOriginFilterKo)
            for index in 0..<count {
                for each in tempArray {
                    if arrayFilterMerge[index].strId == each.strId {
                        arrayFilterMerge[index].kor = each.kor
                    } else {
                        if !arrayFilterMerge.contains(where: { $0.strId == each.strId }) {
//                            print(each)
                            arrayFilterMerge.append(each)
                        }
                    }
                }
            }
        }
        transModelDelegate?.enableBtnExportMerge(isOn: true, osType: osType)
        printfilterSortedAll(arry: arrayFilterMerge)
    }
    
    public func printExportFormat(array:[EachLocale],
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
    
    public func printfilterSortedArray(arry:[EachLocale],
                                       type:LanguageType) {
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
        print("******************* Count = \(arry.count) *******************")
        print("")
    }
}
