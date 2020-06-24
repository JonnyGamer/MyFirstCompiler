# My First Compiler
The following descibes my first take at a compiler. I am creating a new language similar to Swift that is parsed on-time. However, this programming language will have built in benefits. It will include Easy Regex support, and also use NumberKit allowing for Ints with no limit.


## Data Types
I have created several base Types. Each one has their own Regex definition, and a cleaner.<br>
 - **Q** What is a Regex Defition?<br>
 - **A** This is a Regular Expression that can match against a String. If true, that String is of the correct format.
 - **Q** What is a cleaner?
 - **A** If a String matches with a specific Regex Definition, it can be cleaned. Example: `-0001.0` is cleaned to `-1.0`
 
**My Base Types**
 - **Bool** - `true|false`
 - **Int** - `-?\d+`
 - **Double** - `-?\d+\.\d+`
 - **String** - `\"[^\"]*\"`
 - **Regex** - `/.+/`
 - **Undefined** - `undefined`
 - **Void** - `\(\)`
 
I also have special data types that do not have a Regex Definition.<br>
The **Type** data type is `Bool|Int|Double|String|Regex|Undefined|Void|Type` but can also will be automatically extended when new objects are created.

**TODO**
 - Give Regex Defitions different priorority levels
 - Allow multiple Regex Defitions for types
 - Support meta characters for the String data type
 - Support a Paragraph data type allowing for Multiline Strings
 - Support a Code data type `{ place code here }` allowing for sneaky code snipping

## Storing Data
There are 4 ways you can save data<br>
`let` `var` `ref` `any`<br>
I will explain each one

>• **let**<br>
Let is immutable.<br>
Once you save an object into `let`, you may not change it later.
>
>• `let a = 7` 'a' has been saved to 7. 'a' has also been inferred to be an Int.<br>
• `let b Int = 7` 'b' has been saved to 7. 'b' has also been explicitly defined to be an Int.<br>
• `let foo = 7; foo = 8` This throws an error, because values stored using 'let' cannot be redefined.

<br>

>• **var**<br>
Var can be mutated.
Once you save an object into `var`, you may reassign it later. However, it must be the same type.
>
>• `var a = 88; a = 90` 'a' starts out being '88', but then mutates to become '90'
>• `var a = 500; a = "magic"` This throws an error. The Type of var values cannot be mutated

<br>

>• **ref**<br>
Ref can store references of values. It can also be mutated to store different references of the same type.
Once you save an object into `ref`, and when the object that has been assigned is mutated, the ref gets mutated as well.<br>
Let's see this in action.
>
>• `var a = 100`
>• `ref b = a` This new b value is now a. b is *not* 100. b is a.
>• `a = 300`
>• `print(b)` This prints `300`. Since a was mutated

<br>

>• **any**<br>
Any is a special value. It's value is mutable, and it's Type is also mutable. It is also can be a ref.<br>
Woah.
I have removed the `Any` type in Swift, and replaced it with this new storage type.
>
>• `any a = 100`
>• `a = "now I am a String"` This is now ok with Any.
>• `typeOf(a)` It prints String.
>• `a = Double`
>• `typeOf(a)` It prints Type.

<br>




