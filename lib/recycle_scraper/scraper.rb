module RecycleScraper
  class Scraper
    attr_reader :username, :password

    def initialize(username, password)
      @username = username
      @password = password
      @fti_ab_website = FTIABWebsite.new(username, password)
    end

    def generate_csv
      CSV.parse(get_csv_contents, {
        headers: true,
        converters: :numeric
      })
    end

    private

    def get_csv_contents
      HTMLToCSVConverter.new(@fti_ab_website.get_locations).convert
    end
  end
end
