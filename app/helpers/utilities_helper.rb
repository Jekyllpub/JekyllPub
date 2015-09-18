module UtilitiesHelper

  # Returns the current date and hour
  def now
    t = Time.now # Get server hour
    t -= (60*60*5) if Rails.env.production? # Get local hour
    t = t.to_s # YYYY-MM-DD HH:MM:SS +/-TTTT
  end

  # Returns today's date
  def today
    t = now
    t = t.split(" ")
    t[0] # YYYY-MM-DD
  end

  # Returns the string replacing spaces for hyphens
  def hyphenize s
    s.split.length > 1 ? s.gsub!(' ', '-') : s
  end

  # Returns the string capitalized replacing spaces for hyphens
  def dehyphenize s
    s.gsub!(/(\.)\w+/, "")
    a = s.split("-")
    s = ""
    i = 0
    a.each do |word|
      s << word.capitalize << " "  if i > 2
      i+=1
    end
    s
  end

  # Returns a youtube link as an id
  def video_id s
    return s if s.include?(%(src="https://www.youtube.com/embed/))
    if s.include?(".com/")
      if s.include?("youtube.com/watch?v=")
        if s.include?("www.youtube.com/watch?v=")
          if s.include?("https://www.youtube.com/watch?v=")
            s.gsub!("https://www.youtube.com/watch?v=", "")
          else
            s.gsub!("www.youtube.com/watch?v=", "")
          end
        else
          s.gsub!("youtube.com/watch?v=", "")
        end
      end
    elsif s.include?(".be/")
      if s.include?("youtu.be/")
        if s.include?("https://youtu.be/")
          s.gsub!("https://youtu.be/", "")
        else
          s.gsub!("youtu.be/", "")
        end
      end
    else
      return s if s.length == 11
    end
  end

  # Returns a youtube video in its embedded format
  def embedded_video s
    %(<iframe width="560" height="315" src="https://www.youtube.com/embed/#{video_id s}?rel=0" frameborder="0" allowfullscreen></iframe>)
  end

  # Formats the post
  def format_post parameters = {}
    if parameters[:layout]
      # Constructs the frontmatter in three different sections
      a = %(---\ncategory: #{parameters[:category]}\nlayout: #{parameters[:layout]}\n)
      b = %(author: #{parameters[:author]}\nexcerpt: #{parameters[:excerpt]}\n)
      c = %(thumbnail: #{parameters[:thumbnail]}\npublished: #{parameters[:published]}\ndate: #{now}\n---\n)
      # Joins the frontmatter's sections
      yaml = a << b << c
      # Constructs the body depending on the presence of a video
      body = %(#{parameters[:body]}) 
      body << %(\n\n***\n\n#{embedded_video parameters[:video] }) unless parameters[:video].blank?
      # Constructs the full post
      yaml << body
    else
      # Constructs the body depending on the presence of a video
      body = %(#{parameters[:body]})
      body << %(\n\n***\n\n#{embedded_video parameters[:video] }) unless parameters[:video].blank?
      return body
    end
  end
  alias :format_article :format_post

end