module Notifications
  class FreeText < Notification
    def title
      extras["title"]
    end

    def text
      extras["text"]
    end

    def link
      extras["link"]
    end
  end
end
