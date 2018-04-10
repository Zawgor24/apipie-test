class Api::V1::UsersController < ApplicationController
  before_action :set_api_v1_user, only: [:show, :update, :destroy]

  def_param_group :user do
    param :id, :number
    param :name, String
    param :age, Integer
  end

  # GET /api/v1/users
  api!
  def index
    @api_v1_users = Api::V1::User.all

    render json: @api_v1_users
  end

  api :GET, '/users/:id', "Shows user's personal page"
  def show
    render json: @api_v1_user
  end

  api :POST, '/users/'
  param_group :user
  def create
    @api_v1_user = Api::V1::User.new(api_v1_user_params)

    if @api_v1_user.save
      render json: @api_v1_user, status: :created, location: @api_v1_user
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  api :PUT, '/users/:id'
  param_group :user
  def update
    if @api_v1_user.update(api_v1_user_params)
      render json: @api_v1_user
    else
      render json: @api_v1_user.errors, status: :unprocessable_entity
    end
  end

  api!
  def destroy
    @api_v1_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_user
      @api_v1_user = Api::V1::User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def api_v1_user_params
      params.require(:api_v1_user).permit(:name, :age)
    end
end
