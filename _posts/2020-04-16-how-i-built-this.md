---
layout: post
title: This Website Using Jekyll, GitHub Pages, Docker, and Travis
excerpt: An indepth guide to the fundamentals of Jekyll through the lense of a non-coder.
categories: [meta, code]
hide: true
permalink: /dennis/
---

# First Things First
As with anything technical, there is a lack of material on that stage between beginner and professional — for me this is the stage I constantly live when it comes to software. Many blogs will tell you how to setup a basic GitHub Pages-hosted, Jekyll-built website, any other blogs will show you how they setup docker and microsoft azule to deploy their website. But not many will make that connection between "what is going on here" and "this is how you do it". This post tries to 1) break down what is going on "behind the scenes" as jekyll builds your website and 2) showcase my workflow and the challenges I overcame so that you can identify key blockages early on, understand why they happen, and improve upon them. 

Here's what I'm using with links to the relevant sectrions: 
* [Jekyll](https://jekyllrb.com):`3.8` as a static site generator (_with custom plugins_)
* [GitHub Pages](https://pages.github.com) to _host_ the website (plus routing from a custom domain provied by [Namecheap](https://www.namecheap.com)).
* [Travis](https://travis-ci.org) and [Docker](https://www.docker.com) to _build and deploy_ the static site to the `master` branch of my GitHub repository, which GitHub serves and hosts automatically. 
* [Katex](https://katex.org) for displaying Maths _whilst using [kramdown](https://kramdown.gettalong.org/index.html)_, the default markdown converter in Jekyll.

I'll also point out some Windows traps, demonstrate my git workflow (and provide alternatives), give you some ideas on how to extend your theme's layouts, and show you how to display Maths in _both Mathjax and Katex_. 

<!-- TODO: TABLE OF CONTENTS -->

### Going Further
- [Liquid Templating Crash Course](https://www.seanh.cc/2019/09/29/liquid) for extending the functionality of different `.html` files and layouts. 
