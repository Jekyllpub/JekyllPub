class ArticleCleanupJob < ActiveJob::Base
  queue_as :default

  def perform(*articles)
    # Do something later
    articles.each do |article|
    	article.delete
    end
  end
end
