require 'net/http/post/multipart'
require 'yaml'

module SFWash
  class Client
    #SFWASH_URL = 'http://www.sfwash.com/schedule-a-pick-up'
    SFWASH_URL = 'http://requestb.in/qoa9s5qo'
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

      # Other random parameters that pretty much must be included as well
      transformed_params.merge({
        'ff_contentid' => 2,
        'ff_applic' => nil,
        'ff_module_id' => nil,
        'ff_form' => 4,
        'ff_task' => 'submit',
        'ff_target' => 2,
        'ff_align' => nil,
        'option' => 'com_content',
        'Itemid' => 2,
        'id' => 2
      })
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
    VALID_COMMANDS = %w{schedule}
    CONFIG_FILE_PATH = File.expand_path('~/.sfwash')

    AVAILABLE_DAYS = %w{Monday Tuesday Wednesday Thursday Friday}

    def self.run(command, options)
      if command && VALID_COMMANDS.include?(command)
        self.send(command, options)
      elsif command
        $stderr.puts("Sorry, `#{command}` is not a valid command.")
        exit
      else
        $stderr.puts("You must specify a command! Try `sfwash help`.")
      end
    end

    def self.schedule(options)
      client = SFWash::Client.new

      if File.exists?(CONFIG_FILE_PATH)
        config = YAML.load_file(CONFIG_FILE_PATH)[:preferences]

        if options[:day]
          day = transform_day(options[:day])
          config = config.merge(:day => day) if day
        end

        puts "Confirm this order? [Y/N]"
        for key,value in config do
          puts key.to_s + ": " + value
        end
        if gets.chomp == "Y"
          client.schedule_request(config)
        else
          puts "Order cancelled. Run `sfwash setup` to edit your config file and `sfwash schedule` to try again"
        end

      else
        puts "Oh no, you don't have a config! See the documentation at https://github.com/amfeng/sfwash."
      end
    end

    def self.transform_day(day)
      day = day.capitalize
      day if AVAILABLE_DAYS.include?(day)
    end
  end
end
