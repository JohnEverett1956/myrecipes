class IngredientsController < ApplicationController
  
  before_action :set_ingredient, only: [:edit, :update, :show] 
  before_action :require_admin, except: [:show, :index] 
  
  def new
    @ingredient = Ingredient.new
  end
  
  def edit
    
  end 
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "Ingredient was successfully created"
      redirect_to @ingredient
    else
      render "new"
    end
  end
  
  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = "Ingredient was successfully updated"
      redirect_to @ingredient
    else
      render "edit"
    end
  end
  
  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 4)
  end
  
  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 4)
    
  end
  
  private
    def set_ingredient
       @ingredient = Ingredient.find(params[:id]) 
    end
    
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
    
    def require_admin
      if !logged_in? ||(logged_in? && !current_chef.admin?)
        flash[:danger] = "Only Admin users can perform that action"
        redirect_to ingredients_path
      end      
    end
  
end