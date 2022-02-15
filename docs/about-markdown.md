---
layout: page
title: "About markdown"
permalink: /about-markdown/
---

You can use markdown to write and format your blog posts. In this post I will show you how to use markdown syntax to create nice looking posts.

### Text formatting

Text can be **bold**, _italic_ or ~~strikethrough~~.

### Links

You can normal links like https://www.google.com, set a [link text](https://google.com), or use [relative links](/../../settings/environments/new).

You can also link to [other sections in the same file](#sourcecode)

### Images and attachments

Drag you images to markdown and they automatically get uploaded: 
![octocat](https://user-images.githubusercontent.com/5276337/154123090-166819a4-fbf7-4022-a732-d3ed3692e913.png)

You can format them using normal HTML:
<img width="200" alt="Octoca" src="https://user-images.githubusercontent.com/5276337/154123090-166819a4-fbf7-4022-a732-d3ed3692e913.png">

Other file types get uploaded as a link:
[Test.pdf](https://github.com/wulfland/AccelerateDevOps/files/8073553/Test.pdf)

You should use relative paths for images. Here are some examples:

| Context	| Relative Link |
|---------|---------------|
| In a `.md` file on the same branch | `/assets/images/electrocat.png` |
| In a `.md` file on another branch	| `/../main/assets/images/electrocat.png` | 
| In issues, pull requests and comments of the repository	| `../blob/main/assets/images/electrocat.png` | 
| In a .md file in another repository	| `/../../../../github/docs/blob/main/assets/images/electrocat.png` | 
| In issues, pull requests and comments of another repository	| `../../../github/docs/blob/main/assets/images/electrocat.png?raw=true` |

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
