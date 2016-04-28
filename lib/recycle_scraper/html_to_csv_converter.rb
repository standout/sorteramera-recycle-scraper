require 'csv'

module RecycleScraper
  class HTMLToCSVConverter
    OUTPUT_PATH = 'tmp/recycle_locations.csv'
    COLUMNS_INDEXES = [3, 5, 6, 7, 8, 9, 10, 14, 15]

    def initialize(html)
      @document = Nokogiri::HTML(html)
    end

    def convert
      CSV.generate do |csv|
        rows = @document.xpath('//table/tr')
        rows.each do |row|
          columns = rows.index(row) == 0 ? row.xpath('th') : row.xpath('td')
          converted_columns = []

          columns.each do |column|
            next unless COLUMNS_INDEXES.include?(columns.index(column))
            converted_columns << column.text
          end

          csv << converted_columns
        end
      end
    end
  end
end
