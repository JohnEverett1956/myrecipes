require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "John", email: "john@example.com")
    @recipe = Recipe.create!(name: "First Rceipe", description: "First test receipe", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Second Rceipe", description: "Second test receipe")
    @recipe2.save
  end

  
  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end
  
  
  test "should get recipes listing" do
    get recipes_path
    assert_template "recipes/index"
    assert_match @recipe.name, response.body
    assert_match @recipe2.name, response.body
  
  end
  
end
