class CustomersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  
  def index
    # @customers = Customer.all
    # @customers = Customer.page(params[:page])
    @q = Customer.search(params[:q])
    @customers = @q.result(distinct: true).page(params[:page])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if  @customer.save
      redirect_to @customer
    else
      render :new
    end
  end

  def edit
    # @customer = Customer.find(params[:id])
  end

  def update
    # @customer = Customer.find(params[:id])
    if  @customer.update(customer_params)
      redirect_to @customer
    else
      render :edit
    end
  end

  def show
    # @customer = Customer.find(params[:id])
    @comment = Comment.new
    @comments = @customer.comments
  end

  def destroy
    # @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to root_path
  end
  
  private
  
  def set_customer
      @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :family_name,
      :given_name,
      :email,
      :company_id,
      :post_id
      )
  end
end
