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
      render :index
    end
  end
  def show
    @event = Event.find(params[:id])
    render partial: 'event_detail', locals: { event: @event }
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: 'イベントが削除されました。'
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), notice: 'イベントが更新されました。'
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end)
  end
end