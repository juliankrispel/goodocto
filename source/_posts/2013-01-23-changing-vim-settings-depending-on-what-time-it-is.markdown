---
layout: post
title: Changing vim-settings depending on what time it is
date: 2013-01-23 22:40
comments: true
categories: notes vimscript
---

To change your vim settings depending on the time of day just use the time functions like so:

    if strftime("%H") > 17
      set background=dark
    endif

In this case I'm using it to change [solarized's](http://ethanschoonover.com/solarized "Solarized Colortheme") color mode.
