import UIKit

// Sorry, I don't have time to prepare the presentation, ahmm ok, I can show you a simple case of using `Actor` in real life on the playground code. I hope it will not take a lot of time for all of us, so you can come back to enjoy your chapter time. I will code on the fly, so not sure it's working or not, but please correct me if I am wrong.

// Actor can solve the race-condition, data-race problem. I don't remember the difference between them.
// But basically the problem is related to the fact that multiple threads can access, and alter the same mutable data at the same time.
// It might lead to incorrect result, or the application might be crashed.

// imagine at ING, we have a model named `BankAccount`, and `BankAccount` has fields named `accountName`, and `balance`.
// The user can deposit money
// The user can transfer money from one account to another account
private struct BankAccount {
    let accountName: String
    var balance: Int
    
    // naive approach: isBalanceSufficient()
    
    // NSLock: traditional way to prevent race conditions in Objective-C. We use `NSLock` to lock the critical section in our code.
    // Once a thread accessed this critical section, it will block other threads. Other threads must wait until the lock is released.
    // private let lock = NSLock(). One disadvatage is it might lead to `deadlock`, if 2 threads are waiting for each other.
    
    // SerialQueue: put the code execution in a serial queue, it guarantees only one thread can access the resource at a time.
    // private let seriaQueue = DispatchQueue(label: "SerialQueue")
    
    // ConcurrentQueue with dispatchBarrier, it guarantees when it's time to execute the task, there is only one task in the concurrent queue
    // private let concurrentQueue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
    
    @discardableResult
    mutating func transfer(amount: Int, to toAccount: inout BankAccount, onThread threadNumber: Int) -> Bool {
        
        // lock.lock()
        // seriaQueue.sync {
        // concurrentQueue.async(flags:.barrier) {}
        
        // we should guarantee that we never transfer the amount of money that exceeds the current balance
        guard balance >= amount else { return false }
        
        // the thread1 comes here, need to wait for 1 second. The balance is still not changed.
        // in the meantime, the thread2 also comes here.
        // prepare data, fetch from database, need to check some conditions before performing actual transaction.
        sleep(1)
        
        // both thread1 & thread2 come here and alter the current balance.
        // actual transaction
        // if isBalanceSufficient() { ... }
        balance -= amount
        display(onThread: threadNumber)
        
        toAccount.deposit(amount: amount)
        toAccount.display(onThread: threadNumber)
        
        // lock.unlock()
        
        return true
            
        // }
    }
    
    mutating func deposit(amount: Int) {
        balance += amount
    }
    
    // we can print out the current balance on the console so that we know what's going on with the balance.
    func display(onThread threadNumber: Int) {
        print("on thread \(threadNumber) \(accountName) balance = \(balance)")
    }
}

var bankAccountOne = BankAccount(accountName: "BankAccountOne", balance: 100)
var bankAccountTwo = BankAccount(accountName: "BankAccountTwo", balance: 100)


// we use 2 concurrent queues to execute the transactions on different threads
let concurentQueue1 = DispatchQueue(label: "ConcurrentQueue1", attributes: .concurrent)
let concurentQueue2 = DispatchQueue(label: "ConcurrentQueue2", attributes: .concurrent)

// DATA RACE

// transaction1
// transaction1 has a chance to be executed first.
concurentQueue1.async {
    bankAccountOne.transfer(amount: 50, to: &bankAccountTwo, onThread: 1)
}

// transaction2
// transaction2 has no chance to be excuted. The result is correct.
concurentQueue2.async {
    bankAccountOne.transfer(amount: 70, to: &bankAccountTwo, onThread: 1)
}
