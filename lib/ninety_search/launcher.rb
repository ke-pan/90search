# frozen_string_literal: true

class Launcher
  Signal.trap("INT") do
    puts 'Bye bye'
    exit 1
  end

  def setup_server
    Server.setup
  end

  def load(filename)
    Client.load_data(filename, load_file(filename))
  end

  def search(filename, field, target)
    results = Client.search(filename, field, target) || search_from_file(filename, field, target)
    print(results, field, target)
  end

  def load_file(filename)
    file = File.open(filename)
    json = MultiJson.load(file.read)
    json = [json] unless json.is_a? Array
    json
  rescue MultiJson::ParseError
    puts "#{filename} is not a valid json file"
    exit 1
  rescue => e
    puts e.message
    exit 1
  end

  def search_from_file(filename, field, target)
    _search(load_file(filename), field, target)
  end

  def _search(array_of_hash, field, target)
    array_of_hash.find_all do |h|
      Array(h.fetch(field, nil)).any? { |str| str.to_s == target }
    end
  end

  def print(results, field, target)
    if results.empty?
      puts 'No result found!'
      return
    end
    colorful_target = Rainbow(target).red
    puts '['
    results.each do |h|
      puts '  {'
      h.each do |k, v|
        if k == field
          if v.is_a? Array
            v = v.map { |i| i.to_s == target ? colorful_target : i }.join(", ")
          else
            v = colorful_target
          end
        end
        puts "    #{k} => #{v}"
      end
      puts '  },'
    end
    puts ']'
  end
end
