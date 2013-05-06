WISHLIST
========

Wishlist is a way of organizing gift giving to avoid the awkwardness of duplicate gifts.

Users set up a "wantlist" of gifts they would like to receive. Users claim gifts from other users' wantlists.

Usage
-----
1. Clone repo
2. Install dependencies
3. Create and fill out `config/database.yml` and `config/secret.yml`
4. Remove authentication filter in `app/controllers/application_controller.rb`
5. Adjust `Gemfile` and `config/deploy.rb` as needed

Dependencies
------------
- Ruby 1.9.3 ([rbenv][] management recommended)
- Rails 3.1.12
- MySQL

[rbenv]: https://github.com/sstephenson/rbenv

Why
---
This was (somewhat hastily) created for my family's 2011 Christmas celebration, partly to gain experience in writing/maintaining/deploying a Rails application, but also to avoid the awkward duplicate gift situation.

Though lacking in some features, it got the job done. The TODO is a pretty good list of what I didn't have the time to complete, and other things in mind for the next version(s).

I probably won't be revisiting this for a while, but feel free to contribute or fork for your own purposes.

License
-------

MIT License.
