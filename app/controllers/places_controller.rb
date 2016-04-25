class PlacesController < ApplicationController

  def index
    @places = Place.all
    render json: @places
  end

  def today
    @today = Date.today
    @places = Place.where(created_at: @today.beginning_of_day..@today.end_of_day)
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


  def create
    @places = []
    r = JSON.parse(request.body.string)
    long = r["latlong"]["coords"]["longitude"]
    lat = r["latlong"]["coords"]["latitude"]
    response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{long}&radius=30&key=" + ENV["GOOGLE_PLACE_API"])

    response['results'].each do |place|
      place_id = place['place_id']
      @places << HTTParty.get('https://maps.googleapis.com/maps/api/place/details/json?placeid='+ place_id +'&key=' + ENV["GOOGLE_PLACE_API"])
    end

    @places.each do |place|
      p = Place.create({
        name: place['result']['name'],
      	address: place['result']['formatted_address'],
      	phone: place['result']['international_phone_number'],
      	website: place['result']['website'],
      	user_id: 1,
      	favorite: false
      	})
      # Review.create({
      #   name: place['author_name'],
      #   content: place['text'],
      #   rating: place['rating'],
      #   place_id: p.id
      #   })
    end
  end

end
