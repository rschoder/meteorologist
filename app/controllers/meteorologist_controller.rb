require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================
        url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    raw_data=open(url).read

    require "JSON"

    parsed_data=JSON.parse(raw_data)

    @lat = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @lng = parsed_data["results"][0]["geometry"]["location"]["lng"]

    urldark = "https://api.forecast.io/forecast/4df2a29dce51f30f3d9b940ef41ba13a/#{@lat},#{@lng}"

    raw_data1=open(urldark).read

    parsed_data1=JSON.parse(raw_data1)

    currently=parsed_data1["currently"]

    minutely=parsed_data1["minutely"]

    hourly=parsed_data1["hourly"]

    daily=parsed_data1["daily"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]
    render("street_to_weather.html.erb")
  end
end
