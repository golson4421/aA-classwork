class CatsController < ApplicationController
  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    
    render :show
  end

  def new
    @cat = Cat.new
    # make a blank user
    render :new
  end

  def create
    # debugger
    @cat = Cat.new(cat_params)
    if @cat.save
      # render json: @user
      redirect_to cat_url(@cat)
      # after user is successfully created, send the client to the show page 
      # for the user that was just created 
    else
      render json: @cat.errors.full_messages, status: 422
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:birthdate, :color, :name, :sex, :description)
  end

end
