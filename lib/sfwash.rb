require 'net/http/post/multipart'

module SFWash
  class Client
    SFWASH_URL = 'http://requestb.in/10s5g3l1'

    def schedule_request
      url = URI.parse(SFWASH_URL)
      params = {
        'ff_nm_Name[]' => 'Amber Feng',
        'ff_nm_Phone[]' => 'phone',
        'ff_nm_email[]' => 'email',
        'ff_nm_bfQuickMode2392926[]' => 'address',
        'ff_nm_bfQuickMode2924333[]' => 'suite',
        'ff_nm_day[]' => 'Friday',
        'ff_nm_Time[]' => 'Anytime_Access',
        'ff_nm_Instructions[]' => 'OldPreferences',
        'ff_nm_detergent[]' => 'Last Order',
        'ff_nm_Bleach[]' => 'Last Order',
        'ff_nm_Softener[]' => 'Last Order'
      }

      req = Net::HTTP::Post::Multipart.new(url.path, params)
      res = Net::HTTP.start(url.host, url.port) do |http|
        http.request(req)
      end

      if res.code == '200'
        puts "Successfully scheduled! You should be receiving an email from SFWash shortly."
      else
        puts "Blergh, something went wrong. Maybe SFWash is down? ):"
      end
    end
  end

  class CLI
    def schedule
      client = SFWash::Client.new
      client.schedule_request
    end
  end
end

cli = SFWash::CLI.new
cli.schedule
