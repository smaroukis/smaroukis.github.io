---
layout: post
title: Example Syntax Post
excerpt: "This is a description under the title."
categories: [tag1, tag2]
---

![Cover](/img/foster_falls/ff_cover.jpeg)

## Photo with Caption

![Photo text]({{"/img/foster_falls/ff_cover.jpeg"}})

## PDF hyperlink

[pdf example]({{"/file/echo-lake-to-angora.pdf"}})

[//]: # (This is a comment)

## Link to other posts

[//]: # (Below, site.baseurl is optional)

[Link to a post]({{ site.baseurl }}{% link _posts/2017-01-27-southern-comfort-food.md %})

[Link to a post]({{ site.baseurl }}{% post_url 2017-01-27-southern-comfort-food %})

[Link to a page]({{ site.baseurl }}{% link index.html %})

[Link to a file]({{ site.baseurl }}{% link /file/echo-lake-to-angora.pdf %})

## Embedded Map

<div id="map" class="map leaflet-container" style="height: 500px; position:relative;"></div>

<script>
    var map = L.map('map').setView([-118.179,36.495], 10);
    L.tileLayer('https://api.mapbox.com/styles/v1/smaroukis/cj079ohrl00012ro37wtvmoea/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1Ijoic21hcm91a2lzIiwiYSI6ImNpcTZyNW96djAwZ3BmbmtrcnZpbXRoMG0ifQ.wlaRgsckB1_vTtYKWEhZJw').addTo(map)
</script>

## Latex

Surround maths in `$$...$$`
