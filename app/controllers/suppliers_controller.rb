class SuppliersController < ApplicationController
   before_action :set_supplier, only: [:show, :edit, :update, :destroy] 
   def index
      @suppliers = Supplier.all
   end

   def new
      @supplier = Supplier.new
   end

   def show
    
   end

   def edit
   
   end

   def create
      @supplier = Supplier.new(supplier_params)
      if @supplier.save()
         redirect_to suppliers_path, notice: "Fornecedor cadastrado com sucesso."
      else
         flash.now[:notice] = "Fornecedor não cadastrado."
         render 'new'
      end
   end

   def update
      @supplier.update(supplier_params)
      if @supplier.save()
         redirect_to supplier_path(@supplier), notice: 'Fornecedor alterado com sucesso.'
      else
         flash.now[:notice] = "Não foi possível alterar o fornecedor."
         render 'edit'
      end
   end

   def destroy
      @supplier.destroy()
      redirect_to suppliers_path, notice: 'Fornecedor removido com sucesso.'
   end


   private
   def supplier_params
      supplier_params = params.require(:supplier).permit(:corporate_name, :brand_name, :city, :full_address, :registration_number, :state, :email)
   end

   def set_supplier
      @supplier = Supplier.find(params[:id])
   end
end