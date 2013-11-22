require 'net/http/post/multipart'
require 'yaml'

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

    def schedule_request(params)
      url = URI.parse(SFWASH_URL)

      req = Net::HTTP::Post::Multipart.new(url.path, transform_params(params))
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
    CONFIG_PATH = File.expand_path('~/.sfwash')

    def schedule
      client = SFWash::Client.new

      saved_config = YAML.load_file(CONFIG_PATH)[:preferences]
      client.schedule_request(saved_config)
    end
  end
end

cli = SFWash::CLI.new
cli.schedule
