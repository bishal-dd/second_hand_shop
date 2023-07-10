class AccountsController < ApplicationController
  before_action  :authenticate_user!
  skip_before_action :verify_authenticity_token


  # GET /accounts
  def index
    @account = Account.find_by(user_id: params[:id])

    if @account
      account_attributes = @account.attributes
      if @account.image.attached?
        account_attributes['image_url'] = url_for(@account.image) if @account.image.present?
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
    @account = Account.find_by(user_id: params[:id])

    if @account
      render json: { status: "failed", message: "Account already uploaded" }
      return
    end

    @account = Account.new(account_params)
    @account.user_id = params[:id]
    uploaded_image = params[:image]

    if uploaded_image
      @account.image.attach(uploaded_image)
    end

    if @account.save
      render json: { status: "success" }
    else
      render json: { status: "failed" }
    end
  end



  # PATCH/PUT /accounts/1  # PATCH/PUT /accounts/1
  def update
    @account = Account.find_by(user_id: params[:id])

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

    # Only allow a list of trusted parameters through.
    def account_params
      # params.require(:account).permit(:name, :image)
      params.permit(:name, :image)
    end
end
