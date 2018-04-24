##Question1

输出：都是Son

理由：

Runtime创建一个objc_super结构变量，objc_super结构的地址作为参数传递给objc_msgSendSuper的super属性，objc_super结构变量的recevier属性是当前执行方法的类。执行[super class]方法时，son类去father类找class方法，没找到就一直找到NSObject里面。NSObject找到class方法，class方法就是输出调用这个方法的类。objc_msgSend(objc_super->receiver, @selector(class))，objc_super->receiver就是son。所以说最后[super class]方法是son。

##Question2

输出： YES NO NO NO

理由：

-(BOOL) isKindOfClass: classObj	判断是否是这个类或者这个类的子类的实例

-(BOOL) isMemberOfClass: classObj 	判断是否是这个类的实例

1. NSObject元类的isa指针指向自己，自己和自己比较，所以输出YES
2. ？？？？按理说应该YES啊……...
3. Sark元类的isa指针指向父类的元类，继续往上找都是元类，所以输出NO
4. Sark元类的isa指针指向父类的元类，所以输出NO

##Question3

好像有点问题，类方法没有定义无法编译

Runtime error