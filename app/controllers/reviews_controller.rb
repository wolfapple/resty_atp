class ReviewsController < ApplicationController
  def create
    if params[:review][:pension_id]
      @review = PensionReview.new(params[:review])
      if @review.save
        redirect_to @review.pension
      else
        render :controller => :pensions, :action => :show
      end
    else
      @review = SpotReview.new(params[:review])
      if @review.save
        redirect_to @review.spot
      else
        render :controller => :spots, :action => :show
      end
    end
  end
  
  def destroy
    if params[:review_type] == 'pension'
      @review = PensionReview.find(params[:id])
      @pension = @review.pension
      @review.destroy
      redirect_to @pension
    else
      @review = SpotReview.find(params[:id])
      @spot = @review.spot
      @review.destroy
      redirect_to @spot
    end
  end
end