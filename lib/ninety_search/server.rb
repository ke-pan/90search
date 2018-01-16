# frozen_string_literal: true
require 'drb/drb'

module Server
  URI = "druby://localhost:8787"
  def self.setup
    DRb.start_service(URI, Engine.new)
    DRb.thread.join
  end

  class Engine
    def initialize
      @workers = {}
      @tries = {}
    end

    def load_data(name, data)
      worker = Worker.new
      worker.setup_tries(data)
      @workers[name] = worker
    end

    def search(filename, field, target)
      return unless @workers[filename]
      @workers[filename].search(field, target)
    end
  end

  class Worker
    def initialize
      @tries = {}
    end

    def setup_tries(array_of_hash)
      array_of_hash.each do |h|
        h.each do |k, v|
          @tries[k] = Trie.new(k) unless @tries[k]
          Array(v).each { |str| @tries[k].add_node(str, h) }
        end
      end
    end

    def search(field, target)
      return [] unless @tries[field]
      @tries[field].search(target)
    end
  end
end
