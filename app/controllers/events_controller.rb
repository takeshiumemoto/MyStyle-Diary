class EventsController < ApplicationController
  def new
    @event = Event.new
    render partial: 'form', locals: { event: @event }
  end
  def index
    @events = Event.all
    respond_to do |format|
      format.html # HTMLフォーマット
      format.json { render json: @events } # JSONフォーマット
    end
  end
  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_path, notice: 'イベントが追加されました'
    else
      render :new
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_time, :description)
  end
end