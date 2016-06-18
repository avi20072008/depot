class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:create, :show, :decrement]
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @prod = Product.find(params[:product_id])
    #@line_item = @cart.line_items.build(product: @prod)
    @line_item = @cart.add_product(@prod.id)
    # test purpuse
    session[:counter] = 0

    #@line_item = LineItem.new(line_item_params)

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_index_path }
        format.js {}
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def decrement

    @line_item = LineItem.decrease(params[:id])
    #current_li = LineItem.find(params[:id])

    # if current_li.qty == 1 
    #   current_li.destroy
    # else
    #   current_li.qty = current_li.qty - 1
    # end
    
    respond_to do |format|
      if @line_item.save
        format.js {}
        format.html { redirect_to store_index_path }
      else
        format.html{redirect_to store_index_path}
      end
    end

  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(session[:cart_id]), notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id)
    end
end
 