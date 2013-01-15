# Title: Simple Image tag for Jekyll
# Authors: Brandon Mathis http://brandonmathis.com
#          Felix Schäfer, Frederic Hemberger
# Description: Easily output images with optional class names, width, height, title and alt attributes
#
# Syntax {% img [class name(s)] [http[s]:/]/path/to/image [width [height]] [title text | "title text" ["alt text"]] %}
#
# Examples:
# {% img /images/ninja.png Ninja Attack! %}
# {% img left half http://site.com/images/ninja.png Ninja Attack! %}
# {% img left half http://site.com/images/ninja.png 150 150 "Ninja Attack!" "Ninja in attack posture" %}
#
# Output:
# <figure><img src="/images/ninja.png" title="Some IMage" alt="This is the world"><figcaption>The stock goes to poo.</figaption></figure>
# <img class="left half" src="http://site.com/images/ninja.png" title="Ninja Attack!" alt="Ninja Attack!">
# <img class="left half" src="http://site.com/images/ninja.png" width="150" height="150" title="Ninja Attack!" alt="Ninja in attack posture">
#

module Jekyll

  class FigureTag < Liquid::Tag
    @fig = nil

    def initialize(tag_name, markup, tokens)
      attributes = ['class', 'src', 'caption', 'title', 'alt']

      if markup =~ /(?<class>\S[^\/\:]*\s+)?(?<src>(?:https?:\/\/|\/|\S+\/)\S+)?(?:\s+(?:'|")(?<caption>.+?)(?:'|"))?(?:\s+(?:'|")(?<title>.+?)(?:'|"))?(?:\s+(?:'|")(?<alt>.+?)(?:'|"))?/i
        @fig = attributes.reduce({}) { |img, attr| img[attr] = $~[attr].strip if $~[attr]; img }
      end
      super
    end

    def render(context)
      if @fig
        classNames = @fig.has_key?('class') ? " class=\"" + @fig['class'] + "\"" : "" ;
        caption = @fig.has_key?('caption') ? "<figcaption>" + @fig['caption'] + "</figcaption>" : "" ;
        title = @fig.has_key?('title') ? " title=\"" + @fig['title'] + "\"" : "" ;
        alt = @fig.has_key?('alt') ? " alt=\"" + @fig['alt'] + "\"" : "" ;
        src = @fig.has_key?('src') ? " src=\"" + @fig['src'] + "\"" : "" ;

        "<figure" + classNames + "><img#{src}#{title}#{alt}>#{caption}</figure>"
      else
        "Error processing input, expected syntax: {% fig [class name(s)] [http[s]:/]/path/to/image 'Caption' 'Image-Title' 'Alt-Tag' %}"
      end
    end
  end
end

Liquid::Template.register_tag('fig', Jekyll::FigureTag)
