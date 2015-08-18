module ArticlesHelper

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
    s.gsub!(' ', '-')
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

  # Formats post content for index action
  def show_post record
    { body: format_post( body: record.content ), video: embedded_video(record.video) }
  end
  alias :show_article :show_post

  def live_post_path record
    a = %(http://jekyllpub.github.io/#{record.category})
    a << record.created_at.strftime("/%Y/%m/%d/") << hyphenize(record.title).downcase << '/'
  end
  alias :live_article_path :live_post_path

  # Publish a post using Octokit.rb
  def publish_post record
    # Git Repo and commit variables
    client = Octokit::Client.new(:access_token => "3d07581ff92626f9ccea67ecb00c9f1e6266cd90")
    repo = "jekyllpub/jekyllpub.github.io"
    message = "Commit #{record.title}"
    # Define post variables
    # Define post content for creation
    content = format_post date: now,
      author: record.author.capitalize,
      excerpt: record.excerpt,
      thumbnail: "/assets/img/posts/#{record.thumbnail_file_name}",
      category: record.category,
      layout: record.layout,
      body: record.content,
      video: record.video,
      published: record.published?
    post_path = "/_posts/#{today}-#{hyphenize(record.title).downcase}.markdown"
    # Define image variables
    image_path = "/assets/img/posts/#{record.thumbnail_file_name}"
    image = File.open("#{record.thumbnail.path(:medium)}","r").read
    # Create post using Octokit.rb
    client.create_contents repo, post_path, message, content
    # Create Image using Octokit.rb
    client.create_contents repo, image_path, message, image
  end
  alias :publish_article :publish_post

  # Update a post using Octokit.rb
  def update_post record
    # Git Repo and commit variables
    client = Octokit::Client.new(:access_token => "3d07581ff92626f9ccea67ecb00c9f1e6266cd90")
    repo = "jekyllpub/jekyllpub.github.io"
    message = "Update #{record.title}"
    # Define post variables
    post_path = "/_posts#{record.created_at.strftime("/%Y-%m-%d")}-#{hyphenize(record.title).downcase}.markdown"
    post_get = client.contents repo, path: post_path
    # Define post content for update
    content = format_post date: now,
      author: record.author.capitalize,
      excerpt: record.excerpt,
      thumbnail: "/assets/img/posts/#{record.thumbnail_file_name}",
      category: record.category,
      layout: record.layout,
      body: record.content,
      video: record.video,
      published: record.published?
    # Update post using Octokit.rb
    client.update_contents repo, post_path, message, post_get[:sha], content
  end
  alias :update_article :update_post

  # Destroy a post using Octokit.rb
  def destroy_post record
    # Git Repo and commit variables
    client = Octokit::Client.new(:access_token => "3d07581ff92626f9ccea67ecb00c9f1e6266cd90")
    repo = "jekyllpub/jekyllpub.github.io"
    message = "Delete #{record.title}"
    # Define post variables
    post_path = "/_posts#{record.created_at.strftime("/%Y-%m-%d")}-#{hyphenize(record.title).downcase}.markdown"
    post_get = client.contents repo, path: post_path
    # Define image variables
    image_path = "/assets/img/posts/#{record.thumbnail_file_name}"
    image_get = client.contents repo, path: image_path
    # Delete post using Octokit.rb
    client.delete_contents repo, post_path, message, post_get[:sha]
    # Delete image using Octokit.rb
    client.delete_contents repo, image_path, message, image_get[:sha]
  end
  alias :delete_post :destroy_post
  alias :destroy_article :destroy_post
  alias :delete_article :destroy_post
end
