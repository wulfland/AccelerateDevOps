---
layout: post
title:  "Writing Posts with Markdown"
date:   2021-08-12 10:40:00 -0200
categories: GitHub Jekyll Markdown
permalink: /2021-08-12_writing-with-markdown/
published: true
---

You can use markdown to write and format your blog posts. In this post I will show you how to use markdown syntax to create nice looking posts.

### Text formatting

Text can be **bold**, _italic_ or ~~strikethrough~~.

### Sourcecode

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

### Lists

* item 1
* item 2
* item 3

1. item 1
2. item 2
3. item 3

### Blockquote

> This is a blockquote
>
> It can span multiple lines

### Tables

| Head   | Head 2 | Number |
|:-------|:-------|-------:|
|item1   | text   |    10.5|
|item2   | text   |     5.5|
