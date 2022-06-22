---
layout: page
title: "About markdown"
permalink: /about-markdown/
---

You can use markdown to write and format text in GitHub - in Issues, Pull Requests, and markdown files. Here is a list of the most important features.

### Headings 

# `#` Heading
## `##` Heading2
### `###` Heading3

### Formatting text

Formatting `**`**bold text**`**`, `_`_italic text_`_` and `***`***bold and italic***`***`. 
You can also use `~~`~~strikethrough text~~`~~`. 

> `>` This is a quote
>> `>>` This is a nested quote

## Links

https://xpirit.com/
[Link Text](https://xpirit.com)
[Test.pdf](https://github.com/wulfland/AccelerateDevOps/files/8073527/Test.pdf)

### Images

You can drag or drop images to markdown and they will get uploaded automatically.

![octocat](https://user-images.githubusercontent.com/5276337/170288469-b13b7c5c-541c-45e5-990f-f59902f02ab3.png)

#### Size images

Use `img` to set the with of the image:

<img width="200" alt="image" src="https://user-images.githubusercontent.com/5276337/170288469-b13b7c5c-541c-45e5-990f-f59902f02ab3.png">

#### Display images depending on theme:

![Light](https://user-images.githubusercontent.com/5276337/170288469-b13b7c5c-541c-45e5-990f-f59902f02ab3.png#gh-light-mode-only)
![Dark](https://user-images.githubusercontent.com/5276337/170288514-21321111-72b7-4ec2-98e6-b19c9a090721.png#gh-dark-mode-only)

You can now also use `picture` tag:

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://user-images.githubusercontent.com/5276337/170288514-21321111-72b7-4ec2-98e6-b19c9a090721.png">
  <img src="https://user-images.githubusercontent.com/5276337/170288469-b13b7c5c-541c-45e5-990f-f59902f02ab3.png">
</picture>

### Videos

https://user-images.githubusercontent.com/5276337/154125940-0172902e-da3f-4e6e-a4a4-cab7c6a86cde.mp4

### Lists

- List item 1
- List item 2

1. Item 1
2. Item 2 

###  Nested lists
1. Root
    - First nested item
       - Second nested item


### Footnotes

You can user a footnote[^1] in markdown that allows you to jump to it and back using links.

A footnote can have multiple lines[^2].  

You can also use words, to fit your writing style more closely[^note].

[^1]: My reference.
[^2]: Every new line should be prefixed with 2 spaces.  
  This allows you to have a footnote with multiple lines.
[^note]:
    Named footnotes will still render with numbers instead of the text but allow easier identification and linking.  
    This footnote also has been made with a different syntax using 4 spaces for new lines.
    
### Comments and escaping

<!-- This comment will not appear in the rendered Markdown -->

Use <kbd>\\</kbd> to escape markdown: This text is \*not bold\* and \_not italic\_.

### emojis and keyboard keys

:+1: :shipit: :medal_sports: :-1: :100: :trophy: :house:

<kbd>Ctrl</kbd> <kbd>Enter</kbd> <kbd>Space</kbd> <kbd>Ctrl</kbd>+<kbd>C</kbd>


### Tables

| Left-aligned | Center-aligned | Right-aligned |
| :---               |            :---:         |               ---: |
| **title1**      | `git status`        | 1.75%  |
| **title2**     | `git diff`             | 2.81%  |
| **title3**     | `git add`            | 3.51%  |

### Collapsable sections

<details>
This content is hidden by default and you have to click `Details` to see it.
</details>

<details>
  <summary>Details with custom summary</summary>
  This content is hidden by default and you have to click `Details with custom summary` to see it.
</details>

### Syntax highlighted code blocks

C#:
```csharp
void WriteHelloWorld(string name)
{
  Console.WriteLine("Hello World and {0}!", name);
}
WriteHelloWorld("John Doe");
// writes 'Hello World and Johnm Doe' to STDOUT
```
Ruby:
```ruby
def print_helloWorld(name)
  puts "Hello World and #{name}!"
end
print_helloWorld('Jon Doe')
#=> prints 'Hello World and Jon Doe!' to STDOUT.
```
JavaScript:
```javascript
function writeHelloWorld(name) {
  console.log(`Hello World and ${name}!`);
}
writeHelloWorld('Jon Doe');
// writes 'Hello World and Jon Doe!' to STDOUT.
```

### Flow Chart

```mermaid
graph RL;
    7e536==>96a85;
    b7e6b==>7e536;
    main-.->b7e6b;
    HEAD-->main;
    55805==>7e536;
    branch-.->55805;
    tag-.->55805;
```

