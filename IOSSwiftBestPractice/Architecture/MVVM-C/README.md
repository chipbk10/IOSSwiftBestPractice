## Questions

1) Question: design a set of screens that looks quite similar to each other, and only few UI componenets are different using MVVM
- Answer: use Inheritance approach.
++ create a base ViewController with all common UI components. Other ViewControllers will inherit from this ViewController
++ create a base ViewModel, that provide data for this base ViewController. Other ViewModels will inherit from this ViewModel


## Sources
- credit to [Alexdria VA: MVVM in practice](https://www.youtube.com/watch?v=sWx8TtRBOfk&ab_channel=raywenderlich.com)
