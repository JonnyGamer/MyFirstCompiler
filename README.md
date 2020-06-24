# My First Compiler
The following descibes my first take at a compiler. I am creating a new language similar to Swift that is parsed on-time.


## Storing Data
There are 4 ways you can save data<br>
```let``` ```var``` ```ref``` ```any```<br>
I will explain each one

• **let**<br>
Let is immutable.<br>
Once you save an object into ```let```, you may not change it later.

• ```let a = 7``` 'a' has been saved to 7. 'a' has also been inferred to be an Int.<br>
• ```let b Int = 7``` 'b' has been saved to 7. 'b' has also been explicitly defined to be an Int.<br>
• ```let foo = 7; foo = 8``` This throws an error, because values stored using 'let' cannot be redefined.

