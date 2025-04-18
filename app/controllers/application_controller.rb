class ApplicationController < ActionController::Base
  helper_method :authenticated?
  before_action :set_home_blog_posts

  private

  def authenticate
    return if authenticated?
    authenticate_or_request_with_http_basic do |name, password|
      if User.find_by(name:)&.authenticate(password)
        session[:logged_in] = true
      else
        request_http_basic_authentication
      end
    end
  end

  def authenticated?
    session[:logged_in].present?
  end

  def set_home_blog_posts
    content = "Recently, one of our clients requested an inventory management page. Their instruction was simple: \"We want to manage inventory for items like gloves, tools, etc.\" 
    Often, you won’t receive all the necessary details upfront. Our role is to shoulder the heavy lifting, decipher requirements, and provide a solution with minimal inconvenience to the client. It's crucial to act as the brains for the client, allowing them to depend on us with minimal worry.
    We don’t follow a specific technique out of a book. We work in small groups, and an individual often handles multiple tasks. Here's what works for us:
    Firstly, we immerse ourselves in the client's perspective, anticipating their needs. We delve into how they utilize the software, the type of data they handle, and the origin of their inventory management needs. Do they require a comprehensive system or a streamlined solution? Understanding their workflow helps us determine optimal placements for features and gauge complexity."

    marsha_ai_experience = %(
      <p>As part of my entrepreneurial venture during the last two terms of my master's degree, I co-founded a company aimed at <strong>reducing the time and money spent on resolving issue tickets</strong> for mid-size companies.</p>
      <br>
      <p>We initially conceived a user feedback tool but underwent several pivots while engaging with company owners before ultimately arriving at Marsha-AI. <strong>Through analysis of over 5000 tickets</strong> from <a href=\"https://noibu.com/\" target=\"_blank\"><strong><u>Noibu</u></strong></a> and <a href=\"https://cliniconex.com/\" target=\"_blank\"><strong><u>Cliniconex</u></strong></a>, we identified that the vast majority of tickets were related to seeking assistance to complete tasks. Consequently, Marsha-AI was designed to alleviate the burden of issue tickets by empowering companies to <strong>automatically generate user-interactive guides</strong> that facilitate users in accomplishing their objectives.</p>
      <br>
      <p>I led the <strong>product development</strong> and <strong>design</strong> of a comprehensive offering from ideation to launch. Involved in the recruitment of two developers and management of a total of a six-member team (including founding members). I established a shared vision and <strong>prioritized features</strong> for product delivery.</p>
      <br>
      <p>We decided to <strong>shut down</strong> operations shortly after graduation after realizing that there are tools available to generate user guides manually and companies prefer human interventions over automation for things that will go live on their software.</p>
    ).squish

    @home_blog_posts = {
      card:  {
        id: 'home-blog-post',
        title: 'Transform clients\' requirements into features with minimal hassle',
        category: 'LinkedIn Post',
        url: 'https://www.linkedin.com/posts/rushipatel-_design-projectmanagement-softwaredevelopment-activity-7173534615876292608-Kmea?utm_source=share&utm_medium=member_desktop',
        published_at: 'Apr 05, 2024',
        content: content.squish.truncate(200, omission: ' . . . .'),
        embed: '<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:7173534613187846144" height="1500" width="100%" frameborder="0" allowfullscreen title="Embedded post" class="custom-height"></iframe>', 
      },

      link_managing_projects: {
        id: 'managing-projects',
        name: 'managing projects.',
        title: 'Managing Projects',
        category: 'Linkedin Post',
        url: 'https://www.linkedin.com/posts/rushipatel-_managing-a-busy-project-boils-down-to-two-activity-7127790488253779968-qb4z?utm_source=share&utm_medium=member_desktop',
        published_at: '',
        content: '',
        embed: '<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:7127790487771525120" height="250" width="100%" frameborder="0" allowfullscreen="" title="Embedded post"></iframe>',
      },

      link_efficient_solutions: {
        id: 'efficient-solutions',
        name: 'efficient solutions.',
        title: 'Efficient Solutions',
        category: 'Linkedin Post',
        url: 'https://www.linkedin.com/posts/rushipatel-_prioritizing-quality-activity-7130743980266283009-QbPQ?utm_source=share&utm_medium=member_desktop',
        published_at: '',
        content: '',
        embed: '<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:7130743979674886145" height="300" width="100%" frameborder="0" allowfullscreen="" title="Embedded post"></iframe>',
      },

      more_about_entrp_experience: {
        id: 'more-about-entrp-exp',
        name: 'what I learnt.',
        title: 'Entrepreneurship learnings',
        category: 'Linkedin Post',
        url: 'https://www.linkedin.com/posts/rushipatel-_last-week-marked-the-end-of-my-wonderful-activity-7060092980040212480-4VV8?utm_source=share&utm_medium=member_desktop',
        published_at: '',
        content: '',
        embed: '<iframe src="https://www.linkedin.com/embed/feed/update/urn:li:share:7060092977200668672" height="800" width="100%" frameborder="0" allowfullscreen="" title="Embedded post" class="custom-height"></iframe>',
      },
      marsha_ai_experience: {
        id: 'marsha-ai-experience',
        name: 'Marsha-AI',
        title: 'Marsha-AI Experience',
        content: marsha_ai_experience
      },
      read_more_marsha_ai_experience: {
        id: 'read-more-marsha-ai-experience',
        name: 'continue reading',
        title: 'Marsha-AI Experience',
        content: marsha_ai_experience
      },
    }
  end
end
