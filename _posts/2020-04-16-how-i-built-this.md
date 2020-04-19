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
## Resources
* [The best beginner guide for Jekyll and GitHub Pages](http://jmcglone.com/guides/github-pages)
* [The docs](https://jekyllrb.com/docs/)
* Jekyll's [Ruby 101](https://jekyllrb.com/docs/ruby-101/): describes gems, Gemfiles, and Bundler]
* [Liquid Templating Crash Course](https://www.seanh.cc/2019/09/29/liquid) for extending the functionality of different `.html` files and layouts. 
* Official Jekyll Docker [image](https://hub.docker.com/r/jekyll/jekyll/) and [repo](https://github.com/envygeeks/jekyll-docker/blob/master/README.md)
* [Jekyll and Docker on Windows by Fabian Wetzel](https://fabse.net/blog/2018/07/16/Running-Jekyll-on-Windows-using-Docker/)
* [Running Jekyll in Docker](https://ddewaele.github.io/running-jekyll-in-docker/) is a great quick and dirty intro to spinning a site up from scratch with Docker

## Dependencies and Getting Started
Since we are using the official jekyll docker image, the only thing we need to install locally is docker and git (for Windows and bare-bones Linux distributions). This makes it easy to use different computers and not worry about local dependencies. Here's an overview of how we're managing the ruby and gem dependencies, starting with the ones we explicitly state:
- **Jekyll**: The version is determined mainly by our **Gemfile** (`gem "jekyll", "~> 3.8"`)[^1]. We should also make sure to match the docker image jekyll version as specified in our `docker-compose.yml` or from the command line (e.g. `jekyll/jekyll:3.8` for version 3.8)
- **Theme and Other Plugins**: Either as explicitly specified in the **Gemfile**, or implicitly depending on the version of Jekyll and other dependent gems
- **Katex** or **Mathjax**: Defined where you put your javascript, mine is in a file under my `_includes` folder

Dependencies we don't explicitly state:
- **Ruby**: The ruby version is handeled by the jekyll/jekyll docker image (as of writing it was using 2.6.3) 

First you will either build a new site from scratch or pull one down from a repo. To build a new site you will run the `jekyll new <sitename>` command to pull down the jekyll source files into the `<sitename>` directory. Then run `jekyll serve` which will both build the site and serve it locally on port 4000 by default. If you didn't want to serve the site but instead just build the static html files you would do `jekyll build`. The docker commands are as follows (you may need `sudo` for `docker run`):

```
export JEKYLL_VERSION=3.8
docker run -v $(pwd):/srv/jekyll -v $(pwd)/gemcache:/usr/local/bundle jekyll/jekyll:$JEKYLL_VERSION jekyll new .
```

This does the following:

1. mounts our current host directory to the container's `/srv/jekyll` (the docker image has specific priveleges to run jekyll commands in this location)
2. creates and mounts the host folder `current_directory/gemcache` to the correct spot in the container (`/usr/local/bundle`)
3. uses the `jekyll/jekyll:3.8` image to initialize a jekyll site in `/srv/jekyll` which will also show up in our current host directory. This consists of the bare bones files that Jekyll needs to build a site, notably a `Gemfile`, `_config.yml` and a Markdown entry under the `_posts` directory. If you look closely there is also a hidden `.gitignore` file created.

The directory structure should now be

![Directory Structure after `jekyll new .`]({{ site.url }}/assets/img/2020/jekyll-new-tree.png)

We actually don't have a site yet, we just have the source files that jekyll will build one with. Let's do that now in docker.

```
sudo docker run -it -p 4000:4000 -v $(pwd):/srv/jekyll -v $(pwd)/gemcache:/usr/local/bundle jekyll/jekyll:$JEKYLL_VERSION jekyll serve
```

We have added the `-it` command to run it interactively and the `-p` command to forward port 4000 on the container to port 4000 on the host. Navigate to [http://localhost:4000](http://localhost:4000) to see the website. The directory should look like

![Directory Structure after jekyll build or serve]({{ site.url }}/assets/img/2020/jekyll-build-tree.png)

You can see that all the static files needed for displaying a website are under `_site` and the rest of the source files are unchanged. In fact Jekyll will copy any of the source files into the `_site` directory unless they are excluded in the configuration file (Gemfiles, Markdown, and files beginning with `_` or `.` are excluded by default). 

One last point -- the path to the actual blog posts in html depends on how the permalink and categories are set up in the configuration file, which we'll look at next.

## Custom Configuration

### Changing Themes
A list of theme showcases can be found at [https://jekyllrb.com/docs/themes/](https://jekyllrb.com/docs/themes/).

Note any incompatibility between the jekyll version and the theme of choice. Some themes have not been updated to support Jekyll 4.0.

Generally you'll want to check the theme's documentation on how to download a theme. In theory, for themes with gems, you can just add the gem to your gemfile and update the configuration file. Some themes require specific structure that is better mimicked from downloading the source files yourself.

Update Gemfile with the theme's gem

```
gem "leonids"
```

Update `_config.yml` 

```
theme: leonids
```

See [here](https://jekyllrb.com/docs/themes/#overriding-theme-defaults) for info on to how to override theme defaults with your own `_includes` and `_layouts`
### _config.yml
Some other things you may want to change are:
* `url`: the hostname and protocol for you site. If you're hosting on GitHub pages it will be `https://<username>.github.io`.
* `permalink`: the path to your posts online, e.g. `/blog/:title`. See the [docs](https://jekyllrb.com/docs/permalinks/#placeholders) for other placeholders. Note that you can also add a permalink for an individual post in the YAML front matter of that post.
* `exclude` and `include`: for Jekyll `build`
  * If we want to build the site ourselves instead of GitHub Pages, we include a `.nojekyll` empty file, since hidden files are excluded by default and we want this file to propogate to our `_site` folder so that it is there when we push it to GitHub. 
  * Other files that we need in our source but not our site should be excluded or prepended with `.` or `_`. 
* anything else that you or your theme has chosen to define. These are available via liquid tags as {% raw %}`{{ site.<variable> }}`{% endraw %}




[^1]: `~> 3.8` in a Gemile means any version equal to or greater than 3.8 but less than the next major version (4.0)