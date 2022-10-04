class RecipesController < ApplicationController
    def index
        recipes = Recipe.all
        render json: recipes
    end

    def create
        recipe = @current_user.recipes.create!(recipe_params)
        if recipe
            render json: recipe, status: :created
        else
            render json: { error: recipe.errors.full_messages }, "Unprocessable_entity"
        end
    end


    private
    
    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
