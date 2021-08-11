---
layout: post
title:  "Posting Source Code"
date:   2021-08-10 19:00:00 -0200
categories: GitHub Blog
permalink: /2021-08-10_posting-source-code/
published: true
---

Source code can be `inline` or as blocks. Blocks can have syntaxhighlighting for many different languages.

_JavaScript:_

```js
function writeHelloWorld(name) {
  console.log(`Hello World and ${name}!`);
}
writeHelloWorld('Jon Doe');
// writes 'Hello World and Jon Doe!' to STDOUT.
```

_Ruby:_

```ruby
def print_helloWorld(name)
  puts "Hello World and #{name}!"
end
print_helloWorld('Jon Doe')
#=> prints 'Hello World and Jon Doe!' to STDOUT.
```

_C#:_

```csharp
void WriteHelloWorld(string name)
{
  Console.WriteLine("Hello World and {0}!", name);
}
WriteHelloWorld("John Doe");
// writes 'Hello World and Johnm Doe' to STDOUT
```
