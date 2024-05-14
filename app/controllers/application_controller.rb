class ApplicationController < ActionController::Base
  before_action :set_home_blog_posts

  private

  def set_home_blog_posts
    content = "Recently, one of our clients requested an inventory management page. Their instruction was simple: \"We want to manage inventory for items like gloves, tools, etc.\" 
    Often, you won’t receive all the necessary details upfront. Our role is to shoulder the heavy lifting, decipher requirements, and provide a solution with minimal inconvenience to the client. It's crucial to act as the brains for the client, allowing them to depend on us with minimal worry.
    We don’t follow a specific technique out of a book. We work in small groups, and an individual often handles multiple tasks. Here's what works for us:
    Firstly, we immerse ourselves in the client's perspective, anticipating their needs. We delve into how they utilize the software, the type of data they handle, and the origin of their inventory management needs. Do they require a comprehensive system or a streamlined solution? Understanding their workflow helps us determine optimal placements for features and gauge complexity."

    @home_blog_posts = {
      card:  {
        id: 'home-blog-post',
        title: 'Transform clients\' requirements into features with minimal hassle',
        category: 'LinkedIn Post',
        url: 'https://www.linkedin.com/posts/rushipatel-_design-projectmanagement-softwaredevelopment-activity-7173534615876292608-Kmea?utm_source=share&utm_medium=member_desktop',
        published_at: 'Apr 05, 2024',
        content: content.squish.truncate(200, omission: ' . . . .'),
        embed: '<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:7173534613187846144" height="1500" width="100%" frameborder="0" allowfullscreen="" title="Embedded post" class="custom-height"></iframe>', 
      },

      link_managing_projects: {
        id: 'managing-projects',
        name: 'managing projects',
        title: 'Managing Projects',
        category: 'Linkedin Post',
        url: 'https://www.linkedin.com/posts/rushipatel-_managing-a-busy-project-boils-down-to-two-activity-7127790488253779968-qb4z?utm_source=share&utm_medium=member_desktop',
        published_at: '',
        content: '',
        embed: '<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:7127790487771525120" height="250" width="100%" frameborder="0" allowfullscreen="" title="Embedded post"></iframe>',
      },

      link_efficient_solutions: {
        id: 'efficient-solutions',
        name: 'efficient solutions',
        title: 'Efficient Solutions',
        category: 'Linkedin Post',
        url: 'https://www.linkedin.com/posts/rushipatel-_prioritizing-quality-activity-7130743980266283009-QbPQ?utm_source=share&utm_medium=member_desktop',
        published_at: '',
        content: '',
        embed: '<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:7130743979674886145" height="300" width="100%" frameborder="0" allowfullscreen="" title="Embedded post"></iframe>',
      },
    }
  end
end
