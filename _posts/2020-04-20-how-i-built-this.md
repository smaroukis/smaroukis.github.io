---
layout: post
title: How to Customize Jekyll Using GitHub Pages, Docker, and Travis
excerpt: An indepth guide to the fundamentals of Jekyll through the lense of a non-coder.
categories: [meta, code]
katex: true
---
Check out the [source][post-source] for this blog post!

This post is for:
* 1) someone who wants to use custom Jekyll plugins but still host on GitHub pages
* 2) a technologically savvy user who wants to start a blog spend and likes to spend time on the command line (and doesn't want to [read the docs][jekyll-docs]) 
* 3) someone who already has a Jekyll blog but wants to extend their theme's functionality (and doesn't want to [read the docs][jekyll-docs])
> For (2) you may already have built a ruby project and thus are more ruby-savvy than me. Then you won't need docker and you probably have your own deployment workflow. But you need to know more about how Jekyll is building and serving files, what to include and exclude in your configurations, how to use Liquid tags and where to put your custom javascript. For (3) maybe you have been using Jekyll for a few months but want to develop a more fundamental understanding of what is going on behind the scenes. This is where I was a few months ago after I hadn't blogged for a year, I looked at my repo and realized that I didn't know what was going on.

[//]: TODO: add links to the relevant sections
What I'm Using:
* [Jekyll](https://jekyllrb.com) version 3.8
* [GitHub Pages](https://pages.github.com) to _host_ the website but **not** to build it
* [Docker](https://www.docker.com) to **build locally** and to **build in a Travis instance**
* [Travis](https://travis-ci.org) to deploy the static site to the `master` branch of my GitHub repository 
* [Katex](https://katex.org) for displaying Maths _whilst using [kramdown](https://kramdown.gettalong.org/index.html)_, the default markdown converter in Jekyll
* Others: Plotly for graphs, Mapbox and Leaflet for maps.

## Table of Contents
{:.no_toc}
1. TOC_Placeholder
{:toc}

## Getting Started

### Basic Knowledge, Ruby and Bundler
Some basic knowledge of the command line, Jekyll, bash, docker, and git will be useful. You may want to read through Jekyll's [quick start guide][jekyll-docs] to see what is being installed and used locally like `ruby` and `Bundler`. The **TL;DR** is that `ruby` is a programming languagage whose libraries are packaged in `gems`. `Bundler` manages the gems using the versions found in a local `Gemfile`, installing the specified version of various gems and their dependencies. The `Gemfile` is stored in the root directory of the project and the gems are downloaded and stored by `Bundler` somewhere like `/usr/local/bundle`. See [this stack overflow answer](https://stackoverflow.com/questions/15586216/bundler-vs-rvm-vs-gems-vs-rubygems-vs-gemsets-vs-system-ruby) for more detail. 


I'll also point out some Windows traps, demonstrate my git workflow, and give you some ideas on how to extend your theme's layouts.

### Local Dependencies
* [git](https://git-scm.com/download/) - also on Windows it is nice to use the git-bash shell that comes with git
* [docker](https://docs.docker.com/get-docker/) and, for Linux, [docker-compose](https://docs.docker.com/compose/install/) (docker-compose is included with the Docker-Desktop installation on Windows and Mac OS) 

Since we are using the official jekyll docker image, the only thing we need to install locally is docker and git (for Windows and bare-bones Linux distributions). This makes it easy to use different computers and not worry about local dependencies. Here's an overview of how we're managing the ruby and gem dependencies, starting with the ones we explicitly state:
- **Jekyll**: (explicit) The version is determined mainly by our **Gemfile** (`gem "jekyll", "~> 3.8"`)[^1]. We should also make sure to match the docker image jekyll version as specified in our `docker-compose.yml` or from the command line (e.g. `jekyll/jekyll:3.8` for version 3.8)
- **Theme and Other Plugins**: Either as explicitly specified in the **Gemfile**, or implicitly depending on the version of Jekyll and other dependent gems
- **Katex** or **MathJax**: (explicit) Defined where you put your javascript, mine is in a file under my `_includes` folder
- **Ruby**: (implicit) The ruby version is handeled by the jekyll/jekyll docker image (as of writing it was using 2.6.3) 

### Building Your Site From Scratch

First you will either build a new site from scratch or pull one down from a repo. Generally to build a new site you run `jekyll new <sitename>` to pull down the jekyll source files into the `<sitename>` directory. Then you go into this directory and run `jekyll serve` which will both build the site and serve it locally on port 4000 by default. If you didn't want to serve the site but instead just build the static html files you would do `jekyll build`. But since we don't have Ruby, Jekyll, or Bundler locally we use a docker container for all of these.

The docker commands are as follows (you may need `sudo` for `docker run`):

```sh
export JEKYLL_VERSION=3.8
docker run -v $(pwd):/srv/jekyll jekyll/jekyll:$JEKYLL_VERSION jekyll new .
```

> Note I will be using Jekyll 3.8 throughout, so anytime you see this change it to the version you are working with.

This does the following:

1. Mounts our **current host directory**[^2] (`$(pwd)`) to the container's `/srv/jekyll` (the docker image has specific priveleges to run jekyll commands in this location). Anything created by the container in `/srv/jekyll` will show up in our host's current directory, which should be our blog's project directory
2. Uses the `jekyll/jekyll:3.8` image to **initialize a jekyll site** in `/srv/jekyll`, which will also appear in our current host directory (see #1). This consists of the bare bones files that Jekyll needs to build a site, notably a `Gemfile`, `_config.yml` and a Markdown entry under the `_posts` directory. If you look closely there is also a hidden `.gitignore` file created.

The directory structure should now be

```sh
.
├── 404.html
├── about.markdown
├── _config.yml
├── Gemfile
├── index.markdown
├── _posts
    └── 2020-04-18-welcome-to-jekyll.markdown
```

We actually don't have a site yet, we just have the source files that jekyll will build one with. Let's do that now in docker.

```sh
docker run -it -p 4000:4000 -v $(pwd):/srv/jekyll jekyll/jekyll:$JEKYLL_VERSION jekyll serve
```
We have added the `-it` command to run it interactively and the `-p` command to forward port 4000 on the container to port 4000 on the host. Navigate to [http://localhost:4000](http://localhost:4000) to see the website. The directory should now have a new directory `_site` in addition to the source files which are left untouched. 

```sh
_site
├── 404.html
├── about
│   └── index.html
├── assets
│   ├── main.css
│   ├── main.css.map
│   └── minima-social-icons.svg
├── feed.xml
├── index.html
└── jekyll
    └── update
        └── 2020
            └── 04
                └── 19
                    └── welcome-to-jekyll.html
```

> A `Gemfile.lock` file will also have been created in the root directory. This is a list of all of the gems installed by `Bundler` at run time, including the exact versions and any dependencies not declared in the `Gemfile`. Note that both the `Gemfile` and the `Gemfile.lock` should both be checked in to our GitHub repo.

You can see that all the static files needed for displaying a website are under `_site` and the rest of the source files are unchanged. In fact Jekyll will copy any of the source files into the `_site` directory unless they are excluded in the configuration file (Gemfiles, Markdown, and files beginning with `_` or `.` are excluded by default). Further, if any files have YAML front matter, these files will be "processed" by Jekyll. 

One last point -- the path to the actual blog posts in html depends on how the permalink and categories are set up in the configuration file, which we'll look at next.

## Custom Configuration

### Changing Themes
A list of theme showcases can be found at [https://jekyllrb.com/docs/themes/](https://jekyllrb.com/docs/themes/).

> Note any incompatibility between the Jekyll version and the theme of choice. Some themes have not been updated to support Jekyll 4.0.

Generally you'll want to check the theme's documentation on how to download a theme. In theory, for themes with gems, you can just add the gem to your gemfile and update the configuration file. Some themes require specific structure that is better mimicked from downloading the source files yourself.

In our case, let's try the [**Basically Basic**](https://mmistakes.github.io/jekyll-theme-basically-basic) theme which is a good out-of-the-box replacement for Jekyll's default Minima theme. It also has [great documentation](https://github.com/mmistakes/jekyll-theme-basically-basic) to explore and give you ideas on how to extend whatever theme you're using. 

Update `Gemfile` with the theme's gem

```yaml
gem "jekyll-theme-basically-basic"
```

Update `_config.yml` 

```yaml
theme: jekyll-theme-basically-basic
```

If you are still in the interactive shell from the first `jekyll serve`, kill it with `ctrl + C`. Then **serve** the site with the same `docker run ... jekyll serve` command as before.

```sh
docker run -it -p 4000:4000 -v $(pwd):/srv/jekyll jekyll/jekyll:$JEKYLL_VERSION jekyll serve
```

### Extending Themes
There are more source files actually stored within the gem that Bundler downloads. These are folders such as `assets`, `_includes`, `_layouts`, `_sass` that are called upon when Jekyll builds the site. Any local files with the same nomenclature as the theme's gem will override that file, allowing you to customize themes. For example, this allows us to use insert javascript that will render $$\LaTeX $$ for math posts. See [the docs](https://jekyllrb.com/docs/themes/#overriding-theme-defaults) for more. 

### Editing _config.yml
Some other things you may want to change are:
* `url`: the hostname and protocol for you site. If you're hosting on GitHub pages it will be `https://<username>.github.io`.
* `permalink`: the path to your posts online, e.g. `/blog/:title`. See the [docs](https://jekyllrb.com/docs/permalinks/#placeholders) for other placeholders like year, month, and day. Note that you can also add a permalink for an individual post in the YAML front matter of that post.
* `exclude` and `include`: for Jekyll `build`
  * If we want to build the site ourselves instead of GitHub Pages, we include a `.nojekyll` empty file, since hidden files are excluded by default and we want this file to propogate to our `_site` folder so that it is there when we push it to GitHub. 
  * Other files that we need in our source but not our site should be excluded or prepended with `.` or `_`. 
* anything else that you or your theme has chosen to define. These are available via liquid tags as {% raw %}`{{ site.<variable> }}`{% endraw %}

## Setting Up Our Blogging Workflow
Here are the highlights:
1. Create and edit the Markdown files under your `_posts` directory (note the specific naming structure of the files as `YYYY-MM-DD-title-goes-here.md`)
2. Easily serve the local website via container with `docker-compose up`
3. Commit/Push edits to a `source` or `release` branch 
  * Anything under `_site` should be ignored by git (if not add `_site` to your `.gitignore`), which is necessary since you will have conflicts between building and serving, since `build` will use the actual `url` defined in `_config.yml` and `serve` will build the site to `localhost:4000`. 
4. Build the site and push only the contents of `_site` to the `master` branch, which GitHub will host automatically. 

### Serving Via _Docker Compose_
Docker-Compose is normally used to spin up a fleet of containers, but I use it as a convenient short-hand way to use local development flags across multiple development environments. Of course you could write a simple shell script to do the same thing if you only use the same OS all the time.

> On Windows things are a bit wonky. You'll have to create an extra `_config.yml` file so that you can use `url=localhost` instead of the default `0.0.0.0` that `jekyll serve` will do. [This blog post][jekyll-serve-windows] lays it all out. 

To quickly serve the website we create the following file named `docker-compose.yml` (install [docker][docker-install] and [docker-compose][docker-compose-install] as needed):


```yaml
# ./docker-compose.yml

version: '3.7' # docker compose version
services:
  environment:
    - JEKYLL_ENV=local
  site:
    command: jekyll serve --drafts --incremental --force_polling --watch
    image: jekyll/jekyll:3.8
    volumes:
      - .:/srv/jekyll
    ports:
      - 4000:4000 
```

Note this will **only be used to preview the site locally**. If we are building the site ourselves locally we cannot serve it at the same time, since Jekyll has specific overrides for the `serve` command (such as the url). 

Since we are only using it locally we can add it to our `.gitignore` file. Since it does not begin with `.` or `_` we also need to exclude it in our `_config.yml` file or else it will be copied into the `_site` folder when built.

```yaml
# _config.yml

exclude: [docker-compose.yml]
```

Then to run this in the background as we edit our posts we run:

```sh
docker-compose up -d
```

with the detached `-d` flag to detach it from a shell. 

#### Other Docker Commands
Use `docker ps` to list running containers and `docker ps -a` to list all containers. Use `docker image ls` to list docker images.

**Executing commands in the container**: You have an existing container that you want to run something like  `bundle update` in[^3], but you don't want to start a new container from the `jekyll/jekyll` image which would cause all of the gems to be downloaded again[^4]. Get the container name from `docker ps` or `docker-compose ps` (the container has to be active) and run the following:

```sh
docker exec -it <container_name> bundle update
```

To get a shell in the container run

```sh
docker exec -it <container_name> /bin/sh
```

**Stopping a Container**: If you served the Jekyll site in detached mode (`-d`) and you want to stop the server so that port 4000 is available for something else.
```sh
docker kill <container_name>
```

**Restarting a Container**: You want to re-serve the Jekyll site, which means you need to restart the docker container (assuming the container still exists)
```sh
docker restart <container_name>
```

**Removing Unused Containers**: Any containers run without the `--rm` option will still be available. To delete all stopped containers use
```sh
docker system prune
```

### Aside: How GitHub Pages Builds Jekyll in --Safe Mode
Ok so now you have a full fledged Jekyll site locally with source files in the root of the project and all the static files necessary to serve the site in the `_site` folder. 

If you wanted just to quickly see this site on the real internet you could simply try to push everything to the `master` branch on your `<username>.github.io` repo. What would happen? Likely GitHub pages would see that you have Jekyll source files and try to build and serve your site. 

1. In your User repo go to **Settings > Options > Scroll Down to GitHub Pages**. Here we can see that GitHub Pages is building the Jekyll site from the `master` branch. Note that for User pages (`<username>.github.io`) this is the only option. For Project pages, people often change this to `gh-pages`. 
![GitHub Settings > Options > GitHub Pages][gh-pages-source]
2. If you navigate to the **Environments** page on your repo you should see the GitHub Pages deployed your site
![GitHub Environments on your repo][gh-environ]
3. The Activity Log shows the history of deployments. Clicking on **View Deployment** shows you the current site.
![GitHub Activity Log][gh-activity-log]
4. If the GitHub pages `jekyll build` fails or if you are using an unsupported theme you will receive an email from GitHub pages support.

So, what is going on here? Well behind the scenes GitHub pages is using `jekyll build --safe` to disable custom plugins and has the following configurations ([source][gh-pages-config] and [Jekyll docs][jekyll-docs-ghpages]):

```yaml
lsi: false
safe: true
source: [your repo's top level directory]
incremental: false
highlighter: rouge
gist:
  noscript: false
kramdown:
  math_engine: mathjax
  syntax_highlighter: rouge
```

If you wanted to build this locally you would use a different Gemfile than we've made:

```
# GH Pages Local Gemfile Example
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
```

A few things to note here. We are forced into `kramdown` for markup, `mathjax` for maths, and `rouge` for syntax highlighting. This is important later on because even if we specify something different, when we deploy to `master` these are what is being used. {:.notice}


### Aside: How to Override the GitHub Pages --Safe Build

There are a few special setups to tell GitHub that we **don't** want them to build the site. First, instead of deploying to master the Jekyll source files, we deploy **only the built static files**, the contents of _`_site`_. Second we add an empty file named `.nojekyll` so that Pages knows not to run jekyll build.


```sh
.nojekyll
404.html
about
└── index.html
assets
├── main.css
├── main.css.map
└── minima-social-icons.svg
feed.xml
index.html
jekyll
└── update
    └── 2020
        └── 04
            └── 19
                └── welcome-to-jekyll.html
```

Since Jekyll will overwrite whatever is in `_site` upon building, we create the `.nojekyll` file in the **root** directory and add `include: [.nojekyll]` into our `_config.yml` so that this file propogates into the build destination.

### Commiting Local Edits to a Source Branch

So now we understand what is going on behind the scenes with the _Asides_ above. This allows us to develop blog posts in a source or release branch seperately from the static files that GitHub will host. We can either build the static files ourselves or, better yet, when we push to a release branch we can have a continuous deployment tool (like Travis or Jenkins) build and push the static files to the `master` branch on GitHub. 

> Note: I named my release branch `master-source`. 

1. `git checkout master-source`
2. Make edits yada yada
3. `git add` stuff and `git commit -m 'this blog is getting really long'`
4. `git push --set-upstream origin master-source`

Note that we really don't want to make edits on the `master-source` branch, so we would really checkout a different branch, merge those changes into `master-source` and then push to the remote. 

### Setting Up Travis

To setup or continuous integration (CI) tool we need to tell them what branch to watch for changes on, what docker command to run, and what branch and files to push the built site to. There are some good Travis + Jekyll + GitHub Pages how-to's like [this one][blog-travis-example].

```yaml
# ./.travis.yml
language: python # we will use the ruby of the docker container
os: linux
dist: bionic
before_install:
  - docker pull jekyll/jekyll:3.8
branches:
  only:
  - master-source # safelist to only build this branch; edit this to your release or source branch
script: 
  - docker run --rm -it -v="$PWD:/srv/jekyll" jekyll/jekyll:3.8 jekyll build
deploy:
  provider: pages
  local_dir: _site/ # only deploy the contents of _site to the master branch
  skip_cleanup: true
  target-branch: master # where you want to deploy the build to
  token: $GITHUB_TOKEN # set this up in your travis profile
  strategy: git
  keep_history: true
  on:
    branch: master-source # deploy only from the source branch
notifications:
  email:
    recipients:
      - smaroukis@gmail.com # I hope there are no bots scraping this webpage for email addresses
    on_success: always
    on_failure: always
```

A few things to note

1. `script`: This is the main command we are using to build the site with Travis/Docker instead of GitHub Pages. Since we are using `jekyll build` by default we are using `JEKYLL_ENV=production` and the other matter specified in the `_config.yml`. 
2. `only: master-source` and `branch: master-source`: Replace `master-source` with the name of your source/release branch.
3. `local_dir: _site/`: Tells Travis to only deploy the _contents_ of `_site`.
4. `target-branch: master`: Where you want to deploy the the built files to. This should be the same as in your GitHub repo's **Settings > Options > GitHub Pages > Source** points to. 
4. `language: python`: We are using a `python` travis instance to show that we are only using the ruby version of the docker container. It is also faster than a `ruby` instance[^5].


# Wrapping Up

## How are Maths Displayed?

By default the `kramdown` markdown parser will look for math delimiters (`$$...$$`, etc.) and convert these into MathJax html tags (`< script type="math/tex"> $$ P=IV $$ </script>`). Then the javascript included in the header or theme layout will use the specified MathJax version to render on the browser. 

For those who want to use the faster `Katex` engine, you can switch out the `header` javascript pointing to the MathJax cdn host and instead point to Katex host (see [here][katex-cdn]). Then you turn the MathJax `math/tex` script tags into Katex style javascript which executes upon loading the page (see [here][katex-mathjax-conversion]). Note that I had to remove the `defer` part from the Katex starter template `<script>` tags since this will cause the remote javascript pointing to the Katex host to load _after_ the javascript that tries to convert math via Katex has been executed. 

## Displaying Captions Under Images in Leonids

Unfortunately neither kramdown nor my chosen theme, leonids, have good support for captions under photos. Normally you insert a photo in markdown as `![alt image text](/path/to/image)`, but in html the alt image text does not show up as a caption.

The first workaround I found was to insert pure html with a `<figure> <img src=...> <figcaption>` block and corresponding CSS but that is pretty janky. 

The next workaround is to use liquid tags and a new html file in the `_includes` folder that will be rendered upon jekyll build processing. This requires edits to

- the new html file created (mine is `_includes/img.html`)

```html
<!--  ./_includes/img.html -->
{% raw %}<figure>
    <img src="{{site.url}}/{{ include.file }}" alt="{{ include.caption}}">  
    <figcaption>{% raw %}{{ include.caption }}{% endraw %}</figcaption>
</figure>{% endraw %}
```

- the css file for the class or block defined in html (`figure` and `figcaption` above)

```scss
// in ./css/main.scss
figure figcaption{
    text-align: center;
    font-style: italic;
}
```

- and finally the markdown has to be written with a liquid `include` statement

```markdown
{% raw %}{% include img.html file="assets/img/example/path/to/img.png" caption="This caption will show up beneath the picture with the formatting as defined in the main css file" %}{% endraw %}
```

## Improvements and Feedback
For any improvements to content please submit on [GitHub][post-source]. 

* [ ] Environment variables for `$JEKYLL_VERSION` that propogate across OS's and into Travis

## Resources
* [The best beginner guide for Jekyll and GitHub Pages](http://jmcglone.com/guides/github-pages)
* [The docs](https://jekyllrb.com/docs/)
* Jekyll's [Ruby 101](https://jekyllrb.com/docs/ruby-101/): describes gems, Gemfiles, and Bundler]
* [Liquid Templating Crash Course](https://www.seanh.cc/2019/09/29/liquid) for extending the functionality of different `.html` files and layouts. 
* Official Jekyll Docker [image](https://hub.docker.com/r/jekyll/jekyll/) and [repo](https://github.com/envygeeks/jekyll-docker/blob/master/README.md)
* [Jekyll and Docker on Windows by Fabian Wetzel](https://fabse.net/blog/2018/07/16/Running-Jekyll-on-Windows-using-Docker/)
* [Running Jekyll in Docker](https://ddewaele.github.io/running-jekyll-in-docker/) is a great quick and dirty intro to spinning a site up from scratch with Docker
* [Jekyll, Docker, Windows, and 0.0.0.0][jekyll-serve-windows]: for serving your site locally on Windows.


---

# Footnotes

[^1]: `~> 3.8` in a Gemile means any version equal to or greater than 3.8 but less than the next major version (4.0)

[^2]: The syntax for a Windows machine will differ. Using `git-bash` (recommended) I used a backslash to escape the current working directory like `docker run -v /$(pwd):/srv/jekyll jekyll/jekyll`. For full paths you would need to follow Windows syntax before the colon and Linux after: `docker run -v c:\\path\\to\\Windows\\dir:/srv/jekyll ...`

[^3]: You would want to do this if you've updated a gemfile with new themes. Other commands would be `docker exec -it <container_name> gem install "new-jekyll-theme"`.

[^4]: In theory you should be able avoid this by caching the gems locally by additionally mounting a volume to the container's `/usr/local/bundle` directory (e.g. `docker run -v $(pwd):/srv/jekyll -v $(pwd)/gemcache:/usr/local/bundle jekyll/jekyll jekyll build`), but due to permissions errors I was not able to get this to work. 

[^5]: Improve [this post][post-source] by telling me what is the fastest Travis instance os. 

[jekyll-docs]: https://jekyllrb.com/docs/
[jekyll-docs-ghpages]: https://jekyllrb.com/docs/github-pages/
[jekyll-serve-windows]: https://tonyho.net/jekyll-docker-windows-and-0-0-0-0/
[jekyll-ci]: https://jekyllrb.com/docs/deployment/automated/
[docker-compose-install]: https://docs.docker.com/compose/install/
[docker-install]: https://docs.docker.com/get-docker/
[gh-pages-config]: https://help.github.com/en/github/working-with-github-pages/about-github-pages-and-jekyll#configuring-jekyll-in-your-github-pages-site
[blog-travis-example]: https://medium.com/@mcred/supercharge-github-pages-with-jekyll-and-travis-ci-699bc0bde075
[katex-cdn]: https://katex.org/docs/browser.html#starter-template
[katex-mathjax-conversion]: https://kramdown.gettalong.org/math_engine/mathjax.html

[//]: Images
[gh-environ]: {{ site.url }}/assets/img/2020/gh-environ.png
[gh-activity-log]: {{ site.url }}/assets/img/2020/gh-activity-log.png
[gh-pages-source]: {{ site.url }}/assets/img/2020/gh-pages-source.png
[post-source]: https://github.com/smaroukis/smaroukis.github.io/blob/master-source/_posts/2020-04-20-how-i-built-this.md

[//]: TODO: change post-source to use liquid tags to reference itself
