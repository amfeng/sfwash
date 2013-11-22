require 'net/http/post/multipart'

module SFWash
  class Client
    SFWASH_URL = 'http://requestb.in/10s5g3l1'
    TRANSFORMED_PARAMS = {
      :name => 'ff_nm_Name[]',
      :phone => 'ff_nm_Phone[]',
      :email => 'ff_nm_email[]',
      :address => 'ff_nm_bfQuickMode2392926[]',
      :apartment => 'ff_nm_bfQuickMode2924333[]',
      :day => 'ff_nm_day[]',
      :time => 'ff_nm_Time[]',
      :instructions => 'ff_nm_Instructions[]',
      :detergent => 'ff_nm_detergent[]',
      :bleach => 'ff_nm_Bleach[]',
      :softener => 'ff_nm_Softener[]'
    }

    def transform_params(params)
      transformed_params = {}
      for key, value in params
        transformed_params[TRANSFORMED_PARAMS[key]] = value
      end

      transformed_params
    end

    def schedule_request
      url = URI.parse(SFWASH_URL)
      params = transform_params({
        :name => 'Amber Feng',
        :phone => 'blah',
        :email => 'blah',
        :address => 'blah',
        :apartment => 'blah',
        :day => 'Friday',
        :time => 'Anytime_Access',
        :instructions => 'OldPreferences',
        :detergent => 'Last Order',
        :bleach => 'Last Order',
        :softener => 'Last Order'
      })

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
