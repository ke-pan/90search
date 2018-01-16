# frozen_string_literal: true

module NinetySearch
  class CLI < Thor
    desc 'setup', 'Setup process for search'
    def setup
      Launcher.new.setup_server
    end

    desc 'load filename', 'Load json file for search'
    def load(filename)
      Launcher.new.load(filename)
    end

    desc 'search filename field target', 'Search text from json file'
    def search(filename, field, target)
      Launcher.new.search(filename, field, target)
    end
  end
end
