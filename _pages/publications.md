---
layout: single
permalink: /publications/
title: "Publications"
classes: wide
toc: true
# "Updated:" date also reflects edits to the data files this page is built from
last_modified_at_sources:
  - _data/publications.bib
  - _data/publication-links.yml

gallery:
  - url: https://www.dropbox.com/scl/fi/jhoatblsbr16r6eh34u4t/Santangelo-et-al.-2022-Global-urban-environmental-change-drives-adaptation-in-white-clover.pdf?rlkey=gb6dgskpvc1sueoc3wmf50qtg&dl=0
    image_path: /assets/images/science_cover.jpg
    alt: "Cover of Science featuring Santangelo et al. 2022"
  - url: https://www.dropbox.com/scl/fi/x2jvdiqqks5praop3d2zy/Santangelo-Thompson-Johnson-2018-Herbivores-and-plant-defenses-affect-selection-on-plant-reproductive-traits-more-strongly-than-po.pdf?rlkey=t80wx6mmjk94kpgl92hd0q08t&dl=0
    image_path: /assets/images/jeb_cover.jpg
    alt: "Cover of Journal of Evolutionary Biology featuring Santangelo et al."
---

{% include gallery layout="third" class="pub-covers" %}

## Journal articles

{% bibliography --query @article %}

## Book chapters

{% bibliography --query @incollection %}

## Preprints

{% bibliography --query @unpublished %}
