//
//  ASBInterviewExerciseTests.swift
//  ASBInterviewExerciseTests
//
//  Created by ASB on 29/07/21.
//

import XCTest
@testable import ASBInterviewExercise

class ASBInterviewExerciseTests: XCTestCase {

    var debitTx: TransactionData!
    var creditTx: TransactionData!
    var undefinedTx: TransactionData!
    var txTest: Transaction!
    let txTypeCredit = TransactionType.credit
    let txTypeDebit = TransactionType.debit
    let twoDigitPriceFormat: String = "%.2f"
    let threeDigitPriceFormat: String = "%.3f"

    override func setUpWithError() throws {
        // Initialize Mock Txs:
        debitTx = Transaction(id: 0,
                              transactionDate: Date(),
                              summary: "Barkers",
                              debitValue: 230.45678,
                              creditValue: 0)
        
        creditTx = Transaction(id: 1,
                               transactionDate: Date().addingTimeInterval(TimeInterval(10)),
                               summary: "Apple ANZ",
                               debitValue: 0,
                               creditValue: 2128.182333)
        
        undefinedTx = Transaction(id: 2,
                                  transactionDate: Date().addingTimeInterval(TimeInterval(80)),
                                  summary: "MightyApe 🦍",
                                  debitValue: 230.45678,
                                  creditValue: 2128.182333)
        txTest = Transaction(id: 3,
                             transactionDate: Date().addingTimeInterval(TimeInterval(1)),
                             summary: "HickleAbbott",
                             debitValue: 115,
                             creditValue: 0)
        
       
    }

    func testTransactionType() throws {
        
        // Test transaction types:
        XCTAssertTrue(debitTx.transactionType() == TransactionType.debit)
        XCTAssertFalse(debitTx.transactionType() == TransactionType.credit)
        
        XCTAssertTrue(creditTx.transactionType() == TransactionType.credit)
        XCTAssertFalse(creditTx.transactionType() == TransactionType.debit)
        // Test unconsistent debit/credit field - defaults to .credit
        XCTAssertTrue(undefinedTx.transactionType() == TransactionType.credit)
        XCTAssertFalse(undefinedTx.transactionType() == TransactionType.debit)
    }

    func testTransactionValue() throws {
        let expectedDebitValue = 230.45678
        let expectedCreditValue = 2128.182333
        
        // Test transaction value:
        XCTAssertTrue(debitTx.txValue() == expectedDebitValue)
        XCTAssertTrue(creditTx.txValue() == expectedCreditValue)
         // Test unconsistent debit/credit field - defaults to .credit
        XCTAssertTrue(undefinedTx.txValue() == expectedCreditValue)
    }
    
    func testGST() {
        let exclusiveGST = 100.0
        // inclusiveGST GST we multiply the exclusive GST by the GST multiplier:
        let inclusiveGST = round(exclusiveGST * Constants.Numbers.GSTTaxMultiplier)
        // substract the exclusive GST
        let paidGST = inclusiveGST - exclusiveGST
        
        
        // make sure tx vale is the inclusiveGST:
        XCTAssertTrue(txTest.txValue() == inclusiveGST)
        XCTAssertTrue(txTest.getGSTTax() == paidGST)
    }
    
    func testTransactionDisplayFormat() throws {
        let expected2DigitFromatDebitValue = "230.46" // rounded
        let expected2DigitFromatCreditValue = "2128.18"
        let expected3DigitFromatDebitValue = "230.457" // rounded
        let expected3DigitFromatCreditValue = "2128.182"
        
        // test formatting price with two digits
        XCTAssertTrue(debitTx.txValue(displayFormat: twoDigitPriceFormat) == expected2DigitFromatDebitValue)
        XCTAssertTrue(creditTx.txValue(displayFormat: twoDigitPriceFormat) == expected2DigitFromatCreditValue)
        
        // test formatting price with three digits
        XCTAssertTrue(debitTx.txValue(displayFormat: threeDigitPriceFormat) == expected3DigitFromatDebitValue)
        XCTAssertTrue(creditTx.txValue(displayFormat: threeDigitPriceFormat) == expected3DigitFromatCreditValue)
    }
    
    func testTxTypeMethods() throws {
        
        XCTAssertTrue(txTypeCredit.name == "Credit")
        XCTAssertTrue(txTypeCredit.color == UIColor.green)
        
        XCTAssertTrue(txTypeDebit.name == "Debit")
        XCTAssertTrue(txTypeDebit.color == UIColor.red)
    }
    
    func testViewLayout() throws {
        let expectedStrPrice = "$230.46" // rounded
        let expectedSummary = "Barkers"
        
        XCTAssertTrue(DetailViewLayout.priceSection.cellValueFrom(debitTx) == expectedStrPrice)
        XCTAssertTrue(DetailViewLayout.summarySection.cellValueFrom(debitTx) == expectedSummary)
    }
}
