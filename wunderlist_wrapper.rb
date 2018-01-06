require 'wunderlist'
require './config_reader'

module Wishwundergram
  class WunderlistWrapper
    attr_reader :client, :config, :list_id, :task_names
    def initialize(task_names)
      @config = Wishwundergram::ConfigReader
      @client = Wunderlist::API.new(
        access_token:  @config.access_token,
        client_id:     @config.client_id
      )
      @list_id = nil
      @task_names = task_names
    end

    def list
      @list_id = @client.list(@config.list_name).id
    end

    def create_list
      return if list
      list = @client.new_list(@config.list_name)
      list.save
    end

    def create_tasks
      @task_names.each do |task_name|
        create_task(task_name)
      end
    end

    def create_task(title)
      task = @client.new_task(@config.list_name, title: title, completed: false)
      task.save
    end
  end
end
