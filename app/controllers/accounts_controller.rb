class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show update destroy ]

  # GET /accounts
  def index
    @accounts = Account.all

    account = @accounts.first

    if account
      account_attributes = account.attributes
      if account.image.attached?
        account_attributes['image_url'] = url_for(account.image)
      end
    else
      account_attributes = {}
    end

    render json: { account: account_attributes }
  end



  # GET /accounts/1
  def show
    @account =  Account.find(params[:id])

    account = @account.attributes
    if @account.image.attached?
      account['image_url'] = url_for(@account.image)
    end

    render json: { account: account}
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)

    uploaded_image = params[:image]
    if uploaded_image
      @account.image.attach(uploaded_image)
    end

    if @account.save
      render json: { status: "success"}
    else
      render json: { status: "failed"}
    end
  end

  # PATCH/PUT /accounts/1
  def update
    @account = Account.find(params[:id])

    if @account.update(account_params)
      uploaded_image = params[:image]
      if uploaded_image
        @account.image.attach(uploaded_image)
      end
      render json: { status: "success" }
    else
      render json: { status: "failed" }
    end
  end


  # DELETE /accounts/1
  def destroy
    @account = Account.find(params[:id])
    if @account.destroy
      render json: { status: "delete success" }
    else
      render json: { status: "delete failed" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      # params.require(:account).permit(:name, :image)
      params.permit(:name, :image)
    end
end
