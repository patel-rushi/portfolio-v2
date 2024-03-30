class WorkController < ApplicationController
    def index
        @work = [
            { 
                title: 'Software Developer II', 
                company: 'Explorator Labs', 
                link: 'https://exploratorlabs.com/',
                duration: 'Feb 2022 - Present',
                description: [
                    'In November 2021, I joined Explorator Labs as a part-time developer. I first got introduced to <strong>RoR (Ruby on Rails)</strong> during this time. I under vent personal training on RoR until February 2022. Thereafter, I started working on actual client projects where I begin with writing test cases using Cypress.',
                    'In May 2022, I started working full-time as a co-op student. I worked on XP courier company’s project to develop their website and portal using Ruby on Rails and React Js. I mastered my skills on RoR and React during this time. I also worked on Pivot.jobs mobile app, build on React Native, where I fixed bugs and optimised the notification architecture using Firebase to bring down the cost',
                    'In October 2022, I converted to a part-time developer to continue pursing my studies. I worked on Ottawa inner city health project, one of biggest projects we have. It`s comprises two apps to digitalise the record keeping and work flow of nurses at the walk-in clinics. I added major features and fixed bugs as per client\'s requirement. App is build using Ruby on Rails and React JS.',
                    'In August 2023, I started working full-time where I took more responsibilities and started completely handling Ottawa inner city health and XP courier project. I started meeting clients, gathering requirements, designing solutions, estimating timeline, assigning it to the developers, code review, testing and deployment.',
                    'Now, also leading products, project management and recruiting.'
                ]
            },
            { 
                title: 'Co-founder', 
                company: 'Marsha-AI', 
                link: '',
                duration: 'Sep 2022 - Apr 2023',
                description: [
                    'Led product development and design of a complete offering from ideation to launch.',
                    'Managed a 4-member team, established a shared vision and prioritized features for product delivery.',
                    'Engaged in end-to-end process: discovery, ideation, prospect engagement, fundraising, recruitment, development, and launch.',
                ]
            },
        ]
    end
end