class EducationController < ApplicationController
    def index 
        @education = [
            {
                title: 'Master\'s Entrepreneurial Engineering Design',
                university: 'University of Ottawa (Canada)',
                link: '',
                duration: 'Sep 2021 - Apr 2023',
                description: [
                    'As part of this unique master\'s program, I combined my knowledge of computer science with design and entrepreneurship.',
                    'It helped me learn about product development, management, design, generating progressive ideas for a company, and building and launching products.',
                    'I founded Marsha-AI as a byproduct of this course. It taught me how to iterate, navigate through messes, and focus on things that truly matter to reach product-market fit.',
                ]
            },
            {
                title: 'Bachelor\'s Information Technology',
                university: 'Charusat University (India)',
                link: '',
                duration: 'Jun 2017 - Apr 2021',
                description: [
                    'Undergraduate studies in the field of computer science laid a technical foundation for me, enabling me to do what I do today.',
                    'It introduced me to various areas including Data Structures, Algorithms, Databases, Programming, Machine Learning, Artificial Intelligence, Web Design & Development, and Software Engineering.',
                ]
            },
        ]
    end
end