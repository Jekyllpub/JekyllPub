module ArticlesHelper

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
    message = "Commit #{record.title}"
    # Define post variables
    # Define post content for creation
    record.thumbnail.nil? ? thumbnail = nil : thumbnail = "/assets/img/posts/#{record.thumbnail_file_name}" 
    content = format_post date: now,
      author: record.author.capitalize,
      excerpt: record.excerpt,
      thumbnail: thumbnail,
      category: record.category,
      layout: record.layout,
      body: record.content,
      video: record.video,
      published: record.published?
    post_path = "/_posts/#{today}-#{hyphenize(record.title).downcase}.markdown"
    # Create post using Octokit.rb
    ArticlesController.octokit.create_content ENV["REPOSITORY"], post_path, message, content
    unless record.thumbnail.nil?
      # Define image variables
      image_path = "/assets/img/posts/#{record.thumbnail_file_name}"
      image = File.read("#{record.thumbnail.path(:medium)}")
      # Create Image using Octokit.rb
      ArticlesController.octokit.create_content ENV["REPOSITORY"], image_path, message, image
    end
  end
  alias :publish_article :publish_post

  # Update a post using Octokit.rb
  def update_post record
    message = "Update #{record.title}"
    # Define post variables
    post_path = "/_posts#{record.created_at.strftime("/%Y-%m-%d")}-#{hyphenize(record.title).downcase}.markdown"
    post_get = ArticlesController.octokit.contents ENV["REPOSITORY"], path: post_path
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
    ArticlesController.octokit.update_contents ENV["REPOSITORY"], post_path, message, post_get[:sha], content
  end
  alias :update_article :update_post

  # Destroy a post using Octokit.rb
  def destroy_post record
    message = "Delete #{record.title}"
    # Define post variables
    post_path = "/_posts#{record.created_at.strftime("/%Y-%m-%d")}-#{hyphenize(record.title).downcase}.markdown"
    post_get = ArticlesController.octokit.contents ENV["REPOSITORY"], path: post_path
    # Delete post using Octokit.rb
    ArticlesController.octokit.delete_contents ENV["REPOSITORY"], post_path, message, post_get[:sha]
    unless record.thumbnail.nil?
      # Define image variables
      image_path = "/assets/img/posts/#{record.thumbnail_file_name}"
      image_get = ArticlesController.octokit.contents ENV["REPOSITORY"], path: image_path
      # Delete image using Octokit.rb
      ArticlesController.octokit.delete_contents ENV["REPOSITORY"], image_path, message, image_get[:sha] 
    end
  end
  alias :delete_post :destroy_post
  alias :destroy_article :destroy_post
  alias :delete_article :destroy_post
end