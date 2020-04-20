---
layout: post
title: Example Syntax Post
excerpt: "This is a description under the title."
categories: [tag1, tag2]
---

![Cover](/assets/img/avatar.jpg)

## Urls

[Inline style link to my blog](https://smaroukis.github.com)

[Reference link to my blog][my blog]

You can even use just [my-blog] as a link.

For a hardcoded inline link use <https://smaroukis.github.io>

declarations:

[my blog]: https://smaroukis.github.io

## Photo with Caption 

![Photo text]({{ site.url }}/assets/img/avatar.jpg}})

## PDF hyperlink

[pdf example]({{"/assets/file/echo-lake-to-angora.pdf"}})

[//]: # (This is a comment)

## Link to other posts

[//]: # (Below, site.baseurl is optional)

[Link to a post]({{ site.baseurl }}{% link _posts/2019-01-02-asymmetrical-fault-current.md %} )

[Link to a post]({{ site.baseurl }}{% post_url 2019-01-02-asymmetrical-fault-current %})

[Link to a page]({{ site.baseurl }}{% link index.html %})

[Link to a assets/file]({{ site.baseurl }}{% link /assets/file/echo-lake-to-angora.pdf %})

## Embedded Map

<div id="map" class="map leaflet-container" style="height: 500px; position:relative;"></div>

<script>
    var map = L.map('map').setView([-118.179,36.495], 10);
    L.tileLayer('https://api.mapbox.com/styles/v1/smaroukis/cj079ohrl00012ro37wtvmoea/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic21hcm91a2lzIiwiYSI6ImNpcTZyNW96djAwZ3BmbmtrcnZpbXRoMG0ifQ.wlaRgsckB1_vTtYKWEhZJw').addTo(map)
</script>

## Latex

Surround maths in `$$...$$` as described in `kramdown` documentation