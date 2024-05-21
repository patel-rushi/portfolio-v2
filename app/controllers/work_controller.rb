class WorkController < ApplicationController
    def index
        @work = [
            { 
                title: 'Software Developer II', 
                company: 'Explorator Labs', 
                link: 'https://exploratorlabs.com/',
                duration: 'Feb 2022 - Present',
                description: [
                    'In November 2021, I was first introduced to <strong>Ruby on Rails (RoR)</strong>. I underwent personal training in RoR until February 2022. Thereafter, I began working with Explorator Labs on a probationary period, during which I worked on actual client projects, starting by writing test cases using <strong>Cypress</strong>.',
                    'In May 2022, I started working full-time (40 hours per week) as a co-op student. I worked on the XP Courier Company`s project to develop their website and portal using Ruby on Rails and React.js. <strong>I honed my skills in Rails and React during this time</strong>. Additionally, I worked on the Pivot.jobs mobile app, built on React Native, where I fixed bugs and optimized the notification architecture using Firebase to reduce costs.',
                    'In October 2022, I transitioned to a part-time developer role (20 hours per week) to continue pursuing my studies. I worked on the <strong>Ottawa Inner City Health project</strong>, one of our largest projects. It comprises two apps to digitalize record-keeping and workflows for nurses at walk-in clinics. I implemented major features and resolved bugs according to client requirements. The apps are built using <strong>Ruby on Rails, plain JS, CSS</strong> and <strong>React.js</strong> components.',
                    'In August 2023, I resumed full-time work,  <strong>taking on more responsibilities and assuming full responsibility for managing the Ottawa Inner City Health and XP Courier projects </strong>. I began engaging with clients, gathering requirements, designing solutions, managing tasks, estimating timelines, assigning tasks to developers, conducting code reviews, and overseeing testing and deployment.',
                    #'Presently, I am also leading product development, project management, and recruitment efforts.'
                ]
            },
            { 
                title: 'Co-founder', 
                company: 'Marsha-AI', 
                link: '',
                duration: 'Sep 2022 - Apr 2023',
                description: [
                    'As part of my entrepreneurial venture during the last two terms of my master`s degree, I co-founded a company aimed at <strong>reducing the time and money spent on resolving issue tickets</strong> for mid-size companies.',
                    'We initially conceived a user feedback tool but underwent several pivots while engaging with company owners before ultimately arriving at Marsha-AI. <strong>Through analysis of over 5000 tickets</strong> from <strong><u><a href="https://noibu.com/" target="_blank">Noibu</a></u></strong> and <strong><u><a href="https://cliniconex.com/" target="_blank">Cliniconex</a></strong></u>, we identified that the vast majority of tickets were related to seeking assistance to complete tasks. Consequently, Marsha-AI was designed to alleviate the burden of issue tickets by empowering companies to <strong>automatically generate user-interactive guides</strong> that facilitate users in accomplishing their objectives.',
                    'I led the <strong>product development</strong> and <strong>design</strong> of a comprehensive offering from ideation to launch. Involved in the recruitment of two developers and management of a total of a six-member team (including founding members). I established a shared vision and <strong>prioritized features</strong> for product delivery.',
                    'We decided to <b>shut down</b> operations shortly after graduation after realizing that there are tools available to generate user guides manually and companies prefer human interventions over automation for things that will go live on their software.'
                ]
            },
            { 
                title: 'Co-op/Intern Developer', 
                company: 'HPC Sphere | Ellipsis Infotech', 
                link: '',
                duration: 'Feb - Jul 2021 | Apr - Aug 2019',
                description: [
                    'These two internships laid the foundation for my journey into the software development world.',
                    'At Ellipsis, I worked on the company\'s internal portal, where I was introduced to essential development tools such as VS Code, Git version control, my first development language (C#), web framework (.NET), databases, and more.',
                    'At HPC Sphere, I worked on my first real client project and web application. I learned how to build a responsive UI, utilize modern front-end frameworks (Vue.js), a less-modern back-end framework (Laravel), integrate APIs, manage authentication (logins & signups), host web apps, and resolve technical issues related to website hosting, such as configuring SSH certificates.'
                ]
            },
        ]
    end
end