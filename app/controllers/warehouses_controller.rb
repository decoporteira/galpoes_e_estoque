class WarehousesController < ApplicationController
   
   
   def new
      @warehouse = Warehouse.new
   end
   def show
      @warehouse = Warehouse.find(params[:id])
   end
   def edit
      @warehouse = Warehouse.find(params[:id])
   end

   def update
      @warehouse = Warehouse.find(params[:id])
      warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
      @warehouse.update(warehouse_params)
      if @warehouse.save()
         redirect_to warehouse_path(@warehouse.id), notice: "Galpão editado com sucesso."
      else
         flash.now[:notice] = "Não foi possível atualizar o galpão"
         render 'edit'
      end
   end

   def create
      # receber os dados, criar um novo galpao e redirecionar
      warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
      @warehouse = Warehouse.new(warehouse_params)
      if @warehouse.save()
         redirect_to root_path, notice: "Galpão cadastrado com sucesso."
      else
         flash.now[:notice] = "Galpão não cadastrado."
         render 'new'
      end
   end
end