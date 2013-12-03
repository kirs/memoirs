## Memoirs

Memoirs is an aggregator of Rubygems.org history (CHANGELOGs).
It retrieves all versions of the most popular gems and parses CHANGELOGs.

As a result, you can see what is changed in specific version of Devise (or some other library) without the need to open repo and loopup of this version in CHANGELOG.md

Memoirs is a Rails API app with little frontend in `public/frontend`.
To parse CHANGELOGs, we use [treetop](https://github.com/nathansobo/treetop).
For background processing we use Sidekiq.

Credits:

* Kir Shatrov
* Andrey Ognevsky

Inspired by [changems](https://github.com/benhamill/changems).
