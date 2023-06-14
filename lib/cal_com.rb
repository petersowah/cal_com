# frozen_string_literal: true

require_relative 'cal_com/version'
# this is the main module for the gem
module CalCom
  class Error < StandardError; end

  class << self
    API_KEY = ENV['CAL_COM_API_KEY']
    def initialize
      @client = Faraday.new(url: 'https://api.cal.com/v1')
    end

    def attendees
      response = @client.get("attendees?apiKey=#{API_KEY}")
      JSON.parse(response.body)
    end

    def create_booking(params)
      @params = params
      response = @client.post("/bookings?apiKey=#{API_KEY}", booking_payload.to_json)
      JSON.parse(response.body)
    end

    def bookings
      response = @client.get("bookings?apiKey=#{API_KEY}")
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
        "start": @params[:start],
        "end": @params[:end],
        "attendees": @params[:attendees],
        "location": @params[:location],
        "timeZone": @params[:timezone],
        "metadata": {},
        "customInputs": []
      }
    end
  end
end
