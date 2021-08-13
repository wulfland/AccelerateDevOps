<details>
    <summary>Menu</summary>

* [Home](#Header-1)  
* [Page1](Page1.md)  
  * [Page 1.1](Page1-1.md)
  * [Page 1.2](Page1-2.md)
* [Page2](Page2.md)

</details>

<details>
    <summary>Table of Content</summary>

* [Header 1](#Header-1)  
  * [Head 1.1](#head-11)  

</details>

***

This is an example how you can build a custom wiki using markdown. It does not have a sidebar and footer. But is has the advantage that you can work in pull requests on the changes and you have the wiki close to your code (for auto generation, or to do modifications alongside with your code changes).

The are different tools like VS Code extensions that can auto-generate the ToC if you like.

# Header 1

Summary of the topic.

## Head 1.1

Description of Section 1.

<details>
    <summary>Example</summary>

```js
  nextWhenVisible() {
    // Don't call next when the page isn't visible
    // or the carousel or its parent isn't visible
    if (!document.hidden && isVisible(this._element)) {
      this.next()
    }
  }
```

</details>