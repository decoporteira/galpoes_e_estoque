class OrdersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_order_and_check_user, only: [:show, :edit, :update]
    
    
    def new
        @order = Order.new
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
        
    end

        
    def index
        @orders = current_user.orders
       
    end

    def edit
        @warehouses = Warehouse.all
        @suppliers = Supplier.all
    end


    def create
        order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
        @order = Order.new(order_params)
        @order.user = current_user
        if @order.save
            redirect_to @order, notice: 'Pedido registrado com sucesso.'
        else
            @warehouses = Warehouse.all
            @suppliers = Supplier.all
            flash.now[:alert] = "Não foi possível cadastrar pedido."
            render 'new'
        end
    end

    def update
        order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
        if @order.update(order_params)
            redirect_to @order, notice: 'Pedido alterado com sucesso.'
        else
            @warehouses = Warehouse.all
            @suppliers = Supplier.all
            flash.now[:alert] = "Não foi possível alterar pedido."
            render 'edit'
        end
    end

    def show

    end

    def search
        @code = params['query']
        # @orders_search = Order.where(code: @code)
        @orders_search = Order.where("code LIKE ?", "%#{@code}%")
    end

    private

    def set_order_and_check_user
        @order = Order.find(params[:id])
        if @order.user != current_user
            return redirect_to root_path, alert: 'Você não possui acesso a esse pedido.'
        end
    end

end
