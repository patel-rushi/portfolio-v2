module ApplicationHelper
    def truncate(text, char)
        text.to_s.gsub(/<\/?[^>]*>/, ' ').squish.truncate(char, omission: ' . . . .')
    end
end
