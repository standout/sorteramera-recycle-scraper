module RecycleScraper
  class FTIABWebsite
    ENDPOINT = 'http://webapp.ftiab.se'
    PATHS = {
      login:     'Koordinater/koordinatlogin.aspx',
      locations: 'Koordinater/koordinatavslistaXL.aspx?lan=&kommun=0'
    }

    def initialize(username, password)
      @agent = Mechanize.new
      login(username, password)
    end

    def login(username, password)
      @agent.get(page(:login)) do |login_page|
        login_form = login_page.form_with(id: 'form1') do |form|
          form.txtAnv = username
          form.txtLosenord = password
        end.click_button
      end
    end

    def get_locations
      @agent.get(page(:locations)).content
    end

    private

    def page(key)
      "#{ENDPOINT}/#{PATHS[key]}"
    end
  end
end
