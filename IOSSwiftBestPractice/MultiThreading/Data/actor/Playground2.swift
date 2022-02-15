import UIKit

// That's how actor comes to solve this problem.
// An actor automatically serializes all access to its properties and methods, which ensures only one caller can directly interact with the actor at a time.
// actor works like classes, they are passed by reference.
// actor doesn't support subclass, actor looks like `final class`
private actor BankAccount {
    let accountName: String
    var balance: Int
    
    init(accountName: String, balance: Int) {
        self.accountName = accountName
        self.balance = balance
    }
    
    @discardableResult
    // async mean this method perform asynchronous work
    // async can replace the closure completion, and callback
    func transfer(amount: Int, to toAccount: BankAccount, onThread threadNumber: Int) async -> Bool {
        guard balance >= amount else { return false }
        sleep(1)
                
        balance -= amount
        display(onThread: threadNumber)
        
        // await is used to wait for an async code
        await toAccount.deposit(amount: amount)
        await toAccount.display(onThread: threadNumber)
        
        return true
    }
    
    func deposit(amount: Int) {
        balance += amount
    }
        
    func display(onThread threadNumber: Int) {
        print("on thread \(threadNumber) \(accountName) balance = \(balance)")
    }
}

private var bankAccountOne = BankAccount(accountName: "BankAccountOne", balance: 100)
private var bankAccountTwo = BankAccount(accountName: "BankAccountTwo", balance: 100)


// we use 2 concurrent queues to execute the transactions on different threads
private let concurentQueue1 = DispatchQueue(label: "ConcurrentQueue1", attributes: .concurrent)
private let concurentQueue2 = DispatchQueue(label: "ConcurrentQueue2", attributes: .concurrent)

// DATA RACE

concurentQueue1.async {
    // task encapsulates a piece of asynchronous code
    // we can manage a task like resume a task or cancel a task
    Task {
        await bankAccountOne.transfer(amount: 50, to: bankAccountTwo, onThread: 1)
    }
}

concurentQueue2.async {
    Task {
        await bankAccountOne.transfer(amount: 70, to: bankAccountTwo, onThread: 2)
    }
}
