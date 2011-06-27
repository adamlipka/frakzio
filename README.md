Frakzio
==========

This gem helps to write a fraction like attributes of a ActiveRecord models. 

Usage
-----

### Add fraction capability to your ActiveRecord model

    class Window < ActiveRecord::Base
        act_as_frakzio :width, :height
    end

Make sure that the frakzio attributes are string type.

### Fraction normalizer
    
    w = Window.create(:width => 10.5, :height => "10 8/4")
    w.width
    > "10 1/2"
    w.height
    > "12"
    
    
Copyright
---------

Copyright © 2011 Piotr Dębosz, Adam Lipka.