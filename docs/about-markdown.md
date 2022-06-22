---
layout: page
title: "About markdown"
permalink: /about-markdown/
---

You can use markdown to write and format your blog posts. In this post I will show you how to use markdown syntax to create nice looking posts.

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



