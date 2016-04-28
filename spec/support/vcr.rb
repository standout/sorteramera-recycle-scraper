VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/vcr_cassettes'

  c.filter_sensitive_data('<USERNAME>') { ENV['SCRAPER_USERNAME'] }
  c.filter_sensitive_data('<PASSWORD>') { ENV['SCRAPER_PASSWORD'] }

  c.around_http_request do |request|
    case request.uri
    when %r{webapp.ftiab.se}
      VCR.use_cassette(request.uri, record: :new_episodes, &request)
    else
      request.proceed
    end
  end
end
