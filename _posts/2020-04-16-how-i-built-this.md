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

Here's what I'm using with links to the relevant sections: 
* [Jekyll](https://jekyllrb.com):3.8 as a static site generator (_with custom plugins_). Note that as of writing the next major release of Jekyll (4.0.0) has been released but I have yet to upgrade.
* [GitHub Pages](https://pages.github.com) to _host_ the website (plus routing from a custom domain provied by [Namecheap](https://www.namecheap.com))
* [Travis](https://travis-ci.org) and [Docker](https://www.docker.com) to _build and deploy_ the static site to the `master` branch of my GitHub repository, which GitHub serves and hosts automatically
* [Katex](https://katex.org) for displaying Maths _whilst using [kramdown](https://kramdown.gettalong.org/index.html)_, the default markdown converter in Jekyll

I'll also point out some Windows traps, demonstrate my git workflow (and provide alternatives), give you some ideas on how to extend your theme's layouts, and show you how to display Maths in _both Mathjax and Katex_. 

<!-- TODO: TABLE OF CONTENTS -->
Tip: Go to the beginning of any section to see further resources. 

# Local Dependencies
* [git](https://git-scm.com/download/) - on Windows it is nice to use the git-bash shell that comes with git
* [docker](https://docs.docker.com/get-docker/) and, for Linux, [docker-compose](https://docs.docker.com/compose/install/) (docker-compose is included with the Docker-Desktop installation on Windows and Mac OS) 

# Jekyll
### Resources
* [The best beginner guide for Jekyll and GitHub Pages](http://jmcglone.com/guides/github-pages)
* [The docs](https://jekyllrb.com/docs/)
* Jekyll's [Ruby 101](https://jekyllrb.com/docs/ruby-101/): describes gems, Gemfiles, and Bundler]
* [Liquid Templating Crash Course](https://www.seanh.cc/2019/09/29/liquid) for extending the functionality of different `.html` files and layouts. 
* Official Jekyll Docker [image](https://hub.docker.com/r/jekyll/jekyll/) and [repo](https://github.com/envygeeks/jekyll-docker/blob/master/README.md)

### Dependencies and Getting Started
Since we are using the official jekyll docker image, the only thing we need to install locally is docker and git (for Windows and bare-bones Linux distributions). This makes it easy to use different computers and not worry about local dependencies. Here's an overview of how we're managing the ruby and gem dependencies, starting with the ones we explicitly state:
- **Jekyll**: The version is determined mainly by our **Gemfile** (`gem "jekyll", "~> 3.8"`)[^1]. We should also make sure to match the docker image jekyll version as specified in our `docker-compose.yml` or from the command line (e.g. `jekyll/jekyll:3.8` for version 3.8)
- **Theme and Other Plugins**: Either as explicitly specified in the **Gemfile**, or implicitly depending on the version of Jekyll and other dependent gems
- **Katex** or **Mathjax**: Defined where you put your javascript, mine is in a file under my `_includes` folder

Dependencies we don't explicitly state:
- **Ruby**: The ruby version is handeled by the jekyll/jekyll docker image (as of writing it was using 2.6.3)
- 

[^1]: `~> 3.8` in a Gemile means any version equal to or greater than 3.8 but less than the next major version (4.0)