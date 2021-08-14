[Home](Home.md) - Page2

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