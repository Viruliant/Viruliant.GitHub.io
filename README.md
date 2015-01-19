# Github Pages Template

______________
## gh-template
The built in Github markdown displayer won't allow stuff like:

* mathjax code like this: `\\[e^x =\lim_{n\to\infty}\left(1+\frac{x}{n}\right)^{n} = \sum_{n=0}^{\infty} \left( \frac{x^n}{n!} \right)\\]`  
* embed youtube videos
* [SVG Parameters](http://www.w3.org/TR/SVGParamPrimer) code like this: `<object type="image/svg+xml" data="map.svg?y=255&x=172"></object>`

This is a template to allow you to do almost anything, including on your own server. Just use [NodeJS](http://nodejs.org/) and the included `gh-template-node.js` file

### Code is @[github.com/MinJSLib/gh-template](https://github.com/MinJSLib/gh-template)
### Demo is @[minjslib.github.io/gh-template](http://minjslib.github.io/gh-template/)

____________
## Chapter 1

This chapter and the following chapter is just example markdown to show what all [gh-template](https://github.com/MinJSLib/gh-template)
can do.

\\\\[e^x =\lim_{n\to\infty}\left(1+\frac{x}{n}\right)^{n} = \sum_{n=0}^{\infty} \left( \frac{x^n}{n!} \right) = \frac{x^n}{0!} + \frac{x^n}{1!} + \frac{x^n}{2!} + \frac{x^n}{3!} + \text{⋅ ⋅ ⋅}\\\\]

<iframe width="420" height="315" src=
"//www.youtube.com/embed/vtLLdtBQBoI?list=PLjgrsP5Vg40lWLyr1whakzuDsmGW0el0y&loop=1"
 frameborder="0" allowfullscreen></iframe>

|Some   |Table  |
|-------|-------|
|Example|Content|

____________
## Chapter 2

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore
et dolore magna aliqua.

<object type="image/svg+xml" data="map.svg?x=400&y=130"></object>

Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

![](./spin.gif)
