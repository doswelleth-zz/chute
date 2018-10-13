//
//  IAPHelper.swift
//  chute
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation
import StoreKit

class IAPHelper: NSObject {
    
    private override init () {}
    
    static let shared = IAPHelper()
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    func getProducts() {
        let productIdentifier : Set = [IAPMembership.autoRenewingSubscription.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: productIdentifier)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func purchase(product: IAPMembership) {
        guard let productToPurchase = products.filter({ ($0.productIdentifier == product.rawValue)}).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
    
    func restorePurchases() {
        print("Member restored purchase")
        paymentQueue.restoreCompletedTransactions()
    }
}

extension IAPHelper : SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        for product in response.products {
            print(product.localizedTitle)
        }
    }
}

extension IAPHelper : SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            
            switch transaction.transactionState {
            case .purchasing:
                break
            default:
                queue.finishTransaction(transaction)
            }
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, shouldAddStorePayment payment: SKPayment, for product: SKProduct) -> Bool {
        return true
    }
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
        case .deferred:
            return "Payment Deferred"
        case .failed:
            return "Payment Failed"
        case .purchasing:
            return "Payment Purchasing"
        case .restored:
            let notification = NotificationCenter.default
            notification.post(name: Notification.Name(Notif().name), object: nil)
            return "Purchase Restored"
        case .purchased:
            let notification = NotificationCenter.default
            notification.post(name: Notification.Name(Notif().name), object: nil)
            return "Product Purchased"
        }
    }
}

struct Notif {
    let name = "MakeSuccessButtonVisible"
}
