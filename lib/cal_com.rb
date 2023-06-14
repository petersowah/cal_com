# frozen_string_literal: true

require_relative 'cal_com/version'
# this is the main module for the gem
module CalCom
  class Error < StandardError; end

  class << self
    def initialize
      @client = Faraday.new(url: 'https://api.cal.com/v1', params: { apiKey: ENV['CAL_COM_API_KEY'] })
    end

    def attendees
      response = @client.get('attendees')
      JSON.parse(response.body)
    end

    def create_booking(params)
      @params = params
      response = @client.post('/bookings', booking_payload.to_json)
      JSON.parse(response.body)
    end

    def bookings
      response = @client.get('bookings')
      JSON.parse(response.body)
    end

    private
    def booking_payload
      {
        "name": @params[:name],
        "email": @params[:email],
        "title": @params[:title],
        "eventTypeId": @params[:eventTypeId], # "eventTypeId": "string",
        "description": @params[:description],
        "start": @params[:start_time],
        "end": @params[:end_time],
        "location": @params[:location],
        "timeZone": @params[:timezone],
        "metadata": {},
        "customInputs": []
      }
    end
  end
end
