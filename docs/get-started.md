---
layout: page
title: "Get started"
permalink: /get-started/
---

HitHub Pages supports `Jekyll` as the renderer. You can use it to write content in markdown. 

### Configuration

For this page I use the following `_config.yml`:

````yaml
title: Accelerate DevOps with GitHub
description: >-
  This is is a sample Jekyll website that is hosted in GitHub Pages.
  It demonstrates how to create nice content using markdown. 
twitter_username: mike_kaufmann
github_username: wulfland
theme: minima
markdown: kramdown
plugins:
  - jekyll-feed
show_excerpts: true
header_pages:
- get-started.md
- about-markdown.md
- About.md
```

### The homepage

Add a file index.md to your pages folder and add the following header:

```markdown
---
layout: home
---
```

This will serve as the homepage and hosts your blog posts and pages. 

### Pages

A page is a markdown file in the root of your pages folder. It has a header like this:

```markdown
---
layout: page
title: About
permalink: /about/
---
```

If you want to sort the pages you can do this in the config file.

### Posts

Posts must be in the folder `_posts`and must have a special file format. The format is the following:

```text
YYY-MM-DD-NAME-OF-POST.md
```

`YEAR` is a four-digit number, `MONTH` and `DAY` are both two-digit numbers. The file can have the `.md` or `.markdown` extension.

Add a header with the following values to the file:

```markdown
---
layout: post
title:  "Posting in Jekyll"
date:   2021-08-13 17:30:00 -0200
categories: GitHub Jekyll Markdown
permalink: /2021-08-13_posting-in-jekyll/
published: true
---
```

That's it. Now you just have to push your changes to GitHub to update your website.
