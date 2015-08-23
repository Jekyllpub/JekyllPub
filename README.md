# Jekyll Pub

By [Sebastian Lopez](http://github.com/sebastian9) and [ZtuX](http://github.com/ztux)

Jekyll is a static site generator built with Ruby that uses Shopify's Liquid as a templating language. It is simple, meaning it's got no databases nor complicated configurations; static, since it generates HTML/CSS and Javascript files ready to deploy; and blog aware, thanks to its many built-in functionalities.

Static Site generators are the next step in blogging engines since they are simple, scalable and pretty fast. Static file serving is cheap, and there's no need for server side operations when all you need is a blog with a couple hundred posts having all this [tools](http://cloudcannon.com/tips/2014/12/12/the-ultimate-list-of-services-for-static-websites.html) around for static websites. 

Jekyll has been called "The Blogging Plataform for Geeks" which is nice, but it's precisley its main obstacle as I see it. I have a project called Dodecaedro hosted in [Github Pages](http://dodecaedro.mx) as a starting point, but one of the main reasons the project has now stopped is that I was responsible for doing every update publishing every post that was ever written. A task that consumed a valuable of my time I could spend getting interviews for the website or gathering more writers (which eventually I wouldn't manage to upload).

As they say at Cloud Cannon:

"The main reasons we hear for not using static websites are: Non-technical users can’t update static websites easily."

So this is what Jekyll Pub aims to give a solution for. Jekyll Pub, currently in construction, is a rails app you can upload to heroku for non-technical writers to manage site's posts easily in a RESTful way. This project enables us Geeks to have a professional site hosted in Github Pages that can be updated by non-tech people. 

Initially, this app will require some Ruby on Rails basic understanding for  personal configuration depending on your site needs but it aims to be a complete solution even for non rubyists and eventually for people with no server configuration experience either.

# Contributing

We encourage you to contribute with us for opening the world of professional internet content creation to more people. 

Email at contacto[at]sebastianls[dot]com

# TO DO

+ User CRUD
+ Admin activation
+ Paperclip gem Integration -> Done
+ Article CRUD -> Done
+ Tests and Documentation
+ Facebook and Twitter API integration for automatic updates
+ Github App Authorization

# License

The MIT License (MIT)

Copyright (c) 2015 Sebastián López and Alfredo Hernández

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
