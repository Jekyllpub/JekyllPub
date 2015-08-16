module ArticlesHelper

  # Returns the current date and hour
  def now
    t = Time.now # Get server hour
    t -= (60*60*5) # Get local hour
    t = t.to_s # YYYY-MM-DD HH:MM:SS +/-TTTT
  end

  # Returns today's date
  def today
    t = now
    t = t.split(" ")
    t[0] # YYYY-MM-DD
  end

  # Returns the string replacing spaces for hyphens
  def hyphenize(s)
    s.gsub!(' ', '-')
  end

  # Returns the string capitalized replacing spaces for hyphens
  def dehyphenize(s)
    s.gsub!(/(\.)\w+/, "")
    a = s.split("-")
    s = ""
    i = 0
    a.each do |word|
      s.<<(word.capitalize).<<(" ") if i > 2
      i+=1
    end
    s
  end

  # Returns a youtube link as an id
  def video_id(s)
    if s.include? (%(src="https://www.youtube.com/embed/))
      return s
    elsif s.include?("youtube.com/watch?v=")
      if s.include?("www.youtube.com/watch?v=")
        if s.include?("https://www.youtube.com/watch?v=")
          s.gsub!("https://www.youtube.com/watch?v=", "")
        else
          s.gsub!("www.youtube.com/watch?v=", "")
        end
      else
        s.gsub!("youtube.com/watch?v=", "")
      end
    else
      if s.length == 11
        return s
      else
        s = nil
      end
    end
  end

  # Returns a youtube video in its embedded format
  def embedded_video(s)
    %(<iframe width="560" height="315" src="https://www.youtube.com/embed/#{video_id(s)}?rel=0" frameborder="0" allowfullscreen></iframe>)
  end

  # Prepares the post with a YAML frontmatter
  def format_content(parameters = {})
    if parameters[:layout]
      # Constructs the frontmatter in three different sections
      a = %(---\ncategory: #{parameters[:category]}\nlayout: #{parameters[:layout]}\n)
      b = %(author: #{parameters[:author]}\nexcerpt: #{parameters[:excerpt]}\n)
      c = %(thumbnail: #{parameters[:thumbnail]}\ndate: #{now}\n---\n)
      # Joins the frontmatter's sections
      yaml = a << b << c
      # Constructs the body depending on the presence of a video
      body = %(#{paramenters[:body]}) 
      body << %(\n\n***\n\n#{embedded_video(parameters[:video])}) if parameters[:video]
      # Constructs the full post
      yaml << body
    else
      # Constructs the body depending on the presence of a video
      body = %(#{paramenters[:body]})
      body << %(\n\n***\n\n#{embedded_video(parameters[:video])}) if parameters[:video]
    end
  end

  # Publish a post using Octokit.rb
  def publish_post(record)
    client = Octokit::Client.new(:access_token => "<40 char token>")
    repo = "jekyllpub/jekyllpub.github.io"
    post_path = "_posts/#{today}-#{hyphenize(record.title).downcase}.markdown"
    message = "Commit post #{record.title}"
    content_parameters = {
      author: record.author,
      excerpt: record.excerpt,
      thumbnail_url: "http://jekyllpub.herokuapp.com#{record.thumbnail.url}",
      category: record.category,
      layout: record.layout,
      body: record.content,
      video: record.video,
      date: now
    }
    content = format_content(content_parameters)
    client.create_contents(repo, post_path, message, content)
  end
end
