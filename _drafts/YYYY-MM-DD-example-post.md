---
layout: post
title: Example Syntax Post
excerpt: "This is a description under the title."
categories: [tag1, tag2]
---

![Cover](/assets/img/avatar.jpg)

## Photo with Caption - Using `baseurl`

![Photo text]({{"/assets/img/avatar.jpg" | relative_url }})

## Photo with Caption - Using Absolute Url `url`

![Photo text]({{"/assets/img/avatar.jpg" | absolute_url }})

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