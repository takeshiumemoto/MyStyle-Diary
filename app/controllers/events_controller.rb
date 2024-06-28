class EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = current_user.events.new
    render partial: 'form', locals: { event: @event }
  end

  def index
    @events = current_user.events
    respond_to do |format|
      format.html # HTMLフォーマット
      format.json { render json: @events } # JSONフォーマット
    end
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to events_path, notice: 'イベントが追加されました'
    else
      render :index
    end
  end

  def show
    @event = current_user.events.find(params[:id])
    render partial: 'event_detail', locals: { event: @event }
  end

  def edit
    @event = current_user.events.find(params[:id])
  end

  def update
    @event = current_user.events.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event), notice: 'イベントが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    redirect_to events_path, notice: 'イベントが削除されました。'
  end

  private

  def event_params
    params.require(:event).permit(:title, :start, :end)
  end
end
