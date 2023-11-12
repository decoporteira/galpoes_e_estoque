class WarehousesController < ApplicationController
   before_action :set_warehouse, only: [:show, :edit, :update, :destroy]
   
   def new
      @warehouse = Warehouse.new
   end
   
   def show
      @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
      @product_models = ProductModel.all
   end

   def edit; end

   def create
      # receber os dados, criar um novo galpao e redirecionar
      @warehouse = Warehouse.new(warehouse_params)
      if @warehouse.save()
         redirect_to root_path, notice: "Galpão cadastrado com sucesso."
      else
         flash.now[:notice] = "Galpão não cadastrado."
         render 'new'
      end
   end

   def update
      @warehouse.update(warehouse_params)
      if @warehouse.save()
         redirect_to warehouse_path(@warehouse.id), notice: "Galpão editado com sucesso."
      else
         flash.now[:notice] = "Não foi possível atualizar o galpão"
         render 'edit'
      end
   end

   def destroy
      @warehouse.destroy
      redirect_to root_path, notice: 'Galpão removido com sucesso'
   end

   private

   def warehouse_params
      warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
   end

   def set_warehouse
      @warehouse = Warehouse.find(params[:id])
   end
end