class HomeController < ApplicationController
  def index
    content = "Recently, one of our clients requested an inventory management page. Their instruction was simple: \"We want to manage inventory for items like gloves, tools, etc.\" 
    Often, you won’t receive all the necessary details upfront. Our role is to shoulder the heavy lifting, decipher requirements, and provide a solution with minimal inconvenience to the client. It's crucial to act as the brains for the client, allowing them to depend on us with minimal worry.
    We don’t follow a specific technique out of a book. We work in small groups, and an individual often handles multiple tasks. Here's what works for us:
    Firstly, we immerse ourselves in the client's perspective, anticipating their needs. We delve into how they utilize the software, the type of data they handle, and the origin of their inventory management needs. Do they require a comprehensive system or a streamlined solution? Understanding their workflow helps us determine optimal placements for features and gauge complexity."

    @home_blog_posts = [{
      id: 'home-blog-post',
      title: 'Transform clients\' requirements into features with minimal hassle',
      category: 'Tech',
      url: 'https://www.linkedin.com/posts/rushipatel-_design-projectmanagement-softwaredevelopment-activity-7173534615876292608-Kmea?utm_source=share&utm_medium=member_desktop',
      published_at: 'Apr 05, 2024',
      content: content.squish.truncate(200, omission: ' . . . .'),
      embed: '<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:7173534613187846144" height="1200" width="100%" frameborder="0" allowfullscreen="" title="Embedded post"></iframe>', 
    }]
  end
end