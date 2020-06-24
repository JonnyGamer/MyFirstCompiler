# My First Compiler
The following descibes my first take at a compiler. I am creating a new language similar to Swift that is parsed on-time. However, this programming language will have built in benefits. It will include Easy Regex support, and also use NumberKit allowing for Ints with no limit.


## Data Types
I have created several base Types. Each one has their own Regex definition, and a cleaner.<br>
 - **Q** What is a Regex Defition?<br>
 - **A** This is a Regular Expression that can match against a String. If true, that String is of the correct format.
 - **Q** What is a cleaner?
 - **A** If a String matches with a specific Regex Definition, it can be cleaned. Example: `-0001.00` is cleaned to `-1.0`
 
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

### let
Let is immutable.<br>
Once you save an object into `let`, you may not change it later.
 - `let a = 7` 'a' has been saved to 7. 'a' has also been inferred to be an Int.<br>
 - `let b Int = 7` 'b' has been saved to 7. 'b' has also been explicitly defined to be an Int.<br>
 - `let foo = 7; foo = 8` This throws an error, because values stored using 'let' cannot be redefined.

### var
Var can be mutated.
Once you save an object into `var`, you may reassign it later. However, it must be the same type.
 - `var a = 88; a = 90` 'a' starts out being '88', but then mutates to become '90'
 - `var a = 500; a = "magic"` This throws an error. The Type of var values cannot be mutated

### ref
Ref can store references of values. It can also be mutated to store different references of the same type.
Once you save an object into `ref`, and when the object that has been assigned is mutated, the ref gets mutated as well.<br>
Let's see this in action.

 - `var a = 100`
 - `ref b = a` This new b value is now a. b is *not* 100. b is a.
 - `a = 300`
 - `print(b)` This prints `300`. Since a was mutated

### any
Any is a special value. It's value is mutable, and it's Type is also mutable. It is also can be a ref.<br>
Woah.
I have removed the `Any` type in Swift, and replaced it with this new storage type.

 - `any a = 100`
 - `a = "now I am a String"` This is now ok with Any.
 - `typeOf(a)` It prints String.
 - `a = Double`
 - `typeOf(a)` It prints Type.

## Undefined Data
You can choose to define a value without storing data into it.<br>
It is now Undefined.<br>
`let a Int`<br>
`print(a)` undefined is printed.<br>
You can now assign it later.<br>
`a = 5`
This is not a mutation. It's an assignment.<br>
If an object is undefined, you can assign it later.

### rmv
You can also delete values.<br>
`let a = 5`<br>
`rmv a `

## Built in Methods
I have 2 built in methods `print` and `typeOf`<br>
`print(5)` This prints anything inside the parenthesis.<br>
`typeOf(5)` This prints the type of the object inside the parenthesis.

Right now these are the only 2 methods. I will soon add support for custom methods with parameters and return types.

## Operators
I have built a couple operators.<br>
Operators are resolve left to right, based upon a numeric priority

`=` - Assignment Operator: Creates a value on the lhs and assigns it to the rhs. Returns Void.<br>
`==` - Equality Operator: Checks if 2 values of the same type are equal. Returns a Bool.<br>
`is` - An alias of the `==` operator. I will add beter alias support soon. I love words, so I will allow wordy operators unlike Swift.<br>
`!=` - An Inequality Operator: Checks if 2 values of the same type are equal. Returns a Bool.<br>
`as` - A type checking operator: `5 as Int` returns `true`. `Bool as Type` returns `true`.

Currently I am only supporting `infix` operators. I will add suport for `prefix` and `postfix` very soon. I am also thinking of an `outfix` idea.

## Parenthetical Expressions
I have added support for complex operator expressions that use parenthesis.<br>
Parenthesis have upmost priority and are resolve first in to out.

`(5 == 5) != (6 == (7))` is a true satement.
`(() as Void) == true` is also a true statement.

## Control Flow
`if true`<br>
`  do this`<br>
`end if`<br>
<sub><sup>Indentation is optional :)</sup></sub>

Welcome to If Statements!
If a Boolean Expression resolves to `true`, some code can run!

This is ok
`if true == true`

### Create your first if statement
If statements must start with an `if` and end in an `end if`<br>
(Maybe later it'll just be `end`)

Immediately following the `if` must be a Boolean Expression that resolves either to `true` or `false`

You can *even nest em*<br>
`if true`<br>
`   if true`<br>
`      print("We both truuue")`<br>
`   end if`<br>
`end if`

### Or and Or If
`or` is the same as the `else` in Swift.
`or if` is the same as the `else if` in Swift.


`any a = Somethinf Rrandom`<br>
`if (a as Int)`<br>
`   do this`<br>
`or if (a as Double)`<br>
`   do this instead`<br>
`or`<br>
`   do this`<br>
`end if`<br>

`or if` is unlimited, you can use as many as you want.

## Skip Statements
This part gets a little creepy.
You can SKIPP lines of code.

`skip`<br>
`this code will NEVER RUN aaaah`

`skip` skips over the next line.<br>
Cool Trick:<br>
`skip; print("I am not skipped")`<br>
`I am skipped`<br>
Skips only skip following lines. :)

You can even specify how many lines you want to skip<br>
`5 skip`<br>
This skips 5 lines.<br>
`let a = 5; (a + a) skip`<br>
You can even use epxressions that resolve to an Int! (Once I add the `+` operator heh)

**TODO:** `-1 skip` This skips the rest of the program.<br>
**TODO:** `1.0 skip` Non Ints won't throw Error. Only warnings and won't skip.

`skip if true`<br>
This skip statement will skip 1 line, only if true is true. WOW!<br>
`(a + a) skip if (a as Int)` You can even do this.

**WARNING:**<br>
Skip statements are finiky, and I made them on accident. I think you should not use them as they could cause your code to catastrophically break without a descriptive message. Skips are bad bad bad. But I love them :))) -1-1-1

## Extras
**Mutliline Expressions**<br>
• Allows for `let a = 5; let b = 6` writing 2 statements on 1 line.
• You can even do this: `if true; do this; end if`<br>
**Comments**
• Allows you to comment out a single expression. `// let a = 6`
• However, doing this `// var a = 6; a = 7` will not comment out the second line.<br>
**Mutliline Comments**
• Allows for massive comments `/*`<br>
`this code is ignored`<br>
`so is this`<br>
`*/` <- This ends the massive comment<br>
**Warning and Error Messages**<br>
I have provided warning and error messages.<br>
Errors stop your program and tells you what went wrong on what line.<br>
Warnings never halt your code, but they give you a short message. (They can be turned off and ignored!)
