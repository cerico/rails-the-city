class Api::V1::CountersController < ApplicationController
  def show
    render json: Counter.all
  end

  def update
    counter = Counter.create!(name: counter_params[:name], value: counter_params[:value])
    # counter.update({ value: counter_params[:value] })
    render json: counter
  end

  def counter_params
    params.require(:counter).permit(:value, :id, :name)
  end
end
