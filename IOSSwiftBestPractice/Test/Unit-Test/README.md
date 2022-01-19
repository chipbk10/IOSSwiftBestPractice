## Questions

1) Question: can you suggest a good unit-test method's name?
- Answer: test_methodName_returnsInput_whenOutput

2) Question: how to test if our app can open a specific URL?
- Answer: to open a URL, we have to use `UIApplication.shared`. We have to find a way to stub 2 methods `.canOpen()` & `.open(...)`. We can make a protocol that contains these method, then extend UIApplication to conform to that protocol. Now, we can mock / stub easily

## Sources
- credit to [Sundell: Unit-Testing](https://www.swiftbysundell.com/discover/unit-testing/)


## Further Reading:
- [Everything about unit-test in Swift](https://bit.ly/3tljDbl)
