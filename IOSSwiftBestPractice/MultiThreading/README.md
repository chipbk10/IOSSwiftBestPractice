## Questions

1) What is GCD?
- Answer: An abstraction to help developers write multi-threaded code without manually creating and managing the threads themselves

2) How to make an asynchronous block become synchronous? Or how to flaten a completion block?
- Answer 1: use Semaphore
- Answer 2: DispatchGroup

3) How to perform a bunch of asynchronous blocks serially? block1 -> block2 -> .... -> block N
- Answer 1: recursive approach
- Answer 2: use Semaphore (like question1)

4) How to limit the number of concurrent blocks?
- Answer: use Semaphore

5) How to wait for many concurrent blocks to finish?
- Answer: use DispatchGroup

6) How to solve readers-writers problem?
- Answer: use `.barrier` flag

7) Explain why synchronous dispatch the task to the same serial queue will lead to the app crash?
- Answer: the task will be added at the end of the serial queue. Mean while the current thread will be blocked forever, as the task is never executed.

8) How to avoid race conditions?
- Answer 1: use NSLock. However, it can lead to a `deadlock`, when 2 threads might wait for each other to release their locks
- Answer 2: use Semaphore(1)
- Answer 3: use SerialQueue
- Answer 4: use .barrier flags with ConcurrentQueue
- Answer 5: use Actor

## Sources
- Credit to [Soroush Khanlou: GCD Handbook](https://khanlou.com/2016/04/the-GCD-handbook/)
- [GCD efficiency tips](https://bit.ly/31tpr71)
- Credit to [Besher Al Maleh: iOS concurrency](https://www.freecodecamp.org/news/ios-concurrency/)
- Credit to [Sundell: Avoiding race-conditions in Swift](https://www.swiftbysundell.com/articles/avoiding-race-conditions-in-swift/)
- Credit to [Mostafa Abdellateef: Avoiding race-condition in Swift](https://medium.com/swiftcairo/avoiding-race-conditions-in-swift-9ccef0ec0b26)
- Credit to [Varun Tomar: Avoiding race-condition in Swift](https://bit.ly/3GeVAOV)
- Credit to [Frank: Everything you know about GCD is a lie](https://ioscoachfrank.com/gcd-lies.html)
- [Concurrency api and pitfalls](https://www.objc.io/issues/2-concurrency/concurrency-apis-and-pitfalls/)

## Further reading
- Credit to [Avanderlee: race-condition vs data-race](https://www.avanderlee.com/swift/race-condition-vs-data-race/)

## Further watching
- [WWDC 2015: Build responsive and efficient apps with GCD](https://developer.apple.com/videos/play/wwdc2015/718/)
- [WWDC 2021: Meet async/await in Swift](https://developer.apple.com/videos/play/wwdc2021/10132)
- [WWDC 2021: Protect mutable state with Swift actors](https://developer.apple.com/videos/play/wwdc2021/10133)
- [How to create thread manually?](https://apple.co/3f28x2y)
