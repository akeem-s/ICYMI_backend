class PlacesController < ApplicationController

  def index
    @places = Place.all
    render json: @places
  end

  def today
    @today = Date.today
    @places = Place.includes(:categories).where(created_at: @today.beginning_of_day..@today.end_of_day)
    render json: @places
  end

  def yesterday
    @yesterday = Date.yesterday
    @places = Place.where(created_at: @yesterday.beginning_of_day..@yesterday.end_of_day)
    render json: @places
  end

  def two_days
    @two_days = 2.days.ago
    @places = Place.where(created_at: @two_days.beginning_of_day..@two_days.end_of_day)
    render json: @places
  end

  def favorites
    @places = Place.where("favorite = ?", true)
    render json: @places
  end

  def show
    @place = Place.find_by(id: params[:id])
    render json: @place
  end

  def edit
    @place = Place.find_by(id: params[:id])
    @place.update(favorite: true)
    @place.save
  end

  def create
    @places = []
    r = JSON.parse(request.body.string)
    long = r["latlong"]["coords"]["longitude"]
    lat = r["latlong"]["coords"]["latitude"]
    puts "lat: #{lat}  long: #{long}"
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{long}&radius=30&key=" + ENV["GOOGLE_PLACE_API"])
    response['results'].each do |place|
      place_id = place['place_id']
      @places << HTTParty.get('https://maps.googleapis.com/maps/api/place/details/json?placeid='+ place_id +'&key=' + ENV["GOOGLE_PLACE_API"])
    end
    @places.each do |place|
      new_p = Place.new({
        name: place['result']['name'],
      	address: place['result']['formatted_address'],
      	phone: place['result']['formatted_phone_number'],
      	website: place['result']['website'],
      	user_id: 1,
      	favorite: false
      	})
        if new_p.save
          if place['result']['opening_hours'] && place['result']['opening_hours']['weekday_text']
            Hour.new({
              place_id: new_p.id,
              mon: place['result']['opening_hours']['weekday_text'][0],
              tues: place['result']['opening_hours']['weekday_text'][1],
              wed: place['result']['opening_hours']['weekday_text'][2],
              thurs: place['result']['opening_hours']['weekday_text'][3],
              fri: place['result']['opening_hours']['weekday_text'][4],
              sat: place['result']['opening_hours']['weekday_text'][5],
              sun: place['result']['opening_hours']['weekday_text'][6]
              })
          end
          place['result']['types'].each do |category|
            cat = Category.find_or_create_by(category: category)
            PlaceCategory.create({
                place_id: new_p.id,
                category_id: cat.id
            })
          new_p
          end
        else
          puts "Failed to save place"
          p new_p.errors.full_messages
          return "This is wrong"
        end

    end
  end

end
