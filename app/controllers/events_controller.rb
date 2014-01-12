# encoding: utf-8

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all.sort_by { |obj| obj.event_date }.reverse
  end
  
  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /events/new
  def new
	if admin_rights
		@event = Event.new
	end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
	if admin_rights
		@event = Event.new(event_params)
		
		# Associate movies with the event
		if params[:movie_ids]
			Movie.all.find(params[:movie_ids]).each do |movie|
				@event.movies << movie
			end
		end
		
		respond_to do |format|
		  if @event.save
			format.html { redirect_to events_url, notice: 'Esitys luotu' }
			format.json { render action: 'show', status: :created, location: @event }
		  else
			format.html { render action: 'new' }
			format.json { render json: @event.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
	if admin_rights
		# Clear old movies of the event
		@event.movies.clear
	  
		# Associate movies with the event
		if params[:movie_ids]
			Movie.all.find(params[:movie_ids]).each do |movie|
				@event.movies << movie
			end
		end

		respond_to do |format|
		  if @event.update(event_params)
			format.html { redirect_to events_url, notice: 'Esitys päivitetty' }
			format.json { head :no_content }
		  else
			format.html { render action: 'edit' }
			format.json { render json: @event.errors, status: :unprocessable_entity }
		  end
		end
	end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
	if admin_rights
		@event.destroy
		respond_to do |format|
		  format.html { redirect_to events_url, notice: 'Esitys poistettu' }
		  format.json { head :no_content }
		end
	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:event_name, :event_date, :participantCount, :movie_ids)
    end
end
