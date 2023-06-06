import Foundation
import WeavrComponents
import UIKit
import React

@objc(UxComponents)
class UxComponents: NSObject {



    @objc(initUxComponents:uiKey:withResolver:withRejecter:)
    func initUxComponents(env: String, uiKey: String, resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) ->Void{

        switch(env){
            // case "QA":
            //     UXComponents.initialize(env: ENV.QA, uiKey: uiKey)


            case "Production":
                UXComponents.initialize(env: ENV.PRODUCTION, uiKey: uiKey)


            case "Sandbox":
                UXComponents.initialize(env: ENV.SANDBOX, uiKey: uiKey)


            default:
                reject(ErrorType.Failed, "UxComponents Initialization Failed", nil)
                return
        }
        resolve("UxComponents Successfully Intialized!")


    }


    @objc(setUserToken:withResolver:withRejecter:)
    func setUserToken(token: String,   resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock) ->Void{
        UXComponents.setUserToken(token: token, completion: {  res in
            switch(res){

                case .success(let data):
                    resolve(data)
                    return
                case .failure(let err):

                    reject(ErrorType.Failed, err.message, nil)
                    return
            }

        })

    }

    @objc(isAssociated:withRejecter:)
    func isAssociated(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock) -> Void{
        let res = UXComponents.isAssociated()
        resolve(res)
    }

    @objc(clearCache:withRejecter:)
    func clearCache(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock)  {
        UXComponents.clearUXComponentsCache()
//        print("cleared")
        resolve("Cache Cleared from Weavr SDK")
    }

    @objc(resetAssociation:withRejecter:)
    func resetAssociation(resolve:RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock)  {
        UXComponents.resetAssociation()
//        print("cleared")
        resolve("resetted association")
    }

    @objc(matchComponents:withResolver:withRejecter:)
    func matchComponents(tags: Array<Any>, resolve: @escaping RCTPromiseResolveBlock,reject:RCTPromiseRejectBlock)  {

        var components = [SecureTextField]()
        tags.forEach({ e in
//            print(e)
            components.append(allEditTexts[e as! String]!.securePasswordField)

        })

        let group1 = UXComponents.createGroup(components: components)

//        print("group1 matched \(group1.match())")
        resolve(group1.match())


    }

    @objc(createTokens:withResolver:withRejecter:)
    func createTokens(tags: Array<Any>, resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock)  {

        var components = [SecureTextField]()
        var keys  = [String]()
        tags.forEach({ e in
//            print(e)
            components.append(allEditTexts[e as! String]!.securePasswordField)
            keys.append("\(e)")
        })

        let group1 = UXComponents.createGroup(components: components)

//        print("group1 matched \(group1.match())")
        group1.createToken(fieldKeys: keys, callBack:  {
            weavrResponse in
            switch weavrResponse {
                case let .success(data):
                        // data the dictionary provides [String : String?], where keys are the passKeys and values are the tokenized


                    let encodedData = try? JSONEncoder().encode(data)
                    let jsonString = String(data: encodedData!, encoding: .utf8)
//                    print(jsonString!)
                        // as dictionary is randomly ordered due to hasing, we are sorting the dictionary by keys
                    let sortedData = data.sorted(by: { $0.key < $1.key })
//                    for (key, value) in sortedData {
//                        print("Key: \(key) \(value ?? "")")
//                    }


                    var finalDic =   [String: String]()
                    sortedData.forEach({key, value in
                        finalDic[key] = value! as String

                    })
                    resolve(finalDic)


                case let .failure(err):

                        // print("\(err.code) \(err.message) \(err.body ?? "")")
                    reject(ErrorType.Failed, err.message, nil)

            }
        })


    }

    internal var newAccessToken = ""

    @objc(updateAccessToken:withResolver:withRejecter:)
    func updateAccessToken(accessToken: String,  resolve: @escaping RCTPromiseResolveBlock,reject: @escaping RCTPromiseRejectBlock){
        self.newAccessToken = accessToken
    }



    @objc(startKyc:token:email:phone:locale:withResolver:withRejecter:)
    func startKyc(reference: String, token: String?, email: String?, phone: String?, locale : String?, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {

        var topViewController = UIApplication.shared.keyWindow?.rootViewController;

                while ((topViewController?.presentedViewController) != nil) {
                    topViewController = topViewController?.presentedViewController;
                }

//       UXComponents.kyc.startKyc(vc: topViewController!,
//					    reference:  reference,
//					    token: token,
//					    mailAddress: email,
//					    phone: phone,
//					    locale: locale ?? "",
//					    kycHandlers: { res in
//                       switch (res){
//
//                       case .tokenExpirationHandler( let onExpaire):
//                           RNEventEmitter.emitter.sendEvent(withName: "onTokenExpired", body: nil)
//
//                           onExpaire((self.newAccessToken as? String) ?? "")
//
//
//
//
//
//                       case .verificationHandler(let isApproved):
//
//
//                           RNEventEmitter.emitter.sendEvent(withName: "onKycSdkTerminate", body: ["Varification": "\(isApproved)"])
//
//
//                       case .dismissHandler(let sdk, let  vc):
//                           vc.dismiss(animated: true)
//                           RNEventEmitter.emitter.sendEvent(withName: "onKycSdkTerminate", body: ["Success Termination": sdk.verboseStatus])
//                       }
//
//                   }, weavrExceptionHandlers: {res in
//                       switch(res){
//
//                       case .weavrApiExceptionHandler(let exc):
//                           RNEventEmitter.emitter.sendEvent(withName: "onKycCompleteFailed", body: ["message": exc])
//
//                       }
//                   }, kycListeners: { res in
//                       switch(res){
//
//                       case .onStatusDidChange(let sdk,let prevStatus):
//
//
//
//                           if(sdk.status == .failed){
//                               RNEventEmitter.emitter.sendEvent(withName: "onKycFailed", body: ["Failed", "failReason: [\(sdk.description(for: sdk.failReason))] - \(sdk.verboseStatus)"])
//
//                           }else{
//                               RNEventEmitter.emitter.sendEvent(withName: "onStatusChanged", body: sdk.verboseStatus)
//
//                           }
//                       case .onEvent(let sdk, let event):
//                           switch (event.eventType){
//
//                           case .stepInitiated:
//                               RNEventEmitter.emitter.sendEvent(withName: "onEvent", body: "step initiated")
//
//                           case .stepCompleted:
//                               RNEventEmitter.emitter.sendEvent(withName: "onEvent", body: "step completed")
//
//
//                           @unknown default:
//                               RNEventEmitter.emitter.sendEvent(withName: "onEvent",
//                               body:  "onEvent: eventType=\(event.description(for: event.eventType)) payload=\(event.payload)")
//
//
//                           }
//
//                       case .onDidDismiss(let sdk):
//                           print("onDidDismiss: sdk has been dismissed with status [\(sdk.description(for: sdk.status))]")
//                           switch sdk.status {
//
//                               case .failed:
//                               RNEventEmitter.emitter.sendEvent(withName: "onKycFailed",
//                               body: [
//                                       "Failed",
//                                       "failReason: [\(sdk.description(for: sdk.failReason))] - \(sdk.verboseStatus)"
//                                                                                                           ])
//
//
//                               case .actionCompleted:
//                                       // the action was performed or cancelled
//
//                                   if let result = sdk.actionResult {
//                                       RNEventEmitter.emitter.sendEvent(withName: "onKycActionComplete",
//                                       body:  "Last action result: actionId=\(result.actionId) answer=\(result.answer ?? "<none>")")
////
//                                   } else {
//                                       RNEventEmitter.emitter.sendEvent(withName: "onKycActionComplete",
//                                   body: "The action was cancelled")
//
//                                   }
//
//                               default:
//                                       // in case of an action level, the other statuses are not used for now,
//                                       // but you could see them if the user closes the sdk before the level is loaded
//                                   break
//                           }
//                       }
//                   })
                }

}

var allEditTexts = [String: SecureTextProtocol]()
