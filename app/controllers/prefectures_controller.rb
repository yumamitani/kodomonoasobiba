class PrefecturesController < ApplicationController

  def show
    @reviews = Review.where(prefecture_id: params[:id]).order("created_at DESC").page(params[:page]).per(12)
    @prefecture= Prefecture.find(params[:id])
    @review = Review.find(1)
  end

end
