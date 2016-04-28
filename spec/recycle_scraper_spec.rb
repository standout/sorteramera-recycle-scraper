require 'spec_helper'

describe 'FTI AB Website scraper' do
  before { ensure_scraper_credentials! }

  let(:username) { ENV['SCRAPER_USERNAME'] }
  let(:password) { ENV['SCRAPER_PASSWORD'] }

  it 'returns a CSV file containing scraped recycle locations' do
    scraper = RecycleScraper::Scraper.new(username, password)

    csv = scraper.generate_csv
    expect(csv[0].to_h).to eq({
      'Åvs'                => 'Asarum',
      'Ort'                => 'Asarum',
      'Glas'               => 'x',
      'Kartong'            => 'x',
      'Metall'             => 'x',
      'Blandplast'         => 'x',
      'Tidningar'          => 'x',
      'Latitud decimal'    => 56.20750,
      'Longitud decimal'   => 14.85139
    })
  end
end
