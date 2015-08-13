module ArticlesHelper

  # returns the current date in dd-mm-yy format
  def now
    t = Time.now
    t = t.to_s
    t = t.split(' ')
    t[0]
  end

  # returns the string replacing spaces for hyphens
  def hyphenize(s)
    s.gsub!(' ', '-')
    return s
  end

  # returns the string capitalized replacing spaces for hyphens
  def dehyphenize(s)
    s.gsub!(/(\.)\w+/, "")
    a = s.split("-")
    s = ""
    i = 0
    a.each do |word|
      s.<<(word.capitalize).<<(" ") if i > 2
      i+=1
    end
    return s
  end

  # returns a youtube link as an id
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

  # returns a youtube video in its embedded format
  def embedded_video(s)
    %(<iframe width="560" height="315" src="https://www.youtube.com/embed/#{video_id(s)}?rel=0" frameborder="0" allowfullscreen></iframe>)
  end

  # Prepares the post with a YAML frontmatter
  def format_content(author = nil, excerpt = nil, thumbnail_path = nil, category = nil, layout = nil, body = nil, video = nil)
    unless video.nil?
     return %(---\ncategory: #{category}\nlayout: #{layout}\nauthor: #{author}\nexcerpt: #{excerpt}\nthumbnail: #{thumbnail_path}\ndate: #{now}\n---\n#{body}\n\n***\n\n#{embedded_video(video)})
    elsif layout.nil?
     return %(#{body}\n\n***\n\n#{embedded_video(video)})
    else
     return %(---\ncategory: #{category}\nlayout: #{layout}\nauthor: #{author}\nexcerpt: #{excerpt}\nthumbnail: #{thumbnail_path}\ndate: #{now}\n---\n#{body}) 
    end
  end

  def show_post(record)
    body = record.content
    embedded_video = record.video
    return format_content()
  end

  def publish_post(record)
    client = Octokit::Client.new(:access_token => "dcd06b46ee5e7c0f96c4c4510bedd7e632d185cd")
    repo = "dodecaedro2015/dodecaedro2015.github.io"
    post_path = "_posts/#{now}-#{hyphenize(record.title).downcase}.markdown"
    message = "Commit post #{record.title}"
    author = record.author
    excerpt = record.excerpt
    thumbnail_url = "http://dodecaedro.herokuapp.com#{record.thumbnail.url}"
    category = record.category
    layout = record.layout
    body = record.content
    video = record.video
    content = format_content(author, excerpt, thumbnail_url, category, layout, body, video)
    client.create_contents(repo, post_path, message, content)
  end

  def all_articles
    client = Octokit::Client.new(:access_token => "dcd06b46ee5e7c0f96c4c4510bedd7e632d185cd")
    repo = "dodecaedro2015/dodecaedro2015.github.io"
    client.contents(repo, path: "_posts/")
  end
end
