module ApplicationHelper
    def truncate(text, char)
        text.to_s.gsub(/<\/?[^>]*>/, ' ').squish.truncate(char, omission: ' . . . .')
    end

    # Page numbers to show, with nil marking a gap, e.g. [1, nil, 4, 5, 6, nil, 12]
    def pagination_window(current, total, radius: 2)
        pages = ([1, total] + ((current - radius)..(current + radius)).to_a).select { |n| n.between?(1, total) }.uniq.sort
        pages.each_with_object([]) do |n, out|
            out << nil if out.any? && n - out.last > 1
            out << n
        end
    end
end
