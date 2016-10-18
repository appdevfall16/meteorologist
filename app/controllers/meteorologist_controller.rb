require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================

    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address_without_spaces}"


        parsed_data = JSON.parse(open(url).read)
        results = parsed_data["results"]
        first=results[0]
        geometry=first["geometry"]
        location=geometry["location"]
        latitude=location["lat"]
        longitude=location["lng"]

    url_2 = "https://api.darksky.net/forecast/8bea9002983bcb8d6e353f0eaed5e860/#{latitude},#{longitude}"
    parsed_data_2 = JSON.parse(open(url_2).read)

    current_temp = parsed_data_2["currently"]["temperature"]
  current_summary = parsed_data_2["currently"]["summary"]

  summary_of_next_sixty_minutes = parsed_data_2["minutely"]["summary"]
  summary_of_next_several_hours = parsed_data_2["hourly"]["summary"]
  summary_of_next_several_days = parsed_data_2["daily"]["summary"]


    @current_temperature = "#{current_temp}"

    @current_summary = "#{current_summary}"

    @summary_of_next_sixty_minutes = "#{summary_of_next_sixty_minutes}"

    @summary_of_next_several_hours = "#{summary_of_next_several_hours}"

    @summary_of_next_several_days = "#{summary_of_next_several_days}"

    render("meteorologist/street_to_weather.html.erb")
  end
end
