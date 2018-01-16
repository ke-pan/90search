# frozen_string_literal: true
require 'drb/drb'

class Client
  DRb.start_service

  def self.server
    DRbObject.new_with_uri(Server::URI)
  end

  def self.load_data(filename, data)
    server.load_data(filename, data)
  end

  def self.search(filename, field, target)
    server.search(filename, field, target)
  rescue DRb::DRbConnError
    nil
  end
end
