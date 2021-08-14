<details>
    <summary>Global Menu</summary>

* [Home](#Header-1)  
* [Page1](Page1.md)  
  * [Page 1.1](Page1-1.md)
  * [Page 1.2](Page1-2.md)
* [Page2](Page2.md)

</details>

***

If you need a custom ToC in addition to the auto-generated ToC by GitHub, you can use links to your headings. Replace spaces with a dash `-`and remove dots `.` like this:

* [Header 1](#Header-1)  
  * [Head 1.1](#head-11)  
  * [Head 1.2](#head-12)  
    * [Head 1.2.1](#head-121)
    * [Head 1.2.2](#head-122)
  * [Head 1.3](#head-13)  
    * [Head 1.3.1](#head-131)
    * [Head 1.3.2](#head-132)

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

## Head 1.2

Description of Section 2.

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

### HEAD 1.2.1

Description of Subsection 1 in Section 2.

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

### HEAD 1.2.2

Description of Subsection 2 in Section 2.

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

## Head 1.3

Description of Section 3.

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

### HEAD 1.3.1

Description of Subsection 1 in Section 3.

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

### HEAD 1.3.2

Description of Subsection 2 in Section 3.

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
