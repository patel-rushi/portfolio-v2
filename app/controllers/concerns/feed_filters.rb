module FeedFilters
    extend ActiveSupport::Concern

    NAMES = {
        notes: 'notes',
        scripts: 'scripts',
        reels: 'reels',
        tech: 'tech'
    }.freeze
end